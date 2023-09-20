Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8477A7A0C
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 13:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjITLHp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjITLHn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 07:07:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3015CD8
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 04:07:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C90F5C433CB
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2023 11:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695208056;
        bh=srUMZdFlosR2/I0cU6FaCJDFNdlELJHerKg9PxCtjYM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ObGKZ5LDt3eSOCRXds2pg9/XGaRUrMFLzwi/Egpv34MnK5A+dlVeYruciWtf8ajyo
         PcrerDDXgTwzcNPL8IeE2i+EJIn7NXOfDfTimE2Fgxfmavz7Ac2UDDYN/zWzedHS6I
         p1s8il7Lw7h2ZhfM83XloyjGNivwknGbDVi+cTLLDnsV+gpw7rSeHZxq5Psc5aHtSO
         1l481U51GkwyQTf/JfFOz242qObe9ABkI+gcUZN+TevJ2L4MlGsALms+uxiqu/Af1Q
         fCEABZjkxKfCYb5Ew8xguW91uQW0sMCgdu/uvBbyY2ClMG0bnm1LmUjvIBKFsLXYMV
         Ip96OCxYMMmrQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B9732C53BC6; Wed, 20 Sep 2023 11:07:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Wed, 20 Sep 2023 11:07:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215800-137361-OwwnagzEXO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #33 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 217931 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
