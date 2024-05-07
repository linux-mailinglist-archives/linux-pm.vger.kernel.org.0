Return-Path: <linux-pm+bounces-7586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237948BE434
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34B928772B
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D5915F3FA;
	Tue,  7 May 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq3F7PNe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1D15E7E8
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088023; cv=none; b=Zt+7AgJjCH/vxlh3NLQQxb/4hR2olJY6vvC8MEmz86PjsJIFJcQlf9NaS0Q9w0BkLC7eaXb8CwyWf0WZBPRa/k8ysff8yts5byMI0qXcZ/FPzKhTTZ2BnxoF7bPQLpX3JNH61ETxr3Hj1qVEEvcsxHzmJ6TzUaeEq6C2r6g7oKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088023; c=relaxed/simple;
	bh=dhpoAtS52m71WLt69ljE0Ckw9Vumy4qaXpqDDb+UKJ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mzf18tQcYuZGelARviXB0c86x3xpm5Cij9LfuKOHN1BQOwo0dv5jOtDh/uN5OXVGqugWx685sW2knJA/+/eXenbqjDu/OVTWgURE8fvTuNe3yWlq0XEB2pQmHIK4plEHkgSOwd/wUlFBEdVM0rUESxqVMPArT7pmTkd06r1AkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq3F7PNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0153BC4AF66
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715088023;
	bh=dhpoAtS52m71WLt69ljE0Ckw9Vumy4qaXpqDDb+UKJ4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fq3F7PNeadCPD5qoPmU3+idXPwxiWy3Q+x8mBLD06gdZCkQl1ndehtpJJ+QC70xj5
	 e5PrgTZIt4i4FTvmKSYzfFMMdj/1/DgOGS94tTOOnttPBO8DB/pgNmeFQmm8m92DtR
	 CyyJcDefs2LRx/anKvI0gZhaQaJNIJa3vwWyMl920dqNXuhuASYxrAqoVxi1IQuW0u
	 1yKCfPmdfK2evpcPJeFpLEUHBoa5pNBes8zqbyD96qqJnLe+6j0SChrJpiaHwIXQFa
	 w3PfIwqKM1otsQjZbWptCV+mcBNSUd9cvDyKTpbtIR/yKt1Q4ObR3w414BUr/4/QZB
	 pZhvjwt4L6nFQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EC3B1C53B6C; Tue,  7 May 2024 13:20:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 13:20:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-VCFqLn0KtI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #28 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Everything should be based off the bleeding-edge branch for linux-pm which =
is
code headed to 6.10.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

