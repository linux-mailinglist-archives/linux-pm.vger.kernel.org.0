Return-Path: <linux-pm+bounces-7040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54868B1757
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 01:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893901F23757
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18FA16EC1E;
	Wed, 24 Apr 2024 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3+7Y66t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75C13A3E6
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002265; cv=none; b=XfImb9m1YbwdgF0vCtyMHsicRIsXp8khHzEKo6eXaCQOTW3kCNLLvKv33zqeoAPV0sa7MGjIVJgemlai8Rhw9zEmpdxHS1q7Ax0GgpqwewrgxTDRQUyiGX4YzdmvvsTCeGtAjhu8sqZV/fUvcJ35CM0tcOhruYvkdvJGP7gGf9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002265; c=relaxed/simple;
	bh=8siSrvqw1O4P/qMLCM7NOz4tPFjiNXTb8ZdL1bUxZlc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IqfqYYDNLewdEChygB5dGpQKnHgEx0CZQYnl0i60/Vtek+9fKP2+Ax0h08zGpp8UWm1ahCDdacILqJ8nOzw+AhswFr43O8l6mxd64e1OAFVvf9At3htNA5LgUJ1xMOqvA3Y8wcdeqswqdybbdunKY0Pv9eHuzYo7yzMVgxLhylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3+7Y66t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34C8DC113CE
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 23:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714002265;
	bh=8siSrvqw1O4P/qMLCM7NOz4tPFjiNXTb8ZdL1bUxZlc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e3+7Y66tsMERRbrsleMXKjBQUhUlb4Ov8izue53hxZhXqjG2405S84u/w/1qGt6Nc
	 hN0Kh36sNmsYo5Z/WGyFhLMtcL7ve89UDwi/tk+h9BlbUHYOSJHfQv1VJu4wj6Mq6J
	 OfUV5+xE0W5JUPZZCeblNmW9dzJ3RVGW+OqE/VCscO3q0pR1ONexy7MvzEY8Ib0xIP
	 M8xeRfXukzWixy86w3ryU/DjY5Q2RbUcoltPs9kKIpr5YP26rP9Cp9LRsApqa41DCm
	 Wwi1PFnZU7jCzpH/lOQYvmQHzI3cjiiayx9XA2o37ef7sPPigmNQgesHmEIibjFvOP
	 CBoIbBiZkdaBQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 250CCC433E5; Wed, 24 Apr 2024 23:44:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Wed, 24 Apr 2024 23:44:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-VHGXuSiYqM@https.bugzilla.kernel.org/>
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

--- Comment #4 from Gaha (gahabana@gmail.com) ---
Anything else i could do that might help pinpoint or reproduce the issue ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

