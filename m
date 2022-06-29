Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B0156045C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 17:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiF2PVl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 11:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiF2PVk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 11:21:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5042CDF2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 08:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E34B2B824DD
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 15:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8211AC341CB
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656516096;
        bh=ZDCDwpca81bkD7zfj/ZeuVqZ6HEMCvFZH+Pt1rVzrs0=;
        h=From:To:Subject:Date:From;
        b=h1X1dCKGVUdldIwir2N6gGyndoyEkLSdtGwOBauE+hgBJJWTQzEYHTgKop2c4raUw
         v8bMIycIYGu/7OeBaPK2B8ntppAsAnoUKMv3ae3ErvGFWWfQeP7CVjSPCt4XTY+GOd
         S6gHnMda43wKV45iJU8zb7w+6oeG/ciUIlSxfUyvxlIvCHZMjPvyKnHPHwF8/uQEn3
         +4jw47JOaGu8SGE4ZCsdQLBvIlbQ5PSfkYAGjy/I9z+6miv3/eweL6QKhm8u+I/Rfu
         q/z0WZhl9ioaynW0xv65beFj5hT1R3TUVgSQwGBCpK8LY/+sDZt9TiZKyE5cVu4wqf
         VIL3CGRHs982g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 68769C05FF5; Wed, 29 Jun 2022 15:21:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216189] New: amd-pstate stops working after S3 suspend
Date:   Wed, 29 Jun 2022 15:21:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: a@annel.in
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216189-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216189

            Bug ID: 216189
           Summary: amd-pstate stops working after S3 suspend
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.18.8
          Hardware: AMD
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: a@annel.in
        Regression: No

Hardware: Lenovo Thinkpad T14 Gen2 AMD=20=20
CPU: AMD Ryzen 7 PRO 5850U=20=20
Kernel: 5.18.8  (tried linux-next too)=20=20


I've managed to get new `amd-pstate` driver working on my system, but after
suspend (S3) it stops working and CPU frequency and Boost state control is =
not
working.=20

Falling back to `acpi-cpufreq` driver solves the issue =E2=80=94 suspend no=
 longer
breaks CPU frequency and Boost controls.=20


```
    ~ sudo cpupower frequency-info=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
    analyzing CPU 0:
      driver: amd-pstate
      CPUs which run at the same hardware frequency: 0
      CPUs which need to have their frequency coordinated by software: 0
      maximum transition latency: 131 us
      hardware limits: 400 MHz - 1.90 GHz
      available cpufreq governors: ondemand performance schedutil
      current policy: frequency should be within 800 MHz and 1.50 GHz.
                      The governor "ondemand" may decide which speed to use
                      within this range.
      current CPU frequency: Unable to call hardware
      current CPU frequency: 3.41 GHz (asserted by call to kernel)

     boost state support:
        Supported: yes
        Active: no
        AMD PSTATE Highest Performance: 166. Maximum Frequency: 4.51 GHz.
        AMD PSTATE Nominal Performance: 70. Nominal Frequency: 1.90 GHz.
        AMD PSTATE Lowest Non-linear Performance: 41. Lowest Non-linear
Frequency: 1.11 GHz.
        AMD PSTATE Lowest Performance: 15. Lowest Frequency: 400 MHz.
```

As we see here, frequency limits are set to 800 MHz - 1.50 GHz and boost st=
ats
is inactive, but actual CPU frequency 3.41 GHz (that means boost is on and
limits are ignored)=20=20

The things starts working again only after reboot.=20=20

Any commands such as=20
```
echo 1 > /sys/devices/system/cpu/cpufreq/boost
echo 0 > /sys/devices/system/cpu/cpufreq/boost
cpupower frequency-set -g ondemand -d 400MHz -u 800MHz
cpupower frequency-set -g performance -d 1.9GHz -u 1.9GHz

```

just does nothing. (after reboot they start working again of course)=20=20


There are no mentions of pstate module in dmesg, but maybe I have to enable
some debug (how to do it?)=20=20

Simillar bug for intel_pstate:
https://bugzilla.kernel.org/show_bug.cgi?id=3D90421=20=20
Maybe it is related some way.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
