Return-Path: <linux-pm+bounces-2405-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 316688331CB
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jan 2024 01:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B404BB211DA
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jan 2024 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034419B;
	Sat, 20 Jan 2024 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHE7EeiH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713C170
	for <linux-pm@vger.kernel.org>; Sat, 20 Jan 2024 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705710051; cv=none; b=GpyzQsl60V2bQVWpNglYhlyuD60i9G3AmHgS8BJ8UE6ANOrvFodZ+EhGB0Tc0+QyA1EbVIC1isWmzBqMYlBiM6IcEm6b9IUhxc1oD35rjwhi/v8B5WDwRpYeqpoDINYbakoEjglFMWZXVf508xlbt7NZLUUa0OOzwUfC+30SBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705710051; c=relaxed/simple;
	bh=mBIlz6wP026VDSN2eVlZfX1vucecYmy8r53/lA5o3VQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BFOTMQQtm8ZItQNpzAvt60R+x85DmdjUlluXUdVM10wbW6oqa3dxlgJJtDLm2FA7xgktKMCTaifoaXxObb9cgRqP4OQfYNlUkFvSWjMdCk572cgwkTeXVa9yUaWQr/kRv7zrDFJ1gkzKN3JNwpZZxH4KyTtKYgV0p/Q7mSOpZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHE7EeiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A1F1C433A6
	for <linux-pm@vger.kernel.org>; Sat, 20 Jan 2024 00:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705710050;
	bh=mBIlz6wP026VDSN2eVlZfX1vucecYmy8r53/lA5o3VQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CHE7EeiHkw8CR3a4RSpze2FnWiMT+cr9/+YbGHKZ3rihjt9MOlGTk1Gg0fy1iiDAh
	 TjKJ6iFxU4R0Yhyt/8xJ0zr/9l8oR7I9yek1oyqhwnbJJ17goQtDfqqFWynxf1YLQI
	 ms6XrBANXQIfBkvNe6OYZS0cBaGnzKHVujibpG1TgrXiU7DlHks2BRehk0NpRcv1RZ
	 6wj0lTAftMrWlXibWUsioQPQjIvFY5196cQ3gtQTk4aaT/1wA5wtamPy5ubjeXW0TQ
	 p0K3fHDGQo1XKNLZn1FS0Dcq0n/RAV7UywpApk+hKb3XMm9XGG0NMljfWeGRDnJ17Z
	 RFVJOnBXnfdPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 44622C53BC6; Sat, 20 Jan 2024 00:20:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Sat, 20 Jan 2024 00:20:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-eFRw5R1SdV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #34 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Can you guys please test this:

https://lore.kernel.org/linux-pm/20240119113319.54158-1-mario.limonciello@a=
md.com/T/#u

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

