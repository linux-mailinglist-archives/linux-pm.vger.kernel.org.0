Return-Path: <linux-pm+bounces-6155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC5A89EB84
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 09:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EEF1C210E3
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF6813C90E;
	Wed, 10 Apr 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkTH1YL6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8813C90A
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733131; cv=none; b=klRJ78V2dzXRh8XrzHnpedmhWgAtuE/pPLnxjG9S2QabJJWxqEjuEXITdocaq3p8QPBOL7m4k+kyrn/5xZ0Q5r27e48UyDUx/M/L1Za7X730vgdUIueRvLKBlCPvCbhl+uXuMdeYHNox4YwmZRfT2vbnKGMm+ijS36xS7bykl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733131; c=relaxed/simple;
	bh=n0Xf/G1khtIsJx+3VKbXiZ9oIkBx2tpbMRz0bRUG+Qk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABpEQwJBPS5UrfHKndPngnjTFVCJg3gOrXZ0m43RlKOssPH33UWt3u+TEPRoiuxGjYgGIjopFJCFCoLmFHFpDMrxhJD1XkJ/zurwuQtWul/Z95rkbGQStQIB1wESBPyO3yggSf29VqU6fb99eb3W1rJw4ZzJsjDoVWLxd82aVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkTH1YL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4677C433C7
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712733130;
	bh=n0Xf/G1khtIsJx+3VKbXiZ9oIkBx2tpbMRz0bRUG+Qk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FkTH1YL6zwhHlYRcdnauYKVP3PxlB3NrPe4ybLSv3VMmypKotIHEvtp0T0hdFfk7a
	 yO7hvZE5Bc/q45n+PAR5PgXb/duDpn79qgZjYaEfv2xJe2WphsxmSlEQ+jdHWtDwVv
	 1OpDMPsN1DTlosEBEUwSqNuMpSnpLykrIY0wxzik5GzGZQ9GbzvDE2NkhdcktqaXO+
	 bb7DDtN8guPfcaZNX1XVEPq0jt3CWm/TDM4Ir0DvCiDPC8Lu7RWgrjQ21lF2xVGQr2
	 hDwfiZxl7AkUmjgAHKI3QmEZuZTjfLNVVcE2By/5PqoNucJCsr5ysW/ZN58yHLzz12
	 9blWiAhMV/UWA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A89E1C53BD9; Wed, 10 Apr 2024 07:12:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 07:12:10 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-ARVY5ul45y@https.bugzilla.kernel.org/>
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

--- Comment #20 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi bro,
I checked your cpuinfo log, the CPPC is not enabled on your system, so the =
MSR
will not work at all, EPP values need to update through MSR interface and y=
ou
also see the crash log when you try to read or write MSR.



for example, this is captured from my system, lscpu need to expose the cppc
flag on your system like mine.
------------------------------------------------------
    CPU family:          25
    Model:               116
#  lscpu | grep cppc
rdpru wbnoinvd <CPPC> arat npt lbrv...
------------------------------------------------------


If your system BIOS have no such option, it will not allow amd pstate driver
work as expected.=20

Please contact with ASUS to request new BIOS to enable CPPC for your system.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

