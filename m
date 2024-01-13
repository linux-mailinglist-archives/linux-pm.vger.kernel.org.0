Return-Path: <linux-pm+bounces-2179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CA882C8DF
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jan 2024 02:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0BE1F248ED
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jan 2024 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF915EA6;
	Sat, 13 Jan 2024 01:42:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7D14001
	for <linux-pm@vger.kernel.org>; Sat, 13 Jan 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-206689895bfso2189226fac.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 17:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705110148; x=1705714948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHpROgkYZvcflLMC1z4OK4WJJjqDQ7anFAnFM1/Cwf4=;
        b=UUJxuOGditXHPk70dXw8spO4r2nkVP/5ieQA91yoApz/7O9vftNtIOMnKQNOLoLXX8
         9I2no5Qa1V7yUCzbOTT3E8M3jyAGAy+OHqrzrSW/c6lCWhsGSvgyFuKeSXSffNxUaWP2
         OlOl5G6pt8neejM2299szJSTEaT3PhEYl6egWI7fguYcuEXp4cbY6uiwRW/XmowxYw/y
         ArATbFzL1HsY5Tg6yisYcAK+Vtyq+jsmzyWBl+P7Kxv3pdiG7eyRFGx+UfmOKjW2wn+A
         Iu/VLsnHyC4Q9XHiZ9d6LdZ5rB93bbJr6BFc7uCY8MQBm9iPS9QNshxzfvuNn/jrFbnc
         RaZw==
X-Gm-Message-State: AOJu0YxHwhfhNHIJGZP+gS4O5htpLqClV+RD7erZRXcsRecNdt/n/vW3
	S67eGm3i0ziZRWoNObbQlH/Q+4JLXKA0kDqLaqA=
X-Google-Smtp-Source: AGHT+IHKkw7r1o/aT6w4mYPdEs9aP/LMAkOZr3SHmDZft7g6Uj/FxwJCL2VvzGIcy0msd8SL3e4MNi/0ylY7Y4wJpXo=
X-Received: by 2002:a05:6870:d8cb:b0:206:9edf:486e with SMTP id
 of11-20020a056870d8cb00b002069edf486emr2345581oac.42.1705110147852; Fri, 12
 Jan 2024 17:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com> <20240112124815.970-5-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20240112124815.970-5-patryk.wlazlyn@linux.intel.com>
From: Len Brown <lenb@kernel.org>
Date: Fri, 12 Jan 2024 19:42:17 -0600
Message-ID: <CAJvTdKkX8LAY5ZOzodzJWS3hafaF5094s1aRNsxXMh3Xfky8jg@mail.gmail.com>
Subject: Re: [PATCH 4/4] tools/power turbostat: Add reading aperf and mperf
 via perf API
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When this patch is applied (on top of the --no-msr patch), then with
--no-msr, we should still see Busy%, Avg_Mhz, Bzy_MHz, and IPC -- but
we do not.

Also, the reason we want to do this isn't because perf takes fewer
cycles than the MSR driver -- though that is an added bonus in the
scenario when that is true.

The reason we want to do this is because we can read APERF and MPERF
within the same system call, reducing "jitter" between the reads and
thus allowing more accurate frequency calculations under key
conditions -- such as when the machine is very busy and turbostat is
contending for the CPU, as well as when the sample interval is very
short.

thanks,
-Len

