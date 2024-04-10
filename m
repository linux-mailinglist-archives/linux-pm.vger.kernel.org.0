Return-Path: <linux-pm+bounces-6226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8233389FD7C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 18:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EB81F27DA7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9036F17B503;
	Wed, 10 Apr 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpxA0Rpe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF837168
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768086; cv=none; b=G8tNdom9GKOfCd0sWM4JhO9zcl0kjR3sal4fWtuZcSxZEck0z2Yn4SJi3KmMJ8ZIAh7SL655b3OWNSCSpBYgLCIj1+vIX0OGLP0A9MzNXLYSJdqKxIL1sjWyj+9o28mIBUG2f0seLB7B4237Nccy7ukXGtz4o4p7LJZ3VFkvA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768086; c=relaxed/simple;
	bh=znQ4p0ojjKEq7yMBBqukNgJu/CwAdqHbMGNRKktC5Ik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5BC5UzRx/zJnXikYQatrjbNjaBA1frx4qkcIh07C/F220UrDFOryb8HzXOPiFf6Pzut7g+iiSfPme3h2wHnDDeRSLw2qD1lZxX60DC+UzwECfgMXChsoqbAnP+L6mx3GQDKvkjmWAtI82LpbrZax/3JrrWeFXan9UisR7qG5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpxA0Rpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BB42C433F1
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768086;
	bh=znQ4p0ojjKEq7yMBBqukNgJu/CwAdqHbMGNRKktC5Ik=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LpxA0RpedDHZ+APV0omt35YrfLSzg+iQ+YIuyyL5ktY9f0KWVGuytRymClAdcnvou
	 YDh2MZpIGs3IbOs1FaPzJxDqP2s5fExQXhT9Nigr8Md9k/8YYsxrf+OrIwyU40M7S0
	 0PBOx60vqz962Vg3kLXZ755M3l5EuC4LETQBQR8Pm/M8YfsuDwOtZtTQBgP9RMo7M+
	 xWu0JmRyC7G9KsNP6M+rPrYNahxB1wVWGfA4NzxaLia2gGoQLYLT5mZt/TC4OrYV4H
	 20FhI4kr2UJW/jj/2xgmZBMec5vRjofmMtMneM84lkaV7Ftj3N50RhPFWqNgv1YM8e
	 pD0bKL8RkXzTw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3F038C53BD3; Wed, 10 Apr 2024 16:54:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Wed, 10 Apr 2024 16:54:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-lBJpg1r2Vh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218705-137361@https.bugzilla.kernel.org/>
References: <bug-218705-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218705

--- Comment #1 from Andrei Amuraritei (andamu@posteo.net) ---
Reading though 218171, I have checked if my ACPI tables have the _CPC entri=
es
and they do:

ssdt10.dsl:        Name (_CPC, Package (0x17)  // _CPC: Continuous Performa=
nce
Control

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

