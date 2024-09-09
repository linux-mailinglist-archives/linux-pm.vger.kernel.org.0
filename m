Return-Path: <linux-pm+bounces-13894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A7971D5B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 17:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81E41F2125A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634B118E1E;
	Mon,  9 Sep 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEHf5KId"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EBE17BAF
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894014; cv=none; b=tTiK4zZfAUYHAmrXz+9TgjPJrnIFPLq+ZfXkGsBIry9ZrPaf96Vj7FdB4MG78i/Z56hy1Ama1HsMtsNwziZtF31IoIezHg0AOx7kPd21uBo05NlKaYlA0uT/2XraxOzZNcVtKSB9zeKxUZ5z/jEwGL0Ah/UnBR2yaPK3GQQ7TSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894014; c=relaxed/simple;
	bh=jSJP0cWzQaYLCmpYbtxwnSRAj6/ApaqHZqOQPcJSMzg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWl5gjwjsNL6ik/LF50j/p/zA8hquEe5/xytHYFecMrIu6FNf6HAQF9/zeTTkCPgrUVMGksPcGI7VFoONFw8+eHnwaTA18mz7raWyM4QKPhyzTILyqDSk0sts3TByaBBRvANZ6Vi/FdmnllNY5jVbhaprbVfAkC9nSrYkeWGJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEHf5KId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0D8DC4CED1
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725894013;
	bh=jSJP0cWzQaYLCmpYbtxwnSRAj6/ApaqHZqOQPcJSMzg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WEHf5KIdTMdXPbmMYtyx5b9/tdbZKK7OWe7mrHKaADVcJ0Ac7BuCc3xOlMLWJuSE7
	 7RY2uPJH7O1R+6MTStXk01OtrKcAx/WX0icQNf2GHj3MlZPf7UXnqyYkK//LqZ01Es
	 dTDw9XJtVD1/vgCT3VwWBo1k96UXqU0pfuTuHHAn5Ra5mK3smeimKaWbBg5Cn1a3kU
	 wmF3r6pbJmYagbq6wf1c3kZtUFD6PG1dlm83ZrP/GaBDBU6Pf7W/+dnVXm1iEpkmMC
	 fFrgLtNtAJoVvCWFwoMB/W7p+M9xejs4MQLwXXCzhBYtk7y4ULKzkCcpM2QVyUt3uQ
	 5j76Oi4DgsCDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BBF89C53BC4; Mon,  9 Sep 2024 15:00:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 15:00:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-nO1Y9X2HFT@https.bugzilla.kernel.org/>
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

--- Comment #85 from al0uette@outlook.com ---
Created attachment 306840
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306840&action=3Dedit
new patch including acpi version checking

Do you think this is appropriate? @mario.limonciello@amd.com

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

