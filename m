Return-Path: <linux-pm+bounces-16649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796329B4524
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 10:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300FB1F218B7
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CBB2038D9;
	Tue, 29 Oct 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp9yvecZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD391192B6F
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192410; cv=none; b=LRoGpd25YQbbvZkLcdkjA+J4oWXiko90psppwwxAe14U7eDXrRGeIO8rShl2FlLTvxgXR277HwDsJfp0EzP142UCeCzcVGlV+bOYXdkEgAGe68KMAC8rINFQX0pojsS9MjSTS71itPQ/ael/0iSG/8evu1M0tSbmn30nBKNKp8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192410; c=relaxed/simple;
	bh=3ZNbrgRRFqvwjIgmrHyemm9MKiYSWr7nZhfJ/16JpbM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yc7CO+5jyRGfT0rJp8JMjInNIVYEbec3EE94gpQO/e4RX3WWk9TKu9kywIuFBbjUCe2uyp1HwMRquQMJ3AuuAg09AFTGpfXMt5GmnNCrX1Ux04vUM/MJHtYyvD7gLLSXQ2+oaqa+PWpOerV2p25OGhBkxoyYfmV6fV1XiKT+8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp9yvecZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 362E8C4CEE3
	for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2024 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730192410;
	bh=3ZNbrgRRFqvwjIgmrHyemm9MKiYSWr7nZhfJ/16JpbM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wp9yvecZmvAnw9LcPdpfjwleGdK0cuJ9OuAh+BOZbRHEYJUbKaoQ7rMrC4p5wFFOj
	 wPI19TI63lgOaI2ntEc0v/Y344cweq4Q16YlUwKWnV/QvM+CHyVIEwNe6pPBL/Qih/
	 X75uo1+CnI4IzWUmvo0hWN5S51Z3epZZvgb3u5Z0Maa5zMMPp/DdXMfr5DQw1tn7L2
	 7CD1pNw9kqTlA8CVZqVoauVw88AHRzIE/Q4hDqbu0x2oq0v3kDaJUsa43pmgURrord
	 bbEUEf2/hXy6zm81TO6h8uy7TrzMKkCE2gFXUMDfGFjAqn1Ci0fSPn3kmTDtuHcU29
	 oGNhJNQnuN2zg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 27FDEC53BC5; Tue, 29 Oct 2024 09:00:10 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Tue, 29 Oct 2024 09:00:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandr@natalenko.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219431-137361-bv1hmlMeZT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #16 from Oleksandr Natalenko (oleksandr@natalenko.name) ---
The message disappears with this patch for me. Should I check something else
too?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

