Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148CC4AC124
	for <lists+linux-pm@lfdr.de>; Mon,  7 Feb 2022 15:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344859AbiBGOWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Feb 2022 09:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241746AbiBGNws (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Feb 2022 08:52:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C26C043189
        for <linux-pm@vger.kernel.org>; Mon,  7 Feb 2022 05:52:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E58EE61268
        for <linux-pm@vger.kernel.org>; Mon,  7 Feb 2022 13:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59A23C341E3
        for <linux-pm@vger.kernel.org>; Mon,  7 Feb 2022 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644241966;
        bh=1vxx1eF35JrEWw0/wu/kw/+5FRH7T9jk/Ofu0LYJhSg=;
        h=From:To:Subject:Date:From;
        b=WMT27z6cYvAaCx6z/fCIgp0xKV0z1d/h7V3D/7fq1TSnUBncNhjRpUY8ZzkQZgob6
         stwHuseDW7lSFPPVOIu4ga2AYz5riYnn7yPwq2uz2XHLIhRRjyNnmlW1HBENj9a6zT
         P8CARIDkKzyZaLxJuCNPet+UIjm7+WuIhoKETwpDwrA8R855oDkwPRsMEOpOmGzGtH
         UIsuMQ2kI4w2rJkWKCPjp2dV8zVrqhGBesTzpd+9F2u1iIW3ZoXavlrS+Zpbi8ZhDr
         hIIUqeq4spzoz0MAx3JOqbsuaRgJxzcNk44uktmKPe54lDY4MpqSaeknNmi1gaT3xP
         pXTNC5VMSSK8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4596DC05FE2; Mon,  7 Feb 2022 13:52:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215574] New: Frequency boost disabled by default on Asus PN50
Date:   Mon, 07 Feb 2022 13:52:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: parag.lkml@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215574-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215574

            Bug ID: 215574
           Summary: Frequency boost disabled by default on Asus PN50
           Product: Power Management
           Version: 2.5
    Kernel Version: 5.17.0-rc2+
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: parag.lkml@gmail.com
        Regression: No

On Asus PN50 with the latest available BIOS 0623 - turbo boost is disabled =
by
default on boot and CPU only goes from 1.4Ghz to 1.8Gz non turbo frequencies
resulting in noticeable sluggishness vs Windows which seems to be able to b=
oost
to 4.2Ghz.

If I manually echo 1 > /sys/devices/system/cpu/cpufreq/boost or put it in u=
dev
rules for that matter - things work as expected, processor boosts to 4.x Gh=
z,
fans kick in and system is snappier.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
