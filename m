Return-Path: <linux-pm+bounces-6143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9803689EAA6
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A891C210AF
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E5522085;
	Wed, 10 Apr 2024 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJiIJqdc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FBD20DDB
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729941; cv=none; b=bIJIrSflUO1pCaptqx+rouaE61NEPRslgEh/RsFVshaLpPQWqMloMiKsE3iCdvQ1lHqac9zugRve67GgUh1Q1/dmxeDV5f04V++CpPPRab/I0RRpd1Asb4G2BmRBKgfzxuA8EpLh2HNExPiJsp90XdK4+qq32n905a+XJTPGcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729941; c=relaxed/simple;
	bh=q4oxASbm7V5lkB3fBhrinpOxPI21CsEVDfNGfBNl4A0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FclC0iNJA8rhqNFGcXnhh9RLFCHMDZpQR808XhZctAVnEGzUjP4wh1OHDt4tKYV7rSN8iHE/Y2iJiK36uE1CBW7IZEmgOj2Kn6LMrfNKFbQZdaVOMxMkMpUKqoXVTGa1+3KkD+aqtyNmLdzWnWlOmRDF82EXj/8y+qpa8Rw49KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJiIJqdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A1A1C433F1
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712729940;
	bh=q4oxASbm7V5lkB3fBhrinpOxPI21CsEVDfNGfBNl4A0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PJiIJqdc0uR/OrQhvAM1yg5F0/qeCr6LdPr5iF2lNqNrT+jk0HZGdhrFz6BZD0ttE
	 Ytl5ZnnzioyFjttqNxSPrZpbN6QqCOa/cHYpdI9+Mmr3XCClfh5BMz0niOk8Ie/Xwj
	 Qn1l4aQ449VpLfNKWYhashHKO1js+5rJTekasb/k1zM/0XioK1OOddoixn+7gu1Knc
	 OR6scaQun0BMlySsXUuN6wrN+GuY0rMnida3Fl/6IVgrfQr3QPZS/iQp0i5EZPjOr2
	 l0paCLB2QvmMWNnuTKpz8pdgHVoaXhT/ODFJeMJJYq193bBjf6IY8cR8Oq96Ox43dX
	 YWsSeKowOtrvw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8EFF5C53BD9; Wed, 10 Apr 2024 06:19:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:19:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-mlW25j3b27@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #9 from al0uette@outlook.com ---
(In reply to Perry Yuan(AMD) from comment #7)
> (In reply to al0uette from comment #6)
> > (In reply to Perry Yuan(AMD) from comment #5)
> > > Hi=EF=BC=8Cplease help to provide this output with below commands.
> > >=20
> > > # cd /sys/devices/system/cpu/cpu0/cpufreq
> > > # grep . *
> > > #sudo rdmsr 0xc00102b3 -a
> > > #lscpu -ae
> > > #dmesg
> >=20
> > Should I do this with amd_pstate=3Dactive commandline?
>=20
> Yes, if your kernel is not updated to include the patches which make the
> amd_pstate_epp as the default mode, you would need to add amd_pstate=3Dac=
tive
> commandline.
>=20
> After you added the amd_pstate=3Dactive and boot system up, we can check =
why=20
> the EPP values cannot be changed.=20
>=20
> Perry.

I've uploaded my output. BTW I do use a quite new kernel (6.9.0-rc1), howev=
er
without amd_pstate=3Dactive my system uses acpi-cpufreq :(

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

