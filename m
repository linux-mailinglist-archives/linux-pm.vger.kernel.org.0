Return-Path: <linux-pm+bounces-8025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EFE8CAF12
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 15:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DA51F217FA
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 13:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D88770F1;
	Tue, 21 May 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxEa+d82"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12D6CDA9
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296997; cv=none; b=bOc5lBF0HcqLXLWjum7hs1aMbLw87kRtCkvESJ3fMInBjHR8wnfpHYyPRys7vTKKKw+ckgMSVpp3+6j63jVG3QXVjb/8KYUAIMzWr16YKPw+KHUI8cycNTJ7DVVzN7bmonWCx58JY9lspOY3yvyl9exsKi9sY0wTocrforaHgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296997; c=relaxed/simple;
	bh=rJ5RYcsJiK2HBdRps3UySYxdnsIL9nywqbCG8ysg5bA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hXd4Cp+E0/ywzQKxmr79GV+SJhcEf/+hgGEGPQVrFrG1LcBhuA2u49mXp/taJUfkljD3hgperKm/GCvL7WapCANcsTq/NuBBkyy+v72h5VLuXqmiINZB/EjFQ73kNM2gJ7d167x1aZFet0C9IpklmlELX5vtp80GeWOL6NcMF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxEa+d82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAC0AC4AF08
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716296996;
	bh=rJ5RYcsJiK2HBdRps3UySYxdnsIL9nywqbCG8ysg5bA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TxEa+d82sa+o8D0YF7imEiZX4RFctKTUmVprC2RYCmMvgfi2fhkQI4AdqkuT04UmH
	 5ec6ow7PF0lCOXxC+oE0j1Xsodwm52lsMdr/gUW+v0qFw1Sr8groC8BCms8zDwWYTR
	 vgXT9Q+R/Qr3z+xUCE+ejX9Raj96V5FXuIAXCefsVjNmCyaZ+nJ+7o1sK4eR4kKhZd
	 N9sjqodYRbZvNSm6S+IKIDwV1zhmHhfO1X++hcpMvy4jiHuVL9MRmwUyj8muByMC/T
	 yO8CdzjtvxLQdOadI+LJRFuvWepmxGoLAuq2eECzGUhi3H5RZwvYgAtzqsCnZz6UxT
	 S2y+c1gh24Zag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CE834C53BB8; Tue, 21 May 2024 13:09:56 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217618] Changing maximum frequency and boost state does not
 work with amd-pstate in passive mode plus the schedutil governor
Date: Tue, 21 May 2024 13:09:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: putr4.s@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-217618-137361-HnaywAIThs@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217618-137361@https.bugzilla.kernel.org/>
References: <bug-217618-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217618

Prajna Sariputra (putr4.s@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #5 from Prajna Sariputra (putr4.s@gmail.com) ---
With kernel 6.9.0, it looks like limiting the frequency control now works in
both active and passive mode, and in the latter case both the schedutil and
ondemand governors respect the frequency limit, so this appears to be fixed=
 for
me, thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

