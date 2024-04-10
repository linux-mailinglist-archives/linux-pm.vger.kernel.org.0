Return-Path: <linux-pm+bounces-6137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC0E89E9C9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257E2B22129
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 05:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F243BA37;
	Wed, 10 Apr 2024 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQIroKc3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B090946C
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727213; cv=none; b=aGpBc350DUPl3H0xTHLJHUc7mR2yeY4ipGr2TAbdyZQ3BVMhEcQkChn0vFxuSI9Nyw+qE8yTEaX6IqZKNOyKmBerPD5PPLQI0dP60urhG4BRdVjqGMX6N2uWtNg+8YlUe3GZsq64uEVHruJ2K/BhcJmGZWe7o1Uzz2aJoNFKcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727213; c=relaxed/simple;
	bh=6Npic4G7BotuEmksN141ETADLPpXoPSxqtousP86E6I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbeGEO3tG8uaPPuMWMlLTUk/e6dHXIfvjm1sz7Jo/SG+Wx/W4IYL09jLEctt5vy0Nv634ycCkUbDYUmBZqNzezznF0TQKEwKmEwifisFMRYVF3LYT+ht7dK8dvG3fOtguC4rGrTeQyghUJ3gEMTJ8MJ/e5ZCf7TVHrWIZVNec9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQIroKc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAD94C43390
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712727212;
	bh=6Npic4G7BotuEmksN141ETADLPpXoPSxqtousP86E6I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hQIroKc32Wb2aab82JS9t+3qnNkgMHvTsFJxTbdStuBAi+xxR9RKECAOzXBnc/7DO
	 pSM4Ydy3suF4TrTxUQtJhlRW7btn9dRVraLKDl6h5sDXjXemT8B2oKBdfNOPdmvuYf
	 NuYajuigIg5F/VoiBh//9OcaZbVMjYCL+ZJ4cnmmPnRavTx4j+X9wurQw9GelQNNtG
	 NGU8cLPU5VQeifxlFhe67GjktY45Kgc0wjsu6oJJ2muF3sWcTYlcp5VYdu++YlHNAT
	 BSJ+W6mW/Imcg7LHqJ3Uxuoqr+dY3Qk4Ydqg2SrPpS2cVtm2FZbQeHsI7nEh2qZXZA
	 8w/KHObEVmjEQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BBA27C53BD9; Wed, 10 Apr 2024 05:33:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 05:33:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-RXboNWSFvy@https.bugzilla.kernel.org/>
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

--- Comment #3 from al0uette@outlook.com ---
Created attachment 306116
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306116&action=3Dedit
cpuinfo

I'm not sure do I need to append amd_pstate=3Dactive to commandline to enab=
le
amd-pstate-epp, I'll try to boot without it and see which governer is in us=
e.

As for the /proc/cpuinfo, I've uploaded in attachments

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

