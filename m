Return-Path: <linux-pm+bounces-7575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B048BDFC5
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821F41C232C0
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8114F9C1;
	Tue,  7 May 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiIKy3S5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711AAD5D
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077802; cv=none; b=a8YU2RVHq0e3NDvAmUlvsGJVnTfikEXYVQy1v9qaX3Iq1IchQ7ZNhk+6RfKLlL9CpT6lw1z9fBJaW9OE9Yw+EE7S3rmAZSKvR1kBeGMzEgZ4YXAXs8j/2XBcEMNeqwu7P0V/vU0HlgwTLP2KqvK5GZG5vRsAKGxEM3bLumhgZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077802; c=relaxed/simple;
	bh=XKlO5PC+s0fPwGJPJ6PC/+kkEUnhOwOVStNEg4wohyg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qwzQHvNCpIH4FHW7Ro0uCfRYZIQB2RHyTgw605J/+FzjYVpnuVss1wE8Oin/iy425t/MVP62VR8bNRSTeD0ZMTJSV7i5GIaQEU4ah+GJZjU7zOQz3i/+3WDuoIfXyfEEW08h9DTIJNa4SnJx42WowTrMsEQSXRBtqwDv6o5zs3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiIKy3S5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B223C3277B
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 10:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715077802;
	bh=XKlO5PC+s0fPwGJPJ6PC/+kkEUnhOwOVStNEg4wohyg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SiIKy3S5UUbT+JLxp82Bp/LBy4Ivldh2ayq9FPBDLD98K5Yl3xrlRX0VXYRgeuRuS
	 4srftyefRVKE1+HV0CkmsaJvKAg5rvaA/lWTlcRdwZ1K6sVXVV0cwjgNlOjVk+FllU
	 5SJhhypk9kKXwWBMB6nPP0vK81QKDiO1LkzrAr8eNsc2IzF5fLOawRVterNG4lqqGx
	 xB5Sj5nrcb+7hpNuy7QrsFxcXgnAUGQVisEWIMNkILR35AxptEdjpPg4Z+5L+GdfPn
	 71Z+4gCd1l3wE5xOQw0SpQSt4mcWvJqMT/+UdpJkJHm3kYdpAXD5JKypDICaFo3btc
	 mFPRnLJhrrAaw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 64666C53B6B; Tue,  7 May 2024 10:30:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 10:30:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218759-137361-L6jfqfy57g@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218759-137361@https.bugzilla.kernel.org/>
References: <bug-218759-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218759

--- Comment #23 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
Also: how many users do we suspect will run into this?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

