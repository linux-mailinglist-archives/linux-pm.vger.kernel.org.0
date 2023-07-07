Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A349374B3A0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjGGPHH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 11:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGGPHG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 11:07:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEE5AA
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 08:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE289619EB
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 15:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20576C433CB
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688742425;
        bh=qaGApWmRuBDGDvs4Hawd3M02V/rFmNxK/9uvqXXcVK0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=F7VORmoRiKKLOSd0ictHWa8L7eLZlkYp3yZUqfBhufRH/6/Pm30GXfTSUzHb2zVcp
         PhOAGYRPMAzFJcg7DRlW4uKPv+Yr0SSg7n1ud0vQz/5KYVCSCGJgzHl9RfOsE+02wE
         o6YgArhpUv3yO7taY0kCLxtZhGamfJ37tJiI0xrYkpARc3H+SpgWh5Nvu1sbtNr/T1
         0TGDw3Lo5+Tvixd3qhcKvv6ulzbHaAAx4i8OSwo1CzxJxpe0u/OvobjAGlr55ByC/o
         PcaLUYoQYLxNWWRT6U4MAjTCQ5/zEuVC0nDKfpAtWxUD70ht1b/OdbD/IlQfW3TGxi
         uYvmnRlCGHbxQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0986EC53BCD; Fri,  7 Jul 2023 15:07:05 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Fri, 07 Jul 2023 15:07:04 +0000
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
Message-ID: <bug-215800-137361-HpE7R8E5Qe@https.bugzilla.kernel.org/>
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

--- Comment #29 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Mario Limonciello (AMD) from comment #28)
> When you're using active mode (EPP), the hardware is choosing frequencies
> and software only provides a hint to set bias.
>=20
> You can read a little bit more about active mode at
> https://www.kernel.org/doc/html/latest/admin-guide/pm/amd-pstate.html
>=20
> What you should be doing isn't trying to set specific frequency targets, =
but
> rather you should change the values of 'energy_performance_preference' to
> meet the needs for your workload.

Thanks Mario.

Would be great if the documentation was updated in this case and the variab=
le
removed altogether if the amd-pstate driver is active. I know it's possible.

It's a little bit confusing though, as in Windows I can perfectly set minim=
um
and maximum CPU frequencies and I totally expected this driver to actually
allow that.

Now you're saying I need to work with "energy_performance_preference" which
doesn't even look like something I can properly configure.

Lastly the documentation mentions: energy_performance_available_preferences,
the file that I don't have.

In short it looks like everything is in a deep state of flux.

Lastly there's no boost configuration support which is available both for
acpi-cpufreq and Intel's native CPPC driver.

I'll retest the drive in a year. I don't like anything about how it works,
functions and its configuration options. It's worse than acpi-cpufreq from
seemingly any PoV. Maybe there are some advantages for APUs but on my deskt=
op I
only see major disadvantages.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
