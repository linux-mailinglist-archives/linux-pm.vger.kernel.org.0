Return-Path: <linux-pm+bounces-6284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F54F8A1B2C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC51C20EF1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F0456B8C;
	Thu, 11 Apr 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CidoEqZX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730FC56B6B
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850882; cv=none; b=joU3niFY2lK2LTWy2nedHb4mnPuuZYnsoFf1CQt7f8AthcGTZ/PJQbCxjKeMb690N4d953mlAE8y8u2A+Ed9aN5dzncy6nxgWbSQpuxoJnWjagKtNdD3vzJmQhkzMm1IKbGLCwNQ4sPOPkNcO+NYppBm4TTDapQewuFpJ2JgXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850882; c=relaxed/simple;
	bh=r3SwxAkMOZp2RWyg/EVuLLTfIH9wSQn1kk24kWdDDpQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7mF9CnBnEfJ0aIn0cbsPQuo3Nha793kknAG3rULUnNPI6EUb1QWjxJiBnpA6O/jM1nHmxtD67bWN7xTJ3BkRWlVls+/4Ve+OgHfzLRUHD8YbjPlH6R7NvtEYf0IrPNYxE4h/vevl66JhHxreljFf8w1sWDHTiS4elRoidRJBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CidoEqZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 125B2C113CD
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850882;
	bh=r3SwxAkMOZp2RWyg/EVuLLTfIH9wSQn1kk24kWdDDpQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CidoEqZXkHDr3Cfvs9aNAFBJOEX7NdBmgAsOlVsgLjOsepQL+GdQP63S9Hq9hhzax
	 wT3mfU2KX4w3GeWD9wlVyelEy4fna7r6SJeFAOZs53WuMa+EeFZqW1Zr/4/PiIxRgw
	 iRaERPGNIMHwPwJj1xD6vc7ETWlTBuaMLKnuym2WLNFEBs/XaT2TuoLs8chLz0EA16
	 M6xwrdI6HsL99Gy4n8nxriPbzXlrcN9qmoszguH8Zioi47JU4U2Re7jVxIDRtVp7iv
	 ZaD7NQIn1wusUr3HumwKWWFgaRbmZQG43if5dmkd7h4UrsqHILp5a+L8qBpkvuNt7x
	 RoyqtxflxmimA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0A9A0C433E2; Thu, 11 Apr 2024 15:54:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 15:54:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-Gw1Qq8jxsO@https.bugzilla.kernel.org/>
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

--- Comment #37 from al0uette@outlook.com ---
(In reply to Mario Limonciello (AMD) from comment #34)
> Well now that you know it happens in Windows too maybe it's easier to rep=
ort
> to them.

I'll try to persuade them

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

