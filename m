Return-Path: <linux-pm+bounces-6622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6158A9479
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 09:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B656B221B5
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D395D79B96;
	Thu, 18 Apr 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu4n1TsO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB402561F
	for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426997; cv=none; b=iqCFEiOQu+3qt0CZk5BqqVqHmU6Zf3iXWZ9I46qR9us/3MZZNP8F1L7E8XK2CNpiS7nQ7Bn61tuecAFgxXrinBilu67UXlAZMkrAd46kF+cMmPEg7MChohA+zxLu2/8GOTUcnROyd1T0F+P4qKmh7sIbtwaHg2fdMxFC8S0/cNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426997; c=relaxed/simple;
	bh=Lf519Cnf6CGCEYN4WunQrkcqP1ZEEZZmj4roEG32AUQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T40at42jBBydxmr3CxpyMwiD6vhI+/zxF25fWzo7IJ1phafYw7+q4EmtAaRkfRRZEWyqxTENiJ9Gg2dbcdt6bedfIpZ2LvfKukayWqfl3fDRkMkLVsD8JKiVFkC5lgvvMNjB2601tbO6pZvZgLkgHvNXYyGJ+iG12ZSLdVg8bBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu4n1TsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28235C4AF07
	for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 07:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713426997;
	bh=Lf519Cnf6CGCEYN4WunQrkcqP1ZEEZZmj4roEG32AUQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hu4n1TsOGGeM9Vay00EMp2tdkKENR/8aJWJRFeWhBD4o0bHP87uNjCVRjBD1K8kz8
	 2++8nWPFAxwUQ451sQyDlMJvn10dnF0t5AYWFYzaknDRd7LRFalN6fjfEnqGwvfp3H
	 dW1otk6qDCC/Uq7P/4dDVOZtty/tzpnIi0DtpURI3Z+MHVP/Jfvgq/NMHJefP09clq
	 H20xefytIDRUxfz2h2iCQoX9xh1ZXKys0bImbMzj4Tfj72LN8XrNg8ko9QJAYGpBei
	 gCmtSoQbNhYzNi7Vv1zXy2CV58dbeOWCLG3ZAN7QJ6lUfI+9oGWjiVjqcIT+m4BLcb
	 /e4fjcdFmUygA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1EB08C433DE; Thu, 18 Apr 2024 07:56:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 18 Apr 2024 07:56:36 +0000
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
Message-ID: <bug-218686-137361-orbhiYAIAR@https.bugzilla.kernel.org/>
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

--- Comment #40 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to al0uette from comment #39)
> (In reply to Perry Yuan(AMD) from comment #38)
> > Hi,
> >=20
> > sudo apt install cpuid
> > sudo cpuid -l 0x80000008 -r
> >=20
> > Please help to provide this output.=20
> >=20
> > Perry.
>=20
> Here's the output:=20
>=20
> CPU 0:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 1:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 2:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 3:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 4:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 5:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 6:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 7:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 8:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 9:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 10:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 11:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 12:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 13:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 14:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000
> CPU 15:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000

thanks to share the info, I have been checking with internal teams for this
issue.  will update here if I got any progres.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

