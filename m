Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46AA4E5A4B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiCWVCZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Mar 2022 17:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbiCWVCY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2022 17:02:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A8C580FA
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=c00BJuGXr4akEio78w/+ArASFVc4fkGTNW6ATgU6EjU=; b=DHanVfBblbYshur0qvJghbnl0c
        2GW9+H33C+aM/rcUIfi40NXdnwhwJ3dYD71W2ySnL5Y7qS3zJ0zhMc84dptOCoX4D5OA53EupJRH6
        Sov3yl2lp8Uj/lCEdyhubpA3rsUZd5v+/hPODWNcnDh37KZsy4hoGexzZEDXDEUWPbYuFLfwBp8to
        ewblzXJTYF43g3ot/iVyYEPk7oQsEUzyY0gWiu7t4ay4Mu7B0f4G247MYKweWj10x+3GqLDvj9XnS
        LKqJP11dtcT9KVwVamKTLB2mWik4vxkpWkAj0BWJLjdqdr/NWwLpjpypmr6ExM4Is0MJpfZD1euEs
        K6u2uFcg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX861-00CqHV-4P; Wed, 23 Mar 2022 21:00:45 +0000
Message-ID: <ffe84a5e-9788-773a-6326-c9c10f79cf10@infradead.org>
Date:   Wed, 23 Mar 2022 14:00:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Documentation: amd-pstate: grammar and sentence structure
 updates
Content-Language: en-US
To:     Jan Engelhardt <jengelh@inai.de>, ray.huang@amd.com
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org
References: <20220323102602.29259-1-jengelh@inai.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220323102602.29259-1-jengelh@inai.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi--

On 3/23/22 03:26, Jan Engelhardt wrote:
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
> basis is v5.17
>=20
>  Documentation/admin-guide/pm/amd-pstate.rst | 135 ++++++++++----------=

>  1 file changed, 67 insertions(+), 68 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentatio=
n/admin-guide/pm/amd-pstate.rst
> index 2f066df4ee9c..c83db37695da 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -19,7 +19,7 @@ Linux kernel. The new mechanism is based on Collabora=
tive Processor
>  Performance Control (CPPC) which provides finer grain frequency manage=
ment
>  than legacy ACPI hardware P-States. Current AMD CPU/APU platforms are =
using
>  the ACPI P-states driver to manage CPU frequency and clocks with switc=
hing
> -only in 3 P-states. CPPC replaces the ACPI P-states controls, allows a=

> +only in 3 P-states. CPPC replaces the ACPI P-states controls and allow=
s a
>  flexible, low-latency interface for the Linux kernel to directly
>  communicate the performance hints to hardware.
> =20
> @@ -27,7 +27,7 @@ communicate the performance hints to hardware.
>  ``ondemand``, etc. to manage the performance hints which are provided =
by
>  CPPC hardware functionality that internally follows the hardware
>  specification (for details refer to AMD64 Architecture Programmer's Ma=
nual
> -Volume 2: System Programming [1]_). Currently ``amd-pstate`` supports =
basic
> +Volume 2: System Programming [1]_). Currently, ``amd-pstate`` supports=
 basic
>  frequency control function according to kernel governors on some of th=
e
>  Zen2 and Zen3 processors, and we will implement more AMD specific func=
tions
>  in future after we verify them on the hardware and SBIOS.
> @@ -41,9 +41,9 @@ continuous, abstract, and unit-less performance value=
 in a scale that is
>  not tied to a specific performance state / frequency. This is an ACPI
>  standard [2]_ which software can specify application performance goals=
 and
>  hints as a relative target to the infrastructure limits. AMD processor=
s
> -provides the low latency register model (MSR) instead of AML code
> +provide the low latency register model (MSR) instead of an AML code
>  interpreter for performance adjustments. ``amd-pstate`` will initializ=
e a
> -``struct cpufreq_driver`` instance ``amd_pstate_driver`` with the call=
backs
> +``struct cpufreq_driver`` instance, ``amd_pstate_driver``, with the ca=
llbacks
>  to manage each performance update behavior. ::
> =20
>   Highest Perf ------>+-----------------------+                        =
 +-----------------------+
