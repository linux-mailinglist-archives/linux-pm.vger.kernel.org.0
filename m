Return-Path: <linux-pm+bounces-3150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0784522B
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 08:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF2D1C252E7
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 07:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC61586EC;
	Thu,  1 Feb 2024 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMTb2Czn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90B157E8A
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773412; cv=none; b=gCcpZhMWIH1LVQZTHhQpNaDdJyPxMaluqc60W0ZtR84nUOOnoNEn10F+XSz38eTX+FyoQy+3agnTiGfsXNL1EB3Wb2D6f0VncWY/CrBGF4CdHF6wp2TriAiYnUlp3cihPaFDxXw+v4oV4egiAkl5hR61iMoB6ivVbC1PqtzcEnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773412; c=relaxed/simple;
	bh=0/Mil8PKHVMCjthNxLevxj9NdEL9NpIvV8ZDNgm+Y00=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WEAtDVZHRA/lQ6AyXv6Hl0wRHGBFMGH69zxgCbwBEIVipE+9U5Mp8f5K+gV0vEqlmqwLHyo+/csTKKbxkR3zMIM+vgHi9z0p8z1cbe6pZDDCbaUbAxcLX6XGQRFfRBj5STkI73Iwg0Rn2qWAm6NLRX8LjXHEeFFSzCCyiwstN0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMTb2Czn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4398FC433B1
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 07:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706773412;
	bh=0/Mil8PKHVMCjthNxLevxj9NdEL9NpIvV8ZDNgm+Y00=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JMTb2CznYDJDikwWKq9JIqkOul/m7mxzATtbYK/mHOezmoDDP7/6TlgHAHWCjLdOV
	 ZJUhCktQafajZrIpmkx2JmnsjqsE6kNbfLoQI0hYp7x0gAPMTXERTJAYwrnHVUEjmW
	 sjs8hXYlRXRw7H4rVe3jRNQ9nP0cJgQwZjJoGXyee3s486RYw9u4qIDTKLkWaL1hrx
	 nnNdxhfaUCUsW/pzxlX64YSBax3q/Auwcj/8tb8nb7Brq3teLuRgfeBS9C6ZJe7Tj+
	 eubjEtlxupLGfnO8TCbCAP+rls/Vh9RLPi0YGiMXLuUCGs4SwNBVRHMxdSHMKd81TU
	 T77cc6L//+8GQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 30526C53BD2; Thu,  1 Feb 2024 07:43:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 01 Feb 2024 07:43:31 +0000
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
Message-ID: <bug-217931-137361-WKA2UaUsgL@https.bugzilla.kernel.org/>
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

--- Comment #43 from Artem S. Tashkinov (aros@gmx.com) ---
Lastly, this looks wrong:

# cat /sys/devices/system/cpu/cpu*/cpufreq/amd_pstate_max_freq
4929000
4929000
4929000
4929000
4929000
4929000
4929000
4929000
4929000
4929000
4929000
4929000
4929000
4929000
4929000
4929000

This CPU cores boost to _different_ frequencies.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

