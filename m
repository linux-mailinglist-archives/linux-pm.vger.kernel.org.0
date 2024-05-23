Return-Path: <linux-pm+bounces-8085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2B8CD82C
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 18:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD76B20EC3
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975B111AA;
	Thu, 23 May 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6uE0NMd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD6F9D4
	for <linux-pm@vger.kernel.org>; Thu, 23 May 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480834; cv=none; b=ktGY51UDQWPQhaB+yeqboje1U3JdwJrp0I3LJqHKttdo0BVhFYzPq6KCfHCb6JYRqMYr9ox2QRnuVtPzk0Dt8v4vMlSn4nDQxJ5pxRsATgNpZlWV5bUUMjCGa4lLURbkJeiJJ4xvMmkTTI7LKkOmQR07nEBucitkILp5Npikkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480834; c=relaxed/simple;
	bh=WAIIy5npf66cjQKqFzxKNbR3pdpqjaTXSpZKmRu8JZg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxZeA7eBPsl85D3kO/3+H3wtz5J30DHudgivcYMUb/wNEVakHXYYnu74bzRzVA5W+eun3j6PYyVNoKFlQcKDSaNEtykaUQWXdd2eSRG+HP4LM4GNk9zTP37OMRLYOJsjonWdV9zPeqXpKAfhldX4zD8eCuJbffoXJana4LLWf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6uE0NMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A647DC32782
	for <linux-pm@vger.kernel.org>; Thu, 23 May 2024 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716480833;
	bh=WAIIy5npf66cjQKqFzxKNbR3pdpqjaTXSpZKmRu8JZg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X6uE0NMdO/BgJF6Nwdo0D8yXVhvOpmyLDmMo+64RzboHtyXqTqQ9z0ncJArnEarmK
	 TN2enlb7WjZb2eioeolfrn5uuZYNv8536eBhfVeKdPoXw3pEQhomIe9OJ283RMzwIh
	 JzkUwQjzMPzQXCQltOrh/W7K4K8iBxe5vpvXTFGQA7ose6lwAl2UssrFGsxlpYLnpA
	 X7r9AmUmq7EX9CcAlhj9IyJKUoovjqBBjro4FnAc3Q+IKih6hdIcCxDk53uCcbiRYO
	 v1t2Icz8kOUlBv6fSn1sCY/EDz4nUrY7DEMglN8ghsOPBWaFuWZSJZk0OAaEXkHVv7
	 7uyMdDK0jYZXg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9475AC53BB8; Thu, 23 May 2024 16:13:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218865] NULL pointer reference if X86_AMD_PSTATE_DEFAULT_MODE=1
 on a AMD CPU that supports CPPC
Date: Thu, 23 May 2024 16:13:53 +0000
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
Message-ID: <bug-218865-137361-PJo1br3kpW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218865-137361@https.bugzilla.kernel.org/>
References: <bug-218865-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218865

--- Comment #6 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Matthew Stapleton from comment #5)
> Thanks for the patch.
>=20
> After manually applying just "[PATCH v2 10/10] cpufreq: amd-pstate:
> automatically load pstate driver by default" to 6.6.31, the AMD Ryzen 3 4=
100
> system is no longer crashing at bootup with X86_AMD_PSTATE_DEFAULT_MODE s=
et
> to 1 (Disabled) and when no amd_pstate option is specified.

Thanks for the testing!
glad to know that patch work for you.
Then we can close the ticket looks like.=20


Perry

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

