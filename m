Return-Path: <linux-pm+bounces-7871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 038C78C67A1
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F691F21AD6
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2024 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D59C13E8BE;
	Wed, 15 May 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpXAe+ZS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9D13E8BC
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780654; cv=none; b=A2s88JBMO482dfZhjLNkTQ39Qv6WczGeD319PHGJWCq5G5wYajPuEYkFM5dkhHiPBT05GeMz+pU+oyISyQSHFlnGQThXkIYdv0DZABsoeZufrevkXPHae8exIUJm5Dxe9QlsG2eajG+T7JPFkG9cJravgMHXZa+rd2eRPx4yaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780654; c=relaxed/simple;
	bh=WSTe1M8CM3uSzNtGdX6tKuk2MzkYWPT8Fs8ev8aW2io=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ddw6fjp8iuRMsiZLKLTZq8O00pW4AuBfDe0qtEHVypccr4Wc3/4sLRinjTPgS8WyznHm7c7Z9ISm9pXR6nNhQ0BC4CiOoQVW8CmmY/2gkcrxDq4Xt1S/a98p7ysDZFoHW77t24HJ8lSH8jg9UmXWcdmql0YOE618F+VUlnBu5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpXAe+ZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDE60C32786
	for <linux-pm@vger.kernel.org>; Wed, 15 May 2024 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715780653;
	bh=WSTe1M8CM3uSzNtGdX6tKuk2MzkYWPT8Fs8ev8aW2io=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZpXAe+ZSMBEnmisHOljtlyuKcBRBVYLsJndASuWj6wPcv5BcRm5BMOrcWvJj7A5dU
	 fSCwsos50RXzbfbKtewokvjwyzPrfNN0odS7ehGjgtGD2zDHB+EXxLNt/x7X0rXa+W
	 tjw+CjjxfhxF6l/DJUpHOP2milpmXLwPikMri6rgsrXQ9eK/S+C/WrJaeeh+KOXVyu
	 hbxVoNxpbiynpHEYGsw+qed9fnwXP38wOTIoZKgGdbvzsk7NsYaLDWEUZJQjuIR2Lg
	 XLw0wZEmYLAF2m3XTti0XfbKHarJ/jEr/fcZNGjE0DF5/Yr723PWvSB+RT8pgPK5Bp
	 +x+4xKYGJvBAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AF8D0C53B73; Wed, 15 May 2024 13:44:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Wed, 15 May 2024 13:44:13 +0000
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
Message-ID: <bug-218705-137361-wdHwHADvwX@https.bugzilla.kernel.org/>
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

--- Comment #31 from Andrei Amuraritei (andamu@posteo.net) ---
Hi Perry,

I can also confirm the module loads automatically now, without specifying a
kernel parameter, with V2 patchset on the mentioned kernel branch:

uname -r ; cat /sys/devices/system/cpu/amd_pstate/{prefcore,status} ; git
remote -v
6.9.0-rc7+
enabled
active
origin  https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
(fetch)
origin  https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
(push)

cpupower frequency-info gives driver: amd-pstate-epp

Waiting for V3 patchset. Do you think this will be merged for kernel 6.10?

Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

