Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C622746625
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 01:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjGCXTt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 19:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGCXTs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 19:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162C2FB
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 16:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A843C61089
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 23:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 144D3C433C8
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 23:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688426387;
        bh=3SU1gI1fJZfkuuEQmiR4RwEE8VbPU6iXNrDTvLL81Xk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZqaQ027p46OopgUp0lEC7w/7v6v9bt29sbK6hslC+KSrfsaVpNF2xBsn8dTEXSqm6
         LDHg+3Jx0ioUgbNeTA1omA26GNNkOI8/TSVY285LKUfORtVFkDJ0f8ZtBufPFNP6hr
         fnwk3ftBw7NicHzFVUFw7sHWlgTZh/nFJToGaCSxHz/rxUT6D0s7qntWbkREdDI+lq
         w+HtQu+0hU5QCho2v4hiNVZiWNwhWFEokAJKdtclqyHRuH5mCF4PVDFv4nyCy7ejvl
         Hc1iPtlCwdbTqgsUcR4jnGsA7FcWitiUcWGZcVv+OZanjuCWzijjiXZ3kycgxZLR6h
         XCjAfE0DtExdA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EE3CCC53BCD; Mon,  3 Jul 2023 23:19:46 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217630] Kernel fails to load amd_pstate driver on 3970x while
 Windows works well on the same machine
Date:   Mon, 03 Jul 2023 23:19:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: pshirshov@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217630-137361-1A1Eg8MNSA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217630-137361@https.bugzilla.kernel.org/>
References: <bug-217630-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217630

--- Comment #1 from Pavel S (pshirshov@gmail.com) ---
> Kernel 6.4.0 shows the same error with "amd_pstate=3Dactive",
> "amd_pstate=3Dpassive" and "amd_pstate=3Dguided".

Sorry about the typos

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
