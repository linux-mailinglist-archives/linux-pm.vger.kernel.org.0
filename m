Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2EE4FC227
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbiDKQZD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiDKQZC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 12:25:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E95330555
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 09:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A72A1B8110B
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 16:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1DD9C385A9
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649694164;
        bh=kkwRT0mzyc34Vnd3I/uNOpepE32TaC3o06dvreCm9R0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DnLPZR2BhtWsaysip18o3bTed4Xtl5nl70KDIyl3VzvxIRkC3MhzBBYzf70mxIVOo
         cZ/WM3traH0Og1KmMUKPlOhe7RIcepbgW4iygpCStcQzmAR1b8kTWz0jBe1FxVtOu7
         uvGhoTkL1zdxU1Eh1rkYad6uliqbgTJgp7DACYinDCZL/DSdxmZ9/plieiQRTzNq6/
         DmemmLlVRRh9njpdUK/vmQvb0qmyBg3bt5fvLr8yT8kADGJDp4NNN2mesLR684Y3Wr
         W8znQ0A74Qc235/iaEnhn9fz1maPf6yKIKI3TEEdB5h4gCgMu2hsPNqRn8fuXBRXmj
         A0fYQKDo0F2/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A0E33C05FD2; Mon, 11 Apr 2022 16:22:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215801] Rmmod'ing amd-pstate doesn't restore acpi-cpufreq
Date:   Mon, 11 Apr 2022 16:22:44 +0000
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
Message-ID: <bug-215801-137361-1Pa2cBwaBL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215801-137361@https.bugzilla.kernel.org/>
References: <bug-215801-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215801

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Huang Rui,

Is this doable or I'm asking too much?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
