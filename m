Return-Path: <linux-pm+bounces-11752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613B7942DDC
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 14:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026A41F22326
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFB51AE854;
	Wed, 31 Jul 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfAOJyYn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA01AE843
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427937; cv=none; b=RKXZhvNWlutZ4Rh3ZDUGBR/j35xi4/7/J0nQI4RAOFwEYxHx13ySM5trnuL9zwtArhxmZAZ3W+wV+6HKk2JKyMU9BwB3gyF7mECJdO+skPlOzKzgczar2qM0v3DmnjUNsOBCCddoE6YEtRAuRMC2eMmSiIEnGWAqJnWIbyAr51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427937; c=relaxed/simple;
	bh=IPTZD0vntY+OBEViRACEt61rWebVg+7IkN1aaAzC9q0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eo3pOxvf2WA4Czg28wZyaOfk4e88rxTSDUtMlcomXLwn0T7LN7qsSxPJiyZr7xrz8h6ymgCjMNppMgQ82tLbHHF7hMv3xQD16GkkJyeigDRr3qk/51r30gFqH+jLh7Tx012XQcOM6f3vUThicOshX98+BJcQf0OxHn+yWdHJ0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfAOJyYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6C71C4AF10
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722427936;
	bh=IPTZD0vntY+OBEViRACEt61rWebVg+7IkN1aaAzC9q0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UfAOJyYnzTjUkrMzJ0U/magEUYbzRpi4Cy+gMgyLWqGLHj5HmDHOJh3Bpo0rJ3QSb
	 BbmYHy+U7FV6wKep7kVBTeQkyCOn6saoX0/IE8g+Oc7hTwYZtLyrSuKDfBD5R4XrqV
	 7m5c3jDJcbRpfzmjCr19jlD/QjZGOCLXa0KTDmSUL/f6mZk7oor5i+Jep+82mFzrFd
	 k5xOIAeKnG9NgulT6NKS+AW+G23+7zQOkqfSMsH8RnReQpcyhMpoyMiXLk9tCVwZXu
	 dZq0mJyHXBOKASa5RSMoOZCKIT2ZS1HO2zK7xflHUwcghct2l0eUUvTS6Pb4GOrUMp
	 NAG1yjeq8niYw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DA4A4C53B50; Wed, 31 Jul 2024 12:12:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 31 Jul 2024 12:12:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mike.stokes85@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-YcQrKrDIXA@https.bugzilla.kernel.org/>
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

--- Comment #66 from Mike (mike.stokes85@gmail.com) ---
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

I Can confirm on G14 GA304UV that CPPC is enabled under windows, but not Li=
nux:


Processor 0 in group 0 exposes the following power management capabilities:

Idle state type: ACPI Idle (LPI) States (3 state(s))

Performance state type: ACPI Collaborative Processor Performance Control
Nominal Frequency (MHz): 4001
Maximum performance percentage: 139
Minimum performance percentage: 27
Minimum throttle percentage: 10

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

