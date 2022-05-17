Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321C7529C4C
	for <lists+linux-pm@lfdr.de>; Tue, 17 May 2022 10:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242382AbiEQIZd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 May 2022 04:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiEQIZc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 04:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7066531DC7
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 01:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A59760FD2
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 08:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B58FC34117
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 08:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652775930;
        bh=/dgVGPHp5kFhMfYMK+nBERpCOjU7BvFu6vyYaxSUgmU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cQOT5ATOzEYxL5OO4yNE9FiwN6GUzrOleqb19+8sSRqMr0IGhXorImB79JI+O7Y3+
         MSIRoooAyVhIGxGOvYy8A5z5R+MRwz7C1UjfBfBD00/63ud/bR2FmKUDwMHHZWAUI+
         /rNH+3f0Vg1nT8gHoSA35YN/efYLAc7nEA8Myqc4vtKHKZnjReSyhE+KGDDY3bk2Vt
         Uke4Wvy4/eaL09EatkgcI3fCx5Kd3Oba9NvHz3GpVqge0mCN0jMtfxHosGZjrJiFCF
         ecriDeXKaqbFVoZEV4h8AVqk3szQ/10TG8VQxE/usRLNhacRPyJmTpMg+B52LWLt5y
         Foh9Dl5j7y6xg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 48873C05FD0; Tue, 17 May 2022 08:25:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 17 May 2022 08:25:29 +0000
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
Message-ID: <bug-215800-137361-SR5xqgz3SO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #16 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to perry_yuan from comment #15)
>=20
> Could you help to try the below kernel ?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/
> drivers/cpufreq/amd-pstate.c?h=3Dnext-20220516
>=20
> I tried this kernel, but 5950x cannot reproduce the issue as yours.

Does this patch require enabling debugging in the kernel? I'm not sure how =
I am
supposed to share (debug) data once I've applied it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
