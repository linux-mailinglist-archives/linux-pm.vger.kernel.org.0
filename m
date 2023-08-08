Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0824477451D
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 20:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjHHShN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjHHSgx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 14:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E75C3BD0
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 10:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF45262982
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 17:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 540A4C433CA
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691517527;
        bh=4aUfVsdfQc1CQvlKkyGFnW8cmCnp7nCmItC6CEI9a74=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KMsm7WZ2FRFwWwwqR4/P7PkqJ64Uc4Z/xJw/O9kgLr46Gt8ocxaA2xiXa1dPyChtW
         nF0dOyMQbx1c5r2Zk/DjVCHg7JAXb4P9Op60z+BBsXNRBklhuvVpzMK0K6U3fCq69O
         ZPCtgVm7WtWeMRISdQtMrL+UfDb2iehqtGWpWULMv00dJod/VBU3hO911xJ1yDknpg
         UT3Xu4ZicmZGYLXL31gLeyC45z8TvjdCykvTI0bG3e3xVlgrAkg/CkxFoEGrp3gewN
         stMj0Dky+lAKIVG2m2lAF2h/Q3+bWDnAnY1MtEN+Q7r1nzgelR3xNzzJ9jWnJgUl8p
         afyn0BQ6g5gZQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 42016C53BD3; Tue,  8 Aug 2023 17:58:47 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 08 Aug 2023 17:58:46 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215800-137361-ILCxiNGCdP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215800-137361@https.bugzilla.kernel.org/>
References: <bug-215800-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215800

--- Comment #31 from Artem S. Tashkinov (aros@gmx.com) ---
Created attachment 304797
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D304797&action=3Dedit
Power Options Processor Power Management in Windows.png

(In reply to Mario Limonciello (AMD) from comment #30)
> > It's a little bit confusing though, as in Windows I can perfectly set
> minimum
> > and maximum CPU frequencies and I totally expected this driver to actua=
lly
> > allow that.
>=20
> I suppose I'm confused as well.  Windows should be using EPP as well, and
> various software constructs like the power slider will be changing that b=
ias.
>=20
> Maybe you can better explain exactly what you do in Windows and exactly w=
hat
> is happening.

In Windows I'm free to set minimum and maximum CPU clock speeds to my likin=
g.

Why is it necessary?

1) For instance you want to do benchmarking at certain clock speeds which a=
re
not known to be hitting TDP/TTP/temperature limits, thus they show the true
potential of your CPU.

2) For instance you want to make you CPU run cooler with a very precise
control.

>=20
> > Lastly the documentation mentions:
> energy_performance_available_preferences,
> > the file that I don't have.
>=20
> Eh?  Didn't your above comment show this:
>=20
> /sys/devices/system/cpu/cpufreq/policy0 $ grep -r .=20
> energy_performance_available_preferences:default performance
> balance_performance balance_power power=20
>=20
> > Lastly there's no boost configuration support which is available both f=
or
> > acpi-cpufreq and Intel's native CPPC driver.
>=20
> Something seems quite wrong if you're not getting boost support.
> It registers for boost, see
> https://github.com/torvalds/linux/blob/v6.4/drivers/cpufreq/amd-pstate.
> c#L1121

Will recheck in 6.4.x soon.

>=20
> > It's worse than acpi-cpufreq from seemingly any PoV. Maybe there are so=
me
> > advantages for APUs but on my desktop I only see major disadvantages
>=20
> I /suspect/ what you'll want to do is change the scaling_governor from
> 'powersave' to 'performance' for your desktop use case.

These two options are very coarse vs. being simply able to set maximum clock
speeds.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
