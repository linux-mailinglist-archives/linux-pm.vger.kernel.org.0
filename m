Return-Path: <linux-pm+bounces-7108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D4B8B263C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 18:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C621C2134E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5224014C581;
	Thu, 25 Apr 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAzpVdfb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01C2D60A
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062065; cv=none; b=qp7BwbAxcTOLtrqGCcPqLLOnOzed2jStKMPEFQUjVjSQXfzG2kGM2Cd+c1tIpwmW8MMHZ/ZWvNk3aOgY3bs+rv+KHJqAcKIv8Bq5b3LI7z8FVFoNMRcv1GXpL90VVTC5aREJMz195pv3BParf0EwZJ66wFMPmu5LZqXZEQsK9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062065; c=relaxed/simple;
	bh=E+VKUdaq0FUCZfeiJyLi3Y4KMq2RJPywiHyAZXQ7FQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RRgSJEv5jOAyoUc5BEJmF4hs0UDcPpH87tfp4Nr1aUNmlrsIMh5vUE77JeKIkaX4nV4oHR9Rg50exhSMDEca3wi5PObHRTbwoC9/qJmFJ/C/jFZtqHz14KVjfXRAcEpAN5QENzSvZvGJReoFg0L/a0kH6CV3GFD2p2u/LXKYNPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAzpVdfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB53FC113CE
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062064;
	bh=E+VKUdaq0FUCZfeiJyLi3Y4KMq2RJPywiHyAZXQ7FQA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IAzpVdfbE0ge3PHT7/Gg+pwrkh2iwztILLopzgPQ1bLq9kPzjPt4epEGZbq63pmkl
	 Pg3PsFnjxjLXSpFGHKDOL/PbdaqiTGgaDAgAqmMNt7v/wtPJJkIQqymmupxd+umxpl
	 dkiKORqMBAqzQuDyKhR2NX7BpBdzltte4qBxH4tnGsXCbo2klRR7b7W9D3rAD7xkCB
	 x48a3350GIXFySFOMFDDFfpsPloXldHd4GOOburbNaH0KhUv4ftp4RplA2VvwbjmSa
	 PiE2DDu91pngm3QdMTDKxW0vlAqDBoe9kLkGQklwi5PhBtEo8sTcADnJFxe/sv7M75
	 ULCTN3A2wlEJA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9FE66C433E5; Thu, 25 Apr 2024 16:21:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Thu, 25 Apr 2024 16:21:04 +0000
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
Message-ID: <bug-218759-137361-lYhOmQQobj@https.bugzilla.kernel.org/>
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

--- Comment #8 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Can you please try with preferred core disabled?

amd_prefcore=3Ddisable

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

