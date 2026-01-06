Return-Path: <linux-pm+bounces-40335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F58BCFB356
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 23:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE5BC3020CDB
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 22:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0F127E056;
	Tue,  6 Jan 2026 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="US1+Kp+Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB2320E025
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 22:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737361; cv=none; b=WB5JSrTHtnDs1YBh2TcuKWO6J326i90ONlWdmP5Hw982zP0p+1IS8qwDCqer/9WQS+KUcMPaYe/PQpjjb3akfKCRy0V/vdSO86Eoqool6FoG8TMSOrhFHorD5Z33VP74FexRLs4i69QqFI6g34XkKDjySmy9sSZhBxZPPa8aCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737361; c=relaxed/simple;
	bh=jQsBfSb6DJKgJHP5mOf9ELx9cc5chxkZ5HKHA/PmJEI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VRhUKhQDJlzeINxNohraUKvZFLSo29sm0VSPtnro+6Dyo8Ic8MSltYA1bitVkj2eqhAJZLj0RwPT3GV8RYdpgs+aV9/7aHBvbt9G0QcH1FNzhPFRaAYY7JXGCrhyRwZpnXsEW9/jbjRxdkpMg0zqEiMLIZ9WSbXzJz42BsHU624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=US1+Kp+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84AC1C19422
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 22:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737360;
	bh=jQsBfSb6DJKgJHP5mOf9ELx9cc5chxkZ5HKHA/PmJEI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=US1+Kp+ZHFQdJQ2a6zVbz6yLlO7euFbLYrW3kEIgvrvhd833p5Ey4e4xto3zd4yVL
	 ePghkFu9tfgqCpHSSIuPO6d8T3c8bPu81cJ58N/4Vs0DwHyxr0pGcJX4NJvARE15lv
	 ockft2JgMG+9hHBmysAC1HPRQYoIWVV6AOy60feLJ591DVcFu70eCTHllMEZa68mt3
	 GuOLsySvweXcyhV6ovxDqiushEXOD9UwQyjtMJDVJlqYvE6ocQhZp4h4zC/XKsy1uE
	 zPZfnEZeqpP6EKobYwLw1PRZD+XII+A3zEoGO3/iTvEcSZbZzXeWGwjwCgi+DUfLbe
	 HFgko/ZqZ8XEA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7EBDAC41612; Tue,  6 Jan 2026 22:09:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220946] hibernation seems to be broken after commit
 bb31fef0d03ed17d587b40e3458786be408fb9df on v6.19.0-rc4
Date: Tue, 06 Jan 2026 22:09:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jpeisach@ubuntu.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220946-137361-xZRNveZ6RK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220946-137361@https.bugzilla.kernel.org/>
References: <bug-220946-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220946

--- Comment #5 from Joshua Peisach (jpeisach@ubuntu.com) ---
Created attachment 309134
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309134&action=3Dedit
acpidump

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

