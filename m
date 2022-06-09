Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D762954505F
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241703AbiFIPPH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 11:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344192AbiFIPPG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 11:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE827FCC
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 08:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FC7E61EF4
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 15:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AFE9C34114
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 15:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654787704;
        bh=B4ej79Sru0iL+cQmRN9Yz6LjXxqtuMqcIKtq4o/YVzM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tYz9NiMtRY0qlfTOJs6FaIBgq9qQh9S41Y+VVeZHNLQM7TWFz9T79qLAekjnuYi9D
         Ekqf9owNdT5aiEDeIXBfMztGZ7GpXktDZsNQDwX98ogRRurFHqNZP2+mc1zoLmsb7e
         cJMOATHj4nPfbNehbNSmR4R1t6CaAYL4Yz+AoQ7mval3HMAvaY00Yw7TldmxCpzGaH
         HzZPGns4NvVkh9M5fwBu3BSPIdlmmryEkE4k2jrdZ6g04JQuvIEtcklU4Z67crz9dV
         pvhi/fNkK+CoesCvKPXhCLnB9L+ggayN1jOBoJUbEMTOPcZ9nShgx4xmhegeSLmLNM
         sdtkkXbY1v3EQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 72907CBF854; Thu,  9 Jun 2022 15:15:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Thu, 09 Jun 2022 15:15:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: perry_yuan@dell.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215938-137361-qHYZOfCCqq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

Perry_Yuan (perry_yuan@dell.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |perry_yuan@dell.com

--- Comment #11 from Perry_Yuan (perry_yuan@dell.com) ---
(In reply to Alex Maras from comment #10)
> Note - in the most recent test, I was limiting to 1gHz instead of 1.4 -
> results are the same, successfully stating at 1gHz prior to sleeping,
> unbound after waking from sleep.

Hi Alex.
Thanks for your detail and info share, I will check the logs soon. then will
give you some feedback.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
