Return-Path: <linux-pm+bounces-7210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 419818B3E2B
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 19:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CF61F283D2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B0171664;
	Fri, 26 Apr 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUYx9Seu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B616171662
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152315; cv=none; b=i8a1SAcSQhMoRj9q9M3uU8VdFPkYyDJrMn1g2Ci5VoqpUjgQB8cVrq0B/RiMf7sGPz6d9ACk23avCt/AirIyOYRzsuwjhu7j5FwO6/dOf2636isLQhZ1bEUPhozgZxg7cot9HNmBvXQAswfQFqQenkuCej5u+9ZcjRvdb063cOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152315; c=relaxed/simple;
	bh=ea84UUnSYnofATogIhi6nip9FK2aLIJ3o343Vkginj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=usArL5NrPNFQUqMNAoLB9C9H7sOAxFsrbjrrKYwfnlwTa3jLlDD4DnSM4pQ01heWyytrayYIQQiU81MiweKfWWPYyqcPe2MdJtlxeBPfa6+8xtpm2cuhyce1ubtYwE7YF/xZesmXPKhyoD5geoULmq2cbZt55fiobUC8FylH1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUYx9Seu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE0EEC2BD11
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714152314;
	bh=ea84UUnSYnofATogIhi6nip9FK2aLIJ3o343Vkginj8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RUYx9SeuU31JG7PLSpsZCFQvJ6W9/92FwG4saGKC7rY35UjNbCJPFg0vvGM/92Vz0
	 Unwqz6uQOSJc6mVMZHqqwpz+lvj5DwFPjpkOtkbFUDhdQ7FmlcsH0PXlNbyLr/y1lZ
	 VLh1u5SpOEw1hIqCDcdZQjZEYqjPWY6OakiReQ2IV11gdZvAOcpeeeqewxBCtQRf7S
	 GogRzaS6delQm9xr+tZpaxZ+WyU9YxAq8v0mGlGaiiYmgurZrM0Mym7/VlxQJwHnal
	 C5p0kDACcTs0+Jcls0jSLd5BRp1umfDgpbMi9vIjOXORyV9FXd+DEKmHpLWE3to+7M
	 6qiXd/Oytdy9Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B6674C433E3; Fri, 26 Apr 2024 17:25:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Fri, 26 Apr 2024 17:25:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218705-137361-JVmju39f7B@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #18 from Andrei Amuraritei (andamu@posteo.net) ---
Created attachment 306223
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306223&action=3Dedit
dmesg with amd_pstate.dyndbg and amd_pstate=3Dpassive

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

