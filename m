Return-Path: <linux-pm+bounces-23729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78362A58B94
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 06:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156647A3942
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 05:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B31BC073;
	Mon, 10 Mar 2025 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ierdPBd9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D977B3E1
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583617; cv=none; b=E1Ecc10gsO3M8sy7++cDgoAnu6sCv69Ud2WnF1DzrgVEvysKxvzvGHKRi3st/nVA8qVp3lLrr/ogPol/fX5XK22qczAyRenn2Ic9CFGoKo0YXvA9+QnVxynF0sLSn0WPDisRyj/SjpkfuPyzr4j9UYB7jvR0ajC6DNsP8fjbkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583617; c=relaxed/simple;
	bh=xKkuJrZbsMsdLiPQISg4wHMWgd3QLzIMH70qC7FZpgA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QKDX48QUZwl/8HoYnmbOLCzO4w/8iTHfOah8icInEqztGuJXY32suVDBsCSk9Co04UcGyBTvvsUI2W5CXZt0G+5HYJpc/pjyM0bsTrrgLe3VuDMosYcUJA2cBwGVZJ4fIdNuQfkcVb5V5lOrYqenhjAqOczfFoeCLKrJ4I/iJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ierdPBd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95962C4AF0B
	for <linux-pm@vger.kernel.org>; Mon, 10 Mar 2025 05:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741583616;
	bh=xKkuJrZbsMsdLiPQISg4wHMWgd3QLzIMH70qC7FZpgA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ierdPBd9t8o6HqU5vfC4uSl47/nCoxbe5krwDc64mv8P1af0Qt7U4k/nW5EjjwS2W
	 3Rq8JggjT7xxzGRt1HENXf1I5VlSEBVA6ktujcNEPLUvVEex3oUVFJvjlfJAF57AWk
	 oOoJb3RtHcWXh6REaHzudtPpYlD3qqBCXXDqVquRbPC1ZuLnGN82eEThjd74pphNft
	 YFSh8vccRXF60WspHzcK3zDEcVT8kcE4ymjwnK4B+ZxjDaHXscLDojmY198Q3NrZtV
	 U/SZ8MFk6X1Tv1mdEHL3KaY1u8yImMZMzZ/muXZbTZ/Ck8snFxnnwRbiaYP5TdEiTS
	 U1TWW9PPeOjNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 85F2CC53BBF; Mon, 10 Mar 2025 05:13:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219851] [amd-pstate 6.15] Frequency Scaling Will Not Scale
 Above Lowest Non-Linear Performance on Ryzen 7 5700U
Date: Mon, 10 Mar 2025 05:13:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Dhananjay.Ugwekar@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219851-137361-NfLhDu9BJY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219851-137361@https.bugzilla.kernel.org/>
References: <bug-219851-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219851

--- Comment #2 from Dhananjay Ugwekar (AMD) (Dhananjay.Ugwekar@amd.com) ---
Hello Eric,

1. Could you please give more details on how to reproduce the issue? which
governor, amd-pstate mode (when the issue was observed), workload. Are you =
able
to reproduce the issue on your machine as well?
2. Just to confirm, does the user have
https://web.git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commi=
t/?h=3Damd-pstate-v6.15-2025-03-03&id=3Df6c0b760290951688697d9debbb2b8462c4=
23a48,
in his tree, it fixed a corner case in the culprit commit that you pointed =
to.

Thanks,=20
Dhananjay

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

