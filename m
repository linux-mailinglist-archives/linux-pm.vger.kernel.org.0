Return-Path: <linux-pm+bounces-7936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890368C85E6
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 13:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36347285F3F
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2024 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959A3FB2F;
	Fri, 17 May 2024 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aos6apd4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652053DBB3
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715946798; cv=none; b=uMkhl85/4bzGtAsGP12D5QqRujwHXbI5kUJMEqfoO/MAEiSQF/5ORnkFAWz/4FGxDz5Oq0GfMf2ABGH5mfY1wT3ysumpwpQAB380EgG8wCrG9orWEQGABk6wJEFopLV/2QHembHkNFvQTMJb2mbB6DKmSySVK/tah0NMq9rY9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715946798; c=relaxed/simple;
	bh=xMN+ZCNk1TT00iHfG0FuziQ9OuoORDafU5lPuvx3D/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+a15ZdoAbc0M3fnwq+gXxqQUNZpAJNSP7q9B/bMhXAoWR/n59X3Xuplgxhi50ijWAsTjvuTh6+tyYk5Z01DkBbko5reWooaWdnfqVp1oqirHNGlQp1NgPy1DJrDnqBf0hoRDDP8hdmcBgheRDvwjjYmqjtbNSonwjG0g9iA3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aos6apd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 326CAC2BD11
	for <linux-pm@vger.kernel.org>; Fri, 17 May 2024 11:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715946798;
	bh=xMN+ZCNk1TT00iHfG0FuziQ9OuoORDafU5lPuvx3D/8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Aos6apd4QU2rRL93gigG3tYtTCjaodt5walOKJha97ajeY04JYqa2TUB9jNe43sjP
	 SPCEH/ZJ/4qUdvAMdCF44+vuXLlH95SZ+bZAuoA7JS9Uw2IMoIvrx/kSFOCGeaLAEC
	 nNiJjoNlltIKrLwwad1R7Pl5uafjje3CHADpGRR/PB+HIWPvHdASI5etHBhTDsmCwe
	 OVMnUOokPjNvQjn+Ug/QK0n2r5PdKxyMI+WoKO0Dah2jQTv4Zt/3d4vs9J2cnn59Yt
	 cPNQ5wLnEgi53hUdXEqGrrrOwF8sRttRLYHMTBvIXC5m2EGbdu6HZvu3/du/cnI9Lj
	 A80iN2RdT672A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 27B9BC53BB8; Fri, 17 May 2024 11:53:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Fri, 17 May 2024 11:53:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-4XsqSvq7bi@https.bugzilla.kernel.org/>
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

--- Comment #46 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
[AMD Official Use Only - AMD Internal Distribution Only]

Hi there,  AMD has been checking with asus to request to update bios to new
version,   Cppc needs to be enabled from BIOS otherwise it will not work
anyway.   have you submited support case to Asus ?


Best regards,

Perry Yuan
________________________________
=E5=8F=91=E4=BB=B6=E4=BA=BA: bugzilla-daemon@kernel.org <bugzilla-daemon@ke=
rnel.org>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: Friday, May 17, 2024 4:50:33 PM
=E6=94=B6=E4=BB=B6=E4=BA=BA: Yuan, Perry <Perry.Yuan@amd.com>
=E4=B8=BB=E9=A2=98: [Bug 218686] Fail to set energy_performance_preference =
of amd processor on
asus ga403uv

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #45 from al0uette@outlook.com ---
Hi Perry, I consulted ASUS for this problem and they're unwilling to provide
help, and it has been 3 months since the last BIOS update. Today I notice t=
his
bug tracker: https://bugzilla.kernel.org/show_bug.cgi?id=3D218171, which se=
ems
have similar issue. Do you think it is possible to fix this problem with
similar method?

--
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

