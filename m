Return-Path: <linux-pm+bounces-11751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D41942D8C
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 13:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5787B283DC7
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B171AED50;
	Wed, 31 Jul 2024 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEz7qvau"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365541AED2E
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426866; cv=none; b=uN6/tWsii4eWy/dZHMH5mbqs8eHwkTklL/ACWbrXKzjHMjCD7JmRAoGdMQFzbIYk2aYuIDiSPRZaamVtFw7kzE3Ua/EQDsSBzW/WkJLSlXU/FVrwgckEBiGmNzkX7uTkHiSHJDmx8PziIiKQv6n+oGXdzF5SBY0nWR1CnXAAWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426866; c=relaxed/simple;
	bh=geRytPZ3bmY7SAwjrlT9zYM8V3g5xuHo4RxGWea9zz4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=urM3VuO6HGU6/PP9kt9JezSTEEHMWSFodC4iZ0LZzpuomFo6AHKduRUeVXxZq/EGckty05ihbN2YW7GUlCsglD0Fftp0OIpKYsCPG8+MOj9Libwvb65O0eoUZna9FStS9OZjkmTfza5h7OCRF4My7DO8DuafVIAvEABbI0HQoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEz7qvau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB092C4AF09
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 11:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722426865;
	bh=geRytPZ3bmY7SAwjrlT9zYM8V3g5xuHo4RxGWea9zz4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YEz7qvauDMsZqDabenrzasIJb2r1VClAfJ48olTyZ3AEaptu5yOQ5e8ps6R6I5J07
	 sRcj4aesONiL00127WHDDePU9vIDfv/4UYoewssCXC92eoFpFJbXsmuwVIxaDJ/eaE
	 w/oquHT5Pr6DGcJhkl9IzpJ2kCdlnlxgX/J7PbI+TyH8YOq1l5mz7HRv0W7NzVlf+W
	 79cw0xe92mAkpatzHt2caht+THMatH6CsOZUzkExtFPHxCNt08PVlipnBugtLqc835
	 TC0Rl30fxMO2ELBpyCf5/KT/x5jpL70qu7e7wABeJg3ttP4kBpFHVCT8CMCnh2rdUy
	 RlCnEP5IgrnLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AF2E2C53B7F; Wed, 31 Jul 2024 11:54:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 31 Jul 2024 11:54:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chemasanchezgarabito@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-Im57OMNkCg@https.bugzilla.kernel.org/>
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

--- Comment #65 from Chema (chemasanchezgarabito@gmail.com) ---
(In reply to xiaojian.du from comment #62)
> (In reply to Chema from comment #61)
> > (In reply to Chema from comment #60)
> > > I have the same laptop and also the command outputs are the same.
> > >=20
> > > I have updated last week to the last BIOS version, but no changes I h=
ave
> > > seen.
> > >=20
> > > Is there any updates to this?
> >=20
> > Also, if CPPC is working in windows why it cant in linux?
>=20
> Not exactly.
>=20
> How to check CPPC is used or not on *Windows OS*:
>     *check Windows Logs -> System, look for "Kernel-Processor-Power" or
> event ID 55.
>        ->>If you find ACPI Collaborative Processor Performance Control,
>            then Windows is using CPPC.
>        ->>If you find ACPI Performance (P) / Throttle (T) State,
>            then it is using legacy P-states, and CPPC is disabled.

I have created and attachment showing that CPPC is working on windows, so is
this a thing of linux that does not work or is it that windows have a
workaround for activating it without the bios having it enabled?

Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