On Fri, Jan 12, 2024 at 6:49=E2=80=AFAM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> Reading the counters via perf API is *usually* faster than going through
> the msr driver, mainly because we do less syscalls, which also helps
> with narrowing the gap between the reads. Getting cache misses on the
> perf path does cost more and this is where the "usually faster" comes
> from.
>
> We would fallback to the msr reads if the sysfs isn't there or when in
> --no-perf mode.
>
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 345 +++++++++++++++++++++-----
>  1 file changed, 277 insertions(+), 68 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index bf733e7d73b5..d85e38cbadcb 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -57,6 +57,7 @@
>  enum counter_scope { SCOPE_CPU, SCOPE_CORE, SCOPE_PACKAGE };
>  enum counter_type { COUNTER_ITEMS, COUNTER_CYCLES, COUNTER_SECONDS, COUN=
TER_USEC };
>  enum counter_format { FORMAT_RAW, FORMAT_DELTA, FORMAT_PERCENT };
> +enum xperf_source { XPERF_SOURCE_PERF, XPERF_SOURCE_MSR };
>
>  struct msr_counter {
>         unsigned int msr_num;
> @@ -209,6 +210,7 @@ char *proc_stat =3D "/proc/stat";
>  FILE *outf;
>  int *fd_percpu;
>  int *fd_instr_count_percpu;
> +int *fd_xperf_percpu; /* File descriptors for perf group with APERF and =
MPERF counters. */
>  struct timeval interval_tv =3D { 5, 0 };
>  struct timespec interval_ts =3D { 5, 0 };
>
> @@ -266,6 +268,7 @@ unsigned int first_counter_read =3D 1;
>  int ignore_stdin;
>  bool no_msr;
>  bool no_perf;
> +enum xperf_source xperf_source;
>
>  int get_msr(int cpu, off_t offset, unsigned long long *msr);
>
> @@ -1336,18 +1339,27 @@ static long perf_event_open(struct perf_event_att=
r *hw_event, pid_t pid, int cpu
>         return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd=
, flags);
>  }
>
> -static int perf_instr_count_open(int cpu_num)
> +static long open_perf_counter(
> +       int cpu,
> +       unsigned type,
> +       unsigned config,
> +       int group_fd,
> +       __u64 read_format)
>  {
> -       struct perf_event_attr pea;
> -       int fd;
> +       struct perf_event_attr attr;
> +       const pid_t pid =3D -1;
> +       const unsigned long flags =3D 0;
> +
> +       memset(&attr, 0, sizeof(struct perf_event_attr));
>
> -       memset(&pea, 0, sizeof(struct perf_event_attr));
> -       pea.type =3D PERF_TYPE_HARDWARE;
> -       pea.size =3D sizeof(struct perf_event_attr);
> -       pea.config =3D PERF_COUNT_HW_INSTRUCTIONS;
> +       attr.type =3D type;
> +       attr.size =3D sizeof(struct perf_event_attr);
> +       attr.config =3D config;
> +       attr.disabled =3D 0;
> +       attr.sample_type =3D PERF_SAMPLE_IDENTIFIER;
> +       attr.read_format =3D read_format;
>
> -       /* counter for cpu_num, including user + kernel and all processes=
 */
> -       fd =3D perf_event_open(&pea, -1, cpu_num, -1, 0);
> +       const int fd =3D perf_event_open(&attr, pid, cpu, group_fd, flags=
);
>         if (fd =3D=3D -1) {
>                 warnx("capget(CAP_PERFMON) failed, try \"# setcap cap_sys=
_admin=3Dep %s\""
>                       " or use --no-perf", progname);
> @@ -1362,7 +1374,7 @@ int get_instr_count_fd(int cpu)
>         if (fd_instr_count_percpu[cpu])
>                 return fd_instr_count_percpu[cpu];
>
> -       fd_instr_count_percpu[cpu] =3D perf_instr_count_open(cpu);
> +       fd_instr_count_percpu[cpu] =3D open_perf_counter(cpu, PERF_TYPE_H=
ARDWARE, PERF_COUNT_HW_INSTRUCTIONS, -1, 0);
>
>         return fd_instr_count_percpu[cpu];
>  }
> @@ -2753,6 +2765,182 @@ int get_core_throt_cnt(int cpu, unsigned long lon=
g *cnt)
>         return 0;
>  }
>
> +static unsigned read_perf_counter_info(
> +       const char * const path,
> +       const char * const parse_format)
> +{
> +       int fdmt;
> +       char buf[16];
> +       unsigned v;
> +
> +       fdmt =3D open(path, O_RDONLY, 0);
> +       if (fdmt =3D=3D -1)
> +               errx(1, "Failed to read perf counter info %s\n", path);
> +
> +       if (read(fdmt, buf, sizeof(buf)) <=3D 0)
> +               return 0;
> +
> +       buf[sizeof(buf)-1] =3D '\0';
> +
> +       if (sscanf(buf, parse_format, &v) !=3D 1)
> +               errx(1, "Failed to parse perf counter info %s\n", path);
> +
> +       close(fdmt);
> +
> +       return v;
> +}
> +
> +static unsigned read_msr_type(void)
> +{
> +       const char * const path =3D "/sys/bus/event_source/devices/msr/ty=
pe";
> +       const char * const format =3D "%u";
> +
> +       return read_perf_counter_info(path, format);
> +}
> +
> +static unsigned read_aperf_config(void)
> +{
> +       const char * const path =3D "/sys/bus/event_source/devices/msr/ev=
ents/aperf";
> +       const char * const format =3D "event=3D%x";
> +
> +       return read_perf_counter_info(path, format);
> +}
> +
> +static unsigned read_mperf_config(void)
> +{
> +       const char * const path =3D "/sys/bus/event_source/devices/msr/ev=
ents/mperf";
> +       const char * const format =3D "event=3D%x";
> +
> +       return read_perf_counter_info(path, format);
> +}
> +
> +static int open_xperf_fd(int cpu)
> +{
> +       const unsigned msr_type =3D read_msr_type();
> +       const unsigned aperf_config =3D read_aperf_config();
> +       const unsigned mperf_config =3D read_mperf_config();
> +       int fd_aperf =3D -1, fd_mperf =3D -1;
> +
> +       fd_aperf =3D open_perf_counter(cpu, msr_type, aperf_config, -1, P=
ERF_FORMAT_GROUP);
> +       if (fd_aperf =3D=3D -1) {
> +               perror("open_perf_counter aperf");
> +               return 0;
> +       }
> +
> +       fd_mperf =3D open_perf_counter(cpu, msr_type, mperf_config, fd_ap=
erf, PERF_FORMAT_GROUP);
> +       if (fd_mperf =3D=3D -1) {
> +               perror("open_perf_counter mperf");
> +               close(fd_aperf);
> +               return 0;
> +       }
> +
> +       return fd_aperf;
> +}
> +
> +static int get_xperf_fd(int cpu)
> +{
> +       assert(fd_xperf_percpu);
> +
> +       if (fd_xperf_percpu[cpu])
> +               return fd_xperf_percpu[cpu];
> +
> +       fd_xperf_percpu[cpu] =3D open_xperf_fd(cpu);
> +
> +       return fd_xperf_percpu[cpu];
> +}
> +
> +/* Read APERF, MPERF and TSC using the perf API. */
> +static int read_aperf_mperf_tsc_perf(struct thread_data *t, int cpu)
> +{
> +       union {
> +               struct {
> +                       unsigned long nr_entries;
> +                       unsigned long aperf;
> +                       unsigned long mperf;
> +               };
> +
> +               unsigned long as_array[3];
> +       } cnt;
> +
> +       const int fd_xperf =3D get_xperf_fd(cpu);
> +
> +       /*
> +        * Read the TSC with rdtsc, because we want the absolute value an=
d not
> +        * the offset from the start of the process.
> +        */
> +       t->tsc =3D rdtsc();
> +
> +       const int n =3D read(fd_xperf, &cnt.as_array[0], sizeof(cnt.as_ar=
ray));
> +       if (n !=3D sizeof(cnt.as_array))
> +               return 1;
> +
> +       t->aperf =3D cnt.aperf * aperf_mperf_multiplier;
> +       t->mperf =3D cnt.mperf * aperf_mperf_multiplier;
> +
> +       return 0;
> +}
> +
> +/* Read APERF, MPERF and TSC using the MSR driver and rdtsc instruction.=
 */
