Return-Path: <linux-pm+bounces-6144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3217789EAD0
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F721F2224A
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3522B282FE;
	Wed, 10 Apr 2024 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKGkAASQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE66262A8
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730372; cv=none; b=dvA3tmn7IPu52lBNUnfsLgS9bmxqhXB8cI57CX9w7j+YkSm4aM3vRSaHnuxrcs958bmeDfIU7qKiSCgIaIiJLuKMV5BU3QLmdxPBG5d9DrNsUFsFDXXJ1Et5K3eYBZ45jZOYMCxIPreOyG/3Ny0tmkvTYRmdkX/kDYzNyAgq3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730372; c=relaxed/simple;
	bh=vMRaAS1tGa9G2yoXj7ORQRDzdBFVj42Ug+WDHTXRXQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iY0mu9rUIU9wd6AC4/iIV/H9cvJdjpePcIBzKThtegXyOeSv2IZpoxd5s88gthChMAZoY96RQBGpUGdumzMx7w1QApVWp/+aT1fJRm4DR6Ii1HEiStLJXeQ6n6wdX3IyikyJXT9IuBO/5zMWQXMvmlm5kYpPMV7GqnJ9jVDiTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKGkAASQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FB80C433F1
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712730371;
	bh=vMRaAS1tGa9G2yoXj7ORQRDzdBFVj42Ug+WDHTXRXQQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CKGkAASQKUeri4ArVp9s81e/rVRoB72vAW5t7GPb3o6y6+h7z7IeANQCwjXXna94O
	 WpW9WJRMCyRg+wcs5B57+7hGqtvA9D+c6s+3xicN6CohTOS7RoOU1D2Hj7upZ0clo0
	 MXjttw83sheV/22dIA1tBW3RnhYglnVKZqNGjB2JYanHU24Jf3gfF0WikY22ZSpzpz
	 fNlFhlM2jeLwMUwiong+9ZwmTFj+LdGMOTT4jSnqFzI4yl+M2TlokRxWSI56jaKUp2
	 5WnhGT7+eKS+VBztpkDY412DYRV46feHT6n+gImQZ5LNsQXiFGawRYWlDms3PA885P
	 qiFdheJIH98lg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7F1D7C53BD3; Wed, 10 Apr 2024 06:26:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:26:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-ObSsdPUDOO@https.bugzilla.kernel.org/>
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

--- Comment #10 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
=EF=BC=83=E3=80=80sudo apt install msr-tools
=EF=BC=83=E3=80=80sudo rdmsr 0xc00102b3 -a
please try this to capture the msr values.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

