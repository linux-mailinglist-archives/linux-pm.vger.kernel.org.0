Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D683256AEA4
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jul 2022 00:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiGGWgx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 18:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiGGWgw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 18:36:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4455FD86
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 15:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A2D62559
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 22:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4291DC341CB
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657233411;
        bh=6vkxdF9MZvlKLbNe1W2YML9Nyhs0wzBu/dh/J1kbT/g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sw9cDI54PNl+rZGyA5xMQnt5oc0XHH0HZ/Q2zoDqAr1GB4mDvmn2WP+ezIHBOO2JL
         cHXsfBkutS67o6laVzSVPAI9xN//ZoK2XXBOTvWaRI1ZfUuPNvCvIIsYtkQl85/0IJ
         pIyevqOicBRaCvY3rlwzVldVX1aWIBfd5I0542uTt7sQvXVyPek62hU2QCT1LqrOok
         oFWluFx0ToQ5f7E5v/ywCOEwHrHYKYVPT+m140uVNXE/1yd8bemhdaryOdIoPkETZW
         xNLgkR0JeoQ2ihbN//ItoYTjYWD0rkeRVUwRIxSLZIfFUPAfuyx3CLJsFemQ4S1uHJ
         juIkYq/QgwjsQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 26D16CC13BA; Thu,  7 Jul 2022 22:36:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Thu, 07 Jul 2022 22:36:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tristang@posteo.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215938-137361-zz4cZdQsjN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

regulator (tristang@posteo.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tristang@posteo.net

--- Comment #21 from regulator (tristang@posteo.net) ---
(In reply to a from comment #20)
> Guys, have you get amd_pstate working with schedutil governor?=20=20
> On my system, it completely ignores frequency limits and boost state.=20

On my 5800HS using amd-pstate, the lowest clock speed schedutil goes to is
2500mhz compared to other governors which go down to 400mhz, we should prob=
ably
log a separate bug report? This is any time not just when waking from suspe=
nd

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
