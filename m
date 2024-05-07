Return-Path: <linux-pm+bounces-7580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CBB8BE1EA
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21004287D0D
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25F156F48;
	Tue,  7 May 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUyha3Ob"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D5D156C6D
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084474; cv=none; b=uI9WquNLOYMEdHoxwblBTXDlftriG4ea8FKXq9tuOoygYxm4Ho3qsiA7JoHHbNzlVfGdXXJkZjUkZrCSNt0l+VUAJ7LpgQl/6XjWvVjEkKKXuB+6N3wo8ZVQKXXbCFNqswWPTBFLcYMk54CYgp5SLyU//c8uCje1wI4bBeeQwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084474; c=relaxed/simple;
	bh=1DIbZ+qvArkWbOEjUYzoaSh730sm5n0TqzY6/fRUdRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SdkMp9xBxEopGqaEGMlSczfBdwFHXPvDF5isSpFhshesLHd8KNyRZccD9l2RoOIHaGHYJGcwL5QDuGfM7mCfK58/7GEnQvZmY7kGwACXckZDr+veb3GFHFCeiJKLEy4jp/lPIo87UapbOnFxamfOadNx2ZBGAy/QxHGKMMfBwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUyha3Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D62AC4AF68
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715084474;
	bh=1DIbZ+qvArkWbOEjUYzoaSh730sm5n0TqzY6/fRUdRo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BUyha3Ob6SXw1k9TZh/N7GcOmdcitA9Aj0QvZSMaEfhcmuPLVwFW01/EDekbAaxcR
	 4KGcqV0KOCfeWhuqemL3YlWiZdfx5DARpD5jEkKaTAEgEbIAfIVC5ZC34dngG4a7/S
	 VEU5eiP2tvUSVIPxyVOCxSR6uCeWhlKh7gcXOxwhNBQOmqCD614IIn0jyMJlgtZn0J
	 XeXVh1tnCEBUXI+zb65bh3r3RhgwtT2a+fsB+p6SlHQ1ikQ/NilSTjVDrdSjsQwciU
	 VtOkrgxwZr1/PXkJloT3IyO9Yd7v1rPdBGFywnNabCawvR9wi0Ihxw81F6W8raVpb/
	 wVo8rvmXQLT/g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 44D37C53B6C; Tue,  7 May 2024 12:21:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 12:21:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-DJqW5KPVyR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #25 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Try to apply just patch 10 in that above link.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

