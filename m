Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8C6566096
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiGEBQ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jul 2022 21:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGEBQZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2022 21:16:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B2BE0A0
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 18:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C00ACB81600
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 01:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F77FC341CF
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 01:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656983782;
        bh=Azc78YL4t6otPpO9mNrwcKNHuFQsDEGpNTLX8XFx6/g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bvXT4wWRVSCZJNX7wJ/vKh2DvT5CHnHDy3E3bn18pzkxlomKenUIyP8lEA6MzZwXO
         /Lr2lZuDexQ7aR11TeeVvLZ1tFigew+VhTYhCsgKy7lwWmxxqR2ZiFXeiyovQ2lnmD
         pb0V4WMoGOkQgATTgAa6QeNNM2rcvnzQfxkLnM59MLhMLwG4Dqyj61eOrusiKk5iC6
         RYQ9BV7KASMT2sRASxPtETHSLJQhUO4IotFQwLl8U9ieboABpY8qAL4IC/+ejI+lPF
         LJvT14hkrmWhDeUeYMFWv24KYztlKAyRmkOTe6yBpj5iAczJBRqJ+GlLtzM2UO03XI
         IGi02CfCoYY0w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4E8D4CC13B7; Tue,  5 Jul 2022 01:16:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Tue, 05 Jul 2022 01:16:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: perry_yuan@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-z13ZbA2Ndi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #17 from perry_yuan@outlook.com ---
(In reply to Alex Maras from comment #13)
> Hey Perry, results below:
>=20
> [I] alex@alex-laptop ~> sudo cpupower frequency-set -g userspace
> [sudo] password for alex:
> Setting cpu: 0
> Setting cpu: 1
> Setting cpu: 2
> Setting cpu: 3
> Setting cpu: 4
> Setting cpu: 5
> Setting cpu: 6
> Setting cpu: 7
> Setting cpu: 8
> Setting cpu: 9
> Setting cpu: 10
> Setting cpu: 11
> Setting cpu: 12
> Setting cpu: 13
> Setting cpu: 14
> Setting cpu: 15
> [I] alex@alex-laptop ~> systemctl suspend
> [I] alex@alex-laptop ~> cd /sys/devices/system/cpu/cpufreq/policy0
> [I] alex@alex-laptop /s/d/s/c/c/policy0> echo 1752589 | sudo tee
> scaling_setspeed
> 1752589
> [I] alex@alex-laptop /s/d/s/c/c/policy0> cat scaling_setspeed
> 1752589
> [I] alex@alex-laptop /s/d/s/c/c/policy0> cat scaling_governor
> userspace
> [I] alex@alex-laptop /s/d/s/c/c/policy0> cat scaling_cur_freq
> 2796520
> [I] alex@alex-laptop /s/d/s/c/c/policy0>
>=20
>=20
> Looks like the same issue continuing. Do you want the same dmesg with pst=
ate
> logging turned on?

The suspend issue has been fixed by below patch.
Please try the below patch for the suspend/resume issue.

https://patchwork.kernel.org/project/linux-pm/patch/20220623031509.555269-1=
-Jinzhou.Su@amd.com/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
