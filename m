Return-Path: <linux-pm+bounces-24817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC14A7BE01
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 15:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1088C17B5E6
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 13:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E21EF0B4;
	Fri,  4 Apr 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLL2KynK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B071EEA30
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773810; cv=none; b=MptRTV4hxdEKfYuWouI/DxipgT2U/TCGLlvJofWV/BtMIcuds1QZT8Ko5vJdJ2sN1ehffTXMtZKbDMkjOOt45/53amiMYvX7keEcH917j2907YhPh8Uwo03mz2CLVVrhi0PB3JBTfzf/buKBtGrANekqlxDvhXqLBmy+jQhsshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773810; c=relaxed/simple;
	bh=En94voQyUJpWsB82rYC5yrgXmRoFulDalJDlinelRg4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j7uYnbOkqYN4oMrxC9A1PoZwybW28nq5wqrKX/9PsYQxFo02uplJqL1cvXPeSrHmkAu+0VGXKbx02o+qSoa4Vk2TpfxmbNCwnx38hQuf/giiJyU3PmOTy1e/CTmU4JR+nVqVjLpjNJqG944xWN0ZL7XqsFRjOHjGBTzwJH571Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLL2KynK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 544B8C4CEED
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743773809;
	bh=En94voQyUJpWsB82rYC5yrgXmRoFulDalJDlinelRg4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WLL2KynKhQdM894ZTrkUyZg7h1ja1QTJ3NuKg2GkhkEsVX+pf0aGGN815TIbRFzc/
	 OcTet19UFWz8TNet8Q3XhjUeHUDnImT4IpJm3bIo+2CzXCFCUhoNiIsjvt9Y5+Pyhm
	 ekHy9S9by0r7zqZaR1gI63ypoamvhEa7+NEi/9ozRk6FMTKMP2tmD24wxkzl6iq7sS
	 nlsScv/ulvV+qguCDQu5GGm2uUEVJj6A/NAWiRI/hIDmSBbWmKB0sB13ZlLQYzIX6M
	 Y9mGUDOuPbtKez92KHpPEHkmbj4iPKJSCzav9RVr/q0bUKP8Ja3Lv1Di5ADyCMf3+s
	 V68gh+LO+4H2w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4B185C41612; Fri,  4 Apr 2025 13:36:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date: Fri, 04 Apr 2025 13:36:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vincent.maurin.fr@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215938-137361-leAyVUv5tD@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

--- Comment #23 from Vincent Maurin (vincent.maurin.fr@gmail.com) ---
(In reply to Vincent Maurin from comment #22)
> I am seeing this issue back with 6.13.8

It was remove with this commit
https://github.com/torvalds/linux/commit/2064543f5ba0d2929e3e9b3a616c3262a5=
7c7925

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

