Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795E01AEAE9
	for <lists+linux-pm@lfdr.de>; Sat, 18 Apr 2020 10:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgDRIbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Apr 2020 04:31:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:45753 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgDRIbc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 18 Apr 2020 04:31:32 -0400
IronPort-SDR: ctCfm4bwxczPXKRxFjK7N3XM+rQdvSRwjBL2lhCMDbtL1mFlat++6qjOlt6GoEPfJK9syMIgHi
 7goxyow4E5UQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2020 01:31:28 -0700
IronPort-SDR: ObFGq4tnocYbyl2yW0gSeez4cJhVYAdNdEjx6W8Tut36eboHviKGl7dEu0TKQXfpjTkzMSnWx5
 sKvgLpy9hQjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,398,1580803200"; 
   d="scan'208";a="254442268"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2020 01:31:26 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/3][v3] tools/power turbostat: Introduce functions to accumulate RAPL consumption
Date:   Sat, 18 Apr 2020 16:31:57 +0800
Message-Id: <50dd3e3f782070a2d4458357d0b472f1abacb375.1587196252.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587196252.git.yu.c.chen@intel.com>
References: <cover.1587196252.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the RAPL Joule Counter is 32 bit, turbostat would
only print a *star* instead of printing the actual energy
consumed to indicate the overflow due to long duration.
This does not meet the requirement from servers as the
sampling time of turbostat is usually very long on servers.

So maintain a set of MSR buffer, and update them
periodically before the 32bit MSR register is wrapped round,
so as to avoid the overflow.

The idea is similar to the implementation of ktime_get():

Periodical MSR timer:
total_rapl_sum += (current_rapl_msr - last_rapl_msr);

Using get_msr_sum() to get the accumulated RAPL:
return (current_rapl_msr - last_rapl_msr) + total_rapl_sum;

The accumulated RAPL mechanism will be turned on in next patch.

Originally-by: Aaron Lu <aaron.lwe@gmail.com>
Reviewed-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: According to Len's suggestion:
    1. Enable the accumulated RAPL mechanism by default.
    2. Re-use the rapl_joule_counter_range to represent the
       the timeout of periodical timer.
    3. Remove the condition check in v1 patch when reading RAPL registers.

v3: Doug found two issues, fix them accordingly:
    1. The max timeout should be calculated according to 2 * TDP.
    2. There's no need to wrap the accumulated 64 bits RAPL.
---
 tools/power/x86/turbostat/Makefile    |   2 +-
 tools/power/x86/turbostat/turbostat.c | 224 +++++++++++++++++++++++++-
 2 files changed, 219 insertions(+), 7 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 2b6551269e43..d08765531bcb 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -16,7 +16,7 @@ override CFLAGS +=	-D_FORTIFY_SOURCE=2
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS) -lcap
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS) -lcap -lrt
 
 .PHONY : clean
 clean :
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 95f3047e94ae..44fd3822a5fa 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -259,6 +259,113 @@ struct msr_counter {
 #define	SYSFS_PERCPU	(1 << 1)
 };
 
