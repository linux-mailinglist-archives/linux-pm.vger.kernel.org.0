Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761C34E555F
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 16:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiCWPh2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Mar 2022 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiCWPh2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2022 11:37:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1200E6245
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 08:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80ADAB81DE7
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 15:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 462ECC340E9
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648049755;
        bh=LE4UHiaz1yjtVd0KbNpGITzarjS5xyl1vtJN+XKbRQs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dY1Hkw7+/ww8B0nnVXZB5imfUUyjVUrYVarPzydRwh9YjnzLfyXqrJ/cnjz5Zpr0Y
         YPP3Ty39eGqUbmGb9xXWvH9dGjasCITlKlr1Ptk6AIlgyNOUhUy/+VkVU7TgitxB5u
         w6HM0H4CVXvu61bmGtj27KEVbFiJ0gIN1mUnC21/IaZXzL+gPRB8zXb9HyBZK3n5Nv
         A8lqTdkXsMIQs8Pup0AG++qctcVGJ2S2V1396GVob2/LsPrbgk3ks6FZKS3QDAs/zK
         akBSwsg/dumVuK5TTSSz8SYpoBkhTM0HF3T4BtaYcNYnOE/pgetFkNvPCPEulKr8cl
         8cDFLaLeeMUmQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2B3B1CAC6E2; Wed, 23 Mar 2022 15:35:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Wed, 23 Mar 2022 15:35:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215729-137361-on0aLTT4Qj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215729-137361@https.bugzilla.kernel.org/>
References: <bug-215729-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
With acpi-cpufreq:

# lscpu

Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         48 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  16
  On-line CPU(s) list:   0-15
Vendor ID:               AuthenticAMD
  BIOS Vendor ID:        Advanced Micro Devices, Inc.
  Model name:            AMD Ryzen 7 5800X 8-Core Processor
    BIOS Model name:     AMD Ryzen 7 5800X 8-Core Processor=20=20=20=20=20=
=20=20=20=20=20=20=20=20
    CPU family:          25
    Model:               33
    Thread(s) per core:  2
    Core(s) per socket:  8
    Socket(s):           1
    Stepping:            0
    Frequency boost:     enabled
    CPU max MHz:         4928.1250
    CPU min MHz:         2200.0000
    BogoMIPS:            7600.48
    Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr p=
ge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid
aperfmperf rapl pni pclmul
                         qdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe pop=
cnt
aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse=
4a
misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core
perfctr_nb bpext perfctr_l
                         lc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs
ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a rdse=
ed
adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
cqm_occup_llc cqm_mbm_total=20
                         cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoi=
nvd
arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeass=
ists
pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip pku vaes
vpclmulqdq rdpid ov
                         erflow_recov succor smca fsrm
Virtualization features:=20
  Virtualization:        AMD-V
Caches (sum of all):=20=20=20=20=20
  L1d:                   256 KiB (8 instances)
  L1i:                   256 KiB (8 instances)
  L2:                    4 MiB (8 instances)
  L3:                    32 MiB (1 instance)
Vulnerabilities:=20=20=20=20=20=20=20=20=20
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Spec store bypass:     Mitigation; Speculative Store Bypass disabled via
prctl
  Spectre v1:            Mitigation; usercopy/swapgs barriers and __user
pointer sanitization
  Spectre v2:            Mitigation; Retpolines, IBPB conditional, IBRS_FW,
STIBP always-on, RSB filling
  Srbds:                 Not affected
  Tsx async abort:       Not affected

# ./cpupower frequency-info
analyzing CPU 0:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 2.20 GHz - 4.93 GHz
  available frequency steps:  3.80 GHz, 2.80 GHz, 2.20 GHz
  available cpufreq governors: conservative ondemand userspace powersave
performance schedutil
  current policy: frequency should be within 2.20 GHz and 3.80 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency: 2.20 GHz (asserted by call to hardware)
  boost state support:
    Supported: yes
    Active: yes
    Boost States: 0
    Total States: 3
    Pstate-P0:  3800MHz
    Pstate-P1:  2800MHz
    Pstate-P2:  2200MHz

Will post the results of `cpupower frequency-info` under amd-pstate a tad
later.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
