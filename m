Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ADF74B1D9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGGNgG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 09:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjGGNgF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 09:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ADF1BEE
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 06:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E36619B0
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 13:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99A29C433CA
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688736959;
        bh=cB+CBnO/YIyoi0f4D7HRWF372CJ4qZiStmYydS5oFag=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PEi+pafkEJaVL5Q7j804BIzvTxNZv5RNlK+p1v//0VB/QMU7EmAODomtHRk/K0oSd
         XQsL0Y8cVQJP0w04g2NzVU/xFdPkT/C6k9xCx7alPw3lXWdM4ZJw/FQYpHeVTEsSCJ
         vndQLB4onoCvWAUkolgmSHF7t1iQhCFn6FF7KHWBnGgj+vjcAGVKJWzumT/NHD7kKX
         6Od+nZFI2r3e16RNqemLrOYSDJvU8z+xH/NI1suu/PbfIhKkkIWu1DAEtmU7FPnE5S
         iKbtlp/KCJ6lvamjQNBs44RNYWHI2KdK11aEB3An+CZstLQuxtwMl8qvK7l8ze8MIC
         a8y+W8amRjn8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8667FC53BD3; Fri,  7 Jul 2023 13:35:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Fri, 07 Jul 2023 13:35:59 +0000
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
Message-ID: <bug-215800-137361-kFexQf3t70@https.bugzilla.kernel.org/>
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

--- Comment #27 from Artem S. Tashkinov (aros@gmx.com) ---
I've even tried this:

echo 600000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq

Zero effect. scaling_max_freq is ignored.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
