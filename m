Return-Path: <linux-pm+bounces-6158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F1889EBE6
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 09:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AF31C213D2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB92B13CF9B;
	Wed, 10 Apr 2024 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej1SOfs7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1913CAB4
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734044; cv=none; b=mDPmiuGrTBj5MdBXxv4RwN2xRLac5cJ2CdvOT8xFuiW96ZC4YpwO3/zU6ssYEmEKWE0CaxZbanUyXrS8V+arVM3sSI1KBqAA+UygY7+VRiKLzOqXZzAGAD3A109TPq4so8MQs5JvJenKYRs7l801SohaM77P9Nx4+bZM07FwyZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734044; c=relaxed/simple;
	bh=n2jXnq/cFt0F74ZP+LWnuH/AHfBq2YsbUNPcV+839sc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TfgN6voY0U4vl/WDdGH7k5OqN1RH9OvWtYlBcw82Sl86cSs9k6nE6SlaoiqXvw4PimG7A/hgeR1Ni2FCiYi/GyuF2VjpLmk0ZPEHKaKxVezFHzSRBo3My+2394TFE+HIEHB0OYGYXQ52IjDQKrgqQDtorNwsBAoWsRDbkqStsO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej1SOfs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D83FC43390
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734044;
	bh=n2jXnq/cFt0F74ZP+LWnuH/AHfBq2YsbUNPcV+839sc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ej1SOfs7FpAzvu2Dea8RLtr4ak221fsGAEDy9wgcbu/JroqZwvQc8GyiBWjzTq2D8
	 fDe/Ifnwf4a5xKpMKu17D8imJdu5aR7HUPGO2fNl7uA7amME6fgcimu5JSTzsiugdR
	 KOCxSGo0av/Wb1R1bQBpc+aUbRE+GqzFXsAZmYaa+xh+u+Af/YXaLaz/dK9IeEjqhK
	 CuId55TZUHaxi8uADpiaKDXzLm7vxea/0v8jdHvP03m1RJrivPyNL8J/TwfJ2B5OMr
	 kxIZRbEW98Q7VsQteHTbzH93bNjfvnkVMdfa0RzzDnTu5KrBuJ47naRWJJcP2UWKIS
	 Uh0RCMeqWvUfQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 56AF7C53BD9; Wed, 10 Apr 2024 07:27:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 07:27:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-xSSCkiW3Tu@https.bugzilla.kernel.org/>
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

--- Comment #23 from al0uette@outlook.com ---
OK, thank you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

