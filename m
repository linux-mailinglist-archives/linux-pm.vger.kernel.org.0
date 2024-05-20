Return-Path: <linux-pm+bounces-7999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836998C9FA4
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 17:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFCF1C203D6
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24799136E26;
	Mon, 20 May 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YULAkX04"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF44136E1A
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218787; cv=none; b=pLCaG0w3cFq1rwwi1IbLfIDVgzThrJdrv2cLSqaDEc+Bb8VGl2ep5isdV0vReyWbp83m9Cr8t9VDEbijm3gR6L76Hq1bjuHF48/NHZja25AyGhYBEb6ujjpwN7fjP6hpfkKlJQ5ylPOCxpcARvevcZxGQ/8wrxoe8odRSErRwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218787; c=relaxed/simple;
	bh=v32zhVEaXS3AwZcX+nN2+alW1RWNxhAbTkEVOkUfKkk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDmoZ9RUUqByXJyAYLGIYiuOn+/1cY0qZHPIQt+cd6rVrkw0AqQRDSAtbHSqHZNqbIw9QEyT5lk2Ou2ZKkpGDJkZQaBo4RIIzOxS3ZphO5OYn2nQbeDGCjlAEFYBWtuoAKQ7YpBBtJsUW1RzSSrU3XFxaXxdK9YE6YKGl/1He5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YULAkX04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60EA2C4AF0A
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716218786;
	bh=v32zhVEaXS3AwZcX+nN2+alW1RWNxhAbTkEVOkUfKkk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YULAkX046tNTSyy+oCa9w/JBs6rLiBAGlK7NVP/AkNGg9Z33UyCOxNg1itsfBo5P0
	 t5QHROlX3p76+bjQK/F4+CYErge/O+ozIgCmQcTLSZv+7TdZ6wVsg69k7PFj1j4CH2
	 ggHY5lTtNag9qZE3wIgvxUVkaWWMud2hBc4cc5zQakTL6Qty6dqis17sdz4zHOnQE2
	 bko2Xer8/H5LlRFmQCaD5+krERrbW5twby4WzQhQWW01mA/8/YFPlYpYlbJIQg/ity
	 Uxh2TvXsZdvH2o588uikcjate75nCUqoo0uOwIGEphnNi0rnqAkWxGWJAsEIb35HMH
	 9JeMSVUx8pYCA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 50A03C53BB9; Mon, 20 May 2024 15:26:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 20 May 2024 15:26:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-c4Jdu3HbEj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #48 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
The BIOS release will take longer time than you expected, it is really
depending on the customer request and vendor schedule.
Anyway, I will check from internal channel for this.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