> @@ -91,26 +91,26 @@ AMD CPPC Performance Capability
>  Highest Performance (RO)
>  .........................
> =20
> -It is the absolute maximum performance an individual processor may rea=
ch,
> +This is the absolute maximum performance an individual processor may r=
each,
>  assuming ideal conditions. This performance level may not be sustainab=
le
>  for long durations and may only be achievable if other platform compon=
ents
> -are in a specific state; for example, it may require other processors =
be in
> +are in a specific state; for example, it may require other processors =
to be in
>  an idle state. This would be equivalent to the highest frequencies
>  supported by the processor.
> =20
>  Nominal (Guaranteed) Performance (RO)
>  ......................................
> =20
> -It is the maximum sustained performance level of the processor, assumi=
ng
> -ideal operating conditions. In absence of an external constraint (powe=
r,
> -thermal, etc.) this is the performance level the processor is expected=
 to
> +This is the maximum sustained performance level of the processor, assu=
ming
> +ideal operating conditions. In the absence of an external constraint (=
power,
> +thermal, etc.), this is the performance level the processor is expecte=
d to
>  be able to maintain continuously. All cores/processors are expected to=
 be
>  able to sustain their nominal performance state simultaneously.
> =20
>  Lowest non-linear Performance (RO)
>  ...................................
> =20
> -It is the lowest performance level at which nonlinear power savings ar=
e
> +This is the lowest performance level at which nonlinear power savings =
are
>  achieved, for example, due to the combined effects of voltage and freq=
uency
>  scaling. Above this threshold, lower performance levels should be gene=
rally
>  more energy efficient than higher performance levels. This register
> @@ -119,7 +119,7 @@ effectively conveys the most efficient performance =
level to ``amd-pstate``.
>  Lowest Performance (RO)
>  ........................
> =20
> -It is the absolute lowest performance level of the processor. Selectin=
g a
> +This is the absolute lowest performance level of the processor. Select=
ing a
>  performance level lower than the lowest nonlinear performance level ma=
y
>  cause an efficiency penalty but should reduce the instantaneous power
>  consumption of the processor.
> @@ -149,14 +149,14 @@ a relative number. This can be expressed as perce=
ntage of nominal
>  performance (infrastructure max). Below the nominal sustained performa=
nce
>  level, desired performance expresses the average performance level of =
the
>  processor subject to hardware. Above the nominal performance level,
> -processor must provide at least nominal performance requested and go h=
igher
> +the processor must provide at least nominal performance requested and =
go higher
>  if current operating conditions allow.
> =20
>  Energy Performance Preference (EPP) (RW)
>  .........................................
> =20
> -Provides a hint to the hardware if software wants to bias toward perfo=
rmance
> -(0x0) or energy efficiency (0xff).
> +This attribute provides a hint to the hardware if software wants to bi=
as
> +toward performance (0x0) or energy efficiency (0xff).

Would be nice to say something here like (if this is correct):

This value can be anywhere in the range [0x00, 0x7f]. E.g., 0x80 means
no bias -- performance and energy efficieny are equally important.

