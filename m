Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7705471C4
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jun 2022 06:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350295AbiFKELP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Jun 2022 00:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349624AbiFKELP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jun 2022 00:11:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A8B26C6
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2022 21:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 155CFB83875
        for <linux-pm@vger.kernel.org>; Sat, 11 Jun 2022 04:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD528C3411F
        for <linux-pm@vger.kernel.org>; Sat, 11 Jun 2022 04:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654920670;
        bh=cfXzYtOIC7bPcF2L2hpUIZ+UtawiY//lUwAbp6GUOFA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jhP4r38AAVpapCLqZIZAIoCXw+/RhBF3BmAr9zJ5KkuVHjQ/qQLOcE0BH3oUMzEWI
         a+X40k6EXlZXK81mU8ZQqq31bLoxKeSCfw3SDF1ELLBPhYuYBg0mfKpXx54xCEGvZz
         L8c590bGV7VQLyI2e3KdPzNHqwMXNAF6y/zs7e2V5enUIGsiIGRsbNzAwqC1m7K8M6
         XglpFv1h5IKZf4pGCp7MQZosw0Xpx+PBe7qj7vTKqm9sc3lEB6nSDYx8VXdUhYz5pJ
         eqRF7f16LKDYH5FToqirGZx3wVmYlEQtOSHRIeT9Q6JujAz2t3fGSV8+sQct34LloW
         Yzg0R/7jAZqug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A5636CBF854; Sat, 11 Jun 2022 04:11:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Sat, 11 Jun 2022 04:11:10 +0000
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
Message-ID: <bug-215938-137361-F1M4dLb5ta@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #14 from perry_yuan@outlook.com ---
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

Seeing from you result, issue can be reproduced by my side, the core freque=
ncy
is not updated by low level firmware.
I suppose that the issue was caused by suspend/resume , firmware has proble=
m to
resume the CPU frequency control, so any new frequency set will be ignored.
I will further do some debugging and try to resolve the problem.
Thanks for your confirm.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
