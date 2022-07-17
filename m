Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0A9577677
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 15:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiGQNzn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jul 2022 09:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQNzn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jul 2022 09:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D9813D08
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 06:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51DD860FDF
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 13:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2794C341D0
        for <linux-pm@vger.kernel.org>; Sun, 17 Jul 2022 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658066140;
        bh=oPGrCd4Wnh0CEhVFAgvxnMGAdN5LVWtnMetCpneR7f8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Xp8pzgSI6SOi4+6vcG3hLn//bsqpLYnYJ0dx8yLgl0NmonUuSBcshUiK6WWz4oj02
         wGWg7s86asd0Fkfzi8pLbtlh2QU2A4gEMOsnxPyTAogowuBtq8BUssvRZ0+ERjBKp3
         fCe2yP6C1wnw+jbGdk5p3ciwOi5KMUB5MiWDbckbIezhcih6l4N/vsKlSZOP0AJ030
         uakSdozF8LEpIItkvevtDbnHxqAqLpywR8Be4jJXkZmMT0goNZdyuQcwHRr5wvYBzI
         WcnWhbONbJPoplJnqfT1ympDPH/ZCZ5K41dntQT1vTxryqcmUFSLQ02SDFOaJC2yls
         e+pkoxMoTSgLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 88CE3CC13BB; Sun, 17 Jul 2022 13:55:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Sun, 17 Jul 2022 13:55:40 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-216248-137361-kvh10LoiK1@https.bugzilla.kernel.org/>
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

phandrix (pandre0x59@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pandre0x59@gmail.com

--- Comment #18 from phandrix (pandre0x59@gmail.com) ---
Hi Mario, the patch don=E2=80=99t solve the issue on Zen2 CPU on Arch Linux=
 or Based
Systems. I saw some reports on the Manjaro forum.:
https://forum.manjaro.org/t/testing-update-2022-07-17-kernel-5-18-octopi-ha=
skell-python/116789

Patch is applied.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
