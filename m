Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7DE307BED
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 18:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhA1RNW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 12:13:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:45180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhA1RLS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Jan 2021 12:11:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66168AD2B;
        Thu, 28 Jan 2021 17:10:37 +0000 (UTC)
Date:   Thu, 28 Jan 2021 18:10:33 +0100
From:   Borislav Petkov <bp@suse.de>
To:     'Artem Bityutskiy' <dedekind1@gmail.com>
Cc:     Doug Smythies <dsmythies@telus.net>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Len Brown' <lenb@kernel.org>,
        'Linux PM Mailing List' <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] tools/power/turbostat: fix compatibility with older
 kernels
Message-ID: <20210128171033.GC5685@zn.tnic>
References: <20210127132444.981120-1-dedekind1@gmail.com>
 <20210127185957.GD8115@zn.tnic>
 <002201d6f4e9$1e9f6c10$5bde4430$@net>
 <20210127203346.GE8115@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210127203346.GE8115@zn.tnic>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 27, 2021 at 09:33:46PM +0100, Borislav Petkov wrote:
> Yeah, lemme do a proper patch tomorrow.

Artem, how's that?

---

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 389ea5209a83..a7c4f0772e53 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1834,12 +1834,15 @@ int get_mp(int cpu, struct msr_counter *mp, unsigned long long *counterp)
 int get_epb(int cpu)
 {
 	char path[128 + PATH_BYTES];
+	unsigned long long msr;
 	int ret, epb = -1;
 	FILE *fp;
 
 	sprintf(path, "/sys/devices/system/cpu/cpu%d/power/energy_perf_bias", cpu);
 
-	fp = fopen_or_die(path, "r");
+	fp = fopen(path, "r");
+	if (!fp)
+		goto msr_fallback;
 
 	ret = fscanf(fp, "%d", &epb);
 	if (ret != 1)
@@ -1848,6 +1851,11 @@ int get_epb(int cpu)
 	fclose(fp);
 
 	return epb;
+
+msr_fallback:
+	get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr);
+
+	return msr & 0xf;
 }
 
 void get_apic_id(struct thread_data *t)

---

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
