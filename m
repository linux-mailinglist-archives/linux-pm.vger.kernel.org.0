Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0F17CDD14
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 15:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjJRNUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 09:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjJRNUo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 09:20:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5431D83
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 06:20:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0230C433C8
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697635240;
        bh=WxUN+WnthtxLJVLZcdstz7L8D0QmUdSiKEMkyBWNbWQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eKBnD3Zccl1nQmO3R9cYPoDP5HZ9l/XszmIGbPMw2si36l3EofnncSbiVv/BStbOe
         QjUr4hvgdaYddLBLZ4Cq+a+41kskJh9piyuQKVI1bQv5TjVi2PQhSDEXa1RPmQguvl
         /bykjnbyrgec2DX1HThwnU3h8DC+IeUMFUBPhqT4lKFMNV6OgvrYVLzrMBWCISIO4L
         hSJcGL2KsAv3GJFvxnxdFWJrJLDKkjTblYCqooQZQeo9lo7ViHu9O3Rep8DNzfulGF
         Ye+/BRG+t979VrWyfX2QC4Q2J8bETXoIEZYNKE7M1wx0HOz9FzccApRrfo1wgI9uIS
         Zs689avfL7drA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B4BBEC53BC6; Wed, 18 Oct 2023 13:20:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218023] Overheating Ryzen 7 4800Hs processor
Date:   Wed, 18 Oct 2023 13:20:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218023-137361-qa45tHOJHF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218023-137361@https.bugzilla.kernel.org/>
References: <bug-218023-137361@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
I'm 99.9% sure it's either a hardware failure (malfunctioning fan?) or a bu=
ggy
bios.

The kernel cannot make your CPU run at unsafe temperatures. It's the CPU ta=
sk
to throttle if it heats up.

It's great you've found a workaround but it's not a kernel issue and there's
nothing that can be done in the kernel to fix it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
