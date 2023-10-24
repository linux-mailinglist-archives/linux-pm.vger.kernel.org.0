Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF147D4E76
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 13:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjJXLBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 07:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJXLBJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 07:01:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CF3128
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 04:01:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 483DDC433C7
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2023 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698145266;
        bh=JHighFFeM92GFbZ/2OZ1F/bInurYsbxVOONvkTw/DHU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q9OBeM/3XYT1PukKEUx8GNtOK3EBfx7Emih1BWWzPtiAW9iaMS5jwKBa3M0EvNh6M
         +QsMVcn+QSDvKYYGwJ5mFYsQOAnWG/JqRQJn1o6XWjvKeAQKvIv14G0j1vrXVHGap2
         6iJ3xLpEcz02rbQyckGB//VtJHjeGojW+7uoS8TYqfrS6RKcWNUMv/nBxnyD+spbvg
         9Cvt0LzEuwPZhXD5qEAockpeZn93LW39u2jBtP9zdUhWv3/i+7NVMEQooXcIOhG+dw
         wdJC9hIBcDRl1pHbBGKUAWXaE4wWbhM7suQMN1PRmFYIPGNU/48cNuXN1Xmm3bRTh6
         SmhWC7aMXMBug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3630EC53BD0; Tue, 24 Oct 2023 11:01:06 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218041] Buffer overrun in devfreq trans_stat_show()
Date:   Tue, 24 Oct 2023 11:01:05 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218041-137361-XjvAGWwx6h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218041-137361@https.bugzilla.kernel.org/>
References: <bug-218041-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218041

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |cwchoi00@gmail.com

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
CC'ing Chanwoo as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
