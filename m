Return-Path: <linux-pm+bounces-7146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC8A8B2DDA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7684D2841AA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Apr 2024 00:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71021191;
	Fri, 26 Apr 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElXIoTaQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B084364
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090260; cv=none; b=jjdxEJu3KkKtUDWfGf9koJXXcdrlfSqtIdKifbUukxupIllsXZjY1X/a6mMGy5R3fkemEDrpOBdca+VVRTE1ZFQlmwy4msmBjiEv6k4uF/AmNO9RSjXsmsnfmHIyLGWq7chtHIR0Cq9wazerX7IqlYTnkv0gJEDz3E/5kKzgZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090260; c=relaxed/simple;
	bh=IK5BARUeNDKA8L9B+SRhvVUON8m8TePFAh12t8W4CaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KLqw1syzdzpxaUumZ5OeDQUn4u8l1WsAHfuQE/rywv0DUCvDecFQipFmPUmPGevXOJ+TAiX7uUyc/EcIn/9CRwkg7RVVKKrb4Mm3OpTT+Gr7zNXKHLU2jVwCX/5ILaSNEHKyWxK9UyCZfURA0HlRIWFQe70ush5xbegkjfbGQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElXIoTaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF00DC113CC
	for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2024 00:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714090259;
	bh=IK5BARUeNDKA8L9B+SRhvVUON8m8TePFAh12t8W4CaM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ElXIoTaQxzI7UNNz0vP3DLj2aF6PblDVFhI7UR0tCrevMrlVi9W4PCgU9OpbxbNK7
	 /IJTGx3S4p4Wg7PlnAdaV3N/zZQMgFxU/kXYbwlRVN6CSyisT4tUEWvhQhdoXXE3Kq
	 b/9y84ttFzDVmJC1DFa8p0vuF7ZiVUhxkT21L1OUkDg3KL4vUyzB0SnZxKFY+8dzVP
	 WHYep9oMpPcSzuOigTfYZu0t3VmqzJjUoNbBTKC0SuVIwTjwVpoP0oYhJ8I6HARO4L
	 e1AjqZNORnf4ixviom4Z5bTDpWO9l8I0TqsRLFuXbweJBfpjlwPrCy7XHaTBfaGbgm
	 023Cd++8Y62Xw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BEACAC433E2; Fri, 26 Apr 2024 00:10:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Fri, 26 Apr 2024 00:10:59 +0000
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
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-YmNNStrTfq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #12 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
This should help you get started on a bisect:
https://www.kernel.org/doc/html/latest/admin-guide/bug-bisect.html

If you can build a kernel you basically take a good and bash hash and then =
pick
a point in between and keep going at half way points until you found the br=
oken
commit.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

