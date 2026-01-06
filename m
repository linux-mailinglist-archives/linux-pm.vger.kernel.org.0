Return-Path: <linux-pm+bounces-40312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8280CF85E4
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 13:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB51A3179261
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 12:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DB630DEA4;
	Tue,  6 Jan 2026 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkajyV2G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158E2DA749
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702860; cv=none; b=LwrTbt9KDbJrHlFJONtuKR1ZN1Td30nQme8+eMolZHIJN/CMwT5BP0O6NTQHDjB+MndB5NaoolQTHjr0lluNIRtI/Ii4FCJY7jwaOSlAr/ohYmPjkesbiZVpetOSulOezjBLRV8nhYnws2I5o24TzthyOMPUgpoJxHe9BjE0jVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702860; c=relaxed/simple;
	bh=rQYUwWrpR/woyLHMXaUK+TypG4aFba+oCUjAJcpdcqM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPnb5DPRKEX/7Fk7yCkHEDJiHeBVJWvVYTaJ/RLE4J3YNVjLUgXNu6R6qqf8KaooPajrs2WU6NVb/pzw+MhXr8kMd8YDYbYCs02MVGf0oac5XrRcRNscyVqVQAHhtICd5sYYwUMzylhcf+7n9nzlpNQ2b9Bx30AVjGINhjf2KFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkajyV2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CD0DC116C6
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 12:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767702860;
	bh=rQYUwWrpR/woyLHMXaUK+TypG4aFba+oCUjAJcpdcqM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HkajyV2GslEMxnAmnBRXgRt6xweF02qJF/cU2HXp0x+Ru5Bl59App0QypU4l+e+9m
	 7HcvA8CMJNDWn0Pe9kpuc19EE4zItFrrjviZ76sVIuLEvvkQ+pMT5Zu9BdqRmgSl3M
	 bTSASEoxLFg/dSNnmB1/+Ehg5YWrj7/FUUcEkBP6mS3WttTgjMOCQb9C0vLLKB84wj
	 BAjRRHrkLuRLhI82eOoxcb0vgNaswEoFtmyraEM+NrH4wCPhwzw69D0WkLjopCQWxn
	 rsvrzfD9Nk7D5WdFRtQM+TWVzm/O61zVCoemTfGVX629iBcqTwOMI3+0CzfbYq9yl+
	 RXxYhYDbXQkyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 31AF6C41613; Tue,  6 Jan 2026 12:34:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220946] hibernation seems to be broken after commit
 bb31fef0d03ed17d587b40e3458786be408fb9df on v6.19.0-rc4
Date: Tue, 06 Jan 2026 12:34:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jpeisach@ubuntu.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220946-137361-BdC6cka1WH@https.bugzilla.kernel.org/>
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

--- Comment #3 from Joshua Peisach (jpeisach@ubuntu.com) ---
(In reply to Mario Limonciello (AMD) from comment #2)
> Two things that can help figure out what's going on.
>=20
> 1) Can you please boot the kernel with dynamic debugging enabled for
> amd-pstate and share the logs?
> 2) Can you please share an acpidump for your system

Sure - when I get home this evening I'll do so. It will be at least 12 hours
though.

> Also; I notice a really really old BIOS:=20
>=20
> [    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./X570M
> Pro4, BIOS P3.10 10/26/2020
>=20
> By chance anything newer you can apply?

Yes, there are newer BIOS versions I can upgrade to.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

