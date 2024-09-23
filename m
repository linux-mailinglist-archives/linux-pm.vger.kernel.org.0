Return-Path: <linux-pm+bounces-14578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C69197EEB7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 17:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1698B1F22692
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D22E19DF97;
	Mon, 23 Sep 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1ziu2I+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC01199EB4
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107127; cv=none; b=Qb/mRKftrhVvYQLpem1WLb9N/C7EaUdFjEEQb3/9JXwSoJm+5eEJ1S/yzD/MguVThRDUPWvkW4JDVKr3sfmx70HDLPlWthnSYlvm4OMmwCNDD/wMjRPrKd4ZESVxbJNLMgK9IMSW/S9i/AxFCDr0YGN7EVrbTCzURaSTj0mMZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107127; c=relaxed/simple;
	bh=pGRydKDZfJWPJpNbrfvShDNdbJWu3WlTeZnXsuS51tc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ohAR9dQjFd021aH4rVGmL1TJVhMzHCCExaKl6YBqLv69NsHRGQMM4T0rTUTfseKrGAmgiED6bmmqQpFIicrfN801hTWqDGWZi0y7rWtncNZBQgwUFvKLG5v+gTrC3+E8+735z0wr5lyZvnmgRxAELyWDgpevF2E+PdmwXKaF+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1ziu2I+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7282AC4CED5
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 15:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727107126;
	bh=pGRydKDZfJWPJpNbrfvShDNdbJWu3WlTeZnXsuS51tc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y1ziu2I+UbJIT9TYbE/nrX3dAT/cKkOVLz6bcfb06xcmBmnHCu5/XVVtatsBIJUH0
	 wtj3QDKHGdPqgX112HV2PWbTredwsGw1d5iUmcxFtl+hHOgy0LuDWAm/7z4CtJh51d
	 nAvkOK9lJvtgkbf3WmqsFdFMKHD+8HeJ3nMTJnxt1owa5QgMIfPKBIsrFuxoBCS5H0
	 gzrfSasNCQ1JSt2eQREk8p7zaXxSU5EreOS/TvcIVJ9dusv0yU/6ap7p17FqEEZmAw
	 FvVPJxXqVpITmiR5f+dc6htpa76XTzyr5yagDKGexa0A35DQ9QecBj0L5dxnZ1OJq8
	 iF17LZ/RdVYxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 65CE9C53BB8; Mon, 23 Sep 2024 15:58:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 23 Sep 2024 15:58:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-k9UBuyWPX3@https.bugzilla.kernel.org/>
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

--- Comment #99 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
EPP configuration intentionally isn't available in the performance governor.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

