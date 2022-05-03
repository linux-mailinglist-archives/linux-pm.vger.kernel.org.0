Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F899518802
	for <lists+linux-pm@lfdr.de>; Tue,  3 May 2022 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiECPNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 May 2022 11:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbiECPNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2022 11:13:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2081E3B003
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 08:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB8CEB81ED0
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 15:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56E7EC385A4
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651590570;
        bh=P4m+sGkIKiZnUwUw7HipcwL0pw96ASnEf+jcB8YF0PU=;
        h=From:To:Subject:Date:From;
        b=EOMLCV4A/MDKRI4u1rNzgRTKEW2OTfhq7h5faHdVkteSMsNzqY/tQIz9cX4Ux7wai
         sgIJ0PRHvnEGCIjzQljAr+POdTOP3ayXwGOvuy24tz8p9u7meoFaMtqlLlO25TcG6i
         m4vrjpKVMMKTRweTb96RNVfkoYiPG8FaD7uo1GVXUQAuRX8o/wrEWZeju+gR6r7zWQ
         70TplsCYi8XW3geynkpjcFrZiyn7U569h9+IyZMusHQJ/ooozwS5KohAgSykEVji+4
         3ibD2e86h7ALSWoW4y7rtL2Kf3nF5FJ0tXkLs1BDibBFVypG7NnaC7hll0oacGPXbf
         Ok8pwjXMFy9cQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 44426C05FCE; Tue,  3 May 2022 15:09:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] New: amd-pstate ignoring scaling_max_freq after waking
 from suspend
Date:   Tue, 03 May 2022 15:09:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alexmaras@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

            Bug ID: 215938
           Summary: amd-pstate ignoring scaling_max_freq after waking from
                    suspend
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.17.5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: alexmaras@gmail.com
        Regression: No

Using the amd-pstate driver for cpu scaling, I'm only able to enforce a max=
imum
clock speed when my laptop has not slept. I do the following:

echo 'ondemand' | sudo tee
/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

echo '1400000' | sudo tee
/sys/devices/system/cpu/cpufreq/policy*/scaling_max_freq

cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq

At this point, all reported frequencies for all cores are below 1.4ghz. If I
then suspend the laptop, then wake it up, then checking the core frequencies
again will show that it is behaving as if the ondemand governor was not set.
This behavior will persist until a reboot, even if the governor is switched=
 to
another mode and then back, or if the scaling_max_freq value is changed. All
settings will be ignored.=20

I have replicated this behavior on another identical model of laptop (Lenovo
IdeaPad 5 14ARE05),=20

cpupower frequency-info also reports that the current CPU frequency is set =
to
1.4GHZ and that the governor is set to ondemand.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
