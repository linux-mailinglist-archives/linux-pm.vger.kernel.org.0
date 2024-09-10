Return-Path: <linux-pm+bounces-13919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF9972691
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 03:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B02E1F23E2E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 01:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B889D26AE8;
	Tue, 10 Sep 2024 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzm2aKv/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919481859
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725931203; cv=none; b=H+PAcsuV4IGvqnWmUT0AeIJwvFuD4Eab4GxfeI1R9WiMnpg4jSpD77RgYNaj0vS+/HLEI3gptmLz3ddVEGZ6H3iGNTy68fzvUe15gQkRUa7ZkVWj8dd4p68j55zzO6WViXlEkyJ6fhuSR75aODThsW+xPPY9nZGv1iUAm8+Pn1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725931203; c=relaxed/simple;
	bh=WKbF8P64rqcMHLu6Oeg76I9bsUpB8AlEha9pYeBGA4Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+F7d9KYFiTSMCgDwzdDha0veminHCVJGpsI4jlXMgVL7JIEcEhzeViWyT85zbwRQa53KIbzzJFLtFdJLgWfrNzk7L/ABCA2X3jOej6qWNBokBCXGsjep667d7EOS6tj+WC8UMTNJP5y56mmEOSz5DXKuHf5B1AOhvO1ZgmuxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzm2aKv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F63CC4CED0
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725931203;
	bh=WKbF8P64rqcMHLu6Oeg76I9bsUpB8AlEha9pYeBGA4Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qzm2aKv/JkBpVHKc+VLZ4ks7Q0locYhVF0/q/A/WLOVEUJdPUHkhIbFkOdutXfE9+
	 62WBmhhTvEOGt9vJrutDLLIUPIAV+HtV0rwKy7XcrMGxKwEeNt2nX4ZdC5ypZ2sojR
	 7ziXMcWbXN/NY+8hKELcYOsMBwyuU6BWgO4d9L/7mj2cWU0vPW5UEV/Q5c6u5IR214
	 5eR4pp5NZzCvq3FJfmxC/snmo1xe6LoJYksDayeRabY19Ac0iBnKG5IhRHL72Veihb
	 sDI8FzN1Tzhsgpelpns00CPVXZ0QwDKPi0Rei454+mRqHiJ4V4RfahcczD8E4+tZ80
	 D8HS1Ze/DfggQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 179CEC53BC2; Tue, 10 Sep 2024 01:20:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 10 Sep 2024 01:20:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-H8OTnfpBQH@https.bugzilla.kernel.org/>
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

--- Comment #94 from al0uette@outlook.com ---
(In reply to Mario Limonciello (AMD) from comment #88)
> Created attachment 306844 [details]
> opt EPP register writes from FFH (v3)
>=20
> I'll re-open this bug to see if we come up with something that is
> upstreamable.
>=20
> Someone did some testing on another bug report and found a problem.
> Here is an updated version.
>=20
> Can you please share the kernel log with this in place as well as the
> cpupower output?

v3 doesn't work for me either, it shows device or resource busy

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

