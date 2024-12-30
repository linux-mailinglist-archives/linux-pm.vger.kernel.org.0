Return-Path: <linux-pm+bounces-19842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03909FE4C4
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 10:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B4C3A1A30
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070351A23AC;
	Mon, 30 Dec 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqouMV3R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F4419F489
	for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735550435; cv=none; b=hhFwsJe8okHrtdEP3q0Fz3oLOVBA73+VKYn3Yh+w0k5aCwHo9m8IuJmGbfQCVppHIUOtUq6+i3mDearwj9klKzaNSvcm3o/MCDKpCMXt3taEvAcuuWChna/Q0UVRqff16a/FkH3L8tf2jMrFpdqvHx8V2I47sgm/vVIMW2GosoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735550435; c=relaxed/simple;
	bh=M3Y6cNPkMpkYeiEu0IRKgzqXsCExyd+eexG/yAk7qsk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CvwvRDkw2QAmsDGQc4Ej4ONHf7wNiRM49geTE2SiulhoxkgocJ+POkRqu1H9JQBTipdPKOyPv8t3AY1rKnlejQMyX9z0mPLXVb+PkfmakFOWukIYKAbInikOcwTD5kmxWcstWDplgZHp8Ccr+EChSaRUI6rcM67F7DNN3lwiQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqouMV3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 575D0C4CED4
	for <linux-pm@vger.kernel.org>; Mon, 30 Dec 2024 09:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735550435;
	bh=M3Y6cNPkMpkYeiEu0IRKgzqXsCExyd+eexG/yAk7qsk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NqouMV3RvicqAMq8GAIkvDhsp0kYl5zZxt7JJOQsGHtz1mSAubOQ3DWOHgGWM2Z5F
	 DJ9m3eB37g0PSun52/pYe/yFa3/+Yh8smw5gNf49Kpdail155C5/AdTdFMYd0ZITGu
	 DGclfDp8qG20bIGG7gOa7vIEhxF+d0wblTQ+6WXS25Ne3IJrsDrZKwbF6ux7cahbA8
	 a8n48nRSJDOx5jHGirBIe300CEnDvlrWS1VgOq3GhP39x7uXbU70qUIfOIXY4UqGIc
	 sSKug9yZ8cD2WqWZUeYtDfmY/oFZjwNKE9ezUFzBAfZR4zQSOCHR0Xm9ELd2pS+x6L
	 cDNFj4dYbnNsA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 42C94C41606; Mon, 30 Dec 2024 09:20:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219640] Preferred cores working incorrectly for Zen3 CPU
 (regression)
Date: Mon, 30 Dec 2024 09:20:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sobrus@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit bug_file_loc cf_kernel_version
 cf_regression
Message-ID: <bug-219640-137361-aRHlO5jLj5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219640-137361@https.bugzilla.kernel.org/>
References: <bug-219640-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219640

Sebastian (sobrus@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |39311a230e04eab2fe7e257ad79
                   |                            |922040bfdaf1c
                URL|                            |https://discuss.cachyos.org
                   |                            |/t/preferred-cores-stopped-
                   |                            |working-for-zen3-cpu/5108/6
     Kernel Version|                            |6.13rc4
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

