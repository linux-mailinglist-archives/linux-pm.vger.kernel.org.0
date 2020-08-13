Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB42440E4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgHMVvK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:51:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39372 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVvJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:51:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id c10so5335525edk.6;
        Thu, 13 Aug 2020 14:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlKBssEa0bmTLA+VjgLygPbCZV63UfRXUbB5Y2+a2Dc=;
        b=MVF4t8mf1RGHStS8aDhP7NhNv6bCJsNCrlfv1m0SS2SELWQATMYNL8LMto+Y4VAIpe
         d9MO2USG7LNAfUft2ZHsGaT32wMtto+Nujf8wxrGVoiFPuSy2HmdnBlW5ixpqQ9LCHVK
         6Li+bXnq7iwcnutYyREGhrUqRdMDrNRuEy/TSNymhFUlTKsizLoNbFRhR+EIWoekTrru
         avrZl0Vn7DrLHd8zb09qq0u16CwdSQydmW1H/TawC4bRb+tilqwKo5jzCJcUfPXluu4o
         zR3kqQmYMJFRK9v00WBbh6m/vhX1kLqSMs5lXy7uacF1oVCdRtSfzOBTK3PIfztQ6b/9
         9pQA==
X-Gm-Message-State: AOAM532lN0sZ6jxg7YqQA0wfF3MsXK9HJv+sJcAGI24XvaTVNMI0hUO4
        JwuBjztt9R1jzxSQOo+Nh70EZib2OW8RBT0ID2M=
X-Google-Smtp-Source: ABdhPJxc2H57t3Nx8jFMxgYa8F+bEwz7yJ+lTqb61yTiO7lviYVDpFc2oct3694foseNB9/AQJW/dYdW/3DV/xslP0k=
X-Received: by 2002:a05:6402:1d25:: with SMTP id dh5mr6501128edb.266.1597355465471;
 Thu, 13 Aug 2020 14:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585679838.git.yu.c.chen@intel.com> <3e5aa6e7b34827c0245e10c14ca9457512ae8586.1585679838.git.yu.c.chen@intel.com>
In-Reply-To: <3e5aa6e7b34827c0245e10c14ca9457512ae8586.1585679838.git.yu.c.chen@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 13 Aug 2020 17:50:54 -0400
Message-ID: <CAJvTdK=niWaTjwPwXaxr6EGfH8vxzJS01e+k5TgknEMPSDYLvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2][RFC] tools/power turbostat: Introduce reliable RAPL display
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

why not simply use nanosleep(2)