+/*
+ * The accumulated sum of MSR is defined as a monotonic
+ * increasing MSR, it will be accumulated periodically,
+ * despite its register's bit width.
+ */
+enum {
+	IDX_PKG_ENERGY,
+	IDX_DRAM_ENERGY,
+	IDX_PP0_ENERGY,
+	IDX_PP1_ENERGY,
+	IDX_PKG_PERF,
+	IDX_DRAM_PERF,
+	IDX_COUNT,
+};
+
+int get_msr_sum(int cpu, off_t offset, unsigned long long *msr);
+
+struct msr_sum_array {
+	/* get_msr_sum() = sum + (get_msr() - last) */
+	struct {
+		/*The accumulated MSR value is updated by the timer*/
+		unsigned long long sum;
+		/*The MSR footprint recorded in last timer*/
+		unsigned long long last;
+	} entries[IDX_COUNT];
+};
+
+/* The percpu MSR sum array.*/
+struct msr_sum_array *per_cpu_msr_sum;
+
+int idx_to_offset(int idx)
+{
+	int offset;
+
+	switch (idx) {
+	case IDX_PKG_ENERGY:
+		offset = MSR_PKG_ENERGY_STATUS;
+		break;
+	case IDX_DRAM_ENERGY:
+		offset = MSR_DRAM_ENERGY_STATUS;
+		break;
+	case IDX_PP0_ENERGY:
+		offset = MSR_PP0_ENERGY_STATUS;
+		break;
+	case IDX_PP1_ENERGY:
+		offset = MSR_PP1_ENERGY_STATUS;
+		break;
+	case IDX_PKG_PERF:
+		offset = MSR_PKG_PERF_STATUS;
+		break;
+	case IDX_DRAM_PERF:
+		offset = MSR_DRAM_PERF_STATUS;
+		break;
+	default:
+		offset = -1;
+	}
+	return offset;
+}
+
+int offset_to_idx(int offset)
+{
+	int idx;
+
+	switch (offset) {
+	case MSR_PKG_ENERGY_STATUS:
+		idx = IDX_PKG_ENERGY;
+		break;
+	case MSR_DRAM_ENERGY_STATUS:
+		idx = IDX_DRAM_ENERGY;
+		break;
+	case MSR_PP0_ENERGY_STATUS:
+		idx = IDX_PP0_ENERGY;
+		break;
+	case MSR_PP1_ENERGY_STATUS:
+		idx = IDX_PP1_ENERGY;
+		break;
+	case MSR_PKG_PERF_STATUS:
+		idx = IDX_PKG_PERF;
+		break;
+	case MSR_DRAM_PERF_STATUS:
+		idx = IDX_DRAM_PERF;
+		break;
+	default:
+		idx = -1;
+	}
+	return idx;
+}
+
+int idx_valid(int idx)
+{
+	switch (idx) {
+	case IDX_PKG_ENERGY:
+		return do_rapl & RAPL_PKG;
+	case IDX_DRAM_ENERGY:
+		return do_rapl & RAPL_DRAM;
+	case IDX_PP0_ENERGY:
+		return do_rapl & RAPL_CORES_ENERGY_STATUS;
+	case IDX_PP1_ENERGY:
+		return do_rapl & RAPL_GFX;
+	case IDX_PKG_PERF:
+		return do_rapl & RAPL_PKG_PERF_STATUS;
+	case IDX_DRAM_PERF:
+		return do_rapl & RAPL_DRAM_PERF_STATUS;
+	default:
+		return 0;
+	}
+}
 struct sys_counters {
 	unsigned int added_thread_counters;
 	unsigned int added_core_counters;
@@ -1250,12 +1357,12 @@ delta_package(struct pkg_data *new, struct pkg_data *old)
 
 	old->gfx_mhz = new->gfx_mhz;
 
-	DELTA_WRAP32(new->energy_pkg, old->energy_pkg);
-	DELTA_WRAP32(new->energy_cores, old->energy_cores);
-	DELTA_WRAP32(new->energy_gfx, old->energy_gfx);
-	DELTA_WRAP32(new->energy_dram, old->energy_dram);
-	DELTA_WRAP32(new->rapl_pkg_perf_status, old->rapl_pkg_perf_status);
-	DELTA_WRAP32(new->rapl_dram_perf_status, old->rapl_dram_perf_status);
+	old->energy_pkg = new->energy_pkg - old->energy_pkg;
+	old->energy_cores = new->energy_cores - old->energy_cores;
+	old->energy_gfx = new->energy_gfx - old->energy_gfx;
+	old->energy_dram = new->energy_dram - old->energy_dram;
+	old->rapl_pkg_perf_status = new->rapl_pkg_perf_status - old->rapl_pkg_perf_status;
+	old->rapl_dram_perf_status = new->rapl_dram_perf_status - old->rapl_dram_perf_status;
 
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
@@ -3053,6 +3160,111 @@ void do_sleep(void)
 	}
 }
 
