Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B60577799
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 19:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGQRx3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jul 2022 13:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQRx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jul 2022 13:53:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780A13CFA
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 10:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 264E3612AC
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 17:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 873B9C341CA
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658080404;
        bh=fW7PMAFuNE7FBEo/nv8WbSphUG6fIw4ZNTg7EugFQUI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RLV84o1coNO+QhL4HLzCkuEUpMjSgN4t7yMWZ56kZp2jnGf3AMvlh16/LNHDCoWmD
         nyR53069+OS8uLRWTDlpXTwKF1UKZ5jcfTJWIuQZFzxAtA9oierv9s2VvaNIqKACQ9
         iUmWlTgrkSYBVP6XKusRAr7PDs5WC59bngt9w4ERjK2MsSegUJnVDig+tfRoNMDFAo
         V2LxitiWGTPwAsuy2B+rP0Ayeo1fMDbTRpjxDluA7Vb+7+BWLhH0nd6V5I0F5rwT97
         soJaG3fuPLUvQg8BgbGqQULs6DTEjLtZWM1r65Ui2dUaWDPN1sRV/ObVwFgJnOr+d8
         B/1Zh53V8KIxA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 73AE7CAC6E2; Sun, 17 Jul 2022 17:53:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Sun, 17 Jul 2022 17:53:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pierre.gondois@arm.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-Yku6u5Ye8S@https.bugzilla.kernel.org/>
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

--- Comment #21 from pierre.gondois@arm.com ---
Hi,
Sorry for the mess I created and thanks Mario for fixing it. It s a bit late
but please let me know if I can be of any help,
Pierre

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
