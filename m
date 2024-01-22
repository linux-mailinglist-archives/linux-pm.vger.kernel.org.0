Return-Path: <linux-pm+bounces-2514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED1D837597
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 22:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE411F26008
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 21:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E30E482C3;
	Mon, 22 Jan 2024 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoPR9ZxQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EEB48780
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960016; cv=none; b=BTQfL5sshLjp55av5YYYwO9lflK1MyhfmgCv09WY6Z05yEYoMOm6SslZzR0M3Et2FYfZ+uBQWlVoEa5SNyAen9C4hwc/0aD4FaDL+YdO5rJL1yz4+cEgPgRwkyDnzL4d9BLyWfzn4+WAfw7HHdHL9OPHvNdL/vS70EawPyAM2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960016; c=relaxed/simple;
	bh=MzaydCUlCqhLhboECIUpZ+C4q3tGr0uWQzxsjzXKAOo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9w91cdWssk5/OThOY2175L3O2ozMM+B0H1Zhw3h4ypQRoviZv/mOGs8lf49v06EagxdQ8K4IY/kUXNCuv47yXvslTSYIdBvfm46jnNOA+JF5no5JnyJhuQ2DARX1fCYtbttTqW0kKwz9kZjY0GJmbLhkgMZYt+gwvlf921GI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoPR9ZxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6F43C43394
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 21:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705960015;
	bh=MzaydCUlCqhLhboECIUpZ+C4q3tGr0uWQzxsjzXKAOo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GoPR9ZxQzmW6vLwfaXLYnHoidiWw2aXeWy/qFBY2naHQsOX31D+QmN5acrsDJwEXg
	 VRW2tkhhJDUJ0OmvUPvc63t+oW4IZNoy9Ls4j4WOvy0yuNMS5qb50Ql9sGc212DaOh
	 IrgvTpzNVAHzyYyTeP31Tm6UhSm41mZNIe3VAkyCICybBgLMTnlnUgh3VMvo6uz1zI
	 ZxIKmdBwBEfmvPgcA0RODEGIU9iL0FVXXoSwiqN5xt3wgib414UXkvTNXM4pNAM7V3
	 rl7t6sV5TvilQ112zgV0Av/87rul1KuR5GZq51getGu7s5u7WEaape/UNszwsx+jsT
	 DBCD+wv9wxI5w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AE397C53BD2; Mon, 22 Jan 2024 21:46:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 22 Jan 2024 21:46:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alex.delorenzo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-2JVO0ZMn6B@https.bugzilla.kernel.org/>
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

--- Comment #38 from AlexDeLorenzo.dev (alex.delorenzo@gmail.com) ---
It's been ~2 days and haven't run into this issue once while using the patc=
h.
I've also used ryzenadj without issue during that time.=20


Pretty sure it's the fix to this issue entirely.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

