Return-Path: <linux-pm+bounces-11936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A169948BFC
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 11:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F4D28292B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 09:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9481BD4F0;
	Tue,  6 Aug 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI7RVMGc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A51B9B4E
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935465; cv=none; b=hphHUinOc1Rf5g5VAeo/zniL56kL7zz2vWnFlBUrOwpVMiuzWpVnv6gxLnM9wRlnKpcqw3RPWNVBIUNDjN1B95CYaXG0/BaxNPjESuBelEaDl1VJ2s/fBBu+9WEXwJc6gcYAj8Asnu4jG30N7B+OfuzNXcfxw0O5dqMr/Pah8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935465; c=relaxed/simple;
	bh=pVpYUd1ZdeuuTMCJ8ti8oebgU4UzIVUcxl8Stpoz0fE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHhjzgvVMu8TF9t4o0jDpp9UQQTk4t5Oe366cnuPzjlJCWgzY5UsAFXYUwi08La9sPEoV3t4Nt9NLTK3nqRXxExNVAnK5wrEk2E6+uOlmlfQuqOLjeIMpsatGdGazadRyWfJo6gPFEL9TMVu52rJPnq6qRyHHrn4L1dI5TTwA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI7RVMGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF0A0C4AF11
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 09:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722935465;
	bh=pVpYUd1ZdeuuTMCJ8ti8oebgU4UzIVUcxl8Stpoz0fE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QI7RVMGcvGFiRg7C703KZ1bI0G0bI+SAQdkL3jhbW6tAXkhydsaFAxqMU+12d/BSf
	 lTZcQKriFWB5WaoXf1WWENK2MGIUfEvKu+Ik9wr0hVQ1cOk4TsG4o6CH9n8IvcLpKz
	 HO2tME8bJBCOIwLV310mwXUeT901hMEi5HrybETUHRouwZVZE12LtqfVxDQ6fEqyl8
	 8Uf1m2lnZOufPMPxh2qGpgoqdpwkIKhbgm4PcLMWpgVmVWpD2NDZQQBoVgk+ff++KV
	 wP8b9FQf5RF/fNE78s5iLY+PB6O0J0YGbbSIzPd6Fn/sOC2GDSP2vCsBIZJYXgCGsg
	 dW1699oSHysIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E47F8C53B73; Tue,  6 Aug 2024 09:11:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 06 Aug 2024 09:11:04 +0000
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
Message-ID: <bug-218686-137361-kbRNBbAhaM@https.bugzilla.kernel.org/>
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

--- Comment #77 from xiaojian.du@amd.com ---
(In reply to Chema from comment #75)

> Thanks for checking
>=20
> It seems that way, asus has made it work in windows but not in the standa=
rd
> way needed by linux. But either way the amd pstate driver is working, but
> the epp change is not working.
>=20
> What could be the easiest to try to solve it from our part, modifying the
> kernel   in some way? If windows is working it should be a workaround to
> make it work maybe disable some checks or something like this
> https://github.com/archlinux/linux/blob/
> b1bc554e009e3aeed7e4cfd2e717c7a34a98c683/arch/x86/kernel/acpi/cppc.c#L14 =
or
> this
> https://github.com/archlinux/linux/blob/
> defaf1a2113a22b00dfa1abc0fd2014820eaf065/drivers/acpi/cppc_acpi.c#L1491..=
.?
>=20
> Cause ASUS has not made any comment about it, I dont know from your part =
it
> they have internally said something to you.
>=20
> Thanks

A simple tricky hack can't solve this problem.
From the perspective of amd-pstate driver, it is the most reliable solution=
 to
check the CPUID register.
Any other workaround to enable CPPC feature forcely and load epp mode in Li=
nux
OS is ugly and unacceptable.
I recommand to wait for further actions from Asus.

Anyway, acpi-cpu driver still can be the second option for now.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

