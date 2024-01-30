Return-Path: <linux-pm+bounces-2993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC665842697
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jan 2024 15:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85F228C214
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jan 2024 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF796D1C8;
	Tue, 30 Jan 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuS0KCnV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D26D1A8
	for <linux-pm@vger.kernel.org>; Tue, 30 Jan 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623416; cv=none; b=WtfnvBPqRP0R3tpy6dHPfPvtTnkDKYS5lrBGB8XHsPzM6R1r6oejrvrlkOmSATKRGivwfxnn21/yzdNzhOUNTMpXmWYL6y5wkD8EwF2b+ySCfZYjHifnwpKfwQM5CSwJimC62RL93eBH1TZHMWeXPsQY5byP79kHABx/IzsSU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623416; c=relaxed/simple;
	bh=Bm17Yzvf54lb1ol+6Pnb5XQGR/6x9cBdAENhxlSi6Co=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RONqufKOsje/dUp8nqMxpHotBO57hxFBmtYm4ju2wh+mGpopOfrto3di1yGsVRSXcIbcmhDM5muz6eNCIfBAvl4WX3JoMIJwDLpMQB7pK5EkVJCdY2SKS47/WH66NknIYQSixyYFkDLTSHwBV7nmV0ER84rQzOc3M1uaNYXetgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuS0KCnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D74C4C433A6
	for <linux-pm@vger.kernel.org>; Tue, 30 Jan 2024 14:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706623415;
	bh=Bm17Yzvf54lb1ol+6Pnb5XQGR/6x9cBdAENhxlSi6Co=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PuS0KCnV4GR2pBmquvk8QF58LbUxZE4NZGZOtnOwEzmWI5qxaqyHBoRhA/WXQ/isd
	 nrAHvLuMsUUDGqnBnkHn44Xq98/VT2HsvvjD/RhnezR+4KxjKxcZiBwZYEUGVWTX7N
	 G1RC95lDtkFQcOOEDd11dD/rxXIQeqDqhGzTYEZyxS5TY9F3Yeq+9FaR7WBN0/pFOW
	 /Wx0orlN8KbhvCifE5IRnKGavwyA8kSLFDDNuIfNPUBVgXDOaq6O3ZkYKK9Bsssohe
	 C5EjVWQdaCoMIx+6bKv50Vfbk4jjVzSpnavY8TGxisgjdcztcaEq+V3bKDA2ymYVrd
	 X8pMXS0i5VwAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C44E6C53BD2; Tue, 30 Jan 2024 14:03:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Tue, 30 Jan 2024 14:03:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-JGiQjvZEIu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #41 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Sjoer van der Ploeg from comment #40)
> Could this be the reason why some CPU's do not boost to their maximum
> frequency, while they are happy to do so on Windows?
>=20
> For example my 5800X3D never reaches 4550 on Linux, but on Windows it see=
ms
> to have no problem getting there.

Could you share the output with below commands? then I can check that.

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal freq=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/nominal_freq

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal perf=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/nominal_perf

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf perf=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_nonlinear_perf

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_perf

echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest freq=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_freq

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

