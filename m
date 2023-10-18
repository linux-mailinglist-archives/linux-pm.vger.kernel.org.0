Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F527CD8DD
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 12:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjJRKJV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRKJU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 06:09:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D35995
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 03:09:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBA2AC433CD
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 10:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697623758;
        bh=JYhK8INZ8n3gvQSHoqgVBUnDGMmEPP5xrGG4WwHMIN4=;
        h=From:To:Subject:Date:From;
        b=dxV5TCyBfNBS9URrAddOFxcKf+BFjFRhrghYjNnz7mIE41FEbJu9M8eSMcOFQw9Ua
         VouqE9f1LwDj/kTVR1q+QzQ4wVWuSCSa/64OFt/z8nwcHWWYPKryt0IDS/hYC33UR5
         FLh9YVxL7wjtI/PhEf75BQhp8ekqAlWqakLVgAAeITbixuelcHNWVIVjuZMx/PlhzU
         RSj/HrUEWwC0jsV9sH0MGHHczVaQhTuAuT0ex2afhbbt57dIlRUPMHuO+J/BNJZjye
         SPk8lgqB/hut+EdKdflpL5F7lEddPwcB+2zKD+1xPMycMP41l6t/ZrkQUJ82i5lTp1
         TG/rbqXshEhtA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C1F00C53BD0; Wed, 18 Oct 2023 10:09:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218023] New: Overheating Ryzen 7 4800Hs processor
Date:   Wed, 18 Oct 2023 10:09:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: workshere359@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-218023-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218023

            Bug ID: 218023
           Summary: Overheating Ryzen 7 4800Hs processor
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: workshere359@gmail.com
        Regression: No

Created attachment 305256
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305256&action=3Dedit
aida 64

Short backstory: I=E2=80=99ve been facing an overheating issue on my ASUS V=
ivobook 14
M1402IA-AM173 laptop running Manjaro (kernel 6.5.3-1-MANJARO, scaling_driver
amd-pstate) with 16GB of RAM and a Ryzen 7 4800Hs processor. Every time I
launch applications like PHPStorm (project indexing) or run PHP unit tests
(Paratest), all CPU cores max out their frequency to the maximum value.
According to htop, it reaches 4300 MHz, and even when the processor heats u=
p,
it doesn=E2=80=99t reduce the frequency to prevent overheating. Eventually,=
 it hits a
critical temperature of 105 degrees, and the laptop shuts down.

I tried running tests on Windows 10 with AIDA64. Within two minutes, I ran =
them
and came to the conclusion that Windows seems to incorrectly detect the fan=
s.
They seemed to be spinning fast, but AIDA was showing only 500-700 RPM (I=
=E2=80=99m not
sure about the accuracy). However, the laptop did not shut down, and the
processor was running at around 3300-3500 MHz and 90 degrees Celsius plus or
minus.

I decided to attach a video showing how it happens. If it=E2=80=99s not too=
 much
trouble, please take a look at it.

VIDEO Here: https://photos.app.goo.gl/JYbrABX7RrEL3i2r5

After long days of suffering and searching for a solution, I was able to fi=
nd a
configuration where my laptop wouldn=E2=80=99t overheat.

Here=E2=80=99s what was done:

1. Install tlp (below I will attach the configuration).
2. Add k10temp Then enable it (sudo modprobe k10temp).
3. Add the following line to the grub configuration: amd_pstate=3Dpassive. =
Update
grub.
After this configuration, my processor frequencies stayed around 3900-3700 =
MHz
=C2=B1. The temperature at its peak was 93 degrees, I saw such numbers once=
. Mostly,
it ranged between 86-90.

works on: 6.5.3-1-MANJARO

CPU_DRIVER_OPMODE_ON_AC=3Dpassive
CPU_DRIVER_OPMODE_ON_BAT=3Dpassive
CPU_SCALING_GOVERNOR_ON_AC=3Dondemand
CPU_SCALING_GOVERNOR_ON_BAT=3Dondemand
CPU_BOOST_ON_AC=3D1
CPU_BOOST_ON_BAT=3D0
CPU_SCALING_MIN_FREQ_ON_AC=3D400000
CPU_SCALING_MAX_FREQ_ON_AC=3D3700000
CPU_SCALING_MIN_FREQ_ON_BAT=3D400000
CPU_SCALING_MAX_FREQ_ON_BAT=3D2900000
CPU_ENERGY_PERF_POLICY_ON_AC=3Dbalance_performance
CPU_ENERGY_PERF_POLICY_ON_BAT=3Dbalance_power.

It seems like something is not working correctly with the fans or the
processor. I've tried it on another system, such as Ubuntu, and the same is=
sue
persists. Right now, everything is functioning, but only with workarounds. I
was advised on a forum to highlight this bug and was directed here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
