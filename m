Return-Path: <linux-pm+bounces-37245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D30C287B6
	for <lists+linux-pm@lfdr.de>; Sat, 01 Nov 2025 21:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC853B7931
	for <lists+linux-pm@lfdr.de>; Sat,  1 Nov 2025 20:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB51222D78A;
	Sat,  1 Nov 2025 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzWuxoyf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8619F1684B0
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 20:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762028347; cv=none; b=VJVNemaFkOZKNV9fQD+HY795LwXAeikpIHpEBc+Uk1c5QNd1xTWQdp9Gks5ZPO9vG5HUwadC53oG/YllWnzUgnyVjLERuzXIN/hw13Sdgqu7inZpOhyWpMg8LYXqJNXRmbJ6p2ONGdPt6SYXci3UfJrN6QXg1GdhiBV/md2oIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762028347; c=relaxed/simple;
	bh=DAVgnXhAnTJMQQUdNWjo/0W+kXN7vX16P5oen/O19/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jChiM8NfGU5G3E2Op7Dl9RPyE+0KjKux2VfT4Ry6g7TCl8Auf9Gv5wGNhjbO6wVxe7wjNrG87fiLLqM0VsCUMeBPDFkGfKHoWPZzlGDu0XTepBxoqN2ngfuGUUDUJZ4ScEhg7EHjXFmp4qby8PmodmwBZ4vfFMfQ0RxHNopoE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzWuxoyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6F54C4CEF1
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 20:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762028344;
	bh=DAVgnXhAnTJMQQUdNWjo/0W+kXN7vX16P5oen/O19/8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UzWuxoyfNjJqV2Huf0Uh5T+GsYV26oFp8Q7PrweOJ5ju1b8ctoAS3Sd44MtO7ze7Q
	 0A46wN+VQOdF/M4loSc3o7MIFyVqF6jSqbfsxELVCLKK7uozqoNJ5PI21AgX5zxQbC
	 bH9VENwuy3r4OyUMIWUFcuJ8RJ06kr4d1lJYN5Mys6ZMDvXDxOhdl3Wf6NXdGYxV2I
	 rcpxMdVJDV9+sN2m7ZdxAhPiE1lCVjvDmBICHwCAK/pBHnGPNTEFIRCe/nned06OkY
	 S12wQgmtV1VDrqB6uQlwd3ApVFZc79jD4G8a9gey/g1xjFR8pnxlTHKLGh7rHd5KdJ
	 SiN2I6LrAhqig==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D8DEDC4160E; Sat,  1 Nov 2025 20:19:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Sat, 01 Nov 2025 20:19:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chris.harris79@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220715-137361-Pd2XPRsISp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

--- Comment #3 from Chris Harris (chris.harris79@gmail.com) ---
Created attachment 308879
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308879&action=3Dedit
First Bad Commit Contents

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

