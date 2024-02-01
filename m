Return-Path: <linux-pm+bounces-3189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F79846106
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 20:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4AF29166E
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 19:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1EB85638;
	Thu,  1 Feb 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzcF/lZm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0A584FCF
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816077; cv=none; b=qYo++2/Cs4OPu/b/ZFugov68/V6hIlqBKWp6wDKjcC16cGMfuDaLeS07FlCjkFyJwaUFnf5cMuaaxSztuNlQFW/1bdOvCWygnImZmDK5LneCowFCm754gKLXYjOOv6haJmyFK70TdxIiTxLWuoKt7INkCghZhwaOuJxvhQzPPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816077; c=relaxed/simple;
	bh=AIDoulLMSsjow95Vx6cteHZyDflIvaremVKjhRctp4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IagM4heYhWyZ6FBAaDmFhC3ulUGVBNZMkLVV+B0/+G4XvHnyz8X6S4VTL2DtJKTPG74DkKR3mi8/qPYWQ5zOdrVZSkXQOWtVbSkP7Za5ogB7IQQMD1C9IS9wiNWt5psbulnioUE8/P2QRMlGbiTgQMng/Fd1fKJCDSveorX+Z6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzcF/lZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07EE3C43394
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 19:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706816077;
	bh=AIDoulLMSsjow95Vx6cteHZyDflIvaremVKjhRctp4U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rzcF/lZmnxmwAoGNLJQIdUbecAKvcB5K9xMgfyB392O1MdMshFpphnu1BGf1B3kyv
	 Ftw6gRfc7Neg1Cad3dwnvTshrFXo2QM169QcCO8Oiz1naGr+M5U3lNAIfbP7M+jpTs
	 5agDjiS2suKhZLJJWRJe4P2v4ieYngZuUvzfgYOJbORZIQWSASuauq0MknOasJYuf9
	 opooCCvbA8wWgFdkFR/GTg8Lrry6JcPFnIscidOZ2ZxFsqA4tgfVmyK7fjc2ovVSdP
	 l8GW3LxtJ1S0VGHd5LiHf7z3rC0JkmerIowDqGADxHrEqxBhDnCXjm3FR14Gnvwvbv
	 OkpxFceSqjt1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E907AC53BCD; Thu,  1 Feb 2024 19:34:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Thu, 01 Feb 2024 19:34:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: badouri.g@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-lJLE98Ejyn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #42 from Gino Badouri (badouri.g@gmail.com) ---
Dear Perry Yuan,

Thanks again for looking into this issue and making the pstate driver
compatible.

https://www.phoronix.com/news/AMD-P-State-Threadripper-3000

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

