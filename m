Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0BE4FDC1D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 13:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350109AbiDLKOe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 06:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351758AbiDLJmd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 05:42:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA07B517DB
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 01:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AD16B81B66
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 08:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EBCFC385A6
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649753445;
        bh=3ZqdZ3DEgrUmw984qgZvplBrpWBxlLiAY8kBIw4hJ+w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gbgQRtQ76zfM+MaEusQ1Ny31OLHGTXeFxO8EFNrPQWc/0dRA4uE7NexzJ33BopIGq
         Tv2iMcLx6+KQ0sOmLffuOAs0KI2d7MWzkQj/HSRUV75eFjxnxiDk3OKExsLKEOrqSD
         JCzQXQxMLVpUmnPx263yNvwR88YNasCSuJK3J2F1NZn5W5j/Ef41M8jIkatadkhiPi
         EkM+roI23ohqDO3FP2yYexBCqtqB09eNIug+81icPHv+DFyEM45Me7DGl2sQ/8/0Gk
         jqgFUuk+39VSSrcn1d5eynSr45F/jysrbkUk7mcgGbPVK6bZar+byotEXJlxAiSeMX
         dfp19b34J4NNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 06622C05FCE; Tue, 12 Apr 2022 08:50:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 12 Apr 2022 08:50:44 +0000
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
Message-ID: <bug-215800-137361-U8EFvraSCi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #10 from Artem S. Tashkinov (aros@gmx.com) ---
Even restoring scaling_max_freq by setting it to cpuinfo_max_freq doesn't f=
ix
the issue.

Again, I'm repeating what I already said in the original bug report.



> For my Ryzen 7 5800X I've tried (under root) numbers from 600 000 to 2 200
> 000 and they all work:
>=20
> echo $number | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
>=20
> However anything above 2 200 000 instead makes **the CPU stay at 2.2GHz**.

Don't mind scaling_max_freq, it's scaling_cur_freq that never exceeds 2.2GH=
z!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
