Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB7B4E7CB9
	for <lists+linux-pm@lfdr.de>; Sat, 26 Mar 2022 01:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiCYTbk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 25 Mar 2022 15:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCYTbd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2022 15:31:33 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E33CC065
        for <linux-pm@vger.kernel.org>; Fri, 25 Mar 2022 12:26:26 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id m67so15748944ybm.4
        for <linux-pm@vger.kernel.org>; Fri, 25 Mar 2022 12:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qsfu3TaDc+kIisG7Ty5A0gyIxTe21mt8ZfufQHZSiNc=;
        b=FogZLqfZ0gN7TbMjwHawN9ifbvquSO9sMUuWTn9wHY3nXCj2Upg2i71cAHUXSmG6qI
         /wHU+UyEBQnawBhgIriRb5BmBjlQgNoG9Pje/1rzBPKNVkVzVP5UQNMz3JNoOTaNmBDn
         0yqAdGT8FV9wv0tWIfNR/Q9lS+FIw6WUiM6ogYIQwkll2kAWeMuXoXlMJwOz8GTDrMfV
         g6cCJgYAM1Mfg3677CZXQ661WLsFlE2/MtGKpE5xV2MeG/KtTu3sO5IzCusf3SVuhbh/
         zDVRmUzxv6vEmllorTafhrYpYEMEeeAUEp9gQb4wJu7WykM1DtizrwFZpJfdZfMZCVq/
         s3/A==
X-Gm-Message-State: AOAM533ay7Gz/DNW6LzoK3zPFL3w9greLSB+6KAOGOuzeRAXXcZuwXIG
        XSt4SCxEVshzsbMnpuLnu76HDYlc9NXd6slBW9e1Fu3i
X-Google-Smtp-Source: ABdhPJyRz/ZxzIOAoAjlfKrO53HKWylXjV9hmrZsuP4KNNPfCAKxJFvne8qAbZMLW5p+mTXUfnWA4OXmHviCBzZcFGE=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr10730082ybe.365.1648229497992; Fri, 25
 Mar 2022 10:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220323102602.29259-1-jengelh@inai.de> <ffe84a5e-9788-773a-6326-c9c10f79cf10@infradead.org>
