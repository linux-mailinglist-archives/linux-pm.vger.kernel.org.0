Return-Path: <linux-pm+bounces-2923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02578415D5
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jan 2024 23:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A11F252D5
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jan 2024 22:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE485381B;
	Mon, 29 Jan 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcjcd7Mk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8115380F
	for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567776; cv=none; b=b0sh98hB3dmGjpW1ZRr47z5r6iyTSvfJ6x2cfm68v1QnkXXTE2660h5ZKj8xlOBuywHivJPVIX/Qw6iABr1VQIZzyGageVkSnjdvRS1OsflX6zyJJiApQQ39mtdDXzpWl4bBoqEiiMhZuFZ+vW4MXDO1Uqz477Kp64c97xw5i+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567776; c=relaxed/simple;
	bh=cR7anOlSvTGCejhyiN870D0OtPF+8B5dhk1cIFrLE4k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFs8U+BPTPD6qSBUm8yJ5WvwAbdoPiLjMaEB5RI5XYVLBjGA1V6sEbgAcRklg7fK288ZnQK+R5rDkOkuq6sS/WGXCh6EdRZzkQDZig67INZVIrUf7cFoc3fccxEXpnLDCTQVU8Ovt2r9fOO6s0o8s9XjSjS3SPYa9zDiKGu+CWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcjcd7Mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CB07C43390
	for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2024 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706567776;
	bh=cR7anOlSvTGCejhyiN870D0OtPF+8B5dhk1cIFrLE4k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tcjcd7MksNKMHM/xbG/mgjSFxSpCmdO8qLEfZH3cbUx03PBYgy/ByfOAqSTMpCNFR
	 aMiRceJ9MvD263eUi3VvBFp4Q4qjmyLm2fQo36TV0V4aYTM5eJElHCMLHV6EGanK2o
	 USF8QQh7hbO2ipq5yhB4dpDxOjvXUxm/b4qY60SnwQGkA5hfG+0AyfM8rSZhaGmC8R
	 lznKNNJU22TmsAGpGGs80TeV5GhDVgcxdSBtJjBIjgH/QvotUMw4VI/nYSEQTMt9Tt
	 RB5ENzumi6MQah8KM76XxmtzbdS8pc/dBBnBKr7EJQy4goMjRteCBYPQxIvFjkkJjf
	 bcFXJWjVZJ7hQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1B003C53BD1; Mon, 29 Jan 2024 22:36:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 29 Jan 2024 22:36:15 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217931-137361-LqL06QFaSK@https.bugzilla.kernel.org/>
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

Sjoer van der Ploeg (sfjuocekr@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sfjuocekr@gmail.com

--- Comment #40 from Sjoer van der Ploeg (sfjuocekr@gmail.com) ---
Could this be the reason why some CPU's do not boost to their maximum
frequency, while they are happy to do so on Windows?

For example my 5800X3D never reaches 4550 on Linux, but on Windows it seems=
 to
have no problem getting there.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

