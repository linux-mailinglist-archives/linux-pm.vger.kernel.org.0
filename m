Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43E973BCDF
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjFWQmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjFWQlq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 12:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62285297B
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 09:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDF7361A8B
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 16:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D09FC433C8
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687538477;
        bh=jjbPwNoLXGaUHEuvNnPGGe7syV9Z0vybfW5HzZ2dRAg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fXkOcRtMA6R8sDj+7uKVYZm1mKOu13LK6tzxfOx2qJYUJXP8GARjHqsEiU1XaMr20
         5JER7kTVAQWHShpqSsh0oFMwr5VofnXot0++QEj+3kXjBz+0Jddc7/xhY6cStXpRZK
         GkyJBUePtJb9rO2UfGjkIFNzKzudTVN3Kqe8sfvJwUriDnL8QpZ0V4AyOTzoUZ9o35
         lTJztNwQf5OTxQ7SgwGi5iOZHUHT9zcJvxuMajKH30ASxacCx6aIAi48d4QwN/4W6s
         zfWBpHZZkdsFPd9AY+VsqXErU5fzfMb9Di1RQXdycA0FI3rwtXzylqSaRtghMWrZdV
         1ZEG4pOoR+9Mg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3332BC53BD0; Fri, 23 Jun 2023 16:41:17 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217589] Intel CPU maximum boost frequency reduced after resume
 from suspend to RAM
Date:   Fri, 23 Jun 2023 16:41:17 +0000
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
Message-ID: <bug-217589-137361-Dkk6JJQkdJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217589-137361@https.bugzilla.kernel.org/>
References: <bug-217589-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217589

--- Comment #4 from Brad  Jackson (bjackson0971@gmail.com) ---
Output of rdmsr -a 0x774 before suspend:
4646
4646
4646
4646
4646
4646
4646
4646
4646
4646
4646
4646
4646
4646
4646
4646
2c2c
2c2c
2c2c
2c2c
2c2c
2c2c
2c2c
2c2c

After resume:
4646
4444
4444
4444
4444
4444
4444
4444
4545
4545
4545
4545
4444
4444
4444
4444
2a2a
2a2a
2a2a
2a2a
2a2a
2a2a
2a2a
2a2a

So this is a BIOS bug to report to MSI?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
