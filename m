Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EFB2440FE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMV5y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 13 Aug 2020 17:57:54 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:41782 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMV5y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:57:54 -0400
Received: by mail-ej1-f66.google.com with SMTP id t10so7820552ejs.8
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2020 14:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GJfCmpq2zYvo74FOocH3q/fg9vH2Av2OWKWzz3OxAYs=;
        b=gjmjpwRAoC4vDCqipJwjGW3NJUKGQ7hFnp6uMMRw2fdfCfyJZ8hHPMVin2W+XbgIPx
         RkIp8h1djQOcd/ay1/yJGeHCqnv3OXx5Q2mPJ3MsMYPy8vv+DQ5oT71qIXDY66eJA6UV
         taGzN+meGLbXiNiC/6a2+9FfmzxSi7cO6Rp8IoP72IBkP5EhZVYz9c3sHWZLFgfb47OT
         gzJ0KyE3n3umprLui+pQ5z64mVNH/ozOoKYfzS+uyhMDY+j0746Oe205ac5B3wf16JLK
         mIvGpqFDZfy3zYktRy81X5CgxAxZsndFRqoIVNbsESWmY/28w/A+rtCsNtx7zeLQH6/p
         gwlw==
X-Gm-Message-State: AOAM533siPWVBkbR7EEr/gfaTtJp8OGcGlm9BThvW6LniymZrc/J+ii7
        s+yvvgPsSfZk4lU1WBKxfNRW97NtGQwgezDuEKM=
X-Google-Smtp-Source: ABdhPJyW30MJgfFzLzdX0qtl/sXuHmpCGyT7yD93XO9IHuExZXzilZyy9WDFrfnhbO1G417Hys/3WVmzfdWE5E6yows=
X-Received: by 2002:a17:906:b157:: with SMTP id bt23mr7109973ejb.354.1597355870977;
 Thu, 13 Aug 2020 14:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <flspncygsvj.fsf@redhat.com> <1A7043D5F58CCB44A599DFD55ED4C94881B93DF1@fmsmsx101.amr.corp.intel.com>
 <flseet7f8tj.fsf@redhat.com>
In-Reply-To: <flseet7f8tj.fsf@redhat.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 13 Aug 2020 17:57:40 -0400
Message-ID: <CAJvTdKnUupXKH09yR-qzHy=xZ8wg_zk1maMPmdtGXWgr1VBUXg@mail.gmail.com>
Subject: Re: x86_energy_perf_policy fails with Input/output error in a VM
To:     =?UTF-8?B?T25kxZllaiBMeXNvbsSbaw==?= <olysonek@redhat.com>
Cc:     "Brown, Len" <len.brown@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Applied.

thanks!
-Len

