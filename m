Return-Path: <linux-pm+bounces-2344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E249F831E2D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 18:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB0F1F22F75
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 17:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C162C6AA;
	Thu, 18 Jan 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEBpDqkI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92622C1BD
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597701; cv=none; b=d8yslWYYPvyeXCzzv/FUaaYyAgf3R+dUU3DsYD+pNHQCGNKmw1Y+vpogLAROTJ7yeqQlL52VANYQHGC6lBXHCkYBlKFoTCmlPAYObzkcrCLuRxuNExqTSaxUO4QO3s8wa84CdWlMp870d1P/XlmQFnw8qGj3Mc5K4tfrZk9Lr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597701; c=relaxed/simple;
	bh=1HZWrfJcu6nIMyjgQWQfqOiiTreAxlrd1XKkCB1C6Jo=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=Kf5tdqIVvhFGHreDRcEv/S8CzSz6Ln2JqkkdekQWZ7O7FwLMn7fehSNCEUAHFNZV8s9jgWHrOM25WEAjO02NQrWD8zLwxiChSx6ecryWzGrNlbBWo1w91POCZdjd9Yi8LQCdoa5PvA8abtQOzOu+Juk9Yy8eWH96HACOm+LhKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEBpDqkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64123C43394
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705597701;
	bh=1HZWrfJcu6nIMyjgQWQfqOiiTreAxlrd1XKkCB1C6Jo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oEBpDqkIsiFfqnG3xC1gCML+QKEmCgL8pX1T9knuOfaVCU0qtdWhrL/x4bOKfafGi
	 6po71Wx4+MfnFgEDXFRwYBP6l+hJUDeRKO7+s8COCO9/igygZkAhh852qKJZL21ryq
	 WobHVwMQHAbzrVm98AicGYYATZod3x2kFINLJSEY3e0uALzSl3YIu45m0bBkcPkC9/
	 qAbwpWzcJUXua5MQjS/TX51bD7lo+MIX4hAnG1XZ9RH83xsWm7Z27m7tau7hUSUn+L
	 jsL9M1ippaIMoK394r4GZJL8lyD9tLCV3K/2cra+zL3FPw8QmFiYNAKd9hRQIPgojT
	 bBruDeXIz76Mg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 330C9C4332E; Thu, 18 Jan 2024 17:08:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 17:08:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: voidpointertonull+kernelorgbugzilla@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-H2SBVuj0HX@https.bugzilla.kernel.org/>
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

--- Comment #20 from Pedro (voidpointertonull+kernelorgbugzilla@gmail.com) =
---
Haven't seen any other issue than the one I described earlier, but then I a=
lso
haven't experimented a whole lot, just wanted to figure out what gets me a
reliable frequency cap I can adjust at will, and I have that in the scripted
form of:
- Set [target] freq
- Safety sleep
- Set [target + 1] freq
That never failed to set [target] frequency so far.
The sleep part should be optional, but then the whole script shouldn't be
required as a starter, so I just chose to fight bugs with hacks.

> The amd-pstate driver doesn't allow to set any frequency limits, so I'm n=
ot
> sure how people here have achieved this.

Are you using a recent enough kernel as discussed earlier?
It's quite unlikely to have that by just using a distribution provided stock
kernel.

Once the kernel version is recent enough, it's as easy as running something
like the following as root:
`echo 3000000 | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq`
Just keep in mind the mentioned issue of the current limit always being what
was requested previously.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