> =20
> =20
>  Key Governors Support
> @@ -173,35 +173,34 @@ operating frequencies supported by the hardware. =
Users can check the
>  ``amd-pstate`` mainly supports ``schedutil`` and ``ondemand`` for dyna=
mic
>  frequency control. It is to fine tune the processor configuration on
>  ``amd-pstate`` to the ``schedutil`` with CPU CFS scheduler. ``amd-psta=
te``
> -registers adjust_perf callback to implement the CPPC similar performan=
ce
> -update behavior. It is initialized by ``sugov_start`` and then populat=
e the
> -CPU's update_util_data pointer to assign ``sugov_update_single_perf`` =
as
> -the utilization update callback function in CPU scheduler. CPU schedul=
er
> -will call ``cpufreq_update_util`` and assign the target performance
> -according to the ``struct sugov_cpu`` that utilization update belongs =
to.
> -Then ``amd-pstate`` updates the desired performance according to the C=
PU
> +registers the adjust_perf callback to implement performance update beh=
avior
> +similar to CPPC. It is initialized by ``sugov_start`` and then populat=
es the
> +CPU's update_util_data pointer to assign ``sugov_update_single_perf`` =
as the
> +utilization update callback function in the CPU scheduler. The CPU sch=
eduler
> +will call ``cpufreq_update_util`` and assigns the target performance a=
ccording
> +to the ``struct sugov_cpu`` that the utilization update belongs to.
> +Then, ``amd-pstate`` updates the desired performance according to the =
CPU
>  scheduler assigned.
> =20
> =20
>  Processor Support
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -The ``amd-pstate`` initialization will fail if the _CPC in ACPI SBIOS =
is
> -not existed at the detected processor, and it uses ``acpi_cpc_valid`` =
to
> -check the _CPC existence. All Zen based processors support legacy ACPI=

> -hardware P-States function, so while the ``amd-pstate`` fails to be
> -initialized, the kernel will fall back to initialize ``acpi-cpufreq``
> -driver.
> +The ``amd-pstate`` initialization will fail if the ``_CPC`` entry in t=
he ACPI
> +SBIOS does not exist in the detected processor. It uses ``acpi_cpc_val=
id``
> +to check the existence of ``_CPC``. All Zen based processors support t=
he legacy
> +ACPI hardware P-States function, so when ``amd-pstate`` fails initiali=
zation,
> +the kernel will fall back to initialize the ``acpi-cpufreq`` driver.
> =20
>  There are two types of hardware implementations for ``amd-pstate``: on=
e is
>  `Full MSR Support <perf_cap_>`_ and another is `Shared Memory Support
> -<perf_cap_>`_. It can use :c:macro:`X86_FEATURE_CPPC` feature flag (fo=
r
> -details refer to Processor Programming Reference (PPR) for AMD Family
> -19h Model 51h, Revision A1 Processors [3]_) to indicate the different
> -types. ``amd-pstate`` is to register different ``static_call`` instanc=
es
> -for different hardware implementations.
> +<perf_cap_>`_. It can use the :c:macro:`X86_FEATURE_CPPC` feature flag=
 to

So there are 2 types, but both of them have references to <perf_cap_> ?
Hm, looks like almost everything references <perf_cap_>.

What is "It" in "It can use" ?

> +indicate the different types. (For details, refer to the Processor Pro=
gramming
> +Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors [=
3]_.)
> +``amd-pstate`` is to register different ``static_call`` instances for =
different

                  will register different
or                registers different
?

> +hardware implementations.
> =20
> -Currently, some of Zen2 and Zen3 processors support ``amd-pstate``. In=
 the
> +Currently, some of the Zen2 and Zen3 processors support ``amd-pstate``=
=2E In the
>  future, it will be supported on more and more AMD processors.
> =20
>  Full MSR Support
> @@ -210,18 +209,18 @@ Full MSR Support
>  Some new Zen3 processors such as Cezanne provide the MSR registers dir=
ectly
>  while the :c:macro:`X86_FEATURE_CPPC` CPU feature flag is set.
>  ``amd-pstate`` can handle the MSR register to implement the fast switc=
h
> -function in ``CPUFreq`` that can shrink latency of frequency control o=
n the
> -interrupt context. The functions with ``pstate_xxx`` prefix represent =
the
> -operations of MSR registers.
> +function in ``CPUFreq`` that can reduce the latency of frequency contr=
ol in
> +interrupt context. The functions with a ``pstate_xxx`` prefix represen=
t the
> +operations on MSR registers.
> =20
>  Shared Memory Support
>  ----------------------
> =20
> -If :c:macro:`X86_FEATURE_CPPC` CPU feature flag is not set, that means=
 the
> -processor supports shared memory solution. In this case, ``amd-pstate`=
`
> +If the :c:macro:`X86_FEATURE_CPPC` CPU feature flag is not set, the
> +processor supports the shared memory solution. In this case, ``amd-pst=
ate``
>  uses the ``cppc_acpi`` helper methods to implement the callback functi=
ons
> -that defined on ``static_call``. The functions with ``cppc_xxx`` prefi=
x
> -represent the operations of acpi cppc helpers for shared memory soluti=
on.
> +that are defined on ``static_call``. The functions with the ``cppc_xxx=
`` prefix
> +represent the operations of ACPI CPPC helpers for the shared memory so=
lution.
> =20
> =20
>  AMD P-States and ACPI hardware P-States always can be supported in one=

> @@ -234,7 +233,7 @@ User Space Interface in ``sysfs``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  ``amd-pstate`` exposes several global attributes (files) in ``sysfs`` =
to
> -control its functionality at the system level. They located in the
> +control its functionality at the system level. They are located in the=

>  ``/sys/devices/system/cpu/cpufreq/policyX/`` directory and affect all =
CPUs. ::
> =20
>   root@hr-test1:/home/ray# ls /sys/devices/system/cpu/cpufreq/policy0/*=
amd*
> @@ -246,38 +245,38 @@ control its functionality at the system level. Th=
ey located in the
>  ``amd_pstate_highest_perf / amd_pstate_max_freq``
> =20
>  Maximum CPPC performance and CPU frequency that the driver is allowed =
to
> -set in percent of the maximum supported CPPC performance level (the hi=
ghest
> +set, in percent of the maximum supported CPPC performance level (the h=
ighest
>  performance supported in `AMD CPPC Performance Capability <perf_cap_>`=
_).
> -In some of ASICs, the highest CPPC performance is not the one in the _=
CPC
> -table, so we need to expose it to sysfs. If boost is not active but
> -supported, this maximum frequency will be larger than the one in
> +In some ASICs, the highest CPPC performance is not the one in the ``_C=
PC``
> +table, so we need to expose it to sysfs. If boost is not active, but
> +still supported, this maximum frequency will be larger than the one in=

>  ``cpuinfo``.
>  This attribute is read-only.
> =20
>  ``amd_pstate_lowest_nonlinear_freq``
> =20
> -The lowest non-linear CPPC CPU frequency that the driver is allowed to=
 set
> -in percent of the maximum supported CPPC performance level (Please see=
 the
> +The lowest non-linear CPPC CPU frequency that the driver is allowed to=
 set,
> +in percent of the maximum supported CPPC performance level. (Please se=
e the
>  lowest non-linear performance in `AMD CPPC Performance Capability
> -<perf_cap_>`_).
> +<perf_cap_>`_.)
>  This attribute is read-only.
> =20
> -For other performance and frequency values, we can read them back from=

