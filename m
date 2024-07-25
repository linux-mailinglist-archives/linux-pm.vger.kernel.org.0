Return-Path: <linux-pm+bounces-11404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9090A93C57F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 006FEB24F1C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C86F519;
	Thu, 25 Jul 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQPyzico"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9FA8468
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919124; cv=none; b=K4EpPofaAnvEI6cU0mtf0TINRIUZKRJUKSljAVmpgxXwjTv/pFs5mS1ZsR0gfvBrYmBpT4QR7QCJOTZWYOY2lm98BEBBZgRWkQKs3PWVoSXlWwCUcf1dl4fQ5as978dl35fAXoIMkvHI1DU4/Bxe9vxQYN7WLixdO1AqsQVx2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919124; c=relaxed/simple;
	bh=nbeWv/9pMU+fECIPxHI3u/vaILnwrWns3gMnFvl/7lo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwxPqdj//rifhOFcyZf9h2iHu8iPOANnwJ7MKLDx36EeSZJ9OfjqoisE4Sr8UMkGPYvKyQbo3eaMQEou45kcfXvsdTVXXXwHm59428Fi0fgYdBO6neN7dNn0OD9u5KYUXv4NgoaVf6pcbWPqawEYlGn7bWDY77eVuqM4x4dANEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQPyzico; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADBBAC4AF0C
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721919123;
	bh=nbeWv/9pMU+fECIPxHI3u/vaILnwrWns3gMnFvl/7lo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oQPyzicow//Yz5ULHfBQS7GHDThRrcVAzq5APqan9i0ZnhJ5qdsq7RUxJcxDxB+iK
	 lQXOIiZ5kJycS5YyUCSPNmPzOzaa9QaUSwwYoockxYHu43E46gyO0WZrRRtW8lYqs0
	 PNGjVeChLzZhZMX3QOJ9POyIjtc74ryAwG5yhG70vPULLHf3jxo/nGiFXyvoeSWbjm
	 GqgzOmX0Bwdu7FoBN/8y4gLmiPslI7xXZO/1ZP2Mchf/pzsL1oVSMnIfwMEHO/rx0R
	 Ru2MOo4kYbsf8vraytr8AMiL+acZSqCRGA6d7dOekzy4PZXktFtMubrz/CbBL0/pK9
	 azGDZhMfuYFMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A64BCC53BB8; Thu, 25 Jul 2024 14:52:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] amd_pstate=active reset computer
Date: Thu, 25 Jul 2024 14:52:03 +0000
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
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219051-137361-8lwjyeO6NV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219051-137361@https.bugzilla.kernel.org/>
References: <bug-219051-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219051

--- Comment #9 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hello,   Thank you for your message. I am currently out of the office for L=
abor
Day Holiday. If you have any urgent issues or need CPPC, Hetero Core related
urgent assistance, please reach out to [Limonciello, Mario]. For non-urgent
matters, I will respond to your email as soon as possible upon my return on
[5/6]. Best wishes, Perry Yuan

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