On Wed, Apr 1, 2020 at 12:51 PM Ondřej Lysoněk <olysonek@redhat.com> wrote:
>
> Hi,
>
> "Brown, Len" <len.brown@intel.com> writes:
>
> > Thanks for the note,
> >
> > I agree that is unfriendly how the tool tells the user that it is not possible for it to run in a VM guest.
> > If people are running into that, and we can make it more graceful, we should.
>
> My use case is being able to differentiate why x86_energy_perf_policy
> failed in programs that use it, namely Tuned [1].
>
> >
> > Is parsing /proc/cpuinfo a universal/reliable way to detect this situation?
>
> From what I've read it seems that it's possible to create a VM that does
> not have 'hypervisor' in CPU flags. However I don't think this is a
> problem for us - false negatives in the detection will just preserve the
> current behaviour.
>
> Regarding the reverse case, to get the 'hypervisor' CPU flag on bare
> metal, you'd have to change the CPU microcode so that the CPUID
> instruction returns different values, as far as I understand it.
>
> Also, the kernel uses the 'hypervisor' flag (X86_FEATURE_HYPERVISOR)
> internally in a number of places to detect a virtual machine. E.g.
> arch/x86/events/core.c:270 or drivers/acpi/processor_idle.c:509 as of
> commit 9420e8ade4353a6710.
>
> However, perhaps it would be good to change the patch so that it prints
> the original msr reading error in cases where /proc/cpuinfo is unavailable.
>
> I've fixed up the patch a bit and changed it so that it searches only
> for whole words '\<hypervisor\>' on lines beginning with
> 'flags\t\t'. This should make it more reliable.
>
> Consider the patch
> Signed-off-by: Ondřej Lysoněk <olysonek@redhat.com>
>
> [1] https://github.com/redhat-performance/tuned/blob/master/tuned/plugins/plugin_cpu.py#L96
>
> Ondrej Lysonek
>
>
> diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> index 3fe1eed900d4..29e0afbb7b4f 100644
> --- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> +++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
> @@ -622,6 +622,77 @@ void cmdline(int argc, char **argv)
>         }
>  }
>
> +/*
> + * Open a file, and exit on failure
> + */
> +FILE *fopen_or_die(const char *path, const char *mode)
> +{
> +       FILE *filep = fopen(path, "r");
> +
> +       if (!filep)
> +               err(1, "%s: open failed", path);
> +       return filep;
> +}
> +
> +void err_on_hypervisor(void)
> +{
> +       FILE *cpuinfo;
> +       char *buffer;
> +       char *flags;
> +       char *start_pos, *stop_pos;
> +       const char *err_msg = NULL;
> +       const char *hypervisor = " hypervisor";
> +
> +       /* On VMs, /proc/cpuinfo contains a "hypervisor" flags entry */
> +       cpuinfo = fopen_or_die("/proc/cpuinfo", "ro");
> +
> +       buffer = malloc(4096);
> +       if (!buffer) {
> +               err_msg = "buffer malloc failed";
> +               goto close_file;
> +       }
> +
> +       if (!fread(buffer, 1024, 1, cpuinfo)) {
> +               err_msg = "Reading /proc/cpuinfo failed";
> +               goto free_mem;
> +       }
> +
> +       flags = strstr(buffer, "flags\t\t");
> +       if (!flags || (flags > buffer && *(flags - 1) != '\n'))
> +               goto free_mem;
> +
> +       if (fseek(cpuinfo, flags - buffer, SEEK_SET)) {
> +               err_msg = "fseek on /proc/cpuinfo failed";
> +               goto free_mem;
> +       }
> +       if (!fgets(buffer, 4096, cpuinfo)) {
> +               err_msg = "Reading /proc/cpuinfo failed";
> +               goto free_mem;
> +       }
> +
> +       start_pos = buffer;
> +       while (1) {
> +               start_pos = strstr(start_pos, hypervisor);
> +               stop_pos = start_pos + strlen(hypervisor);
> +               if (!start_pos || (*stop_pos == ' ' ||
> +                                  *stop_pos == '\n' ||
> +                                  *stop_pos == '\0'))
> +                       break;
> +               start_pos = stop_pos;
> +       }
> +
> +       if (start_pos) {
> +               err_msg = "not supported on this virtual machine";
> +       }
> +
> +free_mem:
> +       free(buffer);
> +close_file:
> +       fclose(cpuinfo);
> +
> +       if (err_msg)
> +               err(1, err_msg);
> +}
>
>  int get_msr(int cpu, int offset, unsigned long long *msr)
>  {
> @@ -635,8 +706,10 @@ int get_msr(int cpu, int offset, unsigned long long *msr)
>                 err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
>
>         retval = pread(fd, msr, sizeof(*msr), offset);
> -       if (retval != sizeof(*msr))
> +       if (retval != sizeof(*msr)) {
> +               err_on_hypervisor();
>                 err(-1, "%s offset 0x%llx read failed", pathname, (unsigned long long)offset);
> +       }
>
>         if (debug > 1)
>                 fprintf(stderr, "get_msr(cpu%d, 0x%X, 0x%llX)\n", cpu, offset, *msr);
> @@ -1086,18 +1159,6 @@ int update_cpu_msrs(int cpu)
>         return 0;
>  }
>
> -/*
> - * Open a file, and exit on failure
> - */
> -FILE *fopen_or_die(const char *path, const char *mode)
> -{
> -       FILE *filep = fopen(path, "r");
> -
> -       if (!filep)
> -               err(1, "%s: open failed", path);
> -       return filep;
> -}
> -
>  unsigned int get_pkg_num(int cpu)
>  {
>         FILE *fp;
> --
>


-- 
Len Brown, Intel Open Source Technology Center