On Tue, Mar 31, 2020 at 2:45 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Since the RAPL Joule Counter is 32 bit, turbostat would
> only print a *star* instead of printing the actual energy
> consumed to indicate the overflow due to long duration.
> This does not meet the requirement on servers as the
> sampling time of turbostat is usually very long on servers.
>
> So maintain a set of MSR buffer, and updates them
> periodically before the 32bit msr register wrapped round.
>
> The idea is similar to the implementation of ktime_get():
> get_msr_sum() is used rather than get_msr() to get the
> accumulated MSR.
>
> This can be illustrated below:
>
> MSR timer:
> total_rapl_msr += (current_rapl_msr - last_rapl_msr);
>
> get_msr_sum():
> return (current_rapl_msr - last_rapl_msr) + total_rapl_msr;
>
> Originally-by: Aaron Lu <aaron.lwe@gmail.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/x86/turbostat/Makefile    |   2 +-
>  tools/power/x86/turbostat/turbostat.c | 292 ++++++++++++++++++++++++--
>  2 files changed, 274 insertions(+), 20 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
> index 2b6551269e43..d08765531bcb 100644
> --- a/tools/power/x86/turbostat/Makefile
> +++ b/tools/power/x86/turbostat/Makefile
> @@ -16,7 +16,7 @@ override CFLAGS +=    -D_FORTIFY_SOURCE=2
>
>  %: %.c
>         @mkdir -p $(BUILD_OUTPUT)
> -       $(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS) -lcap
> +       $(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS) -lcap -lrt
>
>  .PHONY : clean
>  clean :
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 95f3047e94ae..a8979bec97e4 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -47,6 +47,7 @@ unsigned int sums_need_wide_columns;
>  unsigned int rapl_joules;
>  unsigned int summary_only;
>  unsigned int list_header_only;
> +unsigned int longtime;
>  unsigned int dump_only;
>  unsigned int do_snb_cstates;
>  unsigned int do_knl_cstates;
> @@ -259,6 +260,113 @@ struct msr_counter {
>  #define        SYSFS_PERCPU    (1 << 1)
>  };
>
> +/*
> + * The accumulated sum of MSR is defined as a monotonic
> + * increasing MSR, it will be accumulated periodically,
> + * despite its register's bit width.
> + */
> +enum {
> +       IDX_PKG_ENERGY,
> +       IDX_DRAM_ENERGY,
> +       IDX_PP0_ENERGY,
> +       IDX_PP1_ENERGY,
> +       IDX_PKG_PERF,
> +       IDX_DRAM_PERF,
> +       IDX_COUNT,
> +};
> +
> +int get_msr_sum(int cpu, off_t offset, unsigned long long *msr);
> +
> +struct msr_sum_array {
> +       /* get_msr_sum() = sum + (get_msr() - last) */
> +       struct {
> +               /*The accumulated MSR value is updated by the timer*/
> +               unsigned long long sum;
> +               /*The MSR footprint recorded in last timer*/
> +               unsigned long long last;
> +       } entries[IDX_COUNT];
> +};
> +
> +/* The percpu MSR sum array.*/
> +struct msr_sum_array *per_cpu_msr_sum;
> +
> +int idx_to_offset(int idx)
> +{
> +       int offset;
> +
> +       switch (idx) {
> +       case IDX_PKG_ENERGY:
> +               offset = MSR_PKG_ENERGY_STATUS;
> +               break;
> +       case IDX_DRAM_ENERGY:
> +               offset = MSR_DRAM_ENERGY_STATUS;
> +               break;
> +       case IDX_PP0_ENERGY:
> +               offset = MSR_PP0_ENERGY_STATUS;
> +               break;
> +       case IDX_PP1_ENERGY:
> +               offset = MSR_PP1_ENERGY_STATUS;
> +               break;
> +       case IDX_PKG_PERF:
> +               offset = MSR_PKG_PERF_STATUS;
> +               break;
> +       case IDX_DRAM_PERF:
> +               offset = MSR_DRAM_PERF_STATUS;
> +               break;
> +       default:
> +               offset = -1;
> +       }
> +       return offset;
> +}
> +
> +int offset_to_idx(int offset)
> +{
> +       int idx;
> +
> +       switch (offset) {
> +       case MSR_PKG_ENERGY_STATUS:
> +               idx = IDX_PKG_ENERGY;
> +               break;
> +       case MSR_DRAM_ENERGY_STATUS:
> +               idx = IDX_DRAM_ENERGY;
> +               break;
> +       case MSR_PP0_ENERGY_STATUS:
> +               idx = IDX_PP0_ENERGY;
> +               break;
> +       case MSR_PP1_ENERGY_STATUS:
> +               idx = IDX_PP1_ENERGY;
> +               break;
> +       case MSR_PKG_PERF_STATUS:
> +               idx = IDX_PKG_PERF;
> +               break;
> +       case MSR_DRAM_PERF_STATUS:
> +               idx = IDX_DRAM_PERF;
> +               break;
> +       default:
> +               idx = -1;
> +       }
> +       return idx;
> +}
> +
> +int idx_valid(int idx)
> +{
> +       switch (idx) {
> +       case IDX_PKG_ENERGY:
> +               return do_rapl & RAPL_PKG;
> +       case IDX_DRAM_ENERGY:
> +               return do_rapl & RAPL_DRAM;
> +       case IDX_PP0_ENERGY:
> +               return do_rapl & RAPL_CORES_ENERGY_STATUS;
> +       case IDX_PP1_ENERGY:
> +               return do_rapl & RAPL_GFX;
> +       case IDX_PKG_PERF:
> +               return do_rapl & RAPL_PKG_PERF_STATUS;
> +       case IDX_DRAM_PERF:
> +               return do_rapl & RAPL_DRAM_PERF_STATUS;
> +       default:
> +               return 0;
> +       }
> +}
>  struct sys_counters {
>         unsigned int added_thread_counters;
>         unsigned int added_core_counters;
> @@ -551,6 +659,7 @@ void help(void)
>         "               Override default 5-second measurement interval\n"
>         "  -J, --Joules displays energy in Joules instead of Watts\n"
>         "  -l, --list   list column headers only\n"
> +       "  -L, --Longtime       long time duration support\n"
>         "  -n, --num_iterations num\n"
>         "               number of the measurement iterations\n"
>         "  -o, --out file\n"
> @@ -1962,34 +2071,70 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
>                 p->sys_lpi = cpuidle_cur_sys_lpi_us;
>
>         if (do_rapl & RAPL_PKG) {
> -               if (get_msr(cpu, MSR_PKG_ENERGY_STATUS, &msr))
> -                       return -13;
> -               p->energy_pkg = msr & 0xFFFFFFFF;
> +               if (longtime) {
> +                       if (get_msr_sum(cpu, MSR_PKG_ENERGY_STATUS, &msr))
> +                               return -13;
> +                       p->energy_pkg = msr;
> +               } else {
> +                       if (get_msr(cpu, MSR_PKG_ENERGY_STATUS, &msr))
> +                               return -13;
> +                       p->energy_pkg = msr & 0xFFFFFFFF;
> +               }
>         }
>         if (do_rapl & RAPL_CORES_ENERGY_STATUS) {
> -               if (get_msr(cpu, MSR_PP0_ENERGY_STATUS, &msr))
> -                       return -14;
> -               p->energy_cores = msr & 0xFFFFFFFF;
> +               if (longtime) {
> +                       if (get_msr_sum(cpu, MSR_PP0_ENERGY_STATUS, &msr))
> +                               return -14;
> +                       p->energy_cores = msr;
> +               } else {
> +                       if (get_msr(cpu, MSR_PP0_ENERGY_STATUS, &msr))
> +                               return -14;
> +                       p->energy_cores = msr & 0xFFFFFFFF;
> +               }
>         }
>         if (do_rapl & RAPL_DRAM) {
> -               if (get_msr(cpu, MSR_DRAM_ENERGY_STATUS, &msr))
> -                       return -15;
> -               p->energy_dram = msr & 0xFFFFFFFF;
> +               if (longtime) {
> +                       if (get_msr_sum(cpu, MSR_DRAM_ENERGY_STATUS, &msr))
> +                               return -15;
> +                       p->energy_dram = msr;
> +               } else {
> +                       if (get_msr(cpu, MSR_DRAM_ENERGY_STATUS, &msr))
> +                               return -15;
> +                       p->energy_dram = msr & 0xFFFFFFFF;
> +               }
>         }
>         if (do_rapl & RAPL_GFX) {
> -               if (get_msr(cpu, MSR_PP1_ENERGY_STATUS, &msr))
> -                       return -16;
> -               p->energy_gfx = msr & 0xFFFFFFFF;
> +               if (longtime) {
> +                       if (get_msr_sum(cpu, MSR_PP1_ENERGY_STATUS, &msr))
> +                               return -16;
> +                       p->energy_gfx = msr;
> +               } else {
> +                       if (get_msr(cpu, MSR_PP1_ENERGY_STATUS, &msr))
> +                               return -16;
> +                       p->energy_gfx = msr & 0xFFFFFFFF;
> +               }
>         }
>         if (do_rapl & RAPL_PKG_PERF_STATUS) {
> -               if (get_msr(cpu, MSR_PKG_PERF_STATUS, &msr))
> -                       return -16;
> -               p->rapl_pkg_perf_status = msr & 0xFFFFFFFF;
> +               if (longtime) {
> +                       if (get_msr_sum(cpu, MSR_DRAM_PERF_STATUS, &msr))
> +                               return -16;
> +                       p->rapl_dram_perf_status = msr;
> +               } else {
> +                       if (get_msr(cpu, MSR_PKG_PERF_STATUS, &msr))
> +                               return -16;
> +                       p->rapl_pkg_perf_status = msr & 0xFFFFFFFF;
> +               }
>         }
>         if (do_rapl & RAPL_DRAM_PERF_STATUS) {
> -               if (get_msr(cpu, MSR_DRAM_PERF_STATUS, &msr))
> -                       return -16;
> -               p->rapl_dram_perf_status = msr & 0xFFFFFFFF;
> +               if (longtime) {
> +                       if (get_msr_sum(cpu, MSR_DRAM_PERF_STATUS, &msr))
> +                               return -16;
> +                       p->rapl_dram_perf_status = msr;
> +               } else {
> +                       if (get_msr(cpu, MSR_DRAM_PERF_STATUS, &msr))
> +                               return -16;
> +                       p->rapl_dram_perf_status = msr & 0xFFFFFFFF;
> +               }
>         }
>         if (do_rapl & RAPL_AMD_F17H) {
>                 if (get_msr(cpu, MSR_PKG_ENERGY_STAT, &msr))
> @@ -3053,6 +3198,109 @@ void do_sleep(void)
>         }
>  }
>
> +int get_msr_sum(int cpu, off_t offset, unsigned long long *msr)
> +{
> +       int ret, idx;
> +       unsigned long long msr_cur, msr_last;
> +
> +       if (!per_cpu_msr_sum)
> +               return 1;
> +
> +       idx = offset_to_idx(offset);
> +       if (idx < 0)
> +               return idx;
> +       /* get_msr_sum() = sum + (get_msr() - last) */
> +       ret = get_msr(cpu, offset, &msr_cur);
> +       if (ret)
> +               return ret;
> +       msr_last = per_cpu_msr_sum[cpu].entries[idx].last;
> +       DELTA_WRAP32(msr_cur, msr_last);
> +       *msr = msr_last + per_cpu_msr_sum[cpu].entries[idx].sum;
> +
> +       return 0;
> +}
> +
> +timer_t timerid;
> +
> +/* Timer callback, update the sum of MSRs periodically. */
> +static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg_data *p)
> +{
> +       int i, ret;
> +       int cpu = t->cpu_id;
> +
> +       for (i = IDX_PKG_ENERGY; i < IDX_COUNT; i++) {
> +               unsigned long long msr_cur, msr_last;
> +               int offset;
> +
> +               if (!idx_valid(i))
> +                       continue;
> +               offset = idx_to_offset(i);
> +               if (offset < 0)
> +                       continue;
> +               ret = get_msr(cpu, offset, &msr_cur);
> +               if (ret) {
> +                       fprintf(outf, "Can not update msr(0x%x)\n", offset);
> +                       continue;
> +               }
> +
> +               msr_last = per_cpu_msr_sum[cpu].entries[i].last;
> +               per_cpu_msr_sum[cpu].entries[i].last = msr_cur & 0xffffffff;
> +
> +               DELTA_WRAP32(msr_cur, msr_last);
> +               per_cpu_msr_sum[cpu].entries[i].sum += msr_last;
> +       }
> +       return 0;
> +}
> +
> +static void
> +msr_record_handler(union sigval v)
> +{
> +       for_all_cpus(update_msr_sum, EVEN_COUNTERS);
> +}
> +
> +void msr_longtime_record(void)
> +{
> +       struct itimerspec its;
> +       struct sigevent sev;
> +
> +       per_cpu_msr_sum = calloc(topo.max_cpu_num + 1, sizeof(struct msr_sum_array));
> +       if (!per_cpu_msr_sum) {
> +               fprintf(outf, "Can not allocate memory for long time MSR.\n");
> +               return;
> +       }
> +       /*
> +        * Signal handler might be restricted, so use thread notifier instead.
> +        */
> +       memset(&sev, 0, sizeof(struct sigevent));
> +       sev.sigev_notify = SIGEV_THREAD;
> +       sev.sigev_notify_function = msr_record_handler;
> +
> +       sev.sigev_value.sival_ptr = &timerid;
> +       if (timer_create(CLOCK_REALTIME, &sev, &timerid) == -1) {
> +               fprintf(outf, "Can not create timer.\n");
> +               goto release_msr;
> +       }
> +
> +       its.it_value.tv_sec = 0;
> +       its.it_value.tv_nsec = 1;
> +       /*
> +        * A wraparound time of around 60 secs when power consumption
> +        * is high, use 50 secs.
> +        */
> +       its.it_interval.tv_sec = 50;
> +       its.it_interval.tv_nsec = 0;
> +
> +       if (timer_settime(timerid, 0, &its, NULL) == -1) {
> +               fprintf(outf, "Can not set timer.\n");
> +               goto release_timer;
> +       }
> +       return;
> +
> + release_timer:
> +       timer_delete(timerid);
> + release_msr:
> +       free(per_cpu_msr_sum);
> +}
>
>  void turbostat_loop()
>  {
> @@ -5735,6 +5983,7 @@ void cmdline(int argc, char **argv)
>                 {"hide",        required_argument,      0, 'H'},        // meh, -h taken by --help
>                 {"Joules",      no_argument,            0, 'J'},
>                 {"list",        no_argument,            0, 'l'},
> +               {"Longtime",    no_argument,            0, 'L'},
>                 {"out",         required_argument,      0, 'o'},
>                 {"quiet",       no_argument,            0, 'q'},
>                 {"show",        required_argument,      0, 's'},
> @@ -5746,7 +5995,7 @@ void cmdline(int argc, char **argv)
>
>         progname = argv[0];
>
> -       while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:Jn:o:qST:v",
> +       while ((opt = getopt_long_only(argc, argv, "+C:c:Dde:hi:JLn:o:qST:v",
>                                 long_options, &option_index)) != -1) {
>                 switch (opt) {
>                 case 'a':
> @@ -5800,6 +6049,9 @@ void cmdline(int argc, char **argv)
>                         list_header_only++;
>                         quiet++;
>                         break;
> +               case 'L':
> +                       longtime = 1;
> +                       break;
>                 case 'o':
>                         outf = fopen_or_die(optarg, "w");
>                         break;
> @@ -5864,6 +6116,8 @@ int main(int argc, char **argv)
>                 return 0;
>         }
>
> +       if (longtime)
> +               msr_longtime_record();
>         /*
>          * if any params left, it must be a command to fork
>          */
> --
> 2.17.1
>


-- 
Len Brown, Intel Open Source Technology Center
