Return-Path: <linux-pm+bounces-3209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1257846679
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 04:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48ED61F25459
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 03:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2578C2CD;
	Fri,  2 Feb 2024 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex2bz9p+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46EC155
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844188; cv=none; b=pb2Dq+b3z4gPHXIOk2nLB6nD3Jxbt6pR0rXsAa2Axi3Jl1pNZDtZdNxn9uBZt7jCdKC7h+J9dGqQNJE9+WFLapTRPBXoNMdxtJ+fEbAH7/PCg4WNZjEDFKgcjmcEtUysQEdxkd0Q70FLBTpKS0wl/fE/OeMKwSebILP4CJ69+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844188; c=relaxed/simple;
	bh=RHq73Koh/IwUuWiLTnQLfGKsoyUl4qkBnrwpfQivL18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HEqV117+Mxots2/oo2t752Y4BAgga+peICYvoJp2WL0OFAnILlpHM7W7vhhLtNFTF9lBy6nIR1arFEB0hMTxWcP6/PfuzGfDSkCFpBqggHX2oRAGJdQ/aNyHziQLTlP6DYsGFQZv4ZJIW9s4ze9WyHXuIE5sQEmgrDAaLHGFxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex2bz9p+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7C5AC433A6
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 03:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706844187;
	bh=RHq73Koh/IwUuWiLTnQLfGKsoyUl4qkBnrwpfQivL18=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ex2bz9p+pfWhJQtx6U5bvtXoCeDIdhEqyIYoBn4U2TKoc8BNaRfPphcuQGiNz1Tn1
	 yZHlR2uM3mxFiclkbWqJESJgft8UL/hmZqmdFVJi+0vfX0PHwTOLDDOZOoDpG2z7cm
	 pYLkoQs8K12m7j268pAYQ5JUyXzvkbW2uHKeW1yEKr5ImwT2tEIKMMFFLVpoUF+Nyx
	 M00tGu+XrEGQYPxth61llVR25y6Agj4fYF/Kr+QM/maTWOhruAw6SKk1NnvjLifHpJ
	 ZliZ+kuV0IWb9SKnRza2oNMdnNUkIxyBiB2JyaLB3cbD5qm//ZWyjqqPUMoN6YVY1R
	 gp/ssF6L8RoNg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D28DFC53BCD; Fri,  2 Feb 2024 03:23:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Fri, 02 Feb 2024 03:23:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: sfjuocekr@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-vke9XV8j11@https.bugzilla.kernel.org/>
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

--- Comment #52 from Sjoer van der Ploeg (sfjuocekr@gmail.com) ---
(In reply to Perry Yuan(AMD) from comment #41)
> (In reply to Sjoer van der Ploeg from comment #40)
> > Could this be the reason why some CPU's do not boost to their maximum
> > frequency, while they are happy to do so on Windows?
> >=20
> > For example my 5800X3D never reaches 4550 on Linux, but on Windows it s=
eems
> > to have no problem getting there.
>=20
> Could you share the output with below commands? then I can check that.
>=20
> echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal freq=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
> cat /sys/devices/system/cpu/cpu*/acpi_cppc/nominal_freq
>=20
> echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal perf=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
> cat /sys/devices/system/cpu/cpu*/acpi_cppc/nominal_perf
>=20
> echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D"
> cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf
>=20
> echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf perf=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D"
> cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_nonlinear_perf
>=20
> echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
> cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_perf
>=20
> echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest freq=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
> cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_freq
>=20
> Perry.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnominal freq=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
3401
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnominal perf=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
124
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
196
171
196
166
186
181
191
176
171
196
166
186
181
191
196
176
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf perf=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
64
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
21
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest freq=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
550

Only removed repeating values

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

