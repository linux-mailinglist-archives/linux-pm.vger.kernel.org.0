Return-Path: <linux-pm+bounces-8137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADD98CFB13
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D973B281963
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D73A1B6;
	Mon, 27 May 2024 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVViznOU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01C4C618
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797556; cv=none; b=EEflqqRLzCbHC9o81Q4LqtofbdiE6eDnGS6rfQNNrhnkzn8jdBo38VDPCmLNdwV289PpRMLZY8P/Kt6mh1FrdUKUqKk0zJWwbh8F8vH+lYvWWN3wTILMCfWLDqQoLdZjnhqQXeHbIAFpHocnMpla+lzu8NTNg2ZUldYBLrPHEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797556; c=relaxed/simple;
	bh=6joQbb7VbVjzrklvS+rcMQQW/Rv8E1FvQuwUyKZY+tY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BnoPmU5e1uXgpCIkzgI1Lckf0LKFaVYcn7r1ZH6K1GWsIR/rw7sE0yq22iOjjN8OpKEjYDO5RyY1bv+/XNkxLWU0K+LmdPrECIk2nTsYAN2zXPEaAgvvt6HwW9nfbHNLfUMNwYVc6VrUmtKJDr3bEbFvvLgh/KNlIv4rBk7LztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVViznOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AC23C32786
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 08:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716797555;
	bh=6joQbb7VbVjzrklvS+rcMQQW/Rv8E1FvQuwUyKZY+tY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oVViznOUFpo4wQELMY3eUTuSsJlxYl5ipy2HU8EVSAXm8EScWuP0jscASnQR7MnuA
	 U5R6xmA7c0uBXfbhlLkbUqTMg5gItAoupdt0+p/4CmH7f8Q1EKA2DsotBEE/nwtF7O
	 AqQ3Xs2F5rPHYBLUeKbXFDhJAZg2v2EkkT7Y6KVJGeSoYETT/CFTh0GrDZd70PH19O
	 h90T30GaRdUOMnP4n4+8N2gCkmd//+bK/atVYNXSh+miSEI5BX+TKhOohY947cY6wk
	 iMJtcbyjIeD4eOuvqiJJgmBBjg17YyFaLbabnalGtoAdQzGgA2RvGNNWL7S690l93y
	 8ZlYqhefnjbhg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 724B4C53B7F; Mon, 27 May 2024 08:12:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 27 May 2024 08:12:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dacian.bujor@phoneresq.eu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218686-137361-KUYN23b54F@https.bugzilla.kernel.org/>
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

Dacian B (dacian.bujor@phoneresq.eu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dacian.bujor@phoneresq.eu

--- Comment #52 from Dacian B (dacian.bujor@phoneresq.eu) ---
Hello Perry, Mike,

So, i've stumbled upon this thread regarding the amd-pstate driver and after
hours of bashing my head against the wall, i can confirm that i face a simi=
lar
issue, but in my case its even worse since i use a chinese laptop (so bios
updates are kinda out of the question...).
I dont want to upset anyone, but to me at least AMD kinda dropped the ball =
on
this CPPC thing, since it should (at least in my opinion) be enabled by def=
ault
and not up to the vendors.
I will be following this thread if anything comes up...

Kind regards D

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

