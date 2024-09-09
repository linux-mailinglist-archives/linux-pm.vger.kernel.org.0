Return-Path: <linux-pm+bounces-13913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46BB9724EB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 00:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4587A1F249A3
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 22:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9018C35D;
	Mon,  9 Sep 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHhIwByu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273920DC4
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919562; cv=none; b=cN3EJCf5b5uMDerALno8ONQh9ejITJXPY0p8Ev7zuk/VoCDXIKHs7aI3WjJzYMnMspu9JapQgy7zotY9uc0JfOk5Ao9wxmaV75Y9lQv/hbgr411brXIXZB/82sliGnfPG71FHtCFH4o1+M9enzMBIa6VToGzNdSZY/SSEwhoqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919562; c=relaxed/simple;
	bh=gbX6EaoHhWOESmIp9sQhbOdKH/p2Id6hdbipq2RBYI4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CauPwusx0eSJVi0E1FN07xoTM3QZIYxCzjocCUjV2OlytFtKct1jXMzeduhrIUUXB4Zj+3Kff4qG3BsoAoD1pSITc91WL7LnWUBagcW94+svpZsFlJlMr6+LMvmmDTpCgeDpnWtIuc6b7DFlkJ+pUBQOBr2t8Tv1xYXqXRdVTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHhIwByu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D40FBC4CECF
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725919561;
	bh=gbX6EaoHhWOESmIp9sQhbOdKH/p2Id6hdbipq2RBYI4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KHhIwByukOqi7vpaB6Et6Y94ApUPmOKFPiw3Q2VSVW8WQkWWEQHoHF3YO4OjWO1BV
	 YF2d67JUFbmpkcQ7aRGgUJWcoGr4+QlZVK1PSm07POxiivQ2XJzRr/2dkk1uFCac7s
	 yTsrdliKbAn3rT4EtYZiX+3P3TwUfVOMrVK5fMI00ZC76ExxcggPI5lgen1+0wxD7t
	 WcFS6oUfpeJkiT4rhN4VnuwrKtgmXy6G5/EG/x+4cFegafUs8I6jZEa4hzegOZH7yg
	 9CxQn7eAxPF3yErW9D/dOrTrd4OnfsWLjJBm6olYjwPVtWhemd36Ygt+SXW8zOQHLY
	 bjms4mTPrI48w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CDDC7C53BC9; Mon,  9 Sep 2024 22:06:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 22:06:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vderp@icloud.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-FI490cucLP@https.bugzilla.kernel.org/>
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

--- Comment #91 from derp (vderp@icloud.com) ---
also, smoothness of system animations on power-saving profile has visibly
improved (like moving windows in KWin)
it also fixed an issue with drastic power draw when basic GPU activities are
started after being idle: like moving windows in KWin or scrolling in chrome

it used to quickly increase power draw from 2W to 5W, now it increases power
draw from 1W to 2W-3W at most
(as measured by "GPU Power" which is I guess APU total power)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

