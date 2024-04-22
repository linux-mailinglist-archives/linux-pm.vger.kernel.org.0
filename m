Return-Path: <linux-pm+bounces-6756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D20F48AC484
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 08:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E038282366
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E96482DA;
	Mon, 22 Apr 2024 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoVHJfak"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC793482D7
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768847; cv=none; b=lwvVVSPtyZ1XAJWu7QMIUjvQ2Lb12HGWReZGjq+K+rdJEvLs5WF1rS1lWrSLFs06EH4Y+QyO+iu8nCxAP8ZJ1qX1ryh5/T9bXhCULlzMsofHH5GZUiHupNszcqGU9bDQr0M992UI0sNFFGwo4rQLClSlehx25dG/1M2lFjIJlUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768847; c=relaxed/simple;
	bh=WT8su4RmptlZ65qHVsf6X0qLYqNtpxLmpNYjLfU/fGY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cW7DVdvl2O1kNH/Xvo/U2cnluyz3xvrlKkJ1Fx0SsXwcU8A2RqOBZ7vt3OmgOIpncQDaJwZW0pwwbzj5QlZC/S2LsN2PsV5wp9HUAlNCEnSdSmirp3YRxB8EInuE4g+GojEpEJBlySePcVaCFOuFKi3hbFPOhhiOAKZOoVDUGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoVHJfak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3504DC113CC
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 06:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713768847;
	bh=WT8su4RmptlZ65qHVsf6X0qLYqNtpxLmpNYjLfU/fGY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FoVHJfakMj45N/8BTF9MhrqqZSWQKyEMM2vJrAW83bxkMbfe71UTjLNkipe1ed0Id
	 dq/SLoz1yXH5AZV2SanxsycEoDtTYEdpW8jv+elhhPvT/La16n42aA5mEc4n09si9f
	 6nuHiT22i59sFA/xsxtRYBiP4Bd0GqScQSVaocIAZ1WJFySSpyGvQp5x2cjenAsWWc
	 hKh54XeozVyghiLHW/bCPmptDQCs4+4Os7AJLounK0NERkSxFyJCvi1g5BrtUJeIl7
	 WuTc8wu1l3DuEvnwO9VOy/vf8mYRua3oVAMkPZD6lUyrh6Z0/XWFkDXp+wey7G4kbA
	 6dvVcKf6veZsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2BD6AC433E3; Mon, 22 Apr 2024 06:54:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Mon, 22 Apr 2024 06:54:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-218759-137361-1mo9n3uZGI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

Gaha (gahabana@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |6.9-rc5

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

