Return-Path: <linux-pm+bounces-14904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB8A98970D
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 21:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3744CB21182
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 19:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2EC36AEC;
	Sun, 29 Sep 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAdxIak+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0BD79FD
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727637515; cv=none; b=I3VhWbCQBg70jJF+kFSlCfoWrjS9cnsTo07uKZcqkWFaaOLxQBexD+OgWp7WTg+JsREw7Px0Embnj6sqPKp4Dg5ffN+44Wybbtb3227f8eqM5ciFvORFF9DFBUs2VkeoukBFO578iY8bXS7p+bInBzSduTs7uaj7AWFC1bGM80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727637515; c=relaxed/simple;
	bh=l54thSbkZtOPDEPIiUH3QUPc5LBJcwMH4XgxGB8rjKE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VVgdVqNQsWDKxc6tXqlRsrbl2Ae6MFJYDAVQsfA3z2sFWlqdEbp4qNaoE/cB28yqPt3tGhbwY5k3ACK7ufuGbN3dt8GyRZasmqAhIi8RqTO0JpeovOL7bk8HPCCagzqy2XImZdhg49aTPmYkrlnffwcME1wfYv5Z0R5QtOz6Y+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAdxIak+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 150ABC4CECD
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727637515;
	bh=l54thSbkZtOPDEPIiUH3QUPc5LBJcwMH4XgxGB8rjKE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UAdxIak+PjsflPNi7nqVCtRqsuHZHVtGiwaJPq16kJYMLkVfabp926doikFcXZ/bW
	 VmnQ9EXQKBixtFKWA4tb0NE7rQotaU2VXlTADmae/+QZnIMvNETqKKHdKcSkrq3JUv
	 9ZCDNNKJwYnuYGgraeJy6hF7+qzhLcygr/Sz+aQEnfdOkVM9xRQu8OJP1MH+1WeGfo
	 RElTRtvDb8PZVSQulOxF1xcFDNJG6NIl4eZYBwxvNNIiTxt4OpygIzDHTsCBSSe1E4
	 d3SC/mshnWFi5/I46iaLKhBU/fGea9umANnzlqDaDm35lZi5XPxtOUUg/f2r0ZCy64
	 PBHNK4EtVBOSQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0858BC53BCA; Sun, 29 Sep 2024 19:18:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Sun, 29 Sep 2024 19:18:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219332-137361-cyYW4nnmGg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219332-137361@https.bugzilla.kernel.org/>
References: <bug-219332-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

--- Comment #4 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
[laugh]         Limonciello, Mario reacted to your message:
________________________________
From: bugzilla-daemon@kernel.org <bugzilla-daemon@kernel.org>
Sent: Sunday, September 29, 2024 1:50:50 PM
To: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [Bug 219332]
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference: Devi=
ce
or resource busy

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Lastly,

https://docs.kernel.org/admin-guide/pm/amd-pstate.html

Doesn't specify how the driver can be completely disabled.

I'm now using initcall_blacklist=3Damd_pstate_init amd_pstate.enable=3D0 bu=
t I'm
not sure if that's correct.

--
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