+int get_msr_sum(int cpu, off_t offset, unsigned long long *msr)
+{
+	int ret, idx;
+	unsigned long long msr_cur, msr_last;
+
+	if (!per_cpu_msr_sum)
+		return 1;
+
+	idx = offset_to_idx(offset);
+	if (idx < 0)
+		return idx;
+	/* get_msr_sum() = sum + (get_msr() - last) */
+	ret = get_msr(cpu, offset, &msr_cur);
+	if (ret)
+		return ret;
+	msr_last = per_cpu_msr_sum[cpu].entries[idx].last;
+	DELTA_WRAP32(msr_cur, msr_last);
+	*msr = msr_last + per_cpu_msr_sum[cpu].entries[idx].sum;
+
+	return 0;
+}
+
+timer_t timerid;
+
+/* Timer callback, update the sum of MSRs periodically. */
+static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg_data *p)
+{
+	int i, ret;
+	int cpu = t->cpu_id;
+
+	for (i = IDX_PKG_ENERGY; i < IDX_COUNT; i++) {
+		unsigned long long msr_cur, msr_last;
+		int offset;
+
+		if (!idx_valid(i))
+			continue;
+		offset = idx_to_offset(i);
+		if (offset < 0)
+			continue;
+		ret = get_msr(cpu, offset, &msr_cur);
+		if (ret) {
+			fprintf(outf, "Can not update msr(0x%x)\n", offset);
+			continue;
+		}
+
+		msr_last = per_cpu_msr_sum[cpu].entries[i].last;
+		per_cpu_msr_sum[cpu].entries[i].last = msr_cur & 0xffffffff;
+
+		DELTA_WRAP32(msr_cur, msr_last);
+		per_cpu_msr_sum[cpu].entries[i].sum += msr_last;
+	}
+	return 0;
+}
+
+static void
+msr_record_handler(union sigval v)
+{
+	for_all_cpus(update_msr_sum, EVEN_COUNTERS);
+}
+
+void msr_sum_record(void)
+{
+	struct itimerspec its;
+	struct sigevent sev;
+
+	per_cpu_msr_sum = calloc(topo.max_cpu_num + 1, sizeof(struct msr_sum_array));
+	if (!per_cpu_msr_sum) {
+		fprintf(outf, "Can not allocate memory for long time MSR.\n");
+		return;
+	}
+	/*
+	 * Signal handler might be restricted, so use thread notifier instead.
+	 */
+	memset(&sev, 0, sizeof(struct sigevent));
+	sev.sigev_notify = SIGEV_THREAD;
+	sev.sigev_notify_function = msr_record_handler;
+
+	sev.sigev_value.sival_ptr = &timerid;
+	if (timer_create(CLOCK_REALTIME, &sev, &timerid) == -1) {
+		fprintf(outf, "Can not create timer.\n");
+		goto release_msr;
+	}
+
+	its.it_value.tv_sec = 0;
+	its.it_value.tv_nsec = 1;
+	/*
+	 * A wraparound time has been calculated early.
+	 * Some sources state that the peak power for a
+	 * microprocessor is usually 1.5 times the TDP rating,
+	 * use 2 * TDP for safety.
+	 */
+	its.it_interval.tv_sec = rapl_joule_counter_range / 2;
+	its.it_interval.tv_nsec = 0;
+
+	if (timer_settime(timerid, 0, &its, NULL) == -1) {
+		fprintf(outf, "Can not set timer.\n");
+		goto release_timer;
+	}
+	return;
+
+ release_timer:
+	timer_delete(timerid);
+ release_msr:
+	free(per_cpu_msr_sum);
+}
 
 void turbostat_loop()
 {
-- 
2.17.1

