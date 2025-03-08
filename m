Return-Path: <linux-pm+bounces-23673-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B70A57A44
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 13:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F7C16E5F1
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F411B3943;
	Sat,  8 Mar 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNSg/n+b"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBF1DFF0
	for <linux-pm@vger.kernel.org>; Sat,  8 Mar 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741438362; cv=none; b=Cj1sqiFUCTZm8eF8PE1Ie3+mp4m5LKIMCJXVkqu6S5PzJud1JXI361fViSKAXJ0LlaCGzDE8jKs7PUmgL4ldQwcFG3yJECHaLl8JLgTvGx3IimI9mfGfhVEzuZlstuC3rLCciImDM4LkfVyqF2UoNSKiHmE/sTtGeyplgPubQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741438362; c=relaxed/simple;
	bh=PjBvj/f3CTUCO5vkFBx/mUJ7EbQSll3BeAYyXcxmjiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=av6gw9Q82+enJBgyfhdA+R4pSDpBLLnTiLZDfFg45CMx3HLwe77Ey7cVETVTCk/+elOd6F3eyDADQpCeTFA6wW8os2E7VRqhKvOIjFK8W4zGU9EUcMHuTn5S1hxY+I/EqaumFNQRVRhBVtluMh+NYb8DqSqaJUrv2hRkzSXqpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNSg/n+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57567C4CEE5
	for <linux-pm@vger.kernel.org>; Sat,  8 Mar 2025 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741438361;
	bh=PjBvj/f3CTUCO5vkFBx/mUJ7EbQSll3BeAYyXcxmjiI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HNSg/n+bfNP3iVGix8GzDzq7ZCvVz7sA8GwMl0SMQB8CsAE1/7sHMQCZYsJQFJ2MU
	 BF89cfV+EOAJNMSRqS2BSaepsobfLfwbHWgYk2labJtD/UX1l1VS9aJpaTRoH1ZRcl
	 ZVR7xT7PaiHGzplo2CamF9dLJGeEX7timwpUoPwqW3R/BrA/qp4PWKhQ+N0ZTOLXq2
	 DmcL7uhCjnLacZY5V5d03fzzQDGahUTRIDwGsXeaGE02pztL183ZS/Sa+B+a6vi3UV
	 t+X0w6nWw8FblRI5Xsp7hwW3raOaNaOUlRSuOAlir5iwSI+C5atGiqqlmOu/YdYjXW
	 wAIB4cc0PZIDA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 503D3C433E1; Sat,  8 Mar 2025 12:52:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219851] [amd-pstate 6.15] Frequency Scaling Will Not Scale
 Above Lowest Non-Linear Performance on Ryzen 7 5700U
Date: Sat, 08 Mar 2025 12:52:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dnaim@cachyos.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219851-137361-5Xw6xVp3nO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219851-137361@https.bugzilla.kernel.org/>
References: <bug-219851-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219851

--- Comment #1 from Eric Naim (dnaim@cachyos.org) ---
Created attachment 307782
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307782&action=3Dedit
amd-pstate-triage log from good kernel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

