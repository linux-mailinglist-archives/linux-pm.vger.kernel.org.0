Return-Path: <linux-pm+bounces-6136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F6C89E9B9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FB2285851
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 05:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F26310A3E;
	Wed, 10 Apr 2024 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk69s96a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57572168CC
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726922; cv=none; b=mjJ33E0Lkqb/frrssMMWfdOW6AL9BGzWtcCW0fA6k1EETSAg1APDsEkBBht0xh3JCYAz4OILQCegu+lhZMNECtmtoFTsrKmC87rYcjnMNI8jb7R3kPjxWCieCzz3MuybmAh9unHXUpY4X7uazYbzfZLM5RGKhWG1tSknVTOqiPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726922; c=relaxed/simple;
	bh=N5oHX8knLvgcEjedCtwi/YgcPcAFs9rJzovunf0b7ms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuxOuPnIc3La6mC0I++6L5JwhJIJgZXRcayiCtk5ldfUavrjNzkH82wb7mBwCMUIYBrVBQj7XWUtr5QL1k3gZL2C5h0740Cdi7PqEhH6sjIgh+eJENgerJecZSQksUD/gTPXFgLlQBRcs1WzAMw55FIcN5nwHfThDCIdhX9TJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk69s96a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7FAAC433F1
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 05:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712726921;
	bh=N5oHX8knLvgcEjedCtwi/YgcPcAFs9rJzovunf0b7ms=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uk69s96aQFZVX43j7/HK37H5AyYz6nae1zZamSU276kMdf/jIimHwLZgk7rAdTpIA
	 rvedXWUWFcVWr0tethpqA+hn797UZRd4nembUSCmLlPETWDLLd8ekn7TRIRn9pW9XQ
	 yR1wDBpF8FKiQTAkZPpnt9btcP89INJ2Vi6zDB6buxnYyBGVCobgGlD7FqU3rlyAaP
	 a3ejBK98CsrqLXzz4vZ1P93u64Y0/8TNemf6gDUdI2wyDUpZ28xKUEQoGzvFwosfV8
	 vrQVXFj8zCEKhDmmVn4ti93ugcu/9pqmwfbXmj4+XBgG7muoX3+YV3StK4tt3oBlK/
	 ZqExrM9kFmlMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E0BB7C53BD3; Wed, 10 Apr 2024 05:28:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 05:28:41 +0000
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
Message-ID: <bug-218686-137361-QAbx8OKBhl@https.bugzilla.kernel.org/>
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

--- Comment #2 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
This is a modern machine (Phoenix) that should support X86_FEATURE_CPPC.  Do
you "need" to set amd_pstate=3Dactive on the kernel command line?  If so, t=
hen
that points at a bigger problem to me.  That's supposed to be the default on
machines like yours.

Can you please share /proc/cpuinfo?

I suggest turning on dynamic debug for drivers/cpufreq/amd-pstate.c while
reproducing this error and then sharing the snippet it has with the messages
that occurred.

https://www.kernel.org/doc/html/v6.9-rc3/admin-guide/dynamic-debug-howto.ht=
ml

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

