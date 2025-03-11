Return-Path: <linux-pm+bounces-23820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8CA5B927
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 07:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 338857A182C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 06:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D6A1EF368;
	Tue, 11 Mar 2025 06:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm3coyD7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB411EEA42
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674096; cv=none; b=opEKb+UiWFYzWEAUSpKVr+AMXYqPYw3BZYyArNirO29BTO+M2192rWyql0+XHkNxjwKGuNh13qm5jCypX6VWYmXFGecvE07SfLX0LJbkkg9aJ5sZeoSh21WBKfaxQMTPM3bsLe8RQgR+Ki0+9cLqR3LIvjKp9FCZkedvD4JauvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674096; c=relaxed/simple;
	bh=lec4eqLvXi351mFZTYihWRmI6HzvfuecGlm8qTijfEY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o/KtETnEkL+v5g1jYzTl/QaUyIeb33FqAmofJJtWCTVC0XEq0TUO3YF9GGAY+i/HTIIjQY9Q6a9a2oRTjaexawtA/498JIZVrCA+aJ+gIimjWkO0D4jlco7kHez4z32mqDMIOvFLBkuekCOq81RW5oaRgMN82sgJ3fMeBAk7Vew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm3coyD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E71B1C4CEEE
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741674094;
	bh=lec4eqLvXi351mFZTYihWRmI6HzvfuecGlm8qTijfEY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Dm3coyD7A74pe5seKLrgOlx4MH9dPFphxbJFYrAOMllSIQZbUGIFzr4L73fIdG2B7
	 9mwtFMjmyMuEMi/uUwxS8XmKbeQs5WHnR3o3puBTRJYI8ZGoWcWieWJZcjqDNMNgzT
	 jGUOGW/WOThzas/N+bc5tEdmdJeFH2kCiTYTFQHtEusIX6FnGNFhtxKvoARvnPWeRy
	 xrFHdAy9mmLFD0wuW0dQoSmOuUcQ2BjRqwt+H5RhpSYdlJGUOI8scjoOrPhR9sVYS6
	 Q3SpRcp0SC91xOg9LHxHFWiuaGigE2fIJxcjh470HR9BNUh1+bHh0o5v6g3tZadg9z
	 GvnFWyIvGCSSg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D9D7BC4160E; Tue, 11 Mar 2025 06:21:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219851] [amd-pstate 6.15] Frequency Scaling Will Not Scale
 Above Lowest Non-Linear Performance on Ryzen 7 5700U
Date: Tue, 11 Mar 2025 06:21:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Dhananjay.Ugwekar@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219851-137361-p5XIDkUhau@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219851-137361@https.bugzilla.kernel.org/>
References: <bug-219851-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219851

--- Comment #5 from Dhananjay Ugwekar (AMD) (Dhananjay.Ugwekar@amd.com) ---
No worries, happy to help.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

