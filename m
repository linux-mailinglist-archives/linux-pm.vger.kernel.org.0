Return-Path: <linux-pm+bounces-6156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B589EBBE
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 09:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974FC1F219F9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37D913C9C8;
	Wed, 10 Apr 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNzJM8Ol"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61913C9AE
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733671; cv=none; b=WdWJ2rXbf1HJ1QfJlUqW9N7zp9qqM3pTvFCkMfaHQPikq0CupC+yfyW0XtLYOisPhSwLo6+0hm+0HXFEPoABxNxeEOinpwmzEVZnlaG3oCyZWHDIWU0fkNR2yUOIsRBPMhzSQd/Eiu/MnRUyuPqcmWmVCayNNHUY9V7NH5cFJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733671; c=relaxed/simple;
	bh=brqI5AI2Ir+qgvcwfuIsKYjw3t8oD1XgMQFd1hHOXQw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncY24CRKBWebK5NXKTL1RAfvmEXFL85hombiyCTuKU8UiuqNWjugbHj8sKtBBfASL6PD7bHm3TazklU+LvuvB9yXvt6xyHRx7dz/f1+wSDwLQs4eKATlkjI6gpLm4cs10752P9cRQF8MVLD9SyqAsH386TYBgPJVQJfLcNtO4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNzJM8Ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A7AFC43390
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712733671;
	bh=brqI5AI2Ir+qgvcwfuIsKYjw3t8oD1XgMQFd1hHOXQw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TNzJM8OlCpoTbJS+F0z9tQNZBzq5dbf4Mv7dGCEanBPNWzf9nUgQ8XDR9iIGhYM3A
	 IEgrF2jkGkE8lLQdx5Z/1Aiz1IjTF4tzW4OJGxBgN+aPDX6lNwWKKMWxcCS0M4BQcl
	 u5x6ehUJKAZoAhha3yu1itf6CK7+vQ+EgzG4H9TKW/s18lWKLMAY69C+2hJ+zt+P76
	 SAT64ckA0Uvo8aFrktc/UV/eeHZg036dzNSGDUJMUX2drMyYlub9x2KOWbI34aEkbM
	 hGpN1hxVo4y1PVX1sScWhDwvevIWeosAB+jIi2/y/+12F/EkSUHfckmeLpYAbBmAjH
	 HuaIpKh1mduQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E9682C53BD9; Wed, 10 Apr 2024 07:21:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 07:21:10 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-qfXpqZajnc@https.bugzilla.kernel.org/>
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

--- Comment #21 from al0uette@outlook.com ---
Thank you for all of your help. But I don't know how to contact with ASUS to
request new BIOS, can you please tell me how?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

