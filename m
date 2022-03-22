Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9D74E49D2
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 00:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiCVX7d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Mar 2022 19:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiCVX7d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2022 19:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA49823BE5
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 16:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C502612D0
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 23:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 616AFC340F2
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 23:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647993483;
        bh=ygaQbp+7fo58YcQLN67xJdnlga6WoN2ysfqGMf1FDzM=;
        h=From:To:Subject:Date:From;
        b=iyvfyNyg2oPvLSTdUGGBiBZuhLNAXXr8RF0BxEGuOgWFsHy+igTDo5KB1WXXu/zw5
         hb3ELRu7b8ynf8mwMWY9MgL624Sp/GkNr5ohGv5Bg5AbKLZaEniREUqY47LVr+fmkR
         k+i6dJoUYmokZichvv0/UV4jiMttwWCRyrVe34PHIHKpfaE4NQgHOxoQdQhCIRbL/E
         dr6W5CvX4rL0VcpA9zvBQR74ehFByes37lk1VchJmOS0VMnpQS9XN4vgU1EkCxEyK6
         yS7Jf8jycx7H+5m9rQbghqQsA697K7Kst2UlXM9rwmDwV8SSwsc8iJFidTvKUF8lGu
         LoqhnJ38ID2ew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4190CC05FD6; Tue, 22 Mar 2022 23:58:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] New: amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Tue, 22 Mar 2022 23:58:03 +0000
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
Message-ID: <bug-215729-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

            Bug ID: 215729
           Summary: amd-pstate driver has a much higher idle power
                    consumption for a desktop Zen 3 CPU
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.17
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

I have a Ryzen 7 5800X CPU.

With the acpi-cpufreq driver the CPU idles around 20W, frequencies are in t=
he
range of 2.2-2.8GHz.

The very same system with the amd-pstate driver idles around 25W frequencies
are in the range of 3.9-4.75GHz.

This doesn't look right.

Changing governor from ondemand to powersave reduces idle power consumption=
 to
around 21.5W (still higher than with acpi-cpufreq) but this obvious complet=
ely
destroys performance.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
