Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB57519745
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 08:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbiEDGUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 02:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiEDGUB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 02:20:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F4A1D0E2
        for <linux-pm@vger.kernel.org>; Tue,  3 May 2022 23:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82E51B823A2
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 06:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B483C385A4
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 06:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651644984;
        bh=E4qJ80hm9gDBKzN8MZSFjXf8fCSygiYiyC0hjdAVeW4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y+gPlvJgs30fEeL0XNR5D5fif0+ES8LnQw7IWgpPBUFPhCZHB88QRq+bgGupxxRiI
         hAAWtZ/powLKdzrBd0W2XqjiJ99jP3B7NBGAYu9kklakzIB5uxRhWJDUJG7coJVMAf
         0AYGQ0EFtdmNx+eSzjdLS2wnkmacwNLCaOxJb4zxED+VRWcxD2v14jb8juBGJ2lAd+
         LCFW9DIiSEAHkGFf2RxqEmcJiSVmllsGC/6B9K2Qf5dIRxignu4l2Ps9lWv32vGtDp
         kVdsISrSiC7Whgpx2Ev66nKWDu04iE7kD+El0tM4iibNA6n/yt6FCbAHwf7OvztkI9
         lF8sK9fE+h0dA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E59CDC05FD0; Wed,  4 May 2022 06:16:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Wed, 04 May 2022 06:16:23 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215938-137361-kuBel5RUkG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |aros@gmx.com

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Could you please check if bug 215800 affects you?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
