Return-Path: <linux-pm+bounces-3157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DCB8456E6
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 13:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EF41C228D6
	for <lists+linux-pm@lfdr.de>; Thu,  1 Feb 2024 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8695C15F312;
	Thu,  1 Feb 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJJbZH5w"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6B15D5CC
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789074; cv=none; b=MirRWwFFbUVWGGtRcCWXJAIShlyrA4oRWGkBdb2pUHrkTHuIfXGQ9/F49JV7TQHIIx9OKnL+fSW534e3zsV7dZZIzRF7YcVZQ+A6oGenL7vbHdc8MZYX7pjaCbBb0vjctdOrUfj/qoxvjBq1rUwkaBeWRApQB0E7I4GZvOAxIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789074; c=relaxed/simple;
	bh=+jISuYFvKGzEYPJWPPRkByzdN0OMSevZbBZq/47aatE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XD8yuPoVO/IsQ1nNQqkBBMMaFIxW8aOMOGHXuFZTk8HEI/W+EWHsRHPF264qGJIOKAVabeYDAn3xx1/2sYhwVR3N4uuvtX6b7Pa+PIrrQC6aBna9O0ZfmxpopgTb0eo9a2pLgA7smNzawVhjni/FpdYlnIDx4rrpSahyTGmNWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJJbZH5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2E77C433B1
	for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2024 12:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789073;
	bh=+jISuYFvKGzEYPJWPPRkByzdN0OMSevZbBZq/47aatE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fJJbZH5wQH3WHx75PZ9BnKsfNyQkVo2pCkTIxIUjZdKfLLUFcwEBFt5mgjsVUwpZb
	 OA1ABOh4vnJr7PvKg6PkSJ7VbUzCZXoeD8SmTK9gkWOE/XpVrTqMKh5YpycB7CbF+H
	 PVkisCI0PXL+97dFhNBHf0FK9Ld4SqZ0BgeN22no6zdMADgeO/Qn9gQF7/m6D4D/q8
	 OvCChXtyD08D0wlKb1PUQxsOnqmbsjfMXY8B00AsdGYlqqZVZzd6Jm0myJssIhrLlP
	 jnGARDq6mhZv6esyrrNG7qAJd1Wc/Sftc8Y94fwehCepVVE+5TRayh+EhfMuVIXk9g
	 1kWPaEmD/grnA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D1244C53BD3; Thu,  1 Feb 2024 12:04:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 01 Feb 2024 12:04:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-wqqrVN8Ivc@https.bugzilla.kernel.org/>
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

--- Comment #49 from Artem S. Tashkinov (aros@gmx.com) ---
(In reply to Mario Limonciello (AMD) from comment #48)
> Did you pick up
> https://lore.kernel.org/linux-pm/20240119113319.54158-1-mario.
> limonciello@amd.com/T/#u ?

I'm running 6.7.3 which ostensibly includes it:

commit c794cc65bb3eef3142bbecd48f1fd43f1fa8d478
Author: Mario Limonciello
Date:   Fri Jan 19 05:33:19 2024 -0600

    cpufreq/amd-pstate: Fix setting scaling max/min freq values

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

