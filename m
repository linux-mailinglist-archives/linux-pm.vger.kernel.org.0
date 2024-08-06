Return-Path: <linux-pm+bounces-11935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 969FC948B4E
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 10:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31550B21F6C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64961BD009;
	Tue,  6 Aug 2024 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ7biAUj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275F15A4AF
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932953; cv=none; b=KnXAnhj5gxrOTlK8aDAKeixNPp/7sYafrTDHJhpaKmlzNNcOIpxtOtM7fSIUxxb3YsZSpJVdTlEmcpD81u7JL9N/kQSarEA38q7qgrSuYb/EXck+FpXxeoOlK9UwYiKxAnOKFadtnxPztQS1/h7aRX8eH4uwPpnX+MSFeoSDSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932953; c=relaxed/simple;
	bh=4OlAWLfI/4SCivcC0+5hylGBjCs7KQd7ZakTE69+hC0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TY36E978ZgL3ClL5odfDMHAxa+Bupp7OPRGCUSITVQ3eQxiStTq/KP11/VbH6Uv55JclKEc6WZ9I/soetDMzq+m/ejNTQnjhLxMoWGXmGEdOXpEMoLcKibj4KpDH4x3eH8Oms82UIohAUnCQz+nqbjAgVcsMXaXpb3AIPwTu3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ7biAUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6363FC4AF11
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 08:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722932953;
	bh=4OlAWLfI/4SCivcC0+5hylGBjCs7KQd7ZakTE69+hC0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UQ7biAUjmiNq9XgMmOp7M8D4S7F4FU9IU3QfL3pV/H4QNEW851n+RTW/lekrGQAbj
	 K27da7c7NNxinTUH7QzASfoTTyb0J3n4vSJLNkqEQlGI1jHKYkYmraakpij8XDa2A6
	 Sh7JRTuSxtpU3CChWc50lg2vE2h16eubMR2U4ddJ6OGbdrEHoDQuHKqxGqXe1urGrj
	 DGIRwh9CnQlBt9WWozEpNevQsGYLtyU/lBciHx8LwRK8VqDg63KHeMWrEMNkg85gdd
	 F511SE3sSTwJaTqCk9GXFQsFXI1h730IWOlF7tS/3xmLR3ltuivwcecOH4UbGRWqiN
	 G2vj2ndqSI+sA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5AE7EC53BB9; Tue,  6 Aug 2024 08:29:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 06 Aug 2024 08:29:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: k.kirry36@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218686-137361-staZv3XNt0@https.bugzilla.kernel.org/>
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

Kyrylo Budnyk (k.kirry36@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |k.kirry36@gmail.com

--- Comment #76 from Kyrylo Budnyk (k.kirry36@gmail.com) ---
Hello!

I have Lenovo V15 (Ryzen 3 7320U)  Laptop (without any BIOS CPPC options).
I'm using Debian 12 with 6.9.7 kernel (from backports) + compiled kernel wi=
th
full MSR support.

I'm having the same issue with "Unknown error 524".
How can i help with solving the problem?
What system data/outputs do you need?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

