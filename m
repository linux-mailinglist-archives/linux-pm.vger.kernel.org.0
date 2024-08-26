Return-Path: <linux-pm+bounces-12903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01295F8EC
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 20:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEDE1C21A03
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 18:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607B824BB;
	Mon, 26 Aug 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKyGPqVe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410508248C
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696833; cv=none; b=cJNvePWaHJ9bvQHVLMIGzYzWydZ6FyZ7ncyjIEuQyUFclOTB8gOn1bwXdK2VlIW7eWrtG9577NeJOsUaGGTjBX2HQkoiziUl/O0yu6qvrbB3o6Sj6bOeX7s2mRHq9vMV8X17k06q7K9Kxmo6SxtYOsH9Kd+rlVmOjjmQprQLSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696833; c=relaxed/simple;
	bh=vzWv1hnT8TY1yp4Q7aC7Ia9C/zacjpggMh8zo5smoE0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2eFgC7UdwH71ix74Dpv8MoyhB8QFiiWbOuBWlC7y8Hr7OR3oQYeTF8TUJz1bYv3mSx576cL0yGiaRrD0so7vVHp320QLQHJGTaXgEykpLVcaTPYMtYCE1KswRFzsSVOLwJ2ZaHPhKYSvMi/NvrieuPTKx3fNXxrMVdPc64UFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKyGPqVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E74BC4FE0B
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 18:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724696833;
	bh=vzWv1hnT8TY1yp4Q7aC7Ia9C/zacjpggMh8zo5smoE0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QKyGPqVeHejwdS3WN06SAPiWFZgplyP68wZrJvmGK268qQ4XVIu7X5vtqe/bQ/F6o
	 72pLd3f0KLiZgEMnqmkuvJEJh7UfubvfPQWfYODMgYGJvZJVWDshPzcb0wmtCNZfsX
	 smziNXrHrqEbuDyrE6BEY3qjAl0M0SwQplNUkKQuhQG2kUi7aDemKRE0HNGoQdm09H
	 IkS5KKPiq85pvu2klKNz0LWlOvIHb35ylYYbJQkMI2mwXk+y7BhxeS6JHEsPP6N66T
	 FHiul0ElXn2fYLBd1MTrs2E1Du367eBUDYSZhEIunmv9fchN5+Dg4ruN7sXQ1bqkRE
	 0xhXGm/vnNing==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 12491C53BBF; Mon, 26 Aug 2024 18:27:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219110] amd-pstate's balance_performance
 energy_performance_preference doesn't survive suspend resume
Date: Mon, 26 Aug 2024 18:27:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REJECTED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219110-137361-i3OB5S1tvg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219110-137361@https.bugzilla.kernel.org/>
References: <bug-219110-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219110

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |REJECTED
         Resolution|---                         |UNREPRODUCIBLE

--- Comment #12 from Artem S. Tashkinov (aros@gmx.com) ---
I feel like in Linux 6.11.x I cannot reproduce it any longer, i.e. it works=
 as
expected.

If I manage to reproduce it, I'll let you know.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

