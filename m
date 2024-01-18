Return-Path: <linux-pm+bounces-2328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500CA8312BF
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 07:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C4E284266
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 06:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804687481;
	Thu, 18 Jan 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXFvAsrq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2D89444
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559427; cv=none; b=gePGIojUY8D3662XhOEUwpa2CaHx2rqS1O9240N+s1N6zU7PjNY/8HJG8xBboIk8vi/IiJx+3YKVYZtdgQMvXhUAMfWeA10uManwtOn/deisfi4kDmq0dfyoFxLeBgoS0Cx1NJgqbkfQ5j3+lqvkAcKXL/HeZNkGgDFjhOMRLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559427; c=relaxed/simple;
	bh=gZrMTLmYz3TMkw3oqQJ0VPvy4+4rQ+hm13vjZHRv/LE=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=vGW2piIVKz8qk7AG36m979KkTX6YHB4tWRJM/XL7C/xu7yCipz67kII2EXdCxH0Dy3goBHVxvWTLB1zfFem8+gM98KGIHi3blLVoGKwlRO0ID4/lrnc9mlOlZD4JYLTy4L4yUeS1IZ2noRN+WrnwfTZfROYlkwhcNSv/DK1zsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXFvAsrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA3B0C433A6
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 06:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705559426;
	bh=gZrMTLmYz3TMkw3oqQJ0VPvy4+4rQ+hm13vjZHRv/LE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oXFvAsrq5Acj1ijQc2HFK9YrZIWK6i9z0YP7IgMp6kBySj1HCHEHubn2nT6vlI3Uq
	 WxrGsJJGhvdcnNpl55TjqFAhEpfxcbwbxL+mOO/VIVrF4oAJlCUxNsAH6pH9QJnr+Z
	 U9r9TqEEBtfAWjblqJ1FOgcBrlWH6Jkswrm7BpN6Mvwd6pKSb6M26/55YHr5GbdSEt
	 dPDevu8Lhdd5Jl4MaEEL2wcuGD7xdJLPldyElYVuw//NXp+PEu/qvoSOwqo0Qs2syD
	 hK4pkLfMkcnDTi74XOoxf7GmLfSozuh1onuhb4BL6uJoufLjoc2GPc/Sg0F3At427Q
	 VU9+dsJgzPoyA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B8900C53BD0; Thu, 18 Jan 2024 06:30:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Thu, 18 Jan 2024 06:30:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-jDkSXjpuu5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #30 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
FYI, I have been checking the issue with our internal team because of more
users like you are expecting to get fix solution, I will try my test to find
out any workable solutions for you.
Once I got progress for this, I will update here, stay tuned.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

