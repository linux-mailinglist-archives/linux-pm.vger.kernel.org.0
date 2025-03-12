Return-Path: <linux-pm+bounces-23929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECB4A5E404
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 19:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758667AA968
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 18:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E172257AFA;
	Wed, 12 Mar 2025 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA6wsZ0H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45A256C9E
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805936; cv=none; b=H2wJSKO7+6o9uQjlvY4oTEkJy8aAnCI9EtP8IOVujvO5vYW2KQOrEIh/IHMFSfIrt2uIYnptgtDdfbT3VT616/OpddGcDzCbwX76v5riPxLurrbdrGkGG9RMTcrR3Azwkcde2PGdTNHBkakjhWQyjdBMQF29UH8d8K/IZ7ZerCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805936; c=relaxed/simple;
	bh=ZHvLhxmWif7IOlWN0Y0G1KtGJEg7dHyn+7apdPVnH0s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qiMLQXcZCKaTAURJIFNSoi5498W9QneRdHs/JRgGTwlXHZ4bgYAS0cCjuEic86pW1pCzz+aOZ53rHDnpWR+ag2WO73IdQCxTHPHCy1z7HBKRrPQS7UFWiFxadX1sijWmxrEs9fCsintvRfUEZuwbSifqS0SUFHDEfGyEQXx4ykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rA6wsZ0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74A60C4CEEA
	for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2025 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741805934;
	bh=ZHvLhxmWif7IOlWN0Y0G1KtGJEg7dHyn+7apdPVnH0s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rA6wsZ0HLmyD9LBysZTpmqM8enMUQJ4WOAUk8ylbrvyLNz8xtEdRfLGZafsK+umJE
	 Y0zDfIbkgbxT0DBH1JDhouIzZsKxNp+8ndQQgWGoiWN8XUbyqlZkDdvg+3XsfHmidE
	 owpQsE1OAFaJvgZ2BR1ki5XNmaDmuDZWNYlXtnfx62v1+eH1X8jyZcIr+SMffqPSn0
	 7WLEmQW2zWtJjWJbn3zP8JH0QsIBBuoffNkjqEyc/VZVMa85L9vc/zcDymBIohlQyh
	 2fjH70WI3ZBVcGr+EzSW1edf2weUg2K7wiWzgVZf4DpJHdlTsWeOU6SXxvjEqAdC2E
	 6HWCJJuL9XOMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 68060C3279F; Wed, 12 Mar 2025 18:58:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219858] AMD Zen 2 broken power management after sleep
Date: Wed, 12 Mar 2025 18:58:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: diogotavc@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219858-137361-uZrqQD4oBr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219858-137361@https.bugzilla.kernel.org/>
References: <bug-219858-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219858

--- Comment #1 from Diogo Carvalho (diogotavc@protonmail.com) ---
I can also confirm this is still broken on kernel
6.14.0-0.rc6.20250312gt0fed89a9.350.vanilla.fc41.x86_64 (from
https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories). Here's a video
showcasing the behaviour in question:

https://youtu.be/jtBjuvwax_s

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

