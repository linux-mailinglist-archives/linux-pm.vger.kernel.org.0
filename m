Return-Path: <linux-pm+bounces-2347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C4E831FDD
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 20:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314AB1F21BF3
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 19:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789E2D047;
	Thu, 18 Jan 2024 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUXiuaST"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84029438
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607306; cv=none; b=k6kjJaaxiY4AnBoJ4KlPCIax8sQPJ3Yy+2k6OH3vDenYhHaHdNujSCVqhxK6vEHzR5LQmkIx2ne1PwjGnjUk8kBFfiddVGU2QdcTuIe49n1xgkkMjR/xPpL9nknIzxoACnk8aDzQnyakqfr+ZTBhmV2kZ+X6x3wMYtkvoDJEZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607306; c=relaxed/simple;
	bh=ltO/FmZ5fiMQCyD30w07gk/KM49R+euyRoJsqpMCVP8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJGLHNTmfhisxpI9Ms3Xx6zfMcJ/+EA+iJN+GoRzEOxt5bKBmj6ttONK6wOEr6sgpw6JPm9alQLpqunipEKaLhJpMJG92FFhnpenz97IjKy30Jylx6WN+tB8LnjYfn1sfM8d1HmvsEAxEbtxPg2dRvxrGhIuelC/tcjrOATGMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUXiuaST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E3BEC433A6
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 19:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705607305;
	bh=ltO/FmZ5fiMQCyD30w07gk/KM49R+euyRoJsqpMCVP8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AUXiuaSTgjNbOLlaP61g4qqcuHnpW0PAdZSwx5pGEk/WH3r0ZENaNyII6asT7kQtD
	 iKLoZt0oVBNM69zMQXMgzIvDgTp+EfCzLcV/vBpqSqFeNgP/KHbk/h5GSnALD3aNSS
	 lRJ87pdkZoFMhkgq0x0LhAB6PSmYV7e0anREyvQolni5zfx8CY6bSk4qMHgUNs9Spe
	 2x73d1H0NeLj2f8zeIIAgkvzQ+Fx1Igk1hl6YIs7+f3mHrOMzN6K6K0DxPdMMRD6xh
	 rdHLSIvYxVmCiYqq1mSaNBR2wzHlVwJE/5/V8Q2374UfA/LQgr8kKjEbKa9PxBk/+E
	 km45c0Aw8jC/w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4327DC53BD3; Thu, 18 Jan 2024 19:48:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 19:48:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: haunma@keteu.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-RJCj7GzMLJ@https.bugzilla.kernel.org/>
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

--- Comment #22 from Mark Haun (haunma@keteu.org) ---
I repeated Artem's test on 6.7.0-rc6 (Void Linux with custom kernel---a bit
old, sorry).  My energy performance preference is set to "power".  I think =
I am
seeing roughly what Pedro describes.  Writing twice to scaling_max_freq is
definitely doing something, at least if we believe the numbers reported by =
htop
or cpupower.  Usually I cannot keep all of my cores (7840U) at 400 MHz; the
active ones are habitually between 1-3 GHz.  After following the above reci=
pe,
the active cores seem limited to ~544 MHz instead.

(Although, since the amd-pstate-epp driver reputedly does not allow setting
limits at all, I suppose we should consider the possibility that these repo=
rted
numbers are incorrect ;)

It would sure be nice to have the non-determinism (i.e. bugs) ironed out of=
 the
driver first, then consider supporting scaling_max_frequency.  I am actually
open to the idea---in principle---that the EPP stuff obsoletes max_frequenc=
y,
but I have to say, the entire scale is still biased too far towards
performance.  There ought to be a way for the user to basically tell the sy=
stem
"POWER POWER POWER above all, and I really mean it!!" but as it stands, the
furthest that we are allowed to push things is still fairly weak:  any core
with the slightest activity is immediately boosted way up, so even an "idle"
system constantly has a few cores way above idle speed.  This might be why
folks are asking for a frequency cap.  Why isn't EPP more of a logarithmic
scale, where both ends of the scale are so ridiculously overkill that most
people will want a setting closer to the middle?  *That* is how it should be
designed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

