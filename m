Return-Path: <linux-pm+bounces-6008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A739F89ADBB
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 02:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAFB1C20BDE
	for <lists+linux-pm@lfdr.de>; Sun,  7 Apr 2024 00:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937DE36E;
	Sun,  7 Apr 2024 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9iCPq0K"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAFA34
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712449973; cv=none; b=UDgydOUlrpvrfJ8S3NCeVbXssejwdv1u0Zb2R5aeavKCRPGhGnVTweiI6DMlGFwlK8RzdpWQ96JpTOnv9bUde2WNb3rd7xgmxwol1KCe0dd5NJK5D99lqObXbiKaUNjA8WE92/lWyWo/FFHhIcUXPihsi5TDr55WeGvxxSJdi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712449973; c=relaxed/simple;
	bh=tZtT7VPZTu9xOJqvhEXNMwBA/5rguGWC0XqI2WlHvGA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C2hmSHuvEuEKpsgbOsxI/eML/Bn5Xj5k/XaCJDkUk/q5cote74Uho7vKQpO80WkmqWz8oJR9GeRI3hCDDnAd/zlBZ78ghQWqruUrSUD4Hwc0EbtUZtfIh2amM5fHxnjBMgqlJ+khpCovO663nfJ4kLOxd3xHgwDatnaRd5GNouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9iCPq0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0039C433C7
	for <linux-pm@vger.kernel.org>; Sun,  7 Apr 2024 00:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712449973;
	bh=tZtT7VPZTu9xOJqvhEXNMwBA/5rguGWC0XqI2WlHvGA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=m9iCPq0K/RxYM0s5/U4xc5O1OILceazYY5OkdPpmE8vTJPALRRYN3gtK/1iEoOYAW
	 TMl7wUWFLsyG8Nh4EK40W3qEjU6lmwY1CEdeu4Fxn9CD8Ly7Nsc2WCZr7vHHz2W16A
	 zs067nS5Aqj87xgZqVf3VkgU/9ej4r1lfC4rwnu/PJnexTDIyljihQWBQaaL0RCD+2
	 ZL5VZc4eNc4WuLrVGzkaZJlpsRTRV4J+/EYfJuNpCw7vJOZJOYfEJzTdVBijGeTAmT
	 VP0U9jg/7FSVz7uxwar4NZVkEJ3K0fHOt1dx/Eq8O1lGz75+vYGebRGVD+bno1kkzr
	 jnDLrE2Ch0G6w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DDC7AC53BD6; Sun,  7 Apr 2024 00:32:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218689] AMD_Pstate_EPP Ryzen 7000 issues. Freezing and static
 sound
Date: Sun, 07 Apr 2024 00:32:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kbii.chris@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-218689-137361-SjWX0qNyyQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218689-137361@https.bugzilla.kernel.org/>
References: <bug-218689-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218689

Christopher Bii (kbii.chris@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|AMD_Pstate_EPP Ryzen 7000   |AMD_Pstate_EPP Ryzen 7000
                   |issues. Freezing and        |issues. Freezing and static
                   |buzzing                     |sound

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

