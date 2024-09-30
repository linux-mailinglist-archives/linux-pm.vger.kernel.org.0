Return-Path: <linux-pm+bounces-14969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631DD98AADE
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 19:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE391F21564
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6655E73;
	Mon, 30 Sep 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV2qOmSu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D7273FD
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716541; cv=none; b=u8oqIuEqWHfgX5cbTSrWCMSag2Gt5FuuR1n1RWIeFcT1op3dcc63S07NmYuAf22tiOdjUKA1FXPebEwOH+imIOWACAujsYxE36Fy1FPo+EvH5k/7RWhkuZdY2PjKSsIFbpUvQV1ovdVfVSbkC5hbmtQJO+rL0Ryt/YlcJswzEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716541; c=relaxed/simple;
	bh=tNrXvyMO7bZTu/l3FjwAyFbJc6ubJ8zd2kv92JuKo6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MeZG3+zmuozjQKB66veHcPRM2EmAHszoPU4LfU/6t2hDBoc9NdI1V2uFLetb/T8YOG61TxffRKxKrqtN8IJeeSodELaFOGOkL82GMYjLvsyPg2oy3lkzGDbzTOjfCBwL3qLETwXxlkNQ67Ab1eSKdcPdZJCyUSbe3hDgRnnlhuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV2qOmSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E46FC4CEC7
	for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2024 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727716541;
	bh=tNrXvyMO7bZTu/l3FjwAyFbJc6ubJ8zd2kv92JuKo6k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NV2qOmSuugBLefAdbrKkXiZHttPOxsOfNMlHZLWOuJieHEbCfEJdmtH0azvW8MqF0
	 SWMjgcUc8RVpWzZC84QFntMmuZc9jmgJyZc015SE7wcYPzo4BzTc4O21EcJ0V6WOQS
	 VD+ouaJgZToqP0uJdIwvM+RA7CZrdI8/2teva8U9i6PTQYXftxQ1KjcsWDu+jk0Ywm
	 y2aBbkk9z7i86KcsaD7RpHdiV/GXP2gvzaIJNTQFbG3lFdIXz7/rzJh7pQ/dbWvWFi
	 A2Mj2ykem3VIaQnsKNGXIK5ec1Mg/A4X7hAN7caUX31cCHILOsxIakqRmdgJtIeY1t
	 umVRjQ73beBYQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E8462C53BC8; Mon, 30 Sep 2024 17:15:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Mon, 30 Sep 2024 17:15:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219332-137361-yIwwmpe9Cj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219332-137361@https.bugzilla.kernel.org/>
References: <bug-219332-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

--- Comment #11 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> When `amd-pstate=3Dactive` whatever is written to
> `/sys/devices/system/cpu/cpufreq/policy0/scaling_governor` has zero effec=
t on
> the CPU behavior/system thermals. That's what I was trying to say.

I wouldn't say zero effect - it definitely can matter.  If you start out in
powersave at a more efficiency biased EPP value then switching to performan=
ce
is going to increase power consumption and heat etc.

> I wonder if amd-pstate could "simply" hide/disable (i.e. make read-only)
> scaling_available_governors AND scaling_governor.

Userspace can still change the cpufreq governor from performance to powersa=
ve
and vice versa.  So it should not go away.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

