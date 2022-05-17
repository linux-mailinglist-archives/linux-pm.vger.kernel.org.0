Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC2529BC6
	for <lists+linux-pm@lfdr.de>; Tue, 17 May 2022 10:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiEQIHV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 May 2022 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbiEQIHU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 04:07:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5410F3B549
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 01:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA9F761189
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 08:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FD1DC34117
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2022 08:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652774838;
        bh=VunKgfp6h6X7ADASGk+gjh8bXSAFslgQm4R4Or1NYvA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Xh+CEsZIe1G8OgH4GPghZ5eslGae+ARdd976VtA9uil2d9yP4G+NIep+w/ivt0T6F
         X6BfWglgFTMMPAOrT8xy84K1/8kw4yRP+DToh8FrhIHkOnGY5QVV7ARr+Oq9PpoxWh
         ZvUjBSHglDBQCazJDsfH1oyOiV7/hvpi9E+D9fqqMeoHHfNzaa4x2e6rfPQLSeBdYs
         SD0y61oOEHmI9c1idaQV1UxZDeXjsBWguZaYCb6lU3h8kqQJEiEQvUqDoRh9dN8UVG
         CZ2AI6vLCP1Et3zdOdY0YX42dn766TG2Qhgp/GEqJLjedo8xxpkz5TCF8b+UMyf4CH
         7WeUjOOHvP5jQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 21BDEC05FD6; Tue, 17 May 2022 08:07:18 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 17 May 2022 08:07:17 +0000
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
Message-ID: <bug-215800-137361-HuUQRa6x62@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #15 from perry_yuan@outlook.com ---
(In reply to Artem S. Tashkinov from comment #0)
> For my Ryzen 7 5800X I've tried (under root) numbers from 600 000 to 2 200
> 000 and they all work:
>=20
> echo $number | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
>=20
> However anything above 2 200 000 instead makes the CPU stay at 2.2GHz.
>=20
> This is after booting with acpi-cpufreq and loading amd-pstate with
> replace=3D1.
>=20
> Even switching to the performance governor keeps all the cores at 2.2GHz.
>=20
> I've also tried the userspace governor and again only frequencies up to
> 2.2GHz work. Anything above will be ignored.
>=20
> I've tried to fix the issue by `cat cpuinfo_max_freq > scaling_max_freq` =
but
> that didn't work.
>=20
> That looks like a bug.

Could you help to try the below kernel ?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/dri=
vers/cpufreq/amd-pstate.c?h=3Dnext-20220516

I tried this kernel, but 5950x cannot reproduce the issue as yours.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
