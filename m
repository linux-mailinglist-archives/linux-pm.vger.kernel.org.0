Return-Path: <linux-pm+bounces-2310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA444830AFF
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jan 2024 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8730428FB37
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jan 2024 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CCE22325;
	Wed, 17 Jan 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsLILLw9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565222323
	for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508693; cv=none; b=cTQf7d2BhylhkVfUQtZ63+qGzVcnbUJGIBCCAeadRTfYqSEughUut8GeT+RTogtDyRVOX0ifWfBMxQSQI94APO1phPFQ9jB59GrD6Aaw9kzDTpLoaGgyjFOdOvkl65C6BC7h0nd7nBeo4cOo4JhFXyDwp8wC24ovEui7BfOyZv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508693; c=relaxed/simple;
	bh=4W4BPQALA+uCiJizhzUWI6I3viR7jUmAGfXU9lxgUU8=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=O3l5RRwp5MUtUSVnsUtAgAEDZBsEQM5P3PiyV52EDlQrB3+pk5+Y6E7HqqM97gm79JGNHhRUNd486UB1Suv159pfpPcyIFkcBsSGh5wQhNGz4BseurXzwHS+3ENvUmJhjnMRirMiFa3ZRFXApecIaxLN9Sg8WQqqeA8nHlmZe+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsLILLw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B321BC43399
	for <linux-pm@vger.kernel.org>; Wed, 17 Jan 2024 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705508692;
	bh=4W4BPQALA+uCiJizhzUWI6I3viR7jUmAGfXU9lxgUU8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LsLILLw9dKfC9on6UgC7ZRk+nCDYQThvjYC14xbQqsn0Sj9sbSDRRZVKP37UgciWB
	 YXTSFBizVJ+8m52jAt+MML7FCa4gh0BjoiDcLYtpiRhG3dhHKi3JAxC8R6xleV+Rjg
	 zeEHfCuOGQixafMsTpQID3WUbUB0sMWKz7+d6jTSmtIWbNbDRxrZp4+z9vnjtpkerZ
	 wZjV5Yptjf6XpJy3nwJ8fXqWXZGKpt90OU/4ATeFzZ/OAHw0S/5NNTHyJRCCCucova
	 aPJElrlty5KDyVL7EUfh9F7PBGKl7gIe0cNZDl3XgEFqo8+1ZzS8Ur+XUMChwLIs5u
	 yveoo6MTeAxNA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A06D6C53BD3; Wed, 17 Jan 2024 16:24:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 17 Jan 2024 16:24:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pnascimento@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218171-137361-AYFkD8Ekr3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #27 from Pedro Nascimento (pnascimento@gmail.com) ---
Hey Perry,

Thank you for sharing your insights.

Given the issue is spread across MSI, Asus and Gigabyte, I'm concerned we w=
ill
never get around to convincing a fix should come from each of them.

Is it something you, as an AMD employee, could help with? Or is it possible=
 to
work around this at the driver level? Otherwise, I fear this will never be
fixed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

