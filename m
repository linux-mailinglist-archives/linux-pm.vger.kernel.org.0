Return-Path: <linux-pm+bounces-7497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6EA8BBA32
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 11:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E2C1C21029
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426D212B7F;
	Sat,  4 May 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCp918Aa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD2B125DE
	for <linux-pm@vger.kernel.org>; Sat,  4 May 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714813489; cv=none; b=EkI7N+Q8/mbg6+9trdP/IbH4e1xDm92rG2nIwWjt6YMgMy5yn0yFd8WAG+gV8LiNZXB2p+cZe/2CWJ3KkuJsbIBVZikKcpptRDfHOW37WmJgKmtNfLhCe6JARhSRu/RTR0lWKQKcMmv6WI5beop9THJhKIs6quHpqdEVrfbMuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714813489; c=relaxed/simple;
	bh=twzdoZMWl2CDW3XefChLvmJjMkcGCfa2gQjCknqtcRc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ghovti6FpjQH2oRNggj+tBhSoAhvPmLMjyaf+Bl0CxZtN9UjWGiSrEuKrdO5mhyQkp7PyO7mPsiSbjkge28kGa9ua/SpdzVJ3wmOxj2Y5oiLYlMjgERGjaofqpNXKVmIf/0ll4NZ/AyAhxANv0Ea0qqcF0zyc+RCVAyEzJiYW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCp918Aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BC3BC4AF19
	for <linux-pm@vger.kernel.org>; Sat,  4 May 2024 09:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714813488;
	bh=twzdoZMWl2CDW3XefChLvmJjMkcGCfa2gQjCknqtcRc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nCp918Aa7RaHBRqK8J4i0zRCN50VdtJLmwpRZm/DCbC5rsZ0naCH+hJtDQq9p7wzj
	 taukqIhKe/bN46TuhHqb9rMpTB4ctKpHGfJ2xE2NivtQBpEMO8tJbSKOIp0gOMuwpf
	 msLgwZxK31vQruU8YEIchzyZGib8PDL725olSllIdtC8suP01mwV45kK4bly93gf3n
	 szh0Gss80VtUa8o14vmLYpHvB5EB1XBPZcW7SPHhALRbc3O/UHhwJiNHbtWPAdcOsB
	 UE2ON5UiCZlOzdQbdiQdYYjx9wAOgRMLlZJzBgEdNoXGUL4R71lJgl14NAyeFbePEw
	 r8TSabJxOywPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 889EFC53B50; Sat,  4 May 2024 09:04:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218805] CPU stuck to low frequency after resume from sleep
Date: Sat, 04 May 2024 09:04:48 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218805-137361-NBCSgZKt1X@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218805-137361@https.bugzilla.kernel.org/>
References: <bug-218805-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218805

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
What's your CPU precisely?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

