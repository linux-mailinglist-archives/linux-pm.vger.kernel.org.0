Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D274D74672F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 04:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGDCOz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 22:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjGDCOy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 22:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FB0136
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 19:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E0526111D
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 02:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B14C3C433CB
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688436892;
        bh=/XB4bL9McEI2t8QIkTUNKMyltZrhVq5Dl70LOf/LpIE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tOuelYu/VrrgY2ctEXADaa9XVEGDSFdtxCCAfSsIfbaBtOfm/AYHH8htkHg/jbnkw
         rc1YPu2nZAEZp4mb/q+dk1v7iWzxkLI1wcBkvA2hJqmw5SspHweHlkjExOeejSjnt6
         WI+OiirBs8dmh5GZ+ZPvREiSxIKu/Rq1Ji6rmijoY84aX1LwHMiIQ8Z4ZrZMTD5sJX
         rq7JXB5qGugnE+5aglG77VrQXX6MRdo4y9i+dfUywFP/B/7O/GmegbxfBHTRTr2nHE
         Umkd2/U5h/B7GtRCAW95iMpVCgcJimDcyIqtrj0H1mlStN4X7dSZvRlvIR4p5kd9vg
         TWy2OGyuYmrpA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A05C8C53BD2; Tue,  4 Jul 2023 02:14:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 217630] Kernel fails to load amd_pstate driver on 3970x while
 Windows works well on the same machine
Date:   Tue, 04 Jul 2023 02:14:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: bagasdotme@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217630-137361-1uYpAevv0T@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217630-137361@https.bugzilla.kernel.org/>
References: <bug-217630-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217630

Bagas Sanjaya (bagasdotme@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bagasdotme@gmail.com

--- Comment #2 from Bagas Sanjaya (bagasdotme@gmail.com) ---
(In reply to Pavel S from comment #0)
> I have 3970x CPU installed into Gigabyte Designare TRX40 rev 1.0
> motherboard. The UEFI is updated to version F6 so AGESA has version 1.0.0=
.7.
>=20
> CPPC is explicitly enabled in UEFI settings. It definitely works in Windo=
ws:=20
>=20
> > Information   7/3/2023 4:46:04 PM=20=20=20=20
> > Microsoft-Windows-Kernel-Processor-Power        55      (47)    "Proces=
sor
> 63
> > in group 0 exposes the following power management capabilities:
> > Idle state type: ACPI Idle (C) States (2 state(s))
> > Performance state type: ACPI Collaborative Processor Performance Control
>=20
> Kernel 6.3 fails to load amd_pstate with both "amd_pstate=3Dactive" and
> "amd_pstate=3Dpassive" kernel parameters with the following message:
>=20
> > amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
>=20
> Kernel 6.4.0 doesn't shows the same error "amd_pstate=3Dactive",
> "amd_pstate=3Dpassive" and "amd_pstate=3Dguided".
>=20

Do you mean this issue doesn't show up anymore in v6.4.y?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
