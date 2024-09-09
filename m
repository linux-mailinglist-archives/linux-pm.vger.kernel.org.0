Return-Path: <linux-pm+bounces-13909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3309A972465
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 23:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F132853F6
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 21:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9885318C351;
	Mon,  9 Sep 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0WvJubM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341F18C344
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916700; cv=none; b=HW2YK5d9u1n+VXiavQpxAgFAaRIOUUUdvyaQoPVYRdddaNq5cO1dhFTMyvksLDTLEcJElYRZw8a5lit0lVWRZOZpOScG5iAx7o+2L/h1aZjUkbMwIGuLlkCS0303OtI1PogrwqpJJM0aHiUWzSxMM89Mkz3akZYMbR42Is+BTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916700; c=relaxed/simple;
	bh=0GwTSh5uVnkINoXceWfUjfNwd3qlWqHvU10OeuT4fcQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D6GtM3UQWoBIM34nGPUZ5cU6LmFA1OlVwBTFSXWs1LChVnEHlkfbF1ZNq9AkS4g82G5Vsc0Doefmpyz5c582cbufvAM4NccrWiJhMiOso2lM1B7vlnJSbH6qHowe4vJ3OlrZLlf1HASNVA5bUn0f2ptd4FWp8B1GyfL76i4KByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0WvJubM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 512C4C4CECE
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 21:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725916700;
	bh=0GwTSh5uVnkINoXceWfUjfNwd3qlWqHvU10OeuT4fcQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Q0WvJubM1ixkHqewVzRzFKiZo4ZMAe89KaiTSSs1nJZ3aSd0K7kT2gq1LMZgW2gQe
	 7+u7JiwuTQdbTvjmGW0iK4xsXqUy5FGvijgwVw3aCMOStkr3Iv2I9CbVu1SHK7lJFo
	 FK+LEJLhJaZ6/sIbQpXoipXlgtBziG0wFvVUOrrfkLpxh3zExjx3vIOv0aLLyUEBXB
	 NC48RhpX4D2FX6muEEZgu6wea8wt+5p79LbUYNQj16IzDv6WanJ6ShQGaI1vZoC5+L
	 ej4yzt5nYN2/wYLyNHACYNz6W0AzM7/gSODivkL3WJYrPLzAXe6j6F39lk6bbB422J
	 D1QIwnzqntXEQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4BE62C53BC3; Mon,  9 Sep 2024 21:18:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 09 Sep 2024 21:18:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-218686-137361-LYXjWuKKja@https.bugzilla.kernel.org/>
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

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #306842|0                           |1
        is obsolete|                            |

--- Comment #88 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Created attachment 306844
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306844&action=3Dedit
opt EPP register writes from FFH (v3)

I'll re-open this bug to see if we come up with something that is upstreama=
ble.

Someone did some testing on another bug report and found a problem.
Here is an updated version.

Can you please share the kernel log with this in place as well as the cpupo=
wer
output?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

