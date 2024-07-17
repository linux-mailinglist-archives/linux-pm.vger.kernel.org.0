Return-Path: <linux-pm+bounces-11210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9993414B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 19:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4AA281C92
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2024 17:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA54180A96;
	Wed, 17 Jul 2024 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy0xu2tL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9617E914
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236645; cv=none; b=dH/hOX265+CNI+CTnUuzivJJrqIRHZsgkQxkQbmTJsflUB0Q1IlE2lzO9vHeidD/dN6HLpTUbeylH+f+0Gvade1jGFn2ilpDm95CdEKVTgAwxv6lAzyMee5zp4vqpJ3NVzUr8cBpFb0WUcDZ76mbda3FKszTtJeuQQhYCnAT40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236645; c=relaxed/simple;
	bh=60Yw3rAMqjLhHNvEmr3s9XcxfrP97QnInfgcJyj5m98=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qjHYIq3t8m/ew30iGAmQ4WYYOmyH0yYYcp6A409l3YpyXg1jGfakMiNZNGtEKREoWP5vVE30aF3YRfiT90+DBpInLplHpCO/tJ15WULr4uVzhmJ5f76H0BvWZrFLvmIKbZEVDZHn51GtVHaE02+8KrBet38nZgCqpSOo+WaZAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy0xu2tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEE12C32782
	for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2024 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721236644;
	bh=60Yw3rAMqjLhHNvEmr3s9XcxfrP97QnInfgcJyj5m98=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Iy0xu2tL+0v12xXLeWAXyu3DyaYwdds7U7VA3/ZxOOBiUyV45ZQFuWQ99NXszGuQW
	 XaRc9LVcw3ln3n3vNL72oURIyKvYdYTcT6W+SQYSppz7c/qw5SC22wb1ze5vrELQMJ
	 BT84mOvZymWBHqbZ0w1RKKzHv4fR24Ed1kjJcaQXOdMEaXSNweEApcKUV0PZ+pahuW
	 a+O8OQF6uNovs0yrbRPlYe2soTZdgGdVOEQ3LqZQerMCwo3KA0tzIBioeK/+OegJjO
	 XiAtH7soZhTa5oPdYtvCgWGIjIXPOU73JFkbsybgD70lJlcORkUgkrLibMDTb81xL6
	 omnzHDXPvX4Bg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A4B36C53BA7; Wed, 17 Jul 2024 17:17:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] amd_pstate=active reset computer
Date: Wed, 17 Jul 2024 17:17:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219051-137361-gVXiN7sTcI@https.bugzilla.kernel.org/>
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

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Are you running the latest BIOS version? If not, please flash.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

