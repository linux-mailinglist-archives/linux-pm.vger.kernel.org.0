Return-Path: <linux-pm+bounces-22186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD2A37C8A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 08:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49051683F9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 07:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6770618DF60;
	Mon, 17 Feb 2025 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaD1dg2c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172F15382E
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739778715; cv=none; b=qE8eOE21jTkW12IBBIaQLrx8YyyNFxo/byNiuaB2blg0McYMLkvvpFllqdTNRQUtFU2nMBy82XSJKSc7+rWD8n54zhi1LkGwNq77spZ4F8pBu0fVfFF1XJJe5JlnfzU7S1z2XGzresmYD6SlVzQ753L0FGiMh1r25TOLBO6RQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739778715; c=relaxed/simple;
	bh=eE3NZKUpmGrlfZGfofKJGegG02daWVzMXdCiO1O3pr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WfFhyF52oGqmCCTIIdtlq8J0lGC2nKjy/ER638tt50USJvC9cto6qu3QhN7TbYwvQFlwFFQl38/xyx8gP+YEUgtgV1xRJz9yWlpyhdTGWod3hHUGCuaWbpnW9Chu8cUmCKPGEn4S2B1HfZJD7yl/O0+6tu5xClPkEEe7GhqYzdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaD1dg2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3B99C4CEEB
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739778714;
	bh=eE3NZKUpmGrlfZGfofKJGegG02daWVzMXdCiO1O3pr0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TaD1dg2cYOg4Ybzr/xlxa1cX167IB1HWj8AFX3YHthi8qgurbkOllucLO71+UAvFj
	 GTYXIK6Ypxv/cyeiiaRmCNTAmXoC5csShTVDjk3BJYDCZkHwZnIfUv705wGfanBS4/
	 NV3IQlPTOkMkSBqfvPOP2LylUDy+knjWiprA1Lk213eHWH+38PTUXjQEPWl5IIDDKq
	 rlmqfa0eBRw5mYSa0BHCFTIsTA3D9tHkqZAKqZ5LG35py984sJgmgwipSLRqmxl4sz
	 6I/9r4jsf1gKoU5Zn8q6Pe89izbOpSbS8aQMegPF9w/h9kaASrD13SPMr8Zo5RCerK
	 6LFva3ee5Z21w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BCBDFC41606; Mon, 17 Feb 2025 07:51:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 07:51:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-5Ku8JpMa3L@https.bugzilla.kernel.org/>
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

--- Comment #66 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Miroslav Pavleski from comment #65)
> AMD Ryzen 9 6900HS, ROG Zephyrus G14 GA402RK

Thanks.

The issues that you're seeing past resume, have they always been there or t=
hey
are a 6.14 regression?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

