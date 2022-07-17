Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A50577849
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiGQVNj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jul 2022 17:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGQVNi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jul 2022 17:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A41275A
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 14:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 142D160A5F
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 21:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72791C341D1
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658092415;
        bh=0JkmwHhxS6fvFbQqQLEZkPB8FVFEaNV96Gu6H4wpXxM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BlPDNE40Pk4LHIxz/6C4ZLIuSFub4xBrkUOF6ykZ3m+T0c/jS+RRyyyjcc/tAos4I
         Bf+GPhcuZ9+h7ns0KqfMMgdmP1uSTDzbOGmUJe0vkOMXm1mki7zd4Q/DX1ZIQ34Rk5
         AB2SQ/euTjkFLsJYfdzOg7Ds9r0KupVWr7bn7cIRYC7uCqOD0XtrTcMAKE2GFTwVdk
         xPZAsbxt5nOy8rCnyEDpxIcFvD34EtQ8FbpxaSFIqx0eVXLtxu4zSCAdTvn1f+GhCB
         MRj2eSpao4eVnV3wD4JWibM0pLFpv68tzTo5E6HW2cAXAN38rsLGLxuZqm+CyLNA05
         SR4AaWd8V+2Mg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 56BEBCC13BB; Sun, 17 Jul 2022 21:13:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Sun, 17 Jul 2022 21:13:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pandre0x59@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-y2KP8ZIfw7@https.bugzilla.kernel.org/>
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

--- Comment #22 from phandrix (pandre0x59@gmail.com) ---
Hi,

I will just say that amd_pstate work again on Manjaro. Both patches applied
there.=20

Hope it will be upstream later. :)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
