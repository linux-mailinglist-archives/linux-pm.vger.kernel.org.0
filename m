Return-Path: <linux-pm+bounces-7212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0118F8B3E34
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 19:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0251286465
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 17:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D6C148854;
	Fri, 26 Apr 2024 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwa6NVSV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7686FD3
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152444; cv=none; b=O8wi9ApVcvae95G7r8q1Zw/aOuyAem4hoV93/qe6ApKePbZNOfKpxB061wX6yMNm5g7rA86OIr0q0VexmZMVYYXCvbFsKcUyJbsFUdWgj1C8x0qkMAal4K4pOifPYKA9YFWrw9ON/ZiQSoI4BT1wQZkibH+tD4ley27zJReMS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152444; c=relaxed/simple;
	bh=5Q8TAP2H0UQO+d9zgqn6l8bubiaVBnpUyPRfCoPCfD4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SAaDOZr5SAcJ0l0onz+uD7BvrjLZzWrz2PI7yaU9Zgf61u9bcpgVfFQYsAfAxWLPz3SeIiEmqQb7A/KEvfephOd/kG4uv5pM5df/4yRu3bL3bz1TFcRFEScZGkzIGtW57/yJPkBdf6xsaWt/NYmVbQrET4Le0s8KoKhYQS9v4sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwa6NVSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A36BC32781
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 17:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714152443;
	bh=5Q8TAP2H0UQO+d9zgqn6l8bubiaVBnpUyPRfCoPCfD4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Mwa6NVSVuaZesiHZti4t9kVGfLAYVnD2cU8gOr8rrkcCfi7oarzAGSI+HZR+zKUEF
	 hSSAts/2j5/3sVQ+DA266YEv5GwKi4pIWa7e3/jyjf0HxjtGJw2bVcm9EwROGRwmhp
	 NCK7tipnlfvKKErMFBR167nPrKNGwB1thzR6quHE9TyxyofWLRT6AGuKgW8P8U5Zys
	 RzFgOJujOw6zVw99UQv6zaxutstawNjm/J+hzuoz5yj82pTiWECjVNj/BkGLKOCfyi
	 fcmLCTB9Cpjotx20VLmnJ4JYxuvLKefU9NSM7dGfTAUncXGkWYvrOhruEm7DysAIoo
	 YR+IkyVjGj6WA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9396BC433DE; Fri, 26 Apr 2024 17:27:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Fri, 26 Apr 2024 17:27:22 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-cK0PhLAKlC@https.bugzilla.kernel.org/>
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

--- Comment #20 from Andrei Amuraritei (andamu@posteo.net) ---
Hi Xiaojian,

Booted with amd_passive and ran the commands. Output attached in files with
passive in name.

Friendly greetings
Andrei Amuraritei

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

