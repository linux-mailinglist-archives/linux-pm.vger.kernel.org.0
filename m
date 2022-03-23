Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311494E4ABB
	for <lists+linux-pm@lfdr.de>; Wed, 23 Mar 2022 03:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiCWCL0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Mar 2022 22:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiCWCLZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2022 22:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91972580C7
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2022 19:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 344CF614AA
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 02:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92967C36AE2
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2022 02:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648001395;
        bh=TGByKuChoT4UH/eNjvUJXqaiNNJLzPXPKK2+u++CBOI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BSZ3dSBm9vucC7mklL8cfDZjFp9zdzmt8/SasQpMZM90Reza7PWLlgHA5DD407tyy
         ae2jBY/9mHzfRamEq3DsnFCJdiX5g5AlEOTApPcjaTXhzvjW1+ej8FCvXUwYu2WTXB
         xCLyrcMiuqq7RD5jWupqpiqrAwRvK4vhgL9RbM41mp4RSA8E89ooTFrdX9fsO2z/6c
         7a9wbw3L6lcUMc8ja0d+S3/Iog17/BstfKRwqLXd3Lpa5HkvnmxdcLsADmzgWQYKbc
         oI0utSYCCEjE0zcaTE/NSkscheeS+BYfyVuSpYmuqoBtMvSja7OH4rDvl83n82jnX2
         E/CgPnmsB6Rfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 764C9C05FE2; Wed, 23 Mar 2022 02:09:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Wed, 23 Mar 2022 02:09:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: huangrui@mail.ustc.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215729-137361-qzrr3AfEal@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215729-137361@https.bugzilla.kernel.org/>
References: <bug-215729-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

Huang Rui (huangrui@mail.ustc.edu.cn) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |huangrui@mail.ustc.edu.cn

--- Comment #3 from Huang Rui (huangrui@mail.ustc.edu.cn) ---
(In reply to Artem S. Tashkinov from comment #0)
> I have a Ryzen 7 5800X CPU.
>=20
> With the acpi-cpufreq driver the CPU idles around 20W, frequencies are in
> the range of 2.2-2.8GHz.
>=20
> The very same system with the amd-pstate driver idles around 25W frequenc=
ies
> are in the range of 3.9-4.75GHz.
>=20
> This doesn't look right.
>=20
> Changing governor from ondemand to powersave reduces idle power consumpti=
on
> to around 21.5W (still higher than with acpi-cpufreq) but this obvious
> completely destroys performance.

Thanks to report the issue. Could you please dump the print of "lscpu" and =
use
the latest bleeding-edge source code include the CPUPower support
(https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=
=3Dbleeding-edge)
to print "cpupower frequency-info"?

Thanks,
Ray

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
