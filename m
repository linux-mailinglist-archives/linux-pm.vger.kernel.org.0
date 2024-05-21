Return-Path: <linux-pm+bounces-8013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DCF8CA8CC
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 09:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290CCB20DAD
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 07:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819B179BD;
	Tue, 21 May 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc7vWYLA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437DA4F205
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275989; cv=none; b=X5MyNFqkDnj5vKmxH6FdpJ36QBi2dwPpab1eEVvrmkaIWqrzffbOaWmIiGEse9n4kVTOFFBiNhAF79I77NXTojyCNSX3MFG2jl4e1ApoNACO0e+2K1wEWWMRxU7DW29OBKNYEse7jin3EiZlnIu2Gk52DWX0uO3/6INbOq0pcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275989; c=relaxed/simple;
	bh=qIzoY1qdomjQ/trjh1LYXEagyZyPiLpirc9iwMyHs1Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bs9s/YWdOru7jfHb0kJd7JUmDl7pL8Gi6/1CGLgxGnMjPOHyT27jzVRXrHqqvjLDM49xE6PJ9tE7p53JjqzeNQ5CLry0Z8o1bAgQt3xdEyeqFxRAyKzL7NGb3ic0ZrytcsJ1dRZZ3HBR8jSOB4fj7a7+UVwM2qx18Q2dD3UtBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc7vWYLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEA9CC4AF0B
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 07:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716275988;
	bh=qIzoY1qdomjQ/trjh1LYXEagyZyPiLpirc9iwMyHs1Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Tc7vWYLAr0ddUDHJpuLr2TD4Qn6GCXqwuyG2H/hntvQuhNaoZuDB3YKa8x2NiEj3H
	 GUCG4H2/HNpdz4XwVaK0cFTYLI8P0LQbt86GlKqD4Be9uqleThaFYvfldySvGtJzKi
	 reY6FyohbZiVWzRRqhYH9nsylSj28mb/hFc7tnCJDPx9xBDlmuNwtgA8ZlFL1XAPmF
	 DgxHeyh4YYCZI+IgTXbZnAzAXoHAbZznyEj1kO6HUdQAqGmFw7qarJ5QHKVi6yFbkq
	 wlLEHgVT/+O7hYK3SdplYogmye/VZoSh/+DTRL/idGalBA3/Hc6bHK6aB4HuCmoCaF
	 YVBPjVR7RXFVQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D607DC53B73; Tue, 21 May 2024 07:19:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218865] NULL pointer reference if X86_AMD_PSTATE_DEFAULT_MODE=1
 on a AMD CPU that supports CPPC
Date: Tue, 21 May 2024 07:19:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218865-137361-cGJzQxGl9M@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218865-137361@https.bugzilla.kernel.org/>
References: <bug-218865-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218865

--- Comment #3 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Artem S. Tashkinov from comment #2)
> Perry please take a look.

Sure, let me check the issue on my local system.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

