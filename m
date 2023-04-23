Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9999D6EBD70
	for <lists+linux-pm@lfdr.de>; Sun, 23 Apr 2023 08:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjDWGmc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Apr 2023 02:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDWGmc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Apr 2023 02:42:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393EE44
        for <linux-pm@vger.kernel.org>; Sat, 22 Apr 2023 23:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC7F560E06
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 06:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4307CC433EF
        for <linux-pm@vger.kernel.org>; Sun, 23 Apr 2023 06:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682232150;
        bh=gU123W0zBG1RMVkTYeS5ic21O5Twn2a58uwhxGfON+Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gQisUTDsegUnfAvgVtpUohSPfALNAhPJ7e7hsqizylYuPAFgMGCQYVigftN2SUNLp
         m77BvunmJIDSzULLxwztCRX1wub8RnJayppX6m5P5EpQ/xGFeTYpZEulHsqmIHd72B
         EuAQbiR+HMkd+PrKa4rn6EH3ZXEIYKI/u7k20qVXSaRcR8a7bqhAwDcRNNyJiTpAMz
         Nug4XzQ//klwcs4+XgHmzRgl2AVgSLk9+oggUetgd11ULJVt0YJO1TNvfHLHvjr5fh
         D2NTNvCsR/ndBgPYBPC5c5pKWRLWu3X0Au9ppMTQw+CKGNOtya2hVEofP06pO1eoMf
         5zhHJIUFjN+yA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2A5C1C43143; Sun, 23 Apr 2023 06:42:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217361] AMD P-state driver is too aggressive by default
Date:   Sun, 23 Apr 2023 06:42:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ahmedmohsin6@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217361-137361-t8qBePxNGb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217361-137361@https.bugzilla.kernel.org/>
References: <bug-217361-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217361

--- Comment #2 from ahmedmohsin6@gmail.com ---
(In reply to Artem S. Tashkinov from comment #1)
> You've not specified what issues you have and what it means "aggressive".

Sorry I should have explained better. CPU Frequency goes down to around 400=
MHz
when using the AMD p-state driver as you can see in the info from cpupower.
Running anything is slow and takes a long time. This isn't the case when us=
ing
acpi_cpufreq.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
