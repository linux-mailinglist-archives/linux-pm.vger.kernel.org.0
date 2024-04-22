Return-Path: <linux-pm+bounces-6771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C744E8ACA63
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 12:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5851DB20F2A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD013E033;
	Mon, 22 Apr 2024 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3mVg9ok"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE336131191
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780951; cv=none; b=eDvNyO1VTHE64Tn23e1Tg7knT1Ge+paKOERaeOY6HwHhLEDw9nM0u30Db7c8koHJpN0I2ZpwWQf3vCVUo20kuSK2ylMdPh8CiWFmmQDzgx58lcpANjpHBcqlcOGDOvIhrfcMQHH1hz3eZ82vPe34AxX2PeSVHFSyOhVQd7hGv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780951; c=relaxed/simple;
	bh=6H1wm0UEDnounOdQPM4vkW4JbRxdx36nSLtHLuLzdAo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRyJYCrA6fF304tM0R287k+0qrckY4/rkvagKAmN4aG1kRTQtCySbPJC/aaFzovjGGJJE72cWxp6UCS44qNG/1yPujDyiPPd5Bz7VM+GJs8kxJlLzfaNKs0dDniWMXzx5Wjyn0wqqQul7uDT2t6E6+NWs+9swlhJGSO5o29a7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3mVg9ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F2AEC3277B
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713780951;
	bh=6H1wm0UEDnounOdQPM4vkW4JbRxdx36nSLtHLuLzdAo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G3mVg9ok7TPdF+uDhxP1AUTXd9LGu2K5tt1ipwkZotfewkIVlT14x/NsRGJA6fiJE
	 qa5j5bDjBpxUOwsQ2OrNnuRz3o4aB8dw7VaQsrytOW39tPjjHXEymC27xyaafSaVC3
	 wjHdMaod7Exe9VblL25+Y8cv3dh0BxXXd/uqhhHjNPdT67u+pNHM+tyHqXEslzCXg9
	 hgb6nm3zRmenKNfVggd2GkEgZQUHBEA9c1e4Wpp+f4RK/9s959NnMExtNolxW1TuIA
	 lz7SzdPaouA3IInIqZP+H9D8HiuIiDXUwoaU1PiqA3aRgzRu2Tv0hgqSDqJkEwLs1o
	 tNvGuA+wUvodw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3E031C433E3; Mon, 22 Apr 2024 10:15:51 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Mon, 22 Apr 2024 10:15:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gahabana@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218759-137361-IFI6u9U4i5@https.bugzilla.kernel.org/>
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

--- Comment #3 from Gaha (gahabana@gmail.com) ---
Created attachment 306194
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306194&action=3Dedit
Output of CPCC script (on 6.8.0-rc5 kernel)

Output of cppc_attr_values_check.sh script.
BTW, it is exactly the same when ran on 'older' 6.8.7 kernel

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

