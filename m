Return-Path: <linux-pm+bounces-7196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BED8B395A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 16:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D131F21733
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38504148FF0;
	Fri, 26 Apr 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz/REOlR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F614884C
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139957; cv=none; b=VVc69U0f+dU3hTai/1gpdYSRkkeoKI/h8ub/LvgBNmaluyJS3SzzAZRZgi6OPiEMfzzm7GsJguIbNlobDpnSJ9C981UknnJSgHHDuks/W+PWeF11ZHaiY+8E7nosH/T8Tplfm1Sve5ctkjZb1lMn2rxJ2qjOq9XKCGPEOdUX5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139957; c=relaxed/simple;
	bh=sdoFE/+ADF2ytlFl5A4j0Lkywmby/wJtqWvldYYssPE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lA6rNGQyljdb+TZtCvukWYxLBHwKLZbMPVMdqV9dgpz8spbx/oX7b4MHf4wKr+eDcWY8Cv8bN5cZwE54MEp8nwjH37YkjLM+67hYBgTG4bNwKHQZJ7NFDMsv2eBRZFAWZ5cbmjViK4Q7ItiJDPZQReiTBfuH/reotpbChbM2GQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz/REOlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77D96C4AF09
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714139956;
	bh=sdoFE/+ADF2ytlFl5A4j0Lkywmby/wJtqWvldYYssPE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Bz/REOlRvQeOyip94+MmFK8oJs6Kx71hyaEA55RMqQviBghmw5pJXs3SXuk9rvKth
	 KN8nbw/J3rye8BcBYSMFSVUaBDaZPVJXDQ45WxigSXX+iYP4IoSx9+9LimLGVi2Bn+
	 +O4uNzwJ5kfgMURfxm0hWN/FODL/3HeH1riu5LA34A7mPx7H/J/cRVipCTzoJJLLfT
	 E848gQ83WGlkgQp4UDIfw//y87ft5yKOPN+DthHFIRQD+7BHnA180qgVbx3ZUUemgN
	 jKRYz2yQ+wGOK4oAhTTlldb7Fihwy9ZlYsLixsEkgggd1DhG7wUduKRL9NFB89NyWu
	 ggIWmruhwgU8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 64914C43230; Fri, 26 Apr 2024 13:59:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Fri, 26 Apr 2024 13:59:16 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-yY5SksPOqG@https.bugzilla.kernel.org/>
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

--- Comment #15 from Gaha (gahabana@gmail.com) ---
:thumbs-up: :)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

