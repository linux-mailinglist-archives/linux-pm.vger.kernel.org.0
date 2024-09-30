Return-Path: <linux-pm+bounces-14940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B398A509
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DDD1C20F66
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBEE18EFE0;
	Mon, 30 Sep 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNQ7ofB4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69674F8BB
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702889; cv=none; b=Y5FrjcohNhJE93p/KtGgOpDRjiVNfksmAT2yMzL1CUbAjRSZG/gUjWCoGgDUXzAHAYHlsbMmvW9G6/bVIa2XcfzhNq5Ydx8629sI30kH3lNE1OY/AH2B2iJR4o0sI+uudO91Puh8FvSj3RV6kmWHLvJX9fvFc3VquMU2snKRemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702889; c=relaxed/simple;
	bh=iCybYYGnnoX29ThjUdnhGWiMaFZVUTjwboqtyT9B2MY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rFJa2e8wKHplcYX+d1o8jM/28Jaf2F431oD/XNXPALP23TLOySNAyiShlbvgRUdZ35lvdDSA0UOtBiwWlGEQNXJsvCF1OqU/5TJwlCzmWSTjpisnE4cDBr3QJcqMWTz/Z4MatdigXo8E/poV0FUUMqTOoz6JzzV1BW5KWTrLRn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNQ7ofB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F633C4CEC7
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727702889;
	bh=iCybYYGnnoX29ThjUdnhGWiMaFZVUTjwboqtyT9B2MY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QNQ7ofB4AtVnQ8+Ts7PjImjU7w9/vomQxQWV4R+PDBEexnJzassiL44gPsVeNPlk7
	 34OPJyG3TVY7GCcglSLCueEVWNv2B1x288k6fY2uthaEpMyvFFp6vq3TdglhoGST9R
	 fsCgCQ1YtPKTt+nMK6GAyb0yWpjvd01IcPbd6wsPAWmlOpVRPIdxz6MUjc8WWuPyUO
	 Qj5Q+wZColSDksBKLIbLNnXmMzpp5c2xnc76hYgKqSLc4vhcrqSDALoz2UcUQm5nbX
	 Vvas+bgptwRw7HhnQJG2Xzd8zvxf2+F8bxgIKHWkrP/fG7LrBnKhZx6WQ37JPOfVKC
	 xb767aG+RGXQA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2172EC53BC4; Mon, 30 Sep 2024 13:28:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Mon, 30 Sep 2024 13:28:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219332-137361-lJ0ymHZKqh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219332-137361@https.bugzilla.kernel.org/>
References: <bug-219332-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

--- Comment #7 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Dhananjay Ugwekar (AMD) from comment #6)
>=20
> I see from the attachment that you are using performance governor, so you
> are limited to only performance EPP hint, trying to write other EPP hints
> (power/balance_power/balance_performance) will show the above error.=20
>=20
> You'll need to change to powersave governor to use these hints. Please let
> me know if this fixes your issue.

That's indeed the case and changing the CPU frequency governor to "powersav=
e"
has fixed the issue but I wonder if you could log an error message in dmesg=
 if
the governor is incompatible with what the user has requested.

It still makes my head hurt trying to understand the interaction between
classic CPU governors and energy_performance_preference modes.

From the testing I've done it looks like classic CPU governors are 100%
useless/have zero effect in the presence of amd-pstate in which case I don't
understand why they are exposed/exist in the first place. Is it possible to
hide them? Make them read only? Just to avoid further useless bug reports.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

