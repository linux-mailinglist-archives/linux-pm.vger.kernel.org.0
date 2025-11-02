Return-Path: <linux-pm+bounces-37254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3ACC290C8
	for <lists+linux-pm@lfdr.de>; Sun, 02 Nov 2025 16:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6DF3A6330
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39ED1DEFE7;
	Sun,  2 Nov 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZjz5NGf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1BB41760
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762096011; cv=none; b=icc65S52D2tFQ7iaiGrUhcIBQbmjh+x/xcAffAiR6kQSSpgFJjDVI4K4YyPqabomzjWxA4tqZ86QLjenZltb51MQS5EbQGW0nnRzSso4S60UvcU8mqFCqr0A/joqTPkhAsSxiubqgEuThkOnldzKWFLgzLyetghf3LIIvB6RnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762096011; c=relaxed/simple;
	bh=tstj7hRJ8QYmaiWsPOqEqGQZCH5735BfJJI8LLcuLGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J1QwLJxLx+QDb9HiRlzbhJTsS2NuixmPGKyNB/9b8D7uIxj6NMFr4E3sP57cMXB5EORZQX71v02l2vm9cDiOg984dCmEh2JhjNjk9tgl2Z5B5X2VsMZ04CJQH0p90vU2gdohlJAWN5kYoWCaQb0ElNdiTOg3d5jQU3nhZcHgduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZjz5NGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2F6BC116B1
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762096010;
	bh=tstj7hRJ8QYmaiWsPOqEqGQZCH5735BfJJI8LLcuLGU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aZjz5NGfM6p2psIPbPFAfb4hzrZEMp3ynLDE19A9iSgKRzCwYDjiPImZHNPfji8HQ
	 0CXceiJbUjVTbHYDHisYvQVmmkOWY8kvhh8+gasRkxs0daGwM8jhLGqkaZcGtGxKbh
	 kndwUlv+APObUU0iwiEF4vcDm+4MfH8vHhuaHaKI+sWacB+FIJVL4bYTYVSzf+TRze
	 zBjGhqgL5zBMUmQgNDIZBTSBUEIyodp1coWzqM583Ha0afd/Bi3AaZHgpG3rOGz9ev
	 ibjQzJp0D+J4e4vKbmpIPKueThC4su5S9F4VoNwh3WzWVNWF3KiIal2ccC/76rI1oX
	 shuElU8T7EnCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E6863C41613; Sun,  2 Nov 2025 15:06:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Sun, 02 Nov 2025 15:06:49 +0000
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
Message-ID: <bug-220715-137361-oyukcx4OxA@https.bugzilla.kernel.org/>
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

--- Comment #10 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
How about if you apply patch to a stable kernel release like 6.17 or 6.18-r=
c?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

