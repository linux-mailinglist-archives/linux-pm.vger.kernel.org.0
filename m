Return-Path: <linux-pm+bounces-11215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1193428B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 21:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE891C214D3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA55E18C36;
	Wed, 17 Jul 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZObJbkX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9517C9E
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244146; cv=none; b=mZneqqBBYo83i2d3AMzSLEuH4qteh1D8j1YmXxh82GSBybdKTAu0bgiXNBXETTKbWfXtzC05pEU16fiHU+9Ejpe5QyulZJAJO26BRXYhPv+4hNhS4bjNqsfGV3v3OhDkfNSDqY0Y8GZPSRbAGcy+7QNys4JCGa7Q4xqZ1RZ/XMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244146; c=relaxed/simple;
	bh=3kvBh6+27qOMWt2/zUE/O3I9V3P2EInLCEdYPcfHtsU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NGNeVOk8IHa7IaXEyMC7MS5gxzNoTZKfsBrzQQV7e7lrFCOwdQ6TsrLQkTYKWbd0ZN0l5cehimS+hrHtdZI7jI4JjQpWe9DJQUGedk8ZeZOUDSjegkUalQrZ2no0L41182i4+fpGNf1z8ZtpJMEOboe4hJP3UP44mZGw/5eaLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZObJbkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D660C32782
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 19:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721244145;
	bh=3kvBh6+27qOMWt2/zUE/O3I9V3P2EInLCEdYPcfHtsU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UZObJbkX33ID6HWYMtrPCs9vazZOJUZNaDQnxJSafIr++88EuLUaBMzWWIG0+gyIE
	 nJNCqvWtP4+/BgRW1rzsFUk/RmeZuHT5ZCbwIXJFg4QvXZz2AdOtlJcfyoaOUO92/l
	 TQPyKmLJoTl0JAd1D4jkVRo3N7q85XZaGOWPSecwL7X8UOKb6TGAYYGb6arJxutUXo
	 zxlMOJ7VzpQK+IxkenRW8nE7+DczZpMc2shnLsG297K4RQe9eHkUuxjEK8ukSLEBHW
	 Zxqs1ESDvJ+IdhVKcE6lwVb65EC78+J/vMGUDZMNmKyAQLOLCa7mO/5SgTBHaMRQUY
	 GeJDX6Vv46ZAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4FA71C53BB8; Wed, 17 Jul 2024 19:22:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] amd_pstate=active reset computer
Date: Wed, 17 Jul 2024 19:22:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219051-137361-urUZpAFwby@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219051-137361@https.bugzilla.kernel.org/>
References: <bug-219051-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219051

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
Casting Mario.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

