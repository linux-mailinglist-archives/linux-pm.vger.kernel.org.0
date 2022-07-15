Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CB575E13
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jul 2022 11:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiGOI4t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jul 2022 04:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGOI4s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 04:56:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BDC1178
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 01:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 839FAB82B4B
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 08:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F68EC341CD
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657875405;
        bh=++2HCWOgpNKz72P1WKq6ptoswvSEaLdTwcGAGd2aWXM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dtgHj6+kWPU3mXo+R0Hs7xpfI8JyPWgm+UpBNrYqmBdknzkBgN0LO/dQ/IGwx5/NE
         MkNAp+o9/SLNwkfZ4MTHX3vKY9LZHK1cOiqn7Ny9INPi/5AhqfSNui9499jidfpIqT
         ZYLwLGO+VNtDiXaSfDIidiQ+ViC/EquPLjsCnLg0r3Qo6LWv4zlmkbdKZB7YoBoWwc
         1Tvxty1m6QiHTk8iwDiDy6NOegowMrLDa559YlNP0moviEX56dlMcDF8ViW8qOK+80
         +tmCIfekjrbxPG0nxPX7cdhAFfaQ+tdYlIIkA9oSNy7hjmAD/PI0T6oKXz99qq1CYb
         wkDk58V5edUDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id F0482CC13BA; Fri, 15 Jul 2022 08:56:44 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 216248] [Regression] amd-pstate stops working after [ACPI:
 CPPC: Check _OSC for flexible address space]
Date:   Fri, 15 Jul 2022 08:56:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216248-137361-ML2sZoBGfW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216248-137361@https.bugzilla.kernel.org/>
References: <bug-216248-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216248

--- Comment #6 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Arek Ru=C5=9Bniak from comment #3)
> I've built ...git/rafael/linux-pm.git #branch=3Dbleeding-edge (as far I c=
an
> see it's match linux-next) amd-pstate not working.
>=20
> I've done any dumps on this build (hope it's not a problem)
>=20
> 1)it's loaded but not detect boost (but according to turbostats boost wor=
ks)
> 2)will be uploaded
> 3)yes, you have right:
>  [    0.494379] ACPI CPPC: CPPC v2 _OSC not acked
>  [    0.494388] ACPI CPPC: Flexible address space capability not supported


Hi Arek:


Could you upload the dmesg log with below parameter in grub?

cpufreq.dyndbg=3D+p amd_pstate.dyndbg=3D+p cppc_acpi.dyndbg=3D+p debug logl=
evel=3D8
log_buf_len=3D100M

If the driver was loaded, I would like to see if there is any loading error.

also need you help to post cpupower output .

# sudo cpupower frequency-info=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
