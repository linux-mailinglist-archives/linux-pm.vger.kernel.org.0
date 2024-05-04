Return-Path: <linux-pm+bounces-7499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D908BBC41
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 15:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF431F21BE5
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86009347A2;
	Sat,  4 May 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbJ1l9+P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD311CA92
	for <linux-pm@vger.kernel.org>; Sat,  4 May 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714829204; cv=none; b=oNNfIGhFZpTmoZ9bPRvdeCVtiKAEsUPL0LC/uJWXGRnEvVy8OR2tb+q1EVqT2neMxNR7AkD+cnDb3YES07bqq+Jbf4JZR14wqB5EzXYolO3W8sweCzwWfSAtDh84aPdE22nWayjyGEVux36bNxBaii70TicpLAJtg+RkuYL3IDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714829204; c=relaxed/simple;
	bh=f+scNQArJZv+VhReZ21vJlPXuA9xZ8/eqKYCV5PIUYQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GCa+AnamTylovZm/8lxXCJeK1AVfTUZNVc0MpqQ/Lj4OobqvH7WB9xOcU1fy/xqQ5dumruAggvzpgSxsKg07l8y5VgPnVzXbOnDj98wHd3kIVNV+5fPmLV5I7ct3k5vQng8BM84yzyxSO8y8PHEn5wkWgSOnFVhcIZ9mO71MGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbJ1l9+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7373C4AF18
	for <linux-pm@vger.kernel.org>; Sat,  4 May 2024 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714829203;
	bh=f+scNQArJZv+VhReZ21vJlPXuA9xZ8/eqKYCV5PIUYQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZbJ1l9+PcptxaXmhLNtnCUjf2obiAM7ans3RCyhnXbHe766G8XaqN5/hXaAnQD6Vi
	 D+ZxQxzoe4dGNDk2UpkolaAdVMwXAZnYNcP+dExhWzBtCd4SYzC1FC0TU+ESyFEyy9
	 aRCNix9pIJZIEa39oDi40AhwhfqVRtyZz7soOkUZagAEuOTCUHDNHgO0CktX1+zC3d
	 mmkuFt+N9PPF6VM8pVHKqkiaPg1xjQUOCML397Fohnno7UCcOK1jADvAe6fzis8qvr
	 RY5ITe7199MFLPmFmmL4iyFH6AbXskTZNI0iHQF62s+/rjOdFeSTcNOz1U6Esj2cro
	 BlYzD82dcx1Ww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DAF7AC53B6D; Sat,  4 May 2024 13:26:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218805] CPU stuck to low frequency after resume from sleep
Date: Sat, 04 May 2024 13:26:43 +0000
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
Message-ID: <bug-218805-137361-BgR0uf5DRO@https.bugzilla.kernel.org/>
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

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Could you try disabling/enabling turbo boost? I've seen bug reports where
people say it helped them.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

