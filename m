Return-Path: <linux-pm+bounces-37337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD3C2F0B8
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 04:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DF33BF2F8
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243C261B83;
	Tue,  4 Nov 2025 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hkt7CFKw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F521261B91
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225145; cv=none; b=EmMTfRufx+hblEhGu2F14sMysz0hG5Gif/UItnXvgohTp7+6xPi1e/dzynIlECM6EgYWgPzWCZIY+NpETAFctR+8HRm40n7hFJpZiTCYSZ+5eZV8Y2iKDo6GXymGO7MXSVE4C5ii9lWRGEP8WqOMncE/4mA6Pu83FHZn+vciFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225145; c=relaxed/simple;
	bh=0VuvAxSgcCeuyy6TDnlu3HmCJN51+y6sMHz/Th/8DGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WFIXdjIdRyZCAGSLedMpTyzj/tOxCNV03/79orfqNJRfBl4Q8ue4JVs8w9YevrN7EzHlOTDf4J4BvGZkSQoAfqIayO36uua9AWKeDdumTaf50q97qHGiNS9994MqN9HDxog3UiQFD3aYUaxFUh9rHLmhLum7bx0L6acBCJSXEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hkt7CFKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B043DC4CEE7
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 02:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762225144;
	bh=0VuvAxSgcCeuyy6TDnlu3HmCJN51+y6sMHz/Th/8DGQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hkt7CFKweTpapeiKMpkIFUID/6dPfgn6gBtlGZz0wIMmM5lmCdPw7RmJzIFQYCZJ+
	 VH6z/wxNX/A/RQlVpwpzMqrLG+AFFKa+RxCfvTaplhrpdy4XXujlAmHk4nNXnEyOiF
	 anlzdFYZ8z443eS2C0Y2NeR7jdsS9bGwVNi9v4XLuzl+8RjYc0ZEy+5elmSsP+55zw
	 3lfXA1pXpakQ0ZIrirxTqvBF6OZvWEQ/sdTKJQG9J61zyO9UNw+njWBgSDAA4lNpRY
	 /Eq+keg0RkqNVW7jRPSFgISJiNa6++0OHeMp0dNC978j+xgjf+T5elusTrNm23T980
	 GZY7vbWb7Ee7Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A71B7C53BBF; Tue,  4 Nov 2025 02:59:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Tue, 04 Nov 2025 02:59:04 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-QWwv3O1jIs@https.bugzilla.kernel.org/>
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

--- Comment #15 from Chris Harris (chris.harris79@gmail.com) ---
Issue persists on patched 6.17.=20=20
dyndbg=3D'file drivers/cpufreq/*.c +p' was added to kernel command line.
New logs provided.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

