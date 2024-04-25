Return-Path: <linux-pm+bounces-7122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7338B2872
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 20:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273351C20DDA
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8DC12C7E1;
	Thu, 25 Apr 2024 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI1n8Ip2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1253A1BB
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070988; cv=none; b=mu229sBBKxI5UJbl6pvm7TLeRlYiCB/CmjnUWa90OFEKfhCuJzk5aE6FT254W7BHMPUPZmZ9tiglXqeKuE9qdxuv20mevmRM1pS+Nknfp4ISEJ5So1tgZtphzfx4NXM55u26PsAZYVnSRS6d3j0XHqwHeoDhDr8bu34NSjJs3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070988; c=relaxed/simple;
	bh=HG4gn1C3VgZaU7884SaVfuwQN4IEGMoVHheKfncL3fs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eT6jEBZoDZnhVhKTnRTwGl/xyiAPF/IYyQWzJ9tpgUVAHN2Q0Uv36sPiA46dyHiSZMLDGpNRhompnSUq63sdFdjX09E+1L8oZbVsDeW1bYho6Wqgm6pL4HhflhT0ZjmPPcIPE34o6CVUS6urFXLFWJl+Qmulvs87t1NHGv2niNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI1n8Ip2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF9EDC113CE
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714070987;
	bh=HG4gn1C3VgZaU7884SaVfuwQN4IEGMoVHheKfncL3fs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HI1n8Ip2rsLD31+VPN5Xr6evc95a26AS8K93bcRpJwlYgUvKP4EVS+8kDKXvgbgtK
	 uvu1nOvfWzBtSk6AbB39v+iARQB49fCNOOvAYVgXKiSK6QPVdW1oiIu8DrwVGgchVN
	 v0vjz8cLyXIZSdWkPQ3OvkrLJlXghU8td9FNI1LfZOgW+eFkBXc5NreIa8WZ4K+kZS
	 lrRPsKmq+PM9MMoI4+cNXinqARHFvxyTZ4DvsvUL5RFBgaw+52eOEMsf0Gw/aS0nM6
	 eq+GJcxwnBJQnrPsZZe/XfX8zrWb1WqOn2JFS6M6brcrzL5SapqZE2ut6hgnj6q41k
	 TJynldJWIhNSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 97977C433E3; Thu, 25 Apr 2024 18:49:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Thu, 25 Apr 2024 18:49:47 +0000
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
Message-ID: <bug-218759-137361-OyzZLTCKPP@https.bugzilla.kernel.org/>
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

--- Comment #10 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
In that case, would you be able to bisect perhaps?  I think you can *probab=
ly*
focus the bisect on drivers/cpufreq directory so it should be relatively qu=
ick.=20

Even if that is indeterminate you'll at least have a bunch of function hash=
es
you can use to reduce the number of steps for a full kernel tree bisect.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

