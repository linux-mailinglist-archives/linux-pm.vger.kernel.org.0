Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF06D4FB490
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 09:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiDKH0U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 03:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiDKH0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 03:26:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21B532A
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 00:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CED1B80EEB
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 07:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE5B6C385A3
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 07:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649661840;
        bh=7V1EET/psA0wflZcnUEsHYUQ5ldEyzrzQCyARuzUo8k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CUF2QSKI3YY9Fdvvh/QsjIkeGTd2GNk9NQgyYTB3Fln5r86t4poRoV66MBBmMLhpp
         Uconvu+Czu58Aj19vIHEsveD5Lt5vGxI/30nEpv5D2xRlBmYqFbHQinJlBF1XF5i1b
         AvwxPC42lRWXoQOTyQRIFoSdYL1Atr0vizmWy92QSAS2hEGQasS0XnCkwRrfelc5SU
         LsUxJRHRsTzximtYVKcadU3sESQ1QOjG9mVcJEQo9C3NX6Xi9lepmb8CrvjQn7mZVq
         F5dF5aD2z6osXcSQejHRwONUbzLqpiB4dhfQtrBxJ4zUf+wWled5sCy3TOA36yxnKR
         hm8Ja7ekzZ9FQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9B0E4C05F98; Mon, 11 Apr 2022 07:24:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 206307] AMD Ryzen CPU frequency monitoring subsystem is
 insufficient
Date:   Mon, 11 Apr 2022 07:23:59 +0000
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
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-206307-137361-LVaGvFIcQZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206307-137361@https.bugzilla.kernel.org/>
References: <bug-206307-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D206307

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
amd-pstate does that.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