> +Other performance and frequency values can be read back from
>  ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
> =20
> =20
>  ``amd-pstate`` vs ``acpi-cpufreq``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -On majority of AMD platforms supported by ``acpi-cpufreq``, the ACPI t=
ables
> -provided by the platform firmware used for CPU performance scaling, bu=
t
> -only provides 3 P-states on AMD processors.
> -However, on modern AMD APU and CPU series, it provides the collaborati=
ve
> -processor performance control according to ACPI protocol and customize=
 this
> -for AMD platforms. That is fine-grain and continuous frequency range
> +On the majority of AMD platforms supported by ``acpi-cpufreq``, the AC=
PI tables
> +provided by the platform firmware are used for CPU performance scaling=
, but
> +only provide 3 P-states on AMD processors.
> +However, on modern AMD APU and CPU series, hardware provides the Colla=
borative
> +Processor Performance Control according to the ACPI protocol and custo=
mizes this
> +for AMD platforms. That is, fine-grained and continuous frequency rang=
es
>  instead of the legacy hardware P-states. ``amd-pstate`` is the kernel
> -module which supports the new AMD P-States mechanism on most of future=
 AMD
> -platforms. The AMD P-States mechanism will be the more performance and=
 energy
> +module which supports the new AMD P-States mechanism on most of the fu=
ture AMD
> +platforms. The AMD P-States mechanism is the more performance and ener=
gy
>  efficiency frequency management method on AMD processors.
> =20
>  Kernel Module Options for ``amd-pstate``
> @@ -287,25 +286,25 @@ Kernel Module Options for ``amd-pstate``
>  Use a module param (shared_mem) to enable related processors manually =
with
>  **amd_pstate.shared_mem=3D1**.
>  Due to the performance issue on the processors with `Shared Memory Sup=
port
> -<perf_cap_>`_, so we disable it for the moment and will enable this by=
 default
