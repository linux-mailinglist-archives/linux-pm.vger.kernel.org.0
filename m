Return-Path: <linux-pm+bounces-37345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CBFC2FDC5
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 09:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354A8425759
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 08:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6C3126DE;
	Tue,  4 Nov 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm51He3l"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A44311C09
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244345; cv=none; b=SPQIRhp5h7vH18WFsLJPvmUO9jNQ9Cz73kDKvGi5xmNHG0GG4qa3TuZOnKLmZgF0d3L93uyTiOiCepXxdBt8n0fJd4yVHWOgUUUjewZwSowp0rYSS0hPQOOSwREgeEl4zKnLTPfYbFA6xzGPbB/uU8jmN8XhMSkgD9coJ9XncSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244345; c=relaxed/simple;
	bh=Sf/IF4Qoc42mdlXOSjc9xIqIrol1Zul2P8BDlXF2AbE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpOQW6Udivt9/15c/qlahwWVkXk9GcCOXGC4GeObJbCMfhdTWC0zF/iHvKKGWakiy+DImCPzMxXXBiZdHiQg6jGoFkhVE179fZP4VzMbv4JgNR0Hi2Qd2sa91HGCfWa80fqs/uWezZ5E/LDUVJFLRBF8EepvjMCJsLKXoVTnv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm51He3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83EE8C116B1
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 08:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244344;
	bh=Sf/IF4Qoc42mdlXOSjc9xIqIrol1Zul2P8BDlXF2AbE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mm51He3l50VlkwPLq8DiRjFzontgjtHknUtCv/mJisdO2sYgoebvsEwGs8rgwCJRF
	 aKIPfYerbmqPNBGbUnTOR7raAzTXWkmzWYW/07O+a2Fkc6xRaY3ROVtyPBzxSDOEUU
	 FVQgB4Ub8t6gLxGIPXmTVxdjtFzfo0/vFCnsHacVR0jaklXUy91rL5+pt5Izhb8ptt
	 5iQVbrhYKzNOUqmWOIenzyhyyc/h2W9Vg1iLYNW8nBBY6SLq+y/EC4CJ9UdbXuGvqG
	 wb0BOolTFI8DyiD+hXgSGR96+j7cdRaOU/6h5aofDxoCyp39hDBh3oxyrkv34Wpdps
	 2iNKNN7ZzGkAQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7C408C4160E; Tue,  4 Nov 2025 08:19:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Tue, 04 Nov 2025 08:19:04 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chris.harris79@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220715-137361-qgUb1uRNth@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

--- Comment #17 from Chris Harris (chris.harris79@gmail.com) ---
Created attachment 308891
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308891&action=3Dedit
dmesg-6.17-prefcore-patch.txt

Full dmesg output with prefcore patch and full debug enabled

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

