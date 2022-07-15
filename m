Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D41D575F7B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 12:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiGOKnr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 06:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGOKnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 06:43:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD54FBE3D
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 03:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65D2562250
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 10:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF6C4C341CA
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657881824;
        bh=ASgClIff009T7dUMbNUFcuOt5doTQ5c6k31lO+gvxdU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q+RjyClWNQdJsnseGtM890uRx6eUel2+73d+uz4jZqQJ+ggmguSpfEVE0Moxa3CsZ
         29FExhjkB4HnPulrOVTMUP8sEj0dGBMiQk6U7oRSwiqB2toezNHmIec1v/dcyUvRWr
         rXtHyEd1EGbNh73RxSaapta7fDsW42AvMNx4Trid0axs5sNeMTP+tynbVFW+YewhLr
         i0TPpYrbDP0WQVaKaJSpDhcPj/jATIsTDw6u8DfWgaIPuW1T6fNNToeceKQPip3zuT
         wc7E25kquGdWk49udARv/u394qS2OKITgm3DQKtaLu4iGCD1PxVV0ikPQ1NwQRUIEO
         7rzwkzD62yBSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A265ECC13BB; Fri, 15 Jul 2022 10:43:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 10:43:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-VPRhy2ZWFr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216248-137361@https.bugzilla.kernel.org/>
References: <bug-216248-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216248

--- Comment #11 from Arek Ru=C5=9Bniak (arek.rusi@gmail.com) ---
Hi Jose, did you try:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?h=3Dnext-20220714&id=3Dfbd74d16890b9f5d08ea69b5282b123c894f8860

It's fixing issue I've mentioned in #1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
