Return-Path: <linux-pm+bounces-2341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE870831DB3
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 17:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E931F23F8E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9982C194;
	Thu, 18 Jan 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3YpWEoM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0925770
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596061; cv=none; b=BHJCkh27Yan8RriFO6buja8fi3pdkwgD3Vi1O3xwb1BKIIYtHonbVJk4291KhNV+5gP0w6DJEa7p2yHMmlNHGWGffKgqy1wBYkYUz7tWLk8kII9GWAD1tcsn2a7aWR9bxffnwuf5s1u4GL0hqQhStOdmBzFw5JP1CDEquzKJSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596061; c=relaxed/simple;
	bh=sq+7GZcEwIpPulaVJcLAAdlFr9IeXz33TlWvP2iEueI=;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:
	 MIME-Version; b=eV6KBII4d5PXQpwjZvPeoXL7yjBUQ5wpnOGnGKXRxEIdQVz2IA4vfsVsnGQ2f0Ac/8qdbpZ6not2gNXAmUDH63Gw6+F/dadDn6EcSymcOeFGuNumqbwDy/9OhLIDznElhfhM1YuPhwkZUFsPs6oZbvwR1ifX18znPSayDMj62JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3YpWEoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E28BC43394
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705596061;
	bh=sq+7GZcEwIpPulaVJcLAAdlFr9IeXz33TlWvP2iEueI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E3YpWEoMmV+T7mSwUzI0o4L6kqu6oPo4EP55T6JCuXTaHUxCJFRjlpZomnhvqTGu0
	 hAYqGqBE7sS9a4BF3yZF00VI8oLtl1htRUsD93w1gMVvhp+f5TFe7KA5dAk+fwv1HS
	 EceejXpeo/VxNqDwYinBcRNoohIr1udoBHKurPOp3+aCLII7IWKsIt5iPxBfgNMHL6
	 4+bPL8vJLQFEKdLkY9ITZXvHvHr/YWRHu+FV3Z4NhQ3FQBqadIH7ljKnYpPdYWbTQb
	 rQmLtFMULiBd143h/8GY2b27NeW8q3rX9rLPFHt2WpK4U1QecmC8GlF5kLFvn6PIMW
	 hcMLLb+Hbr1iA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2CB27C53BD3; Thu, 18 Jan 2024 16:41:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Thu, 18 Jan 2024 16:41:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-QIJyYJDizS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217931-137361@https.bugzilla.kernel.org/>
References: <bug-217931-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217931

--- Comment #17 from Artem S. Tashkinov (aros@gmx.com) ---
> When you say getting stuck in lowest supported frequency does it resemble=
 bug
> 218305 perhaps?

It's the same bug I've just refiled it.

> What is your CPU scaling governor when it happened?  And does it only hap=
pen
> with suspend/resume or only with reboot?

cpupower frequency-info
analyzing CPU 4:
  driver: amd-pstate-epp
  CPUs which run at the same hardware frequency: 4
  CPUs which need to have their frequency coordinated by software: 4
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 400 MHz - 5.61 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 400 MHz and 5.61 GHz.
                  The governor "powersave" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware
  current CPU frequency: 1.40 GHz (asserted by call to kernel)
  boost state support:
    Supported: yes
    Active: yes
    AMD PSTATE Highest Performance: 214. Maximum Frequency: 5.61 GHz.
    AMD PSTATE Nominal Performance: 145. Nominal Frequency: 3.80 GHz.
    AMD PSTATE Lowest Non-linear Performance: 42. Lowest Non-linear Frequen=
cy:
1.10 GHz.
    AMD PSTATE Lowest Performance: 16. Lowest Frequency: 400 MHz.

It happens both with amd-pstate-epp and acpi-cpufreq.

It only happens after a random number of suspend/resume cycles (as low as o=
ne,
as high as three or four). Rebooting/power cycling always fixes the issue.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

