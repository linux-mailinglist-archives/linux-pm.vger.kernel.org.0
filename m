Return-Path: <linux-pm+bounces-6007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0303A89ACEE
	for <lists+linux-pm@lfdr.de>; Sat,  6 Apr 2024 22:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C611C209FD
	for <lists+linux-pm@lfdr.de>; Sat,  6 Apr 2024 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596773CF63;
	Sat,  6 Apr 2024 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut4eFPOK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D21FDD
	for <linux-pm@vger.kernel.org>; Sat,  6 Apr 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712436543; cv=none; b=Bo3v1FVDH34KxFzCGQZyjt49l9wKs4qv7jT0AbkIOGoHVO1feVpW53dhzom1FdkS5868BMpvdMixxiQCKk1F7LlOK1b4n6L45xNbJX+PU+u0xaq2Opf4wqABOoNBGx1AsvziDHf9SG3F/eVm1Mq0jAndwodgyVTddhvo/vyaUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712436543; c=relaxed/simple;
	bh=lN8h8e8jZL3xNzPdcwYK1/gMmZDE5605mRKUvxON+GM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nM9CEga4ODSkEwtpe0VP47DghxngZiP0V8u421y7EsCYVyDET7LbOHljwgYsJ/WaxGTsZdTA0kz4HfFQMixIuInfmZBjhcF/nCuoYYNVNpIdhq6+9NtavLqjkBkH9EDeiraFmQRiT3ZaB15WItBmIWiYBmrBRli/2k+kjX7iAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut4eFPOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA963C433C7
	for <linux-pm@vger.kernel.org>; Sat,  6 Apr 2024 20:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712436542;
	bh=lN8h8e8jZL3xNzPdcwYK1/gMmZDE5605mRKUvxON+GM=;
	h=From:To:Subject:Date:From;
	b=Ut4eFPOKjRm4zzzs0gQzQhoW8tGIhbKo75pNb+OA81AzlrursYoJMB1id/NN4nvOu
	 b86rnGfm0chNbkPjewM4wYszIyOAODyz1YDkX2Gq5Odt8+vWehjeE64WcBat2cR/XO
	 iEwv5Qnkho7V+Ij0CCB2QVJfUT2l29qoXjSLWW0HChnGtkj6D7AF3OepkrTOVm4d/y
	 4rxmR+7xT4xXYooHXYhgj4ndXfIodfLq7+eu+8ex5mLShGRM5N+16dfUZfUggRrxqA
	 HFJ4nG5kHI30scXAlHXIBfC/mBnOXdlMKhtUZ/hZbX+9ISUiSs6Nk1rcikWkKRUk1k
	 A85zw/JiBnbVg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A1974C53BD7; Sat,  6 Apr 2024 20:49:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218689] New: AMD_Pstate_EPP Ryzen 7000 issues. Freezing and
 buzzing
Date: Sat, 06 Apr 2024 20:49:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kbii.chris@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218689-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218689

            Bug ID: 218689
           Summary: AMD_Pstate_EPP Ryzen 7000 issues. Freezing and buzzing
           Product: Power Management
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: kbii.chris@gmail.com
        Regression: No

Hardware:

AMD Ryzen 9 7900x
Gigabyte b650 aero g
Corsair Dominator Platinum 2x16 6000MHz

Kernel tested on:

6.8.2 Arch
6.8.1 Arch
6.6.9 Debian

Issue:

There has been a static noise coming from my cpu as well as frequent freeze=
s.
This is nearly constant and makes the computer impossible to use for long d=
ue
to the sound.

Remedy:

I have found the issue to disappear completely while using the passive driv=
er
provided by amd_pstate. The scaling driver must be set to schedutil. This
completely mitigates the issue.
kernel flags: amd_pstate=3Dpassive cpufreq.default_governor=3Dschedutil

Suspicions:

I suspect the power management implementation used by amd_pstate_epp to be
causing this issue. There is a async param found inside
/sys/devices/system/cpu/power that is always set to false whenever
amd_pstate_epp is used. My intuition tells me this must be what holds up the
system at times while changing c_states or something.

Extra:

I have seen alot of talk surrounding the fTPM and issues around it but I ca=
nnot
related these two observations together, hence why I am opening a new issue=
. If
this is not the right way to go about it mybad, this is my first bug report.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

