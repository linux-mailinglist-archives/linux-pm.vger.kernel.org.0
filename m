Return-Path: <linux-pm+bounces-2516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC6B8375D8
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 23:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDF81C23C5E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 22:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C31D482D6;
	Mon, 22 Jan 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIMFv7S2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723848780
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961292; cv=none; b=WJCePXCymmzSmbNE10o6l72Sv/xovpPqXfaXDBPeQT/zYDSVKG9eYeZG4NMQq2W5q/DwEZ8MXglwt2/6KRdHxcrDvHe1NQQ+lMgZDqksdyGTgHtAJEToprnne2SvVFswYz8GofcJITFe8vRa/c78cG4VJAbbIIC4r6Y7mxKK6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961292; c=relaxed/simple;
	bh=x3TkesbI6X22V9paxjyP3epr7ndXcPaIbGt8h1dWCnw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdlU5Ssxl35yrxI02MOXJQJOd+RXxv5XsGKljzAlrC/UChdF/54BhGpoDj7etOjsAtZjlBU4dG8NfBV0+nrKskn687r/m+TWkkSZfVoXaVbb7W9rzYnFsuzhw4dmw1oHpRlD2FWsTveGVNR2t3fZSrkx7H+CP3sDo7qpxMZ7ARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIMFv7S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F28FC433A6
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705961292;
	bh=x3TkesbI6X22V9paxjyP3epr7ndXcPaIbGt8h1dWCnw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jIMFv7S29UJKhO9oCTZx2csYeQSPs8wEjHzfnw6V/1g8eWux62QCQKH9Y1M8MLsEJ
	 CZRoG01bKPAj+35j+Fn6nN1JFY/CpWBZKo/qvrIPmUvDMlsPPjJv8RloxkBtZaaWts
	 /9Rub06woiWQroQxdbyr44eOOBdeNBAxNMjcEEjWK6spYF+QtIEy3mg4RaVf4T9EtZ
	 TH4SBULPJM4Drs2s6FSjytJKvFuwqgFykIzy6ctrOHt1YBFV4W9taz2P7TgiRrirZa
	 1a+mER4wL7xAFbckDDD91BjMvFcsiFW6QwJlsa64yklOnQ8Nn2DEOS98Sq9HZHJGW/
	 O3gNsCY7ocJKQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3D3BFC53BCD; Mon, 22 Jan 2024 22:08:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Mon, 22 Jan 2024 22:08:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alessio.disandro@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-Ah4uakZucd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #32 from Alessio Di Sandro (alessio.disandro@gmail.com) ---
I have investigated a bit what happens on the Windows (dark) side, and it l=
ooks
like CPPC is active and used by the OS (same MSI motherboard and bios with =
dual
boot).

HWiNFO shows the list of cores in CPPC order, and by monitoring clocks core=
 21
is indeed the one that can clock the highest.

Windows Event Viewer agrees, showing ACPI CPPC being used (performance state
type) and core 40 the one with the highest maximum performance percentage
(numbering starts from 0 here and considers SMT cores too, while hwinfo sta=
rts
from 1, so that cores 40/41 in the viewer is core 21 in hwinfo). All the ot=
her
maximum performance percentage values agree with hwinfo's CPPC order.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

