Return-Path: <linux-pm+bounces-25440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E3A896F3
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50701889352
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D741AF0AE;
	Tue, 15 Apr 2025 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyXm7Z9o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DF18D65E
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706543; cv=none; b=gf+BYjMrp3OJGM1iIKpqvW8/zOnuSIYpackrcZhOZD1yy+4Oq5N1AySErGP2ECOTZ8WESnPCsu+XPTjrBGUFlhtkOcPGh6MuVuFL1+GTE0dDGNPmhaZN5phkaGIzERdsMs9GZ2X3B9jEX5B2ksHPKxk8xQZBAsgscl1cbEe9+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706543; c=relaxed/simple;
	bh=3iaQ7EeXYBbtDdI/BkUXxHCuwAddsdvlHZpeEeRxxJI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JFZsk5MiXW2Jm6A24QvOtUV92i1yItYwCccHZuPRwqKddzU9S8hUdmpBBCqHFokfZcQryX/YsFKzA+PQxsjD1ymKiNoZ76cZbGrf7mdWTyI8ztCkALhMXc8NDM758mLwuc7EEwoB28DUnaN9NHvP206tanTHaZm9TlRC4QpIHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyXm7Z9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B887C4CEED
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744706542;
	bh=3iaQ7EeXYBbtDdI/BkUXxHCuwAddsdvlHZpeEeRxxJI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PyXm7Z9oweNA9cZgFBStZkLKSH52Jsrx+1l+U2KBiDwMa3neZ+R1/CvQ5fZWF8z+O
	 S7ZxqK7dV3lSnlAzifqziqtJMlGTQYV1C/QLd+aoZun1V3V07oeTk0XGzZrtc56aPM
	 /L3MEjUJSZFwbiWRGwiBi8KZPa39wEBxu4CbIxpimLueadxuGqUAh21RSuPdbBYYit
	 n16IDlkxK58Mm5gvTdbmAFTC9vgOQNxgVt/bQ3s1uldoCrXEE35RqAcPizFRCogLNE
	 YOeAwk1QKW+qCTW+J++ijju3G3fvbnATr8phQy+XdKGJ5KivVcBtDczMVtwaJwDO1l
	 u+qWfkijWA9ZA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7090BC53BBF; Tue, 15 Apr 2025 08:42:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220013] [REGRESSION, BISECTED] acpi-cpufreq: Boost disablement
 not being restored after resume from suspend
Date: Tue, 15 Apr 2025 08:42:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220013-137361-nWxGYxwkXt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220013-137361@https.bugzilla.kernel.org/>
References: <bug-220013-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220013

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |viresh.kumar@linaro.org

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
I cannot CC Lifeng Zheng, CC'ing Viresh Kumar

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

