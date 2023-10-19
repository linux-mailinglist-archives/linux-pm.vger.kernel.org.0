Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B017CF362
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 10:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjJSI5w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 04:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSI5w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 04:57:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E7210F
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 01:57:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44D43C433C8
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697705870;
        bh=Vub5mC5LnERisUZjHkMqduoGGqzjjqviBFunfKBaUoU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YABz8bh1TnprkhLZd5qwXtR7Pmb3DHn90nvjKar3PewYHnSZL5C5kASzvO5G42zuH
         +JEUmOxW/Dz5sg+9pqHA36JvFOh/69xDTj9LcAIuEIJeJjfZTwUadytfaxBNvOJuQ6
         Lw4PvfBdY2FzH/xXp0gHsw0icz8p8WM3sF/I6Zl/umSw4rEc1H3TDD5KDPlA6hPn8B
         akoojbcAZ41jOtN+7Us4Xp2ypg6T6MQqc2nqEBVRA+clPpBq7AJii+JD7fUVpcOtFj
         V6g//GIhbxRYpFBzdbIGMk8w7i2JfprNUTC6Fo1Ct8EpvAyPUce5El8sOQxwAzJJyJ
         GGOSGAVDTo6PA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2A01DC53BD0; Thu, 19 Oct 2023 08:57:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218022] CONFIG_CPU_FREQ_GOV_SCHEDUTIL - 10%-12% reduced
 performance in lower priority processes on ADL Intel processors.
Date:   Thu, 19 Oct 2023 08:57:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218022-137361-LY6YFz6LVA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218022-137361@https.bugzilla.kernel.org/>
References: <bug-218022-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218022

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
If you have issues with graphics, here's the proper bug tracker:
https://gitlab.freedesktop.org/drm/intel/-/issues

In a _new_ bug report it would be nice if you specified which kernels worked
for you and which now don't.

You'll be asked to test vanilla kernel, that's without Ubuntu/Fedora patche=
s.

Distro kernels normally are not supported here.

Fedora 38 (after updates) is now rocking Linux 6.5.7, would be nice if you =
gave
it a try.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
