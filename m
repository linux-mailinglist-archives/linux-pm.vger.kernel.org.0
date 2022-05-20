Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CEB52E7B9
	for <lists+linux-pm@lfdr.de>; Fri, 20 May 2022 10:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbiETIhZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 May 2022 04:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbiETIhY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2022 04:37:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925E09CF59
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 01:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CA5DB82A57
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 08:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00546C34100
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2022 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653035841;
        bh=2SKY3jpynNKLufcZca/1Z+lFwjXHI96uphaPTcdCdgs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tA//iF2imD847LShObPo7unn/aIhyNRs1t/iB5QUe7RqyLnkfWJvSc1Amk9NHa1Jm
         r9IVfBKfRbfNJcIG44ajNtE2kPVPPuOr2kBws4b288r2q6lYLxFBbek9zpBVG3SUeS
         1UEt7Xj6XdMqc9OYoTa/Fgh2T0JWwywtJb4gKvJ7uXBNTsfeySf3LB+p5rfjL7D8MS
         APRpiZ2E8F29NFvuv+fM6BdMYF9H+KotatQsGOkGBXajY3QXYYUTV28PtjfvbgFJPP
         YusSN7c06hM+3/mFIk7MV6joPZ7+JczHCJj0RvI8Kfs3RAIN1o1yx8164wMLBg3C0i
         bBAeXaVR/kOmw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C11B4C05FD6; Fri, 20 May 2022 08:37:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date:   Fri, 20 May 2022 08:37:19 +0000
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
Message-ID: <bug-215938-137361-AuEuNaF996@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #3 from perry_yuan@outlook.com ---
(In reply to Alex Maras from comment #2)
> (In reply to Artem S. Tashkinov from comment #1)
> > Could you please check if bug 215800 affects you?
>=20
> No, I can set my frequency to 3GHZ and run stress and my scaling_cur_freq
> value reports ~3GHZ. I'm also on a AMD Ryzen 7 4800U, which is a Zen2 mod=
el.

Hi Alex.
Could you help to attach the dmesg log and all CPU model info ?
Meanwhile I will check if I can reproduce the issue on my side if I have the
any similar CPU model.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
