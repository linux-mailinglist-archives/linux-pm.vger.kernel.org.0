Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB01569511
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jul 2022 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiGFWKq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 18:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiGFWKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 18:10:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A10C29806
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 15:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2635FB81F19
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 22:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC303C341D5
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 22:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657145439;
        bh=2Dcvz1S2Ga1R7AxQZPzGlCMtVPm+ZVpi2Uia8L5y/gE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=t1pOmIO+F1O2sdvkgj28YpVfmc/iyC9mIYaXHbEazTDBIUKaHUhZuUjGOjoxroT3H
         ugj1/MTrA4XyLeepJbrSxSU/dz8a2cz5mEYdjnW3Iad50nKNKTpWKwvpnUDuRmB4aJ
         gYD9GT2QC+hZEWZoI61dG/Y+IiNbkaUC2DFh0nSEXsbxB3OZwcLdiEI4sLZB6g2N6g
         vR3GIF/gqVz86wzMz+ASg1eMQL7iAsg8cH3kZVWscgOMJiyjfYvvs0g6zGWU4Biv1K
         meGQT9b/oDnsh3WrB5/HuFJD9DqpNRQ0UKy1N/ItOYSCiyufhsWav39eaRDqqy16Zb
         E/ghM2srtOGmg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D1982CBF854; Wed,  6 Jul 2022 22:10:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Wed, 06 Jul 2022 22:10:38 +0000
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
Message-ID: <bug-215800-137361-dLRciTaYNl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #23 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to perry_yuan from comment #22)
> Please drop the replace parameter when loading driver, that patch is not
> merged by upstream yet.

This is reproducible when booting with the amd-pstate driver.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