In-Reply-To: <ffe84a5e-9788-773a-6326-c9c10f79cf10@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Mar 2022 18:31:27 +0100
Message-ID: <CAJZ5v0iB99UtayOzP94fayB=moE7dDL9Bnr13RRmEYXtSFJ8eA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: amd-pstate: grammar and sentence structure updates
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jan Engelhardt <jengelh@inai.de>
Cc:     Huang Rui <ray.huang@amd.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 23, 2022 at 10:00 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 3/23/22 03:26, Jan Engelhardt wrote:
> > Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> > ---
> > basis is v5.17
> >
> >  Documentation/admin-guide/pm/amd-pstate.rst | 135 ++++++++++----------
> >  1 file changed, 67 insertions(+), 68 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> > index 2f066df4ee9c..c83db37695da 100644
> > --- a/Documentation/admin-guide/pm/amd-pstate.rst
> > +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> > @@ -19,7 +19,7 @@ Linux kernel. The new mechanism is based on Collaborative Processor
> >  Performance Control (CPPC) which provides finer grain frequency management
> >  than legacy ACPI hardware P-States. Current AMD CPU/APU platforms are using
> >  the ACPI P-states driver to manage CPU frequency and clocks with switching
> > -only in 3 P-states. CPPC replaces the ACPI P-states controls, allows a
> > +only in 3 P-states. CPPC replaces the ACPI P-states controls and allows a
> >  flexible, low-latency interface for the Linux kernel to directly
> >  communicate the performance hints to hardware.
> >
> > @@ -27,7 +27,7 @@ communicate the performance hints to hardware.
> >  ``ondemand``, etc. to manage the performance hints which are provided by
> >  CPPC hardware functionality that internally follows the hardware
> >  specification (for details refer to AMD64 Architecture Programmer's Manual
> > -Volume 2: System Programming [1]_). Currently ``amd-pstate`` supports basic
> > +Volume 2: System Programming [1]_). Currently, ``amd-pstate`` supports basic
> >  frequency control function according to kernel governors on some of the
> >  Zen2 and Zen3 processors, and we will implement more AMD specific functions
> >  in future after we verify them on the hardware and SBIOS.
> > @@ -41,9 +41,9 @@ continuous, abstract, and unit-less performance value in a scale that is
> >  not tied to a specific performance state / frequency. This is an ACPI
> >  standard [2]_ which software can specify application performance goals and
> >  hints as a relative target to the infrastructure limits. AMD processors
> > -provides the low latency register model (MSR) instead of AML code
> > +provide the low latency register model (MSR) instead of an AML code
> >  interpreter for performance adjustments. ``amd-pstate`` will initialize a
> > -``struct cpufreq_driver`` instance ``amd_pstate_driver`` with the callbacks
> > +``struct cpufreq_driver`` instance, ``amd_pstate_driver``, with the callbacks
> >  to manage each performance update behavior. ::
> >
> >   Highest Perf ------>+-----------------------+                         +-----------------------+
> > @@ -91,26 +91,26 @@ AMD CPPC Performance Capability
> >  Highest Performance (RO)
> >  .........................
> >
> > -It is the absolute maximum performance an individual processor may reach,
> > +This is the absolute maximum performance an individual processor may reach,
> >  assuming ideal conditions. This performance level may not be sustainable
> >  for long durations and may only be achievable if other platform components
> > -are in a specific state; for example, it may require other processors be in
> > +are in a specific state; for example, it may require other processors to be in
> >  an idle state. This would be equivalent to the highest frequencies
> >  supported by the processor.
> >
> >  Nominal (Guaranteed) Performance (RO)
> >  ......................................
> >
> > -It is the maximum sustained performance level of the processor, assuming
> > -ideal operating conditions. In absence of an external constraint (power,
> > -thermal, etc.) this is the performance level the processor is expected to
> > +This is the maximum sustained performance level of the processor, assuming
> > +ideal operating conditions. In the absence of an external constraint (power,
> > +thermal, etc.), this is the performance level the processor is expected to
> >  be able to maintain continuously. All cores/processors are expected to be
> >  able to sustain their nominal performance state simultaneously.
> >
> >  Lowest non-linear Performance (RO)
> >  ...................................
> >
> > -It is the lowest performance level at which nonlinear power savings are
> > +This is the lowest performance level at which nonlinear power savings are
> >  achieved, for example, due to the combined effects of voltage and frequency
> >  scaling. Above this threshold, lower performance levels should be generally
> >  more energy efficient than higher performance levels. This register
> > @@ -119,7 +119,7 @@ effectively conveys the most efficient performance level to ``amd-pstate``.
> >  Lowest Performance (RO)
> >  ........................
> >
> > -It is the absolute lowest performance level of the processor. Selecting a
> > +This is the absolute lowest performance level of the processor. Selecting a
> >  performance level lower than the lowest nonlinear performance level may
> >  cause an efficiency penalty but should reduce the instantaneous power
> >  consumption of the processor.
> > @@ -149,14 +149,14 @@ a relative number. This can be expressed as percentage of nominal
> >  performance (infrastructure max). Below the nominal sustained performance
> >  level, desired performance expresses the average performance level of the
> >  processor subject to hardware. Above the nominal performance level,
> > -processor must provide at least nominal performance requested and go higher
> > +the processor must provide at least nominal performance requested and go higher
> >  if current operating conditions allow.
> >
> >  Energy Performance Preference (EPP) (RW)
> >  .........................................
> >
> > -Provides a hint to the hardware if software wants to bias toward performance
> > -(0x0) or energy efficiency (0xff).
> > +This attribute provides a hint to the hardware if software wants to bias
> > +toward performance (0x0) or energy efficiency (0xff).
>
> Would be nice to say something here like (if this is correct):
>
> This value can be anywhere in the range [0x00, 0x7f]. E.g., 0x80 means
> no bias -- performance and energy efficieny are equally important.
>
> >
> >
> >  Key Governors Support
> > @@ -173,35 +173,34 @@ operating frequencies supported by the hardware. Users can check the
> >  ``amd-pstate`` mainly supports ``schedutil`` and ``ondemand`` for dynamic
> >  frequency control. It is to fine tune the processor configuration on
> >  ``amd-pstate`` to the ``schedutil`` with CPU CFS scheduler. ``amd-pstate``
> > -registers adjust_perf callback to implement the CPPC similar performance
> > -update behavior. It is initialized by ``sugov_start`` and then populate the
> > -CPU's update_util_data pointer to assign ``sugov_update_single_perf`` as
> > -the utilization update callback function in CPU scheduler. CPU scheduler
> > -will call ``cpufreq_update_util`` and assign the target performance
> > -according to the ``struct sugov_cpu`` that utilization update belongs to.
> > -Then ``amd-pstate`` updates the desired performance according to the CPU
> > +registers the adjust_perf callback to implement performance update behavior
> > +similar to CPPC. It is initialized by ``sugov_start`` and then populates the
> > +CPU's update_util_data pointer to assign ``sugov_update_single_perf`` as the
> > +utilization update callback function in the CPU scheduler. The CPU scheduler
> > +will call ``cpufreq_update_util`` and assigns the target performance according
> > +to the ``struct sugov_cpu`` that the utilization update belongs to.
> > +Then, ``amd-pstate`` updates the desired performance according to the CPU
> >  scheduler assigned.
> >
> >
> >  Processor Support
> >  =======================
> >
> > -The ``amd-pstate`` initialization will fail if the _CPC in ACPI SBIOS is
> > -not existed at the detected processor, and it uses ``acpi_cpc_valid`` to
> > -check the _CPC existence. All Zen based processors support legacy ACPI
> > -hardware P-States function, so while the ``amd-pstate`` fails to be
> > -initialized, the kernel will fall back to initialize ``acpi-cpufreq``
> > -driver.
> > +The ``amd-pstate`` initialization will fail if the ``_CPC`` entry in the ACPI
> > +SBIOS does not exist in the detected processor. It uses ``acpi_cpc_valid``
> > +to check the existence of ``_CPC``. All Zen based processors support the legacy
> > +ACPI hardware P-States function, so when ``amd-pstate`` fails initialization,
> > +the kernel will fall back to initialize the ``acpi-cpufreq`` driver.
> >
> >  There are two types of hardware implementations for ``amd-pstate``: one is
> >  `Full MSR Support <perf_cap_>`_ and another is `Shared Memory Support
> > -<perf_cap_>`_. It can use :c:macro:`X86_FEATURE_CPPC` feature flag (for
> > -details refer to Processor Programming Reference (PPR) for AMD Family
> > -19h Model 51h, Revision A1 Processors [3]_) to indicate the different
> > -types. ``amd-pstate`` is to register different ``static_call`` instances
> > -for different hardware implementations.
> > +<perf_cap_>`_. It can use the :c:macro:`X86_FEATURE_CPPC` feature flag to
>
> So there are 2 types, but both of them have references to <perf_cap_> ?
> Hm, looks like almost everything references <perf_cap_>.
>
> What is "It" in "It can use" ?
>
> > +indicate the different types. (For details, refer to the Processor Programming
> > +Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors [3]_.)
> > +``amd-pstate`` is to register different ``static_call`` instances for different
>
>                   will register different
> or                registers different
> ?
>
> > +hardware implementations.
> >
> > -Currently, some of Zen2 and Zen3 processors support ``amd-pstate``. In the
> > +Currently, some of the Zen2 and Zen3 processors support ``amd-pstate``. In the
> >  future, it will be supported on more and more AMD processors.
> >
> >  Full MSR Support
> > @@ -210,18 +209,18 @@ Full MSR Support
> >  Some new Zen3 processors such as Cezanne provide the MSR registers directly
> >  while the :c:macro:`X86_FEATURE_CPPC` CPU feature flag is set.
> >  ``amd-pstate`` can handle the MSR register to implement the fast switch
> > -function in ``CPUFreq`` that can shrink latency of frequency control on the
> > -interrupt context. The functions with ``pstate_xxx`` prefix represent the
> > -operations of MSR registers.
> > +function in ``CPUFreq`` that can reduce the latency of frequency control in
> > +interrupt context. The functions with a ``pstate_xxx`` prefix represent the
> > +operations on MSR registers.
> >
> >  Shared Memory Support
> >  ----------------------
> >
> > -If :c:macro:`X86_FEATURE_CPPC` CPU feature flag is not set, that means the
> > -processor supports shared memory solution. In this case, ``amd-pstate``
> > +If the :c:macro:`X86_FEATURE_CPPC` CPU feature flag is not set, the
> > +processor supports the shared memory solution. In this case, ``amd-pstate``
> >  uses the ``cppc_acpi`` helper methods to implement the callback functions
> > -that defined on ``static_call``. The functions with ``cppc_xxx`` prefix
> > -represent the operations of acpi cppc helpers for shared memory solution.
> > +that are defined on ``static_call``. The functions with the ``cppc_xxx`` prefix
> > +represent the operations of ACPI CPPC helpers for the shared memory solution.
> >
> >
> >  AMD P-States and ACPI hardware P-States always can be supported in one
> > @@ -234,7 +233,7 @@ User Space Interface in ``sysfs``
> >  ==================================
> >
> >  ``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
> > -control its functionality at the system level. They located in the
> > +control its functionality at the system level. They are located in the
> >  ``/sys/devices/system/cpu/cpufreq/policyX/`` directory and affect all CPUs. ::
> >
> >   root@hr-test1:/home/ray# ls /sys/devices/system/cpu/cpufreq/policy0/*amd*
> > @@ -246,38 +245,38 @@ control its functionality at the system level. They located in the
> >  ``amd_pstate_highest_perf / amd_pstate_max_freq``
> >
> >  Maximum CPPC performance and CPU frequency that the driver is allowed to
> > -set in percent of the maximum supported CPPC performance level (the highest
> > +set, in percent of the maximum supported CPPC performance level (the highest
> >  performance supported in `AMD CPPC Performance Capability <perf_cap_>`_).
> > -In some of ASICs, the highest CPPC performance is not the one in the _CPC
> > -table, so we need to expose it to sysfs. If boost is not active but
> > -supported, this maximum frequency will be larger than the one in
> > +In some ASICs, the highest CPPC performance is not the one in the ``_CPC``
> > +table, so we need to expose it to sysfs. If boost is not active, but
> > +still supported, this maximum frequency will be larger than the one in
> >  ``cpuinfo``.
> >  This attribute is read-only.
> >
> >  ``amd_pstate_lowest_nonlinear_freq``
> >
> > -The lowest non-linear CPPC CPU frequency that the driver is allowed to set
> > -in percent of the maximum supported CPPC performance level (Please see the
> > +The lowest non-linear CPPC CPU frequency that the driver is allowed to set,
> > +in percent of the maximum supported CPPC performance level. (Please see the
> >  lowest non-linear performance in `AMD CPPC Performance Capability
> > -<perf_cap_>`_).
> > +<perf_cap_>`_.)
> >  This attribute is read-only.
> >
> > -For other performance and frequency values, we can read them back from
> > +Other performance and frequency values can be read back from
> >  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
> >
> >
> >  ``amd-pstate`` vs ``acpi-cpufreq``
> >  ======================================
> >
> > -On majority of AMD platforms supported by ``acpi-cpufreq``, the ACPI tables
> > -provided by the platform firmware used for CPU performance scaling, but
> > -only provides 3 P-states on AMD processors.
> > -However, on modern AMD APU and CPU series, it provides the collaborative
> > -processor performance control according to ACPI protocol and customize this
> > -for AMD platforms. That is fine-grain and continuous frequency range
> > +On the majority of AMD platforms supported by ``acpi-cpufreq``, the ACPI tables
> > +provided by the platform firmware are used for CPU performance scaling, but
> > +only provide 3 P-states on AMD processors.
> > +However, on modern AMD APU and CPU series, hardware provides the Collaborative
> > +Processor Performance Control according to the ACPI protocol and customizes this
> > +for AMD platforms. That is, fine-grained and continuous frequency ranges
> >  instead of the legacy hardware P-states. ``amd-pstate`` is the kernel
> > -module which supports the new AMD P-States mechanism on most of future AMD
> > -platforms. The AMD P-States mechanism will be the more performance and energy
> > +module which supports the new AMD P-States mechanism on most of the future AMD
> > +platforms. The AMD P-States mechanism is the more performance and energy
> >  efficiency frequency management method on AMD processors.
> >
> >  Kernel Module Options for ``amd-pstate``
> > @@ -287,25 +286,25 @@ Kernel Module Options for ``amd-pstate``
> >  Use a module param (shared_mem) to enable related processors manually with
> >  **amd_pstate.shared_mem=1**.
> >  Due to the performance issue on the processors with `Shared Memory Support
> > -<perf_cap_>`_, so we disable it for the moment and will enable this by default
> > -once we address performance issue on this solution.
> > +<perf_cap_>`_, we disable it presently and will re-enable this by default
> > +once we address performance issue with this solution.
> >
> > -The way to check whether current processor is `Full MSR Support <perf_cap_>`_
> > +To check whether the current processor is using `Full MSR Support <perf_cap_>`_
> >  or `Shared Memory Support <perf_cap_>`_ : ::
> >
> >    ray@hr-test1:~$ lscpu | grep cppc
> >    Flags:                           fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflow_recov succor smca fsrm
> >
> > -If CPU Flags have cppc, then this processor supports `Full MSR Support
> > -<perf_cap_>`_. Otherwise it supports `Shared Memory Support <perf_cap_>`_.
> > +If the CPU flags have ``cppc``, then this processor supports `Full MSR Support
> > +<perf_cap_>`_. Otherwise, it supports `Shared Memory Support <perf_cap_>`_.
> >
> >
> >  ``cpupower`` tool support for ``amd-pstate``
> >  ===============================================
> >
> > -``amd-pstate`` is supported on ``cpupower`` tool that can be used to dump the frequency
> > -information. And it is in progress to support more and more operations for new
> > -``amd-pstate`` module with this tool. ::
> > +``amd-pstate`` is supported by the ``cpupower`` tool, which can be used to dump
> > +frequency information. Development is in progress to support more and more
> > +operations for the new ``amd-pstate`` module with this tool. ::
> >
> >   root@hr-test1:/home/ray# cpupower frequency-info
> >   analyzing CPU 0:
> > @@ -336,10 +335,10 @@ Trace Events
> >  --------------
> >
> >  There are two static trace events that can be used for ``amd-pstate``
> > -diagnostics.  One of them is the cpu_frequency trace event generally used
> > +diagnostics. One of them is the ``cpu_frequency`` trace event generally used
> >  by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace event
> >  specific to ``amd-pstate``.  The following sequence of shell commands can
> > -be used to enable them and see their output (if the kernel is generally
> > +be used to enable them and see their output (if the kernel is
> >  configured to support event tracing). ::
> >
> >   root@hr-test1:/home/ray# cd /sys/kernel/tracing/
> > @@ -364,7 +363,7 @@ configured to support event tracing). ::
> >            <idle>-0       [003] d.s..  4995.980971: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=3 changed=false fast_switch=true
> >            <idle>-0       [011] d.s..  4995.980996: amd_pstate_perf: amd_min_perf=85 amd_des_perf=85 amd_max_perf=166 cpu_id=11 changed=false fast_switch=true
> >
> > -The cpu_frequency trace event will be triggered either by the ``schedutil`` scaling
> > +The ``cpu_frequency`` trace event will be triggered either by the ``schedutil`` scaling
> >  governor (for the policies it is attached to), or by the ``CPUFreq`` core (for the
> >  policies with other scaling governors).
> >
>
> Anyway, this is a big improvement. Thanks.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Applied as 5.18-rc material, thanks!
