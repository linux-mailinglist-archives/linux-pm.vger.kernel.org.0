Return-Path: <linux-pm+bounces-3210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F01846680
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 04:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468FE1C26901
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 03:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7BC2C7;
	Fri,  2 Feb 2024 03:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lgr1Ory7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB6ADDD0
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 03:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844369; cv=none; b=lklw/U3qAUJqJy4L0jhv8MITHlr21xa4pu5FDM0QIwFwXtSkk/VOsAIsUW5Er7vFfWCY6SIQDOpjPA1puALD5L2f7Wnz1ddxvz2ZZ116VJrNATO7/15e6M8J48QEqAM2+iyJyVejhnej1pqbRaD3vIkoHOSEhMAhjcqRVKMjCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844369; c=relaxed/simple;
	bh=opVO3sg1NTwnTgadDAIgZ1VLqWV7bNh9u1pNkN4k5oM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f9OnoQhw9nK8YAtTbNrj8aQy/+FxnynUfP8BhiN9fvUAjRLidzwEeJrUfh9msELrObIebDwR+Dv0h9q2pZOQkYwTakreCAPsn8rSOYiP0piV4My2apZfuZP2IwhvRTGaAwUog2QDhLdd5tbAvU6AyTyINaUmAIytDzes5DRVBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lgr1Ory7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49B26C43390
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 03:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706844369;
	bh=opVO3sg1NTwnTgadDAIgZ1VLqWV7bNh9u1pNkN4k5oM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Lgr1Ory7SFEt3jd1CHf/7/c0ltjbXNpczFEITHMIqOCUU0gpalZMGPJd/SO0w5V4s
	 BfHIvcQuBbrHuNbDZa9RoyCFOFiCZSoR0o7LjiFkZPnYcN3T/pU3malK3H7Gmb6hKB
	 qXhgeJlJOxyDyqOs0y1nZ/uOXrhZUvtIVvD1plM7bsbswEU7ryukWXmoCd9jTH7QaT
	 dAH95l7T6WUNSa4Clna3c23lA8cHMrL+LHhEOHyKht+fKtzTD89c46DXz7j4QoDOrI
	 PBJIWXhgdDDkrlejOqiXx0hP++Kn6xAbaQKnYHc/wsqnUfNm6wNA1/3cbwezm97/8j
	 hmwOw0dkVw4ow==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3947AC53BCD; Fri,  2 Feb 2024 03:26:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Fri, 02 Feb 2024 03:26:08 +0000
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
Message-ID: <bug-217931-137361-bD1EUweZHt@https.bugzilla.kernel.org/>
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

--- Comment #53 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Sjoer van der Ploeg from comment #52)
> (In reply to Perry Yuan(AMD) from comment #41)
> > (In reply to Sjoer van der Ploeg from comment #40)
> > > Could this be the reason why some CPU's do not boost to their maximum
> > > frequency, while they are happy to do so on Windows?
> > >=20
> > > For example my 5800X3D never reaches 4550 on Linux, but on Windows it
> seems
> > > to have no problem getting there.
> >=20
> > Could you share the output with below commands? then I can check that.
> >=20
> > echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal freq=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D"
> > cat /sys/devices/system/cpu/cpu*/acpi_cppc/nominal_freq
> >=20
> > echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal perf=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D"
> > cat /sys/devices/system/cpu/cpu*/acpi_cppc/nominal_perf
> >=20
> > echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D"
> > cat /sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf
> >=20
> > echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf
> perf=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D"
> > cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_nonlinear_perf
> >=20
> > echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
> > cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_perf
> >=20
> > echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest freq=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
> > cat /sys/devices/system/cpu/cpu*/acpi_cppc/lowest_freq
> >=20
> > Perry.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnominal freq=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 3401
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnominal perf=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 124
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> 196
> 171
> 196
> 166
> 186
> 181
> 191
> 176
> 171
> 196
> 166
> 186
> 181
> 191
> 196
> 176
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf perf=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> 64
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 21
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest freq=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 550
>=20
> Only removed repeating values

How about the output of "lscpu -ae"?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

