Return-Path: <linux-pm+bounces-8151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E751D8CFDE3
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238601C206A2
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 10:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE7DF60;
	Mon, 27 May 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntTR+4Gc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5C13AA44
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804598; cv=none; b=Fpk7TOxm/9rmtNgvdmXlbBinBKpmZ2EBGa9dtN9wfAoXZctuVYJm0+P6FqVsiIxiluNrh0SpYW3faW9eC28ciUaBNAeIe2SUsMBOMst2ymz6KmnFCiSXiOXr+lw6PmcknAdti/h3T+pFQwbPGAyNj9JwszsoZx2EEII7mW1+itg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804598; c=relaxed/simple;
	bh=S4C6X63LbSw8re51khQi6Qd1GSIV56U1GMnF3wp12ng=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s96qss+2OIhXZEDjYH4vWChzJEefgUNKgFB4MLqdieP/VgoqF1AJ99rdyvmATtqtU2qcryCLRCZhdZOPBY5zxZ++yObqt/ShW4gXrCF+3ckFjFGctBYHem+fgHIfpAUgPee9Kk72nKt1GfwFa9JO90tMVm5nYie/P0RoNYDXCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntTR+4Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B364C4AF08
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716804597;
	bh=S4C6X63LbSw8re51khQi6Qd1GSIV56U1GMnF3wp12ng=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ntTR+4GcNIN/1HLOtVkilc0be8uFLGnhHQPfXd5tZOy4tlwFksEqmwOrJq7HapZA+
	 /gSwbpQueuVXfWgw6w9Uc/NTC7/GXU81aips+ym3piopqJ0LxnqZuI26RTa3JVYuek
	 l767VG++okmaKUKMqbgq6OSLlNGmGC4pOjgkXs0b2vQ9Qz4YuafzvEW0HF5AwqvSgt
	 3QSbZyMTfzlSuQxrEWcjkP39cJM2DD9QVDTRNhZ/uujy28YxV05CMSQQS2pfRH/Pv9
	 eCJbjcixT70G88TBFJjK3uvf+ZsJ6SHmb5niwgXqnk8WbeytmJXVYE8Fhyn95iDSON
	 T5E+mSdf3vxpQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 70F3AC53BBF; Mon, 27 May 2024 10:09:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 27 May 2024 10:09:57 +0000
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
Message-ID: <bug-218686-137361-xGEPmup2yI@https.bugzilla.kernel.org/>
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

--- Comment #55 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to xiaojian.du from comment #53)
> (In reply to Dacian B from comment #52)
> > Hello Perry, Mike,
> >=20
> > So, i've stumbled upon this thread regarding the amd-pstate driver and
> after
> > hours of bashing my head against the wall, i can confirm that i face a
> > similar issue, but in my case its even worse since i use a chinese lapt=
op
> > (so bios updates are kinda out of the question...).
> > I dont want to upset anyone, but to me at least AMD kinda dropped the b=
all
> > on this CPPC thing, since it should (at least in my opinion) be enabled=
 by
> > default and not up to the vendors.
> > I will be following this thread if anything comes up...
> >=20
> > Kind regards D
>=20
> Yeah, totally understand you, but vendors has their process to release th=
eir
> production BIOS, it takes time.
> Like, you know, diff vendors will cut off their BIOS fucntions to deploy =
on
> diff models of baseboard.

(In reply to Dacian B from comment #52)
> Hello Perry, Mike,
>=20
> So, i've stumbled upon this thread regarding the amd-pstate driver and af=
ter
> hours of bashing my head against the wall, i can confirm that i face a
> similar issue, but in my case its even worse since i use a chinese laptop
> (so bios updates are kinda out of the question...).
> I dont want to upset anyone, but to me at least AMD kinda dropped the ball
> on this CPPC thing, since it should (at least in my opinion) be enabled by
> default and not up to the vendors.
> I will be following this thread if anything comes up...
>=20
> Kind regards D

CPPC is enabled by default on most of the systems as I know, asus ga403uv is
using an older version BIOS PI which not have enabled CPPC yet, AMD has
requested vendors to upgrade BIOS to new version. Before the pstate driver
enabled, you can load acpi_cpufreq driver as short term solution.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

