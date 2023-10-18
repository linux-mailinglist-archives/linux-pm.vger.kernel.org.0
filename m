Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4893B7CE2C5
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 18:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjJRQ3V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 12:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRQ3V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 12:29:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EDD113
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 09:29:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E268EC433C7
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 16:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697646558;
        bh=66FGgOiZYNcxexuFltL2IzLvQiJ5cEhE8xWAnZtn11U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OyK4piapX6LUVm+DcWWPsUgM+9DgyG7OHPmRq2YCLH72HYBR2bSekraD+jhKgMYvx
         4IRwl53C+JkXMDfMyr2v0DFzdc4LdAJWyRTxLtQkpU+GGKqLnhXRNbE0Dh5zuIcpAM
         j48a+bTjHcZ80iQusK/ZeuUIl7eFPb06sZotx21wnAw0s3Ya6aOivdGrAf661ZIGhH
         QB8YM9Sd03HaPwDD8QI2TjLsgxB6K9/IdWG4I/aIT3jVeEXqcmiQoeOQUucDowditc
         Nm/JlekTkkzXTUW/9hv2oT+ATpicUUGrTho+1I9++PKYIR4+Sc4Wwx5WMOTGrL28yh
         E+hmCjnz8bcBw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D0ABDC53BD0; Wed, 18 Oct 2023 16:29:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 218022] CONFIG_CPU_FREQ_GOV_SCHEDUTIL - 10%-12% reduced
 performance in lower priority processes on ADL Intel processors.
Date:   Wed, 18 Oct 2023 16:29:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218022-137361-JuHQFcpIBs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218022-137361@https.bugzilla.kernel.org/>
References: <bug-218022-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218022

--- Comment #4 from sander44 (ionut_n2001@yahoo.com) ---



I have this:

https://community.frame.work/t/tracking-hard-freezing-on-fedora-36-with-the=
-new-12th-gen-system/20675?page=3D18


6.1.7-200.fc37.x86_64 / 12th Gen Intel(R) Core=E2=84=A2 i7-1260P

No i915 tunnings! But with intel_idle.max_cstate=3D2 while booting

With this Since 6.1.17 =E2=80=93 I have started getting hangs =E2=80=93 but=
 w/o the garbled
screens and trash and garbage on my screens. Garble screen hangs will,
seemingly, eliminated with intel_idle.max_cstate=3D2.

With 6.1.17, I started to just getting freezes/hangs; no garbled screens.

So maybe in my situation I did have some problems related the sleep states;=
 but
now perhaps I am now also bumping into the intel GPU issues many have noted
here:

booting now with: intel_idle.max_cstate=3D2 i915.enable_psr=3D0

I seem to have some stability back.

NOTE: There is maybe some correlation between this (new to me) hang and Zoom
with web cam active. Too early to tell at this point.

HTH

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
