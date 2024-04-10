Return-Path: <linux-pm+bounces-6139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA8689E9DE
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8234A1F22E29
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 05:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F9134DE;
	Wed, 10 Apr 2024 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfSrfb6+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039110A03
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727664; cv=none; b=bX9LLWuqWmgaiUvUgZ4xrlSxbOHqFpKww+KdoZmcoZuzHDYOwAnRmR/Whzu8iLhugLBDFg1bou1XqzDYLAg+5/ZVDsqfHUQDk4YN+ODzcv95i6ZmPI257Uv09xcBFmPBVE3fVwVZF0R+pFbibI4nf75R4S3IqNC1MGnRTENrWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727664; c=relaxed/simple;
	bh=YUKZFixLt+2ATcdZmgdlPnCYDr7zWkVn8t9lqoBLXsc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CDVgcVwKmbDJpXj2a7BnrH2ngc7lWR3qV8oZ7mbRM8B37itsjJ+5B+UM5dyb6toCL5ZNvAWd7Qm6pwJ/WldI2XIe7XTMb66tFFe/ljqsA2WsWRcA3hxn5w9VL7cWhR6iNtZEzp6xiLqS+IIZMYb9WRFjoJPEX30NI+iiV5zCSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfSrfb6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7154DC433C7
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712727663;
	bh=YUKZFixLt+2ATcdZmgdlPnCYDr7zWkVn8t9lqoBLXsc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CfSrfb6+tXIVD1hkBT7uQVY9YqxH7GaH5v/WEC0zUaouCGfNbU7lGbfbIXg4C1t8Z
	 +Rk+2b0IcDS7DwFtot9n5zz6BF0mI1sepSOkfu5u8nBwGCHvxTvzyeDK9+U9uhmXNB
	 /UBleUXXeByfg2bfD1mCs3Gn/f/B4RnZr8AQ2O72p+ztR1xtDQRxJeNh01yA/YmmmV
	 4jhnAUEiVQRLr5r6+oohXLICxOzG0pL5bJAzsAIVj1nBUo1o5MAJrVizWsX1JeX+pC
	 oHlBk9wIzYr3MB5rZifqZ/WdvXYusiGa2Xkfm6aMvTFYygYzckPtYO/vFJ4kHeJga/
	 LJYy5o5ziyoyA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5D3C6C53BD9; Wed, 10 Apr 2024 05:41:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 05:41:03 +0000
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
Message-ID: <bug-218686-137361-mPiJerzunY@https.bugzilla.kernel.org/>
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

--- Comment #5 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi=EF=BC=8Cplease help to provide this output with below commands.

# cd /sys/devices/system/cpu/cpu0/cpufreq
# grep . *
#sudo rdmsr 0xc00102b3 -a
#lscpu -ae
#dmesg

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