> +static int read_aperf_mperf_tsc_msr(struct thread_data *t, int cpu)
> +{
> +       unsigned long long tsc_before, tsc_between, tsc_after, aperf_time=
, mperf_time;
> +       int aperf_mperf_retry_count =3D 0;
> +
> +       /*
> +        * The TSC, APERF and MPERF must be read together for
> +        * APERF/MPERF and MPERF/TSC to give accurate results.
> +        *
> +        * Unfortunately, APERF and MPERF are read by
> +        * individual system call, so delays may occur
> +        * between them.  If the time to read them
> +        * varies by a large amount, we re-read them.
> +        */
> +
> +       /*
> +        * This initial dummy APERF read has been seen to
> +        * reduce jitter in the subsequent reads.
> +        */
> +
> +       if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
> +               return -3;
> +
> +retry:
> +       t->tsc =3D rdtsc();       /* re-read close to APERF */
> +
> +       tsc_before =3D t->tsc;
> +
> +       if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
> +               return -3;
> +
> +       tsc_between =3D rdtsc();
> +
> +       if (get_msr(cpu, MSR_IA32_MPERF, &t->mperf))
> +               return -4;
> +
> +       tsc_after =3D rdtsc();
> +
> +       aperf_time =3D tsc_between - tsc_before;
> +       mperf_time =3D tsc_after - tsc_between;
> +
> +       /*
> +        * If the system call latency to read APERF and MPERF
> +        * differ by more than 2x, then try again.
> +        */
> +       if ((aperf_time > (2 * mperf_time)) || (mperf_time > (2 * aperf_t=
ime))) {
> +               aperf_mperf_retry_count++;
> +               if (aperf_mperf_retry_count < 5)
> +                       goto retry;
> +               else
> +                       warnx("cpu%d jitter %lld %lld", cpu, aperf_time, =
mperf_time);
> +       }
> +       aperf_mperf_retry_count =3D 0;
> +
> +       t->aperf =3D t->aperf * aperf_mperf_multiplier;
> +       t->mperf =3D t->mperf * aperf_mperf_multiplier;
> +
> +       return 0;
> +}
> +
>  /*
>   * get_counters(...)
>   * migrate to cpu
> @@ -2762,7 +2950,6 @@ int get_counters(struct thread_data *t, struct core=
_data *c, struct pkg_data *p)
>  {
>         int cpu =3D t->cpu_id;
>         unsigned long long msr;
> -       int aperf_mperf_retry_count =3D 0;
>         struct msr_counter *mp;
>         int i;
>
> @@ -2775,63 +2962,26 @@ int get_counters(struct thread_data *t, struct co=
re_data *c, struct pkg_data *p)
>
>         if (first_counter_read)
>                 get_apic_id(t);
> -retry:
> +
>         t->tsc =3D rdtsc();       /* we are running on local CPU of inter=
est */
>
>         if (DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_Busy) || DO_BIC(BIC_Bzy_MHz=
) || DO_BIC(BIC_IPC)
>             || soft_c1_residency_display(BIC_Avg_MHz)) {
> -               unsigned long long tsc_before, tsc_between, tsc_after, ap=
erf_time, mperf_time;
> +               int status =3D -1;
>
> -               /*
> -                * The TSC, APERF and MPERF must be read together for
> -                * APERF/MPERF and MPERF/TSC to give accurate results.
> -                *
> -                * Unfortunately, APERF and MPERF are read by
> -                * individual system call, so delays may occur
> -                * between them.  If the time to read them
> -                * varies by a large amount, we re-read them.
> -                */
> +               assert(!no_perf || !no_msr);
>
> -               /*
> -                * This initial dummy APERF read has been seen to
> -                * reduce jitter in the subsequent reads.
> -                */
> -
> -               if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
> -                       return -3;
> -
> -               t->tsc =3D rdtsc();       /* re-read close to APERF */
> -
> -               tsc_before =3D t->tsc;
> -
> -               if (get_msr(cpu, MSR_IA32_APERF, &t->aperf))
> -                       return -3;
> -
> -               tsc_between =3D rdtsc();
> -
> -               if (get_msr(cpu, MSR_IA32_MPERF, &t->mperf))
> -                       return -4;
> -
> -               tsc_after =3D rdtsc();
> -
> -               aperf_time =3D tsc_between - tsc_before;
> -               mperf_time =3D tsc_after - tsc_between;
> -
> -               /*
> -                * If the system call latency to read APERF and MPERF
> -                * differ by more than 2x, then try again.
> -                */
> -               if ((aperf_time > (2 * mperf_time)) || (mperf_time > (2 *=
 aperf_time))) {
> -                       aperf_mperf_retry_count++;
> -                       if (aperf_mperf_retry_count < 5)
> -                               goto retry;
> -                       else
> -                               warnx("cpu%d jitter %lld %lld", cpu, aper=
f_time, mperf_time);
> +               switch (xperf_source) {
> +                       case XPERF_SOURCE_PERF:
> +                               status =3D read_aperf_mperf_tsc_perf(t, c=
pu);
> +                               break;
> +                       case XPERF_SOURCE_MSR:
> +                               status =3D read_aperf_mperf_tsc_msr(t, cp=
u);
> +                               break;
>                 }
> -               aperf_mperf_retry_count =3D 0;
>
> -               t->aperf =3D t->aperf * aperf_mperf_multiplier;
> -               t->mperf =3D t->mperf * aperf_mperf_multiplier;
> +               if (status !=3D 0)
> +                       return status;
>         }
>
>         if (DO_BIC(BIC_IPC))
> @@ -5597,17 +5747,50 @@ void print_dev_latency(void)
>   */
>  void linux_perf_init(void)
>  {
> -       if (!BIC_IS_ENABLED(BIC_IPC))
> -               return;
> -
>         if (access("/proc/sys/kernel/perf_event_paranoid", F_OK))
>                 return;
>
> -       fd_instr_count_percpu =3D calloc(topo.max_cpu_num + 1, sizeof(int=
));
> -       if (fd_instr_count_percpu =3D=3D NULL)
> -               err(-1, "calloc fd_instr_count_percpu");
> +       if (BIC_IS_ENABLED(BIC_IPC)) {
> +               fd_instr_count_percpu =3D calloc(topo.max_cpu_num + 1, si=
zeof(int));
> +               if (fd_instr_count_percpu =3D=3D NULL)
> +                       err(-1, "calloc fd_instr_count_percpu");
>
> -       BIC_PRESENT(BIC_IPC);
> +               BIC_PRESENT(BIC_IPC);
> +       }
> +
> +       const bool aperf_required =3D DO_BIC(BIC_Avg_MHz) || DO_BIC(BIC_B=
usy) ||
> +                                   DO_BIC(BIC_Bzy_MHz) || DO_BIC(BIC_IPC=
);
> +       if (aperf_required && xperf_source =3D=3D XPERF_SOURCE_PERF) {
> +               fd_xperf_percpu =3D calloc(topo.max_cpu_num + 1, sizeof(i=
nt));
> +               if (fd_xperf_percpu =3D=3D NULL)
> +                       err(-1, "calloc fd_xperf_percpu");
> +       }
> +}
> +
> +static int has_xperf_access_via_perf(void)
> +{
> +       if (access("/sys/bus/event_source/devices/msr/type", F_OK))
> +               return 0;
> +
> +       if (access("/sys/bus/event_source/devices/msr/events/aperf", F_OK=
))
> +               return 0;
> +
> +       if (access("/sys/bus/event_source/devices/msr/events/mperf", F_OK=
))
> +               return 0;
> +
> +       return 1;
> +}
> +
> +/* Check if we can access APERF and MPERF */
> +static int has_xperf_access(void)
> +{
> +       if (!no_msr)
> +               return 1;
> +
> +       if (!no_perf && has_xperf_access_via_perf())
> +               return 1;
> +
> +       return 0;
>  }
>
>  void probe_cstates(void)
> @@ -5795,7 +5978,7 @@ void process_cpuid()
>
>         __cpuid(0x6, eax, ebx, ecx, edx);
>         has_aperf =3D ecx & (1 << 0);
> -       if (has_aperf) {
> +       if (has_aperf && has_xperf_access()) {
>                 BIC_PRESENT(BIC_Avg_MHz);
>                 BIC_PRESENT(BIC_Busy);
>                 BIC_PRESENT(BIC_Bzy_MHz);
> @@ -6264,6 +6447,20 @@ void set_base_cpu(void)
>         err(-ENODEV, "No valid cpus found");
>  }
>
> +static void set_xperf_source(void)
> +{
> +       xperf_source =3D XPERF_SOURCE_PERF;
> +
> +       if (no_perf || !has_xperf_access_via_perf())
> +               xperf_source =3D XPERF_SOURCE_MSR;
> +
> +       if (quiet)
> +               return;
> +
> +       fprintf(outf, "aperf/mperf source: %s\n",
> +               xperf_source =3D=3D XPERF_SOURCE_MSR ? "msr" : "perf");
> +}
> +
>  void turbostat_init()
>  {
>         setup_all_buffers(true);
> @@ -6272,6 +6469,7 @@ void turbostat_init()
>         check_permissions();
>         process_cpuid();
>         probe_pm_features();
> +       set_xperf_source();
>         linux_perf_init();
>
>         for_all_cpus(get_cpu_type, ODD_COUNTERS);
> @@ -6859,6 +7057,17 @@ int main(int argc, char **argv)
>
>         turbostat_init();
>
> +       /*
> +        * We can't get TSC tweak in no-msr mode,
> +        * so have to disable more BICs, since we can't report them accur=
ately.
> +        */
> +       if (platform->enable_tsc_tweak && no_msr) {
> +               bic_enabled &=3D ~BIC_Avg_MHz;
> +               bic_enabled &=3D ~BIC_Busy;
> +               bic_enabled &=3D ~BIC_Bzy_MHz;
> +               bic_enabled &=3D ~BIC_IPC;
> +       }
> +
>         if (!no_msr)
>                 msr_sum_record();
>
> --
> 2.43.0
>
>


--=20
Len Brown, Intel

