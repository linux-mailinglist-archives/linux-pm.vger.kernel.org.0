Return-Path: <linux-pm+bounces-9016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD589051ED
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 14:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7951C22104
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 12:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4798C16F287;
	Wed, 12 Jun 2024 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhI9LqxH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B116F286
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193798; cv=none; b=rh9EH3xeqPEaBi8SA+/BLwKXWfD4zIYsXXw1jrV1SmDLMhINj1jYpk6nQOnzMBcoFnTrVNGYZF2dNjIgbGjoe4QDsQrqACNg73mz7oZgTRBm6IhVkU2JDGqGNSUubJOINjd+OAHyaMXYgbhpmkUpgXQ4IIVlImLR7rts8B3s04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193798; c=relaxed/simple;
	bh=EfwFJl7wT8IadAoKCthwRwszRPA4rMN3Q0PWZgtdX/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XW347fTR6k3h2T0mNJlNG05PqpSJBUVodTYSul++DdA26hj824JueHJEK2GoqBjQ4or4dQNxaYrS7uYRNvYeGnCYMtom42N1iW0Ps2mPPYK2tUcHUJC/TZDTI7V2uwx3iMx5ySHQSZ3TCwfOaCvi4+/+bAeNPeBj10tV5uZ7h9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhI9LqxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9916BC4AF4D
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718193797;
	bh=EfwFJl7wT8IadAoKCthwRwszRPA4rMN3Q0PWZgtdX/U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MhI9LqxHqNoqKCBmSbBePiUG158PnBrordLVstcTBG56npjhMJUg4f1SqwYN998gY
	 G/JR7uPIaKYgTsJU3At1cLgQRQMAn2KoguZYk1Ju5cSfutli74VI2b2zCnDPCjiqwe
	 08b6MQy5KMvInMe+EHokHBI/jcpNXC8pT8FAzm4ktkoO7a2cKI8boVR8Db6rINZvBl
	 mT5FZ+/SEW5vwXpvJdhYhB2eexovR4CHNlhQIxSjY315v7nemR2TL15asNytjZFK2y
	 Y0K024wZlwNgWSos2weFcQ5uSfp8HawuYUcOYgH8soMJy65bALiwH8oVIw1q63wqH5
	 yKNp1YduUcZjA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 92242C53BB7; Wed, 12 Jun 2024 12:03:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Wed, 12 Jun 2024 12:03:17 +0000
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
Message-ID: <bug-217931-137361-D0nFJOsOud@https.bugzilla.kernel.org/>
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

--- Comment #61 from Artem S. Tashkinov (aros@gmx.com) ---
energy_performance_preference doesn't accept "default":

tee: /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy10/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy11/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy12/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy13/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy14/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy15/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy1/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy2/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy4/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy5/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy6/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy7/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy8/energy_performance_preference:
Invalid argument
tee: /sys/devices/system/cpu/cpufreq/policy9/energy_performance_preference:
Invalid argument

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

