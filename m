Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B385F74B1C1
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGGN1H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 09:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGGN1G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 09:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D11BE1
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 06:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3D99619B0
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 13:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 532ECC433CC
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688736425;
        bh=YuTvYjzYGUbt4VKpZqOCdbtrdsV0J0Zr1Yu7zvVpYM8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GSlGDp2kzLtpVNAHcBVfNESIzy2NT+XGo72K5+W9L35BKZNGvlO+BZhwVRDjir8e+
         +6UqZMfOymANqWIzgh+RlndM1KV2g3mJzvu6DYcH4mD/Nz6F4jH8UrFwtIHUlQ9F/k
         OvkjaWclXOuDQZn5fyQWvv/QwVf29AX4q9uoJ7RUE/3l7aWJAtL054WBpPtMTxSjDM
         Yk2IOY19uiHf3fa++87TmqOULgRlG3nFDp7OKBN6jrqU5fHcPvMrwAKaWZHMjO8wZu
         g4ISVEaedVoCFJZKCMeQJI0MCr2r1DK+gleWdxdGuccnpBAps/+a/dmLVJ+ReFnrsV
         l91FUIy3OS3TA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 40B86C53BD3; Fri,  7 Jul 2023 13:27:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Fri, 07 Jul 2023 13:27:04 +0000
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
Message-ID: <bug-215800-137361-Dk2YYxdAqj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #25 from Artem S. Tashkinov (aros@gmx.com) ---
In kernel 6.3.12 limiting CPU frequency doesn't work at all:

echo 3000000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_fr=
eq

Average across all cores and maximum frequencies that I observe now are:
3726MHz and 4898MHz.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
