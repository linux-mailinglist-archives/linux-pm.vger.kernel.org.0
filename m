Return-Path: <linux-pm+bounces-2349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A383205A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 21:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AD3B255CE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2052E413;
	Thu, 18 Jan 2024 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij3fgYY8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70F2E62A
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608848; cv=none; b=JagzJF3Z8teF+wVleWDNN+j74A+3oTHg+DMwB3+7Ry38tbJQR/4yTKZgPWMqDvOXzSA3u0Wf8O6lpUWTzpUfCT60avOXlk1eUV0Nq1NEg3FLOsqk0TBHIpXL4SqCo5JcipCqa5osLJe4xkHeRN7gweEIrfyaOmXEf+OA7Ug0iic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608848; c=relaxed/simple;
	bh=lZjquvkTBOnm3su+QYhW/mpK2W2xB/OrzpYw7uTonEA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVhzyJE8nV2sCPRmhicBFsw518YXuOT51dYvCRi39rydHgtvIPP7QC6hrWCwDvVVFv/0hFzr+3okJsuiiG/Sg74TErUeqsvjmOeM0UyEkoE6YpSgMpy8fCARnISrFk047tk4OV1cQl+YQXKD0qX5artvvDqfEmUxn21nrTNmshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij3fgYY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 213C3C43390
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 20:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705608848;
	bh=lZjquvkTBOnm3su+QYhW/mpK2W2xB/OrzpYw7uTonEA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ij3fgYY85nYyDt4VVvHm7kfh5RC/p/r+5LtFUm6sPhEaCn29WFNP/wZnJcwSEF8P2
	 a3TyFkrWxxx969cXwGKQQd8uCOvZTRIGj5Lt9fifKBYEc5v9QN8iA0b7Yuyy8cvMdL
	 CsJOlmrmt7OfAWUGqB7eHz9LunFiuJ0liDwqs+/eKDVwUBlSTXIgl+9xNcaLIoXIbI
	 +3n2YO6HZ4blsw5t2KpY2wAuyw8IuS/AVKqmgsTp1QhsxMTq3BHb7YDAprauf5eT70
	 mXykfv/Lhgzo3I6QcIKEpykaA1Z7U4sfJRauYuamvweCN7LAzpl4FN6aLFSeriEJ1D
	 Eg4WqbppvP2YQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0C034C4332E; Thu, 18 Jan 2024 20:14:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 20:14:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: haunma@keteu.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-1AKkndfkir@https.bugzilla.kernel.org/>
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

--- Comment #24 from Mark Haun (haunma@keteu.org) ---
I'll try to update to 6.7.0 or 6.7.1 this weekend and see how/if the behavi=
or
changes on my system.  Do I read that commit correctly, that
scaling_max_frequency *is* supposed to cap the CPU frequencies, in the late=
st
kernels?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

