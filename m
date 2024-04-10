Return-Path: <linux-pm+bounces-6138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233F289E9DB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503EF1C20CAE
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 05:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C210A03;
	Wed, 10 Apr 2024 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ3C6mAM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1A1CA80
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727546; cv=none; b=r+OzleoTofrO5cSWQQjrAHfDajjebML11scA8N3e8tbp87bY2hdnB5heNBaXLJHC3g8P0En/8Yy++z9xb0rHxPWKJ6ALPBCijOhNJ8YqVDv17pNWOMJZhyA+CHoOUph9Qj8W3VIB7b0ylsnnOxjW5wSzkSIJfgAJU2J+11h62Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727546; c=relaxed/simple;
	bh=OiT0LHopk9bSH/84kSGFgsxX/X9lgfA8e3NZTW4OJS8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppxAgdsOTmos8DMyEgbvlCg+WPON5JD4IuomW9PDYab+PX6Lm9/+o8wCOvsdmYsGmztbBF+IA3KBn6gWP9/N9d6V3zv/07MDjnuKFsagpOmQW189xHYkisgFNR1CL7Gj3WZzP0Vg0e6Sr4zxJZ8r1zYDXI0aKhhx04mV/R+3Zuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ3C6mAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAD8BC43390
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712727545;
	bh=OiT0LHopk9bSH/84kSGFgsxX/X9lgfA8e3NZTW4OJS8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TZ3C6mAMO2x2otcQg0YvSzEpHkCZUgSCuFm/+zd+qCcicgabJ3OgiCCwbgu/DqbI6
	 Yf95SUwAkfcCdEKKnTmY9MRRRR6j7EYjV9CLm6ncBhsLnhX0S8gO2M7zP5w7DsEv7m
	 Xyn2BoHiu7SAUdxYwyqXaRJSu4jByefwhLmABdOPQ0wQV75+qouyUwTlU4wLcfsO9e
	 t+p6EUDeoanNjM3qXIim55t5CKc0g+VdZaqDyCNHd7v7M9XSBJtEwn4TiV14xOuZQq
	 DCMwhufEASUhklL4bUz6Fb3seePOR6Pi/apClwQ/sYHQwqsb7d1g4duBlWYg4BVC8S
	 zLr7XFAauCJkg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B76C7C53BD9; Wed, 10 Apr 2024 05:39:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 05:39:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-sVFkEtZOBn@https.bugzilla.kernel.org/>
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

--- Comment #4 from al0uette@outlook.com ---
OK without that parameter my system uses schedutil as scaling_governer :(

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

