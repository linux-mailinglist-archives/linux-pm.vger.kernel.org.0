Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971BB758345
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jul 2023 19:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjGRROY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jul 2023 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjGRROW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2023 13:14:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E6A188
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 10:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D79C661689
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 17:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E3E3C433D9
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689700460;
        bh=oLe9tm4kmVTiRwGfjJlhWYaxXK13kMuN4ZeWrQvCDrM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uOlRBatXISBpT+TEg8GIyyaEE+xZFPlY5f35Vp7ETxJxyUu2ixz6y1KBPSvJgk0/c
         uYHRS/XlvjNJXBRq5WA8JvYJLg4tPWuytZumA8Yb28MMwi6l5N9S9LaMsY0/dkssCw
         ZaE5jYW2dlYC4dU04Z+oD9//tAnxc8vUDJfrezeyCuIPLEAlYHYsilezNhlNQprG1O
         fE6Z39GFoSrlP3B9/7DwbE8ucP+1e9rLGjlNJEVwoXG4aFDM6SMtqoRrabEWH6v0/C
         VhfJURuOlh4iuiJFn24z4kmhYVyZCYIrx8OpnOz9WkucSv/ROEzDLv+ciDFZCwYRtV
         i8oBmkncKDyBg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0D87CC53BCD; Tue, 18 Jul 2023 17:14:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Tue, 18 Jul 2023 17:14:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bjackson0971@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217589-137361-D3lb6TeC2h@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217589-137361@https.bugzilla.kernel.org/>
References: <bug-217589-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217589

--- Comment #11 from Brad  Jackson (bjackson0971@gmail.com) ---
MSI has ignored my support ticket for weeks, but after chatting with a supp=
ort
person, they don't provide support for Linux or seemingly overclocking eith=
er.
I don't have a convenient way to test Windows on my PC to prove it's a BIOS
bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
