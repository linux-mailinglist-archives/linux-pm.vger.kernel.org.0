Return-Path: <linux-pm+bounces-11735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B509425E2
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 07:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3ADD2875C1
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 05:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C5849649;
	Wed, 31 Jul 2024 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVPgzpaR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1C49643
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404470; cv=none; b=NRKww2vJ5KVkyjG3B1tPb6llKhlzmq0U838ltRDEK98HtJcPiAuaiyF+4vy80f2xAxwIc27eI/MfzuPHmLgD13OAGr1h+WTgteo8QbtTUiJncSwr+eM0k654tn4SDrHtkSk0FMhr4pO1tprzGSg1AOb1J4hXHdO/ZsQaJyU36DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404470; c=relaxed/simple;
	bh=XY/HexnDesvfq+PDs3Oq92NdltpNO5kNSej80KJNMYw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UCPx6wkd83vHrVX0TRWRyZDpWl/hq4WXhqUW6O4bW+Hl5vY3atKdvhxNitr+HkcWi2dpd4wp2o90OY2JqFcsXJWlJwJ6i23vOVypq8jKwemMetx8MvRcefzoCbfzp5FzyeaoJzd7RLSCnHhllf7LlD8NTQmuXa6O5F1t8DwvQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVPgzpaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 094ECC4AF11
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 05:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722404470;
	bh=XY/HexnDesvfq+PDs3Oq92NdltpNO5kNSej80KJNMYw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gVPgzpaRn2VYDh0Yd/X0kx66aiAG4u8SAc+if5ga9mEskDlQwhGuuZG2pGf0zP3m4
	 MbFSUusJnz0wOrrT4NQknC0G1GG7jabrNhQXSTwLDt0L0SoLCyyqygnC5GAIBXOBnP
	 qbOeqmRoolOE6ChvG6RCellSyys4e6jz468FiqqfktRFsP9CZUDvt+d/V8mQpV6fUe
	 NDPuG+zXkCHGa24KeE2nVYtgpCRnVD97/XDsR9jigzJpU/OTvSyA/DeTlPavETVhvJ
	 pV/J+I60iI8gARAjRgAHY8T6yLk0b/49/g2QOhSvzdnJZsNLXCW/9gVaX95ui1PJvS
	 qs4fwsdC5+01A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0338AC53B7E; Wed, 31 Jul 2024 05:41:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 31 Jul 2024 05:41:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xiaojian.du@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-TqQqXE27cE@https.bugzilla.kernel.org/>
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

--- Comment #62 from xiaojian.du@amd.com ---
(In reply to Chema from comment #61)
> (In reply to Chema from comment #60)
> > I have the same laptop and also the command outputs are the same.
> >=20
> > I have updated last week to the last BIOS version, but no changes I have
> > seen.
> >=20
> > Is there any updates to this?
>=20
> Also, if CPPC is working in windows why it cant in linux?

Not exactly.

How to check CPPC is used or not on *Windows OS*:
    *check Windows Logs -> System, look for "Kernel-Processor-Power" or eve=
nt
ID 55.
       ->>If you find ACPI Collaborative Processor Performance Control,
           then Windows is using CPPC.
       ->>If you find ACPI Performance (P) / Throttle (T) State,
           then it is using legacy P-states, and CPPC is disabled.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

