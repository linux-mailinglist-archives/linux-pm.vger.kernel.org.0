Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD044E55CC
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 16:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245298AbiCWQAD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Mar 2022 12:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiCWQAC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2022 12:00:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B836F4A3
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 08:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 835B06181B
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 15:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9807C340F2
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648051110;
        bh=8cP17Lu0/zLGt6wHd/FabDWAXhId7dfrExLBZtsZxnM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Mjp100SaXaR55nUHGhpQEpwCn6Z9UaXHfogKCv2FsiP3SzM6fVzVShRfn7zBNPH6F
         HS0ovqERF/r+51h3aSKdwyZltTtyzXAyVVfkMQnphqr3R8S/GhTdSw6DtaYTvfJeXD
         Eb4Yk24J9IeQr18jSxf1Hh2mq51IWy8YAkCA6zUYciKLyuVLoW7tWwEJda7jkSy3Pu
         kmvPPQBLtOIP1ESvjtbGtNPHPxruvZxD2XXsFoEe6tHfw3OEGX/Y5KzplxW+VY3q10
         MQIdJRaPxoDzRbLub+nBn3U4IqfcGbtbQ4i+2U1An8Ex043nXrNuSXn/Fu6SC2CaRQ
         D++5Uk7ieMj6g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BD696C05FD6; Wed, 23 Mar 2022 15:58:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Wed, 23 Mar 2022 15:58:30 +0000
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
Message-ID: <bug-215729-137361-v3CuNhVnWI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215729-137361@https.bugzilla.kernel.org/>
References: <bug-215729-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
After rebooting again with amd-pstate the situation has kinda improved:

Max CPU frequency in idle is now around 1.2GHz with occasional spikes to
2.2GHz.

Power consumption is now around 23W - not a big difference with acpi-cpufreq
but I was under the impression that amd-pstate should be more power efficie=
nt,
not less.

'Minimum' governor is now at around ~20W in idle which matches acpi-cpufreq.

----

Here's the most important thing:

The ondemand governor in idle makes the CPU consume around 23.5W

The performance governor in idle makes the CPU consume around 20.5W which is
near perfect.

So, it looks like the ondemand governor falters with amd-pstate for some
reasons. Maybe it does more work than necessary, maybe it gets called far t=
oo
often, I've no idea.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
