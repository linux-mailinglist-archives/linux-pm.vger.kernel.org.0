Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B0C4F20F1
	for <lists+linux-pm@lfdr.de>; Tue,  5 Apr 2022 06:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiDECke (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Apr 2022 22:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiDECk0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 22:40:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597023F3BD
        for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2022 18:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4C0AB81A5C
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 01:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B905C340EE
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 01:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649122989;
        bh=KFB0kUE4U+pSS2JIrALj266qhKSuv8SDu1Z9NgqRlaY=;
        h=From:To:Subject:Date:From;
        b=J9Frc7W74GIwUJXPdxhE46Af/cTKFNc+dugMpXjGW1XK4VWjHCMIA1DhqAwNqEv6J
         prbNjRUS/4vj845d6Ge8MKnApD9Fg6gWuzdLBLNsTAa1n7uVW4Io6NxCTFzTCCPEfw
         8L39gRaLzIHf2ZwQvoqOtY2pT7CijhYUxFLcwQcVjVAMUktYIqCEJsmrl4eOY3+oaz
         JN+cR+xSP9ffR4DFZi7ZYkEn7984/aw18rmOWR7k9uhs6t9rFjYaIYD/8vEO5azQ5C
         lVS9dTCjY0mR/qVbKT9bPFJkS8wiuKqDWMZ56HfcONRIo4vDgTzdmJESyBpQQpVf+Q
         zkGM6pl7a2dfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3209CC05FD4; Tue,  5 Apr 2022 01:43:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215801] New: Rmmod'ing amd-pstate doesn't restore acpi-cpufreq
Date:   Tue, 05 Apr 2022 01:43:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215801-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215801

            Bug ID: 215801
           Summary: Rmmod'ing amd-pstate doesn't restore acpi-cpufreq
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.17.1
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: aros@gmx.com
        Regression: No

It's nice that you can now replace acpi-cpufreq with amd-pstate using repla=
ce=3D1
but what about the opposite?

Can it be done without rebooting if acpi-cpufreq is built-in?

Would be really nice to have.

Meanwhile some sort of power managerment still works after `rmmod amd-pstat=
e`
because I see that reported frequencies in /proc/cpuinfo change: one or two
random cores are oscillating between 1700 and 2000MHz, all the others are s=
tuck
at 3800MHz.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
