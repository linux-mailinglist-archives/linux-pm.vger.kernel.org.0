Return-Path: <linux-pm+bounces-11253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA51937711
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 13:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1098A1C20B98
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED10824A0;
	Fri, 19 Jul 2024 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOcYL4V9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DF383AC
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387805; cv=none; b=oG701DlmWPNmXZZ/ZwWjfp783POQ+po8Lutu10VWP8azUn751HTlSvJJAzGlu4nYWKdwqlyV4ZebhWPDpi18s3E2qcyST09dJkJ5kTP1SHor3hvFNcwtuXSTYtpq0QfLmQmqZcx9OYkyP8iZP8HkuEDFZeoRpR4tdIwJ2XFLKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387805; c=relaxed/simple;
	bh=9Ure2xYIO0/4Xev8OgbqnXVzY5lETJZRo6t8Na6BLuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AaMm+iwcxQcbtSut8YaVsbN91A1kpFaoNUmGjpYJVWReBL/vhGVqD1HOOeg0GwGybSunbDrVz70fPqnfqD0fgGOneM+WuvFmrk2SEUwKnO00DvR0jGQksOkrHR6wg57LUaO1EntA7Yhwa18dbtrql0UjAWGa6YTCOkMFeN1A6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOcYL4V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDA8FC4AF09
	for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2024 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721387804;
	bh=9Ure2xYIO0/4Xev8OgbqnXVzY5lETJZRo6t8Na6BLuo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kOcYL4V97GJKSTnWf+5HL/rEzzNAePV3q1fY57bxnavc/fHbCVbfSuO2xXxabN689
	 gjnBmlxTr1RI5F7CQAXPl2C6i2aFXy5xkFvGmT/JIAsLFWWlnGf88NBbbv9P+ycaTX
	 smT7Rj8JbsSkVlzJXeTCXRCxK8it0v0wSS1fcA/yo7zogPXyZBeaCCAqFsxoCxOKYv
	 x29qyuFFM8b+1hmG2Z1wAcO2AjFC3CPZ80QNsp9I6SwD30GZILHwUR2v4qQeqYKGfq
	 Jvgnv15ERzUpI0v5oqQO0FFkqLrf/3QmJ9Q/0fsNTdJLTeR2PO+8UKtoETHSOSR5x1
	 ZImsSvZQZoi3Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B4DA3C53BA7; Fri, 19 Jul 2024 11:16:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] amd_pstate=active reset computer
Date: Fri, 19 Jul 2024 11:16:44 +0000
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
Message-ID: <bug-219051-137361-huRF5pnD8B@https.bugzilla.kernel.org/>
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

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
Mario, any ideas what is going on here and how it can be fixed/debugged?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

