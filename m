Return-Path: <linux-pm+bounces-3154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF028454A6
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 10:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727FA1C28B1D
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A5481AC4;
	Thu,  1 Feb 2024 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl/CU+Bt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95D4DA19
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781539; cv=none; b=BuWkg3Y49KzHxC+KuhYnDC1OJX6fqr1X1PmAdA+k3F8WrTfKydkioaZLZ7O7nfg9Zp6xbZFrMwLdhZTnsTmJBF1Y0JF7pBZvtEOi7/M6CcPLQE1V6hpx6GF4HI+HGbhBT9mBHVv7A3tAnWJ425lkmHQ+Laeeu52L6ZaW4yIzc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781539; c=relaxed/simple;
	bh=3X3QXiS4V8dsLmTKrn9wtfuO1akHqv0N3QixC5OrP24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5oWDpeXrMzrJLTIx/PlHb2V5sNR5/yAGo3n75MBWSSDSzONvZbjynVfE067EJQdur0uLX+5p+hyvdJ31/sEDNi/MNlVY4SVYo2Cp2pFiXRdoMbqGduN+dYpEK79k4qop/rQIPTT+xgQK1sy99mktWn36yFyeOaPvmyA4p8mHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl/CU+Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8E4AC43143
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706781538;
	bh=3X3QXiS4V8dsLmTKrn9wtfuO1akHqv0N3QixC5OrP24=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cl/CU+BtPNKHuwphTSgvpXnJpSyojwT/vrnjK/DAkXJaRfikMv0ZzG1zONgaLnkRi
	 K6ysOJlIDf2bqBcYYDWLj3qhHSGOYgNh9ubUflG1uIdbaFvklsuo1J+QcUMUBOzMND
	 4lC+1yra67VJ2jQnco3IyBQIk9BdsxcDnMKLYZ07vZUXfFNr+Qo2qkKGAzn4CMRHs+
	 rzZcZs2zgR/+x2MYDjpvGpYHoQXegs57m/BCNktZOyJZ68xJNMYiAYtOnkOWPE89C0
	 D92DWM0JWdRTeeGo1YJ4NfzpnvC/I34T3tUianxw/JHU+9V8gE09/8lkeQ76Rm7q9b
	 mH0yGhWuc7khQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 953DDC53BD3; Thu,  1 Feb 2024 09:58:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 01 Feb 2024 09:58:58 +0000
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
Message-ID: <bug-217931-137361-XD7jsT2IOf@https.bugzilla.kernel.org/>
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

--- Comment #46 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Perry Yuan(AMD) from comment #44)
> cpufreq_freq_attr_ro(amd_pstate_max_freq);
>=20
> the sysfs entry is ready only, so it is not allowing to write the new max
> freq value to it.
>=20
> you can try to limit the freq with scaling_max_freq and scaling_min_freq.

Exactly what I did, I set scaling_max_freq for all cores to 4GHz (4000000) =
- it
had zero effect.

>=20
> The boost patches and scaling_max_freq support are not same topics, if the
> boost patches can work, however scaling_max_freq is not working, we can f=
ile
> a new ticket to track that problem.
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

