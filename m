Return-Path: <linux-pm+bounces-2835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F2083F0B9
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jan 2024 23:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6C61F2586D
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jan 2024 22:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710531B271;
	Sat, 27 Jan 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J191FmD4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB56BA2B
	for <linux-pm@vger.kernel.org>; Sat, 27 Jan 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394733; cv=none; b=XoE01Op9KiGnH72C948rUzLb3sFlbTF+C4WiTLEHAS56OHJlEFP9SZudO09CvEZOREFvqypHgEOF3YkELS25AxW3Lp8KVw7Ip2VmIMADqatqG08HqdWXga5hKtLIIDhtZDCmJs25rZpcD8dsxN0gWvSHss48dBni+9n/XQ7oXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394733; c=relaxed/simple;
	bh=Jdx+6FFb3hrDYIi+G5ximVRASxkKgGzOuwCAeDAY0d8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jzg4KddKhu4o39p6IcJ1KjWNA2gRJ0LXRXQ9KcdGw86jxY5dS9KRMaYyhoPxC+H9gSbzsM/8w9T62D/+rAlEAQ6xpAvO+gElOaTe/pxA3k0mEuBQnVi0yX0O8wO6qfjERBk/AAWPcd6OtC+TakLic2+F3wgho5FagSAQGMi8weU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J191FmD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7A71C43390
	for <linux-pm@vger.kernel.org>; Sat, 27 Jan 2024 22:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394732;
	bh=Jdx+6FFb3hrDYIi+G5ximVRASxkKgGzOuwCAeDAY0d8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=J191FmD4Noc3XZ/VQnnYlZAEYTxUV+/GuiU0pkiRgTZUiKO+byzzDcQJx5CtqB/iX
	 NlH4oVkAq4ypo/OihVOBLldsF90WLQFIbNVB14Q5Xt1zl7rMYc20DogzdiRKvc/dZL
	 98TcFEpfeNnW4X3ZINXlO4EFrIpBMfi8gsay0M36R4xmZed8iUK82R/u4oRSvaLMhr
	 1zJ5g/QDEH+8EkhKTcV8xRGrkyI8ybIrGTt9e6NTMJDYNRrUWpY+mxto7rWBtdCVvk
	 XLBJ4gjkbwG2y4CuR+/y/9ac6u+XpRSt6jM+svai/uQKp+itpCTUFSX4Pb6sGULKmM
	 Yt85aKOx8G8EA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C3B4CC53BCD; Sat, 27 Jan 2024 22:32:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217809] Core frequencies do not float correctly on AMD Ryzen 7
 5700U when running on battery
Date: Sat, 27 Jan 2024 22:32:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: soren@stoutner.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-217809-137361-03pPgmKewG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217809-137361@https.bugzilla.kernel.org/>
References: <bug-217809-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217809

Soren Stoutner (soren@stoutner.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #2 from Soren Stoutner (soren@stoutner.com) ---
This bug was fixed in the 6.5.0 release.  Thank you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

