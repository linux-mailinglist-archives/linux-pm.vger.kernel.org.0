Return-Path: <linux-pm+bounces-7214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 010A58B3E77
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 19:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EB01C20A4D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A59015B579;
	Fri, 26 Apr 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie2RgkkD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572B145B0F
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153259; cv=none; b=Ld6T+hGbuQphRmBYVD4M1khVSNIv4VIxd4VDQy1tYQYKu5jpGDL4uX+mACYQin8/i5UgxCYwjdxX1hPacgHJrE0T8HBCXiVsRbSrxcB8xoK3ESqPslO/6ID6mqSarGzfKcMsDkCOKugrrTUBbKcgX3juDhHIEtzJXi27RBWHBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153259; c=relaxed/simple;
	bh=dBgHBtN6AS13azEEwCGa1dkdCBSKK9yoVKpRqULrdnE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBWyoEc5IIGmy61ssK4Fg9ca2CBvYRPT0orbL5dFemyWRutASMOvmoKAqqdUdGQbScMZobwb7jocoa3U8gjeoAqOwqWS78O2sBANQqyGGbG4VZfUxhN8GT12gY4zHegJ8oJCrc5j9ZgNQxIsunoBKiJWszXryeXTsAc3eW+6wkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ie2RgkkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4347C2BD10
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714153258;
	bh=dBgHBtN6AS13azEEwCGa1dkdCBSKK9yoVKpRqULrdnE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ie2RgkkDo9RiMI9MLjqZGzuNbv6ZeInNSXfR9vbIr5ss6Bl3KgccMKgsLu6H2J0S0
	 zCt72AoZwx+xiRwYxovjP5Lq34s5WtPxUb0du3hNLGEXlwZJ2yKj2CgW9nbCcBDtBG
	 goyHMKhwUrFUNW4j9s8jQDV6Ba8HqOdhhEKXcgwdmxzu1EincbQavtW/dvZU4je3sA
	 KOUyewcROCI5ZxVR55/aIy5pCouEGiSKvES1IyNMjzCfuXTd/v8dYi4DArNUMJB+j4
	 cgs0/slUCOSUFl9BGK46i/1CbZWBAxwTFaLREyURu9D3aHTQToehTMYY8UTVdhEQHr
	 ABw/3YNzcaIPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C9658C433E3; Fri, 26 Apr 2024 17:40:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Fri, 26 Apr 2024 17:40:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-K3HmCJxUjj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #21 from Andrei Amuraritei (andamu@posteo.net) ---
Not sure if relevant, but I found out that Fedora also has amd-pstate-ut
module, and loading this, i see the following in dmesg:


boot kernel with amd_pstate=3Dpassive

[Fr Apr 26 19:37:29 2024] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid=
=20=20=20=20=20
 success!
[Fr Apr 26 19:37:29 2024] amd_pstate_ut: 2    amd_pstate_ut_check_enabled=
=20=20=20=20=20=20
 success!
[Fr Apr 26 19:37:29 2024] amd_pstate_ut: amd_pstate_ut_check_perf cpu0
highest=3D221 166 nominal=3D111 111 lowest_nonlinear=3D57 57 lowest=3D19 19=
, they
should be equal!
[Fr Apr 26 19:37:29 2024] amd_pstate_ut: 3    amd_pstate_ut_check_perf   fa=
il!
[Fr Apr 26 19:37:29 2024] amd_pstate_ut: 4    amd_pstate_ut_check_freq=20=20
success!

boot kernel with amd_pstate=3Dactive

[Fr Apr 26 19:35:07 2024] amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid=
=20=20=20=20=20
 success!
[Fr Apr 26 19:35:07 2024] amd_pstate_ut: 2    amd_pstate_ut_check_enabled=
=20=20=20=20=20=20
 success!
[Fr Apr 26 19:35:07 2024] amd_pstate_ut: amd_pstate_ut_check_perf cpu0
highest=3D221 166 nominal=3D111 111 lowest_nonlinear=3D57 57 lowest=3D19 19=
, they
should be equal!
[Fr Apr 26 19:35:07 2024] amd_pstate_ut: 3    amd_pstate_ut_check_perf   fa=
il!
[Fr Apr 26 19:35:07 2024] amd_pstate_ut: 4    amd_pstate_ut_check_freq=20=20
success!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

