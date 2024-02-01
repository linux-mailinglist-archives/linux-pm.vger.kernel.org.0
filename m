Return-Path: <linux-pm+bounces-3155-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BDE8455C3
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 11:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E551F2197D
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0668B3A1C3;
	Thu,  1 Feb 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoUaX4q3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA815684
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784509; cv=none; b=Nl4pg7b44RDKKwoHXXjdq7W79/VPDQn83/zoRP4R3h4PqxtaR9jcNWl5NV4D3CXrXnhMAtFLE3p8hhBvVxYnvPaGo1Ut2RlBrJGdy21oDdA8/XmScrhACdKZRB7e34NDaE5P6gWjQ2RNGKwv+6yy/Vn8fc5iVG/Z6TZMnzpGMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784509; c=relaxed/simple;
	bh=QSJkKA+izSiZDS99fNc//e672qnv55SG1LvyZbR9/nY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/NZjuFDqFYcWETAZtHQpl/Bn5Zj2jXTaDcvznIEwWJen/ESJmdFoqOkGi/ty1szmNaAGP2WRjMLEv3ed9f83tJNFTrl3ADeox4v3F8iNw7JzfooAtGz2x0jT1auea+NC7C1pesDVtekvxBniaPCqqZIASjV+B4JYK1YCflgoOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoUaX4q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43CE7C433A6
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706784509;
	bh=QSJkKA+izSiZDS99fNc//e672qnv55SG1LvyZbR9/nY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BoUaX4q3SoXhpE2Fg4qnBW6EKOuErUR5f4yHvOkyrvAHGF+Vmn+YYYOtGqgsVIs9y
	 zYp0hXbgwgS7Gfv2wjFD18ipx2JpSJ3P/UWMjdFNhsP3lCeCyJK/gYBCyMSEr4uAuv
	 BQaw3INKGkZdRd0JBIjnx5E7IbVL17WnSqW63phfLqIczBN65lAHdcB2CuMfT3stRU
	 0fSdF9hSJ7+XD2dM+zbC4lt08cO5hoWCgoTeEXTL64yilPvJCOUjs3JCz1FrLsyh9L
	 W/lZ4kxAg7YfJrjRJ8NHBT/jLqDumzTs07z7d6WtZkXafd0jURf1e7ZxLQsGnl9glN
	 0ehistGBdVMMg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2E071C53BC6; Thu,  1 Feb 2024 10:48:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 01 Feb 2024 10:48:28 +0000
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
Message-ID: <bug-217931-137361-zr9sn4sV04@https.bugzilla.kernel.org/>
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

--- Comment #47 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
[AMD Official Use Only - General]

thanks for confirming this, we will take a look the issue and get a fix for=
 the
max,min scaling set function.

Perry.

=E8=8E=B7=E5=8F=96 Outlook for iOS<https://aka.ms/o0ukef>
________________________________
=E5=8F=91=E4=BB=B6=E4=BA=BA: bugzilla-daemon@kernel.org <bugzilla-daemon@ke=
rnel.org>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: Thursday, February 1, 2024 5:58:58 PM
=E6=94=B6=E4=BB=B6=E4=BA=BA: Yuan, Perry <Perry.Yuan@amd.com>
=E4=B8=BB=E9=A2=98: [Bug 217931] amd-pstate lacks crucial features: CPU fre=
quency and boost
control

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #46 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Perry Yuan(AMD) from comment #44)
> cpufreq_freq_attr_ro(amd_pstate_max_freq);
>
> the sysfs entry is ready only, so it is not allowing to write the new max
> freq value to it.
>
> you can try to limit the freq with scaling_max_freq and scaling_min_freq.

Exactly what I did, I set scaling_max_freq for all cores to 4GHz (4000000) =
- it
had zero effect.

>
> The boost patches and scaling_max_freq support are not same topics, if the
> boost patches can work, however scaling_max_freq is not working, we can f=
ile
> a new ticket to track that problem.
>

--
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

