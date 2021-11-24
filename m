Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA28145B0A1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 01:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhKXAUh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 19:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhKXAUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 19:20:37 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D068C061574
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 16:17:28 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id gu12so500724qvb.6
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 16:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SaDuU9756JcaWakuZtyfngcY5KunoY4sw8GyGkfPJMU=;
        b=WBlkpZEih+M1FwNNrnoh1hBwUHS82Rsw60SHqbdG3zkp7WOgYyyLNyAJ34uIxd2/A2
         NarNAXmuR8BRsR3VDQYrYqDwb3Ye/qSwY0eGNYmJeEvh2m4uojKPvp75vNtw9WYc1otF
         aVV4oKtkm2eJBtJJuzxqR1BrVRd7vvwDBmNrza8Ah4hjpCoKQBIj2TsyZ8Cx1MR5zQK8
         uaIZiG1qhfd2G+YDRFIaMb594+2HnoyaiyF2PTH5zJRB1BGJXaXGBiITUWDcxZ63A5gH
         xoTt2vC1MhEIxjkQhJpvhj05/LrpEyWsuYP+5Ppq1IyCggwqjonp/yM2qLpobR8zZbxy
         zkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaDuU9756JcaWakuZtyfngcY5KunoY4sw8GyGkfPJMU=;
        b=ISUf6sbpU3oo05ctpre4QgQiaUP8agN2vz3XVftAeUdZDHEAZQM5QfUl8JdIm1TzDq
         gfkpoMbYxfwXyFn6LQpm6xjZ4ZH5BffbO/q6nE5Dj6h9vdekJ1ieWUuE9iw0TwIHxa4M
         GEe5RznXTqAlcoDGVHLXCUHwfldx6X1ZSCKQA50DNhzLpwMnAgIOp+mUZ2gXoy6V/ZMo
         ERW6RgbnEFCMyO5Jpp+j0L6Kr6p8DyPZCfRQKFGPiqsjZBaraVa7bqT/aTYnT5U2aE8U
         iiEwKKUnqsM0zQWWsgtOhxx/MkGvSAJi3AiLKzky2rP1NmTjcFFk0XzWYWkEANXbVxR/
         M4RA==
X-Gm-Message-State: AOAM530Gx6R6K08JZ+WvZUW3j1q8hUb/1apywabmSGatYbGIrYBRK7+3
        iexHaTDWU3h7i+3jjQosxtowOtaCKUS11fEmvqdYMA==
X-Google-Smtp-Source: ABdhPJwqZycKlIpo1lIZYbNc5ZBc5lnx90SnGqt0ApSeo3Nm1wL9BvOL4sKRCu8Nvwr58OJnULQ9n3DfmBMg2VqUHxk=
X-Received: by 2002:a05:6214:1c8d:: with SMTP id ib13mr1686975qvb.64.1637713047409;
 Tue, 23 Nov 2021 16:17:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
 <CAHbf0-E5Zrs9-bWYMm8A-RQ7xd0DOCZopzZ2GjtH8xcFf4wVtA@mail.gmail.com>
 <YZzN4Nc2tcclbVIO@hr-amd> <CAHbf0-GPqod-W5exGt4c63YYVG27M4qdSi25wwqmFfC_ypTFyw@mail.gmail.com>
 <YZzRW3pjIoJ4k4O4@hr-amd>
In-Reply-To: <YZzRW3pjIoJ4k4O4@hr-amd>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Wed, 24 Nov 2021 00:17:16 +0000
Message-ID: <CAHbf0-HnJzS7+DaX5o2v4bruVRgpSynDeUvSBhrZnn0NYGkRRw@mail.gmail.com>
Subject: Re: AMD Pstate
To:     Huang Rui <ray.huang@amd.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>, Jinzhou.Su@amd.com,
        Xiaojian.Du@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 23 Nov 2021 at 11:33, Huang Rui <ray.huang@amd.com> wrote:
>
> >
> > Hi
> >
> > Yes I used v4 and CONFIG_CPU_FREQ_GOV_SCHEDUTIL was set as the
> > default, is there any other info that would be useful, I can switch
> > back to schedutil from ondemand and collect for you
> >
>
> > > > That's on a AMD Ryzen 9 5900HX
>
> May I know the CPU family/model id? (you can dump it from lscpu)
>
> But you may need to add "amd_pstate.shared_mem=1" in your grub to enable
> the shared memory manually. Because we are debugging the performance issue
> on shared memory solution, so it is disabled by default.
>
> > > >         amd_des_perf = clamp_t(unsigned long, amd_des_perf,
>
> It's not the V4's codes. I renamed this variate in the V4.
>
> Thanks,
> Ray

Hmm very strange, can you confirm this download from patchwork (which
is what's applied) is correct or not
https://patchwork.kernel.org/series/582973/mbox/

Architecture:            x86_64
 CPU op-mode(s):        32-bit, 64-bit
 Address sizes:         48 bits physical, 48 bits virtual
 Byte Order:            Little Endian
CPU(s):                  16
 On-line CPU(s) list:   0-15
Vendor ID:               AuthenticAMD
 Model name:            AMD Ryzen 9 5900HX with Radeon Graphics
   CPU family:          25
   Model:               80
   Thread(s) per core:  2
   Core(s) per socket:  8
   Socket(s):           1
   Stepping:            0
   Frequency boost:     enabled
   CPU max MHz:         4890.0000
   CPU min MHz:         400.0000
   BogoMIPS:            6587.55
   Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx
mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
nonstop_tsc
                        cpuid extd_apicid aperfmperf rapl pni
pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave
avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a
misaligns
                        se 3dnowprefetch osvw ibs skinit wdt tce
topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3
cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2
smep bm
                        i2 erms invpcid cqm rdt_a rdseed adx
clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
rdpru wbnoinvd cppc
                         arat npt lbrv svm_lock nrip_save tsc_scale
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic
v_vmsave_vmload vgif v_spec_ctrl umip pku vaes vpclmulqdq rdpid
overflow_re
                        cov succor smca fsrm
Virtualization features:
 Virtualization:        AMD-V
Caches (sum of all):
 L1d:                   256 KiB (8 instances)
 L1i:                   256 KiB (8 instances)
 L2:                    4 MiB (8 instances)
 L3:                    16 MiB (1 instance)
Vulnerabilities:
 Itlb multihit:         Not affected
 L1tf:                  Not affected
 Mds:                   Not affected
 Meltdown:              Not affected
 Spec store bypass:     Mitigation; Speculative Store Bypass disabled via prctl
 Spectre v1:            Mitigation; usercopy/swapgs barriers and
__user pointer sanitization
 Spectre v2:            Mitigation; Full AMD retpoline, IBPB
conditional, IBRS_FW, STIBP always-on, RSB filling
 Srbds:                 Not affected
 Tsx async abort:       Not affected
