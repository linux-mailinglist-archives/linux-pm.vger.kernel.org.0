Return-Path: <linux-pm+bounces-24848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E8FA7CC71
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 03:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3B7176668
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 01:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C8818E1A;
	Sun,  6 Apr 2025 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIEdgCbt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BBF6ADD
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743903275; cv=none; b=jh1eaSSnLQCjqv7AcVD8mVRLoWTLiMWlhMP5A/lZISf5SU+RtFrK0zBns7ifW61fPLzc8dJZljOpK45VNO3EkROljeoQOjqCxQQheUggVWTDZXVd9yIBXdcBUP+7R/1NE1lQByyIyYQcRui37C96hC4EhIfCnVRft9UJ6RIW+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743903275; c=relaxed/simple;
	bh=hvwrE8uep+19OZq3mbnT9MHrWTnClUlhFqfYoCtj/XQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZXWStVlNV5ch6nP8FgqDAYqqo9Cp2NwR4xbLEnw9o8657VwVBJnNCnUQl1N5KUoB8wNGffNOZSrXaITwWk1VkdW3BB5HlZbhqLa9x0K2MyodcCc4my/fNGDqoJIPKvMHnIp1nZEYwtY4lhls5Kj81Chci4CpD7KaHjIYv1tliCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIEdgCbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 930C9C4CEE8
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 01:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743903274;
	bh=hvwrE8uep+19OZq3mbnT9MHrWTnClUlhFqfYoCtj/XQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IIEdgCbtIpziA/LRQoLtm+otkjuqUfZsAX1XHkI57D/iugN5gZMZYQiaB8lSDJoe+
	 /X6NuvRjB+69F5eFMUegzNY+flKzwF/ppHsZn9an0A6ObvwObQDl+pkbLeKcnXmrj6
	 Te4snQmersDSKw/E3reCBM23p1bY2uiJpWP3/6x4bfGWDa/ZMKqTCw+vsy6hjrHhg0
	 lPtT3wL1e63UguwsPKdZ2e6TrITGEen1LHQAd02PC4CrqX4Iu8aouXNr8m4uPCuxxr
	 uqbRvF4zR/iljkFcVFNQ+ucrGwfhOs03wrWXjCkpLGfSeejbvJjb3zZsHM+85B+ftA
	 LhILDOYrYZNnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7A9E9C41616; Sun,  6 Apr 2025 01:34:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219981] Regression on amd-pstate suspend/remove
Date: Sun, 06 Apr 2025 01:34:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: mario.limonciello@amd.com
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: assigned_to
Message-ID: <bug-219981-137361-umuyPTnpuv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219981-137361@https.bugzilla.kernel.org/>
References: <bug-219981-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219981

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Assignee|linux-pm@vger.kernel.org    |mario.limonciello@amd.com

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

