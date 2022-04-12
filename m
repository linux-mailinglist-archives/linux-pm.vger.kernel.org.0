Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC054FCD80
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 06:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345115AbiDLERk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 00:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbiDLERj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 00:17:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E915FD6
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 21:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 133F7B81B11
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 04:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6861C385AA
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2022 04:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649736920;
        bh=CrDZjg7EERdtWB0ddqNSt6jVMrqF5LDPJ6ip/xO8L90=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NPD+SqzxLi/vRntX0UnoVMstFuupCbFw4eAzAGJv0C6Mdol/jJg62yOn+nSrF6tsI
         SLkK+Mi1jJbZchQMd75X7jZHp/3vSRZfKu4wNuA0ey1+/HiHLU7BS6KFV36iRN2rck
         S9tJmjCA30kaw8B+5I3I5cIi58SPCGlZDB2krte+kXuneoPYehWDF6QHLdMyL6dunz
         XZh/cgbZrSFtA5sPNVD/X3iBMH+0wGwq7WKLI1ILfpaBStmQL+vAHEX9xGe4dCwRbF
         aR3lUv/9akGZdWtGOD9b2qwGLiAxZyFe1ie9Hu89AFF8t8gSZ/hpOcYCfZVxCcv/jR
         Xn2n/q7TO1Oqg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id AAD7CCC13AD; Tue, 12 Apr 2022 04:15:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215800] amd-pstate does not allow to set arbitrary maximum CPU
 frequency above 2200MHz for a desktop Zen 3 CPU
Date:   Tue, 12 Apr 2022 04:15:20 +0000
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
Message-ID: <bug-215800-137361-YlXrbDCiwt@https.bugzilla.kernel.org/>
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

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Joe from comment #5)
> "I've tried to fix the issue by `cat cpuinfo_max_freq > scaling_max_freq`
> but that didn't work. "
>=20
> cat does not work. Please use "echo $number > scaling_max_freq".

From the original post:

> For my Ryzen 7 5800X I've tried (under root) numbers from 600 000 to 2 200
> 000 and they all work:
>=20
> echo $number | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
>=20
> However anything above 2 200 000 instead makes the CPU stay at 2.2GHz.

Echoing the number manually didn't work either.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
