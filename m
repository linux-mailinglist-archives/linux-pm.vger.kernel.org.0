Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B5C51F79E
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 11:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiEIJNN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 05:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiEIImP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 04:42:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7611312A9
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 01:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D47FB8108E
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 08:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 043C7C385B0
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652085482;
        bh=Kz6CDz5kIbeJlC1q5ITghEDiaJwsNSBobnynDHjS1x4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jstWMA9PWVc1TCfJDIImiMQelNyMv9cGS5yAIHOUdXflOJGLk59PmGLEazJBWGJnp
         zH5+wciMuFJos4DA1fGc9/WOOLqhdsIl6unVkExOkLULiMQ1f+VP56NcaN4KDnPhhl
         acEXGXo5G0bTENtx1l5zMRHIPbJN4F27fuvZctVC85V8CbRzj/xEYgvh+YxlVx2Sjj
         Mhv5n+u2c4nY1CblFvbxmNqSyxm7ryQxtjhqYvfilnufsVo84iGqUSCKmdFo61L2jR
         a7KL4u0s9wfmV8VyHVJRWQyMEzAY1NPl1bwJhtuqM9ecVdlZH/f+VG/Isj4ZhoUSbm
         UR4n13OTF1LWg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E0569C05FD0; Mon,  9 May 2022 08:38:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-pm@vger.kernel.org
Subject: [Bug 215729] amd-pstate driver has a much higher idle power
 consumption for a desktop Zen 3 CPU
Date:   Mon, 09 May 2022 08:38:00 +0000
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
Message-ID: <bug-215729-137361-NVvfoHP98z@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215729-137361@https.bugzilla.kernel.org/>
References: <bug-215729-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215729

--- Comment #9 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Joe from comment #8)
> Hello,
>=20
> I reproduce this issue on my local.=20=20
>=20
> Your device (CPU family:  25, Model:  33) should be shared memory solution
> with AMD P-state driver. Updating CPPC request with shared memory will ne=
ed
> more energy  than writing MSR register directly. We are checking this iss=
ue
> now.
>=20
> For ondemand governor, could you please try to reduce the sampling_rate a=
nd
> then check to energy consumption again? Thanks a lot!
>=20
> Here is the command=20
>=20
> cd /sys/devices/system/cpu/cpufreq/ondemand
> echo 50000 > sampling_rate
>=20
> Thanks
> Joe

Changing sampling_rate from default 2000 to 50000 has improved the situation
considerably but still acpi-cpufreq has a tiny better idle power consumptio=
n.

acpi-cpufreq: ~20W
amd-pstate with default ondemand settings: ~23W
amd-pstate with ondemand/sampling_rate=3D50k: ~21W

Looks like the ondemand scheduler is not super efficient with the amd-pstate
driver.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
