Return-Path: <linux-pm+bounces-7209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C348B3E27
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D85AB230CE
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BCD16D301;
	Fri, 26 Apr 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9xl+7eE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE815CD58
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152293; cv=none; b=QQUICYwyLZagFQiIE6LVOjNJs3vmjW+L7s1hQm/siaUSv371im5400dWPlP6uuwiwNi/JQiOuebratzluIIxgcwmCfK/oFMZ5SEhs/XPUX7j1l0LD7e0uQ/HNrDW1LsQMxvUMj/kZ17+H8oZX20LVRYdSk9JEBBpDm62wPQG6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152293; c=relaxed/simple;
	bh=1JfgWuJFDhZJeei0wLa/Nvgn2Mtx5gwBdJL/X7Citr4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dd/7/PaJI/wLBdCJhu1EYqGJrqKg9YLUEaOOywkBtGw/xKwo/seDUyvU+FB8BzGfNZenJmDrvRErFcieRFm5yLakbAzWwNnlY8I4cOxR/62U/3ZJUOlgBS61bxrajluTMHImX19TsePKyeX+227F6PaHF+LA/CMKTPO+mSfdNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9xl+7eE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B77BBC2BD11
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714152292;
	bh=1JfgWuJFDhZJeei0wLa/Nvgn2Mtx5gwBdJL/X7Citr4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K9xl+7eEtKsX/nkROSbFROCecyDSvAjTWlOgWym2YBoLPDraMgHeNQRl8va4gPwcL
	 39PxOdhw32LHVAexka1EuB24tZWdelLvo6DHkwXMFvZDQQ61Z47NbRXdCwV7UUnUl3
	 3RewkRQLaFMa6ggPZxkUVBg1kKkUjaOBd4aUJSY7sOf3QQ7IEMmFm6+XsZHQIWf3HC
	 BmQ3WAPLsJhi4LnBayoLe3hUjPo1KcrBT6QAwrDQxjUOY5QLEv3XmeRENXLcQfNppr
	 YgYdVOrPRR09eSdY8wF9IQ4tjP7/6nitg/RamH6mtWyx+JQ8AUxBVBstn32wmqg5+I
	 29mme1oVogw8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AE223C04222; Fri, 26 Apr 2024 17:24:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Fri, 26 Apr 2024 17:24:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218705-137361-660bfcJAHV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #17 from Andrei Amuraritei (andamu@posteo.net) ---
Created attachment 306222
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306222&action=3Dedit
lscpu -ae with amd_pstate=3Dpassive

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