> -once we address performance issue on this solution.
> +<perf_cap_>`_, we disable it presently and will re-enable this by defa=
ult
> +once we address performance issue with this solution.
> =20
> -The way to check whether current processor is `Full MSR Support <perf_=
cap_>`_
> +To check whether the current processor is using `Full MSR Support <per=
f_cap_>`_
>  or `Shared Memory Support <perf_cap_>`_ : ::
> =20
>    ray@hr-test1:~$ lscpu | grep cppc
>    Flags:                           fpu vme de pse tsc msr pae mce cx8 =
apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall=
 nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_=
tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx1=
6 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp=
_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw i=
bs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwait=
x cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase b=
mi1 avx2 smep bmi2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb=
 sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_tota=
l cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbr=
v svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pause=
filter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip pku ospke v=
aes vpclmulqdq rdpid overflow_recov succor smca fsrm
> =20
> -If CPU Flags have cppc, then this processor supports `Full MSR Support=

> -<perf_cap_>`_. Otherwise it supports `Shared Memory Support <perf_cap_=
>`_.
> +If the CPU flags have ``cppc``, then this processor supports `Full MSR=
 Support
> +<perf_cap_>`_. Otherwise, it supports `Shared Memory Support <perf_cap=
_>`_.
> =20
> =20
>  ``cpupower`` tool support for ``amd-pstate``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -``amd-pstate`` is supported on ``cpupower`` tool that can be used to d=
ump the frequency
> -information. And it is in progress to support more and more operations=
 for new
> -``amd-pstate`` module with this tool. ::
> +``amd-pstate`` is supported by the ``cpupower`` tool, which can be use=
d to dump
> +frequency information. Development is in progress to support more and =
more
> +operations for the new ``amd-pstate`` module with this tool. ::
> =20
>   root@hr-test1:/home/ray# cpupower frequency-info
>   analyzing CPU 0:
> @@ -336,10 +335,10 @@ Trace Events
>  --------------
> =20
>  There are two static trace events that can be used for ``amd-pstate``
> -diagnostics.  One of them is the cpu_frequency trace event generally u=
sed
> +diagnostics. One of them is the ``cpu_frequency`` trace event generall=
y used
>  by ``CPUFreq``, and the other one is the ``amd_pstate_perf`` trace eve=
nt
>  specific to ``amd-pstate``.  The following sequence of shell commands =
can
> -be used to enable them and see their output (if the kernel is generall=
y
> +be used to enable them and see their output (if the kernel is
>  configured to support event tracing). ::
> =20
>   root@hr-test1:/home/ray# cd /sys/kernel/tracing/
> @@ -364,7 +363,7 @@ configured to support event tracing). ::
>            <idle>-0       [003] d.s..  4995.980971: amd_pstate_perf: am=
d_min_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D3 changed=3D=
false fast_switch=3Dtrue
>            <idle>-0       [011] d.s..  4995.980996: amd_pstate_perf: am=
d_min_perf=3D85 amd_des_perf=3D85 amd_max_perf=3D166 cpu_id=3D11 changed=3D=
false fast_switch=3Dtrue
> =20
> -The cpu_frequency trace event will be triggered either by the ``schedu=
til`` scaling
> +The ``cpu_frequency`` trace event will be triggered either by the ``sc=
hedutil`` scaling
>  governor (for the policies it is attached to), or by the ``CPUFreq`` c=
ore (for the
>  policies with other scaling governors).
> =20

Anyway, this is a big improvement. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

--=20
~Randy
