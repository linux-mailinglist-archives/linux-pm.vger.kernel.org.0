Return-Path: <linux-pm+bounces-7581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406408BE1EE
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 14:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D70288021
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 12:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05D15B130;
	Tue,  7 May 2024 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfN0o+SC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE015B12A
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084543; cv=none; b=OIADi6RT7PusUcvD+rQ7h/BE7vM7YbeZC63vNToYkLFmUSNbgQJ1oqRisqufW54SPmSTSfZ4CFtlamoHzwH6tJWNQPb9g91+KkU/AjmXoqDNi2afeoW+4GKuZ0RSwf3jRMrEOh7C+I1Q58q7X0u7lkFD+vhH9hXzpYIfeOKk6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084543; c=relaxed/simple;
	bh=g3iy20UZZen+/X3G/H0IhrX0VRAIdEqNjvUFy/dIJuk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KTT3pzdVleGwZaqJpmUdzZ+gLdkUOTOD3/ItgQzYVP/QK7vAMhro+kAdcb52WIruI/x2Q/H+BYg0N8gPzlyhao57/0n1W0peF6vyMwD7zlZMxD/cUth2wNPsCijJGkpDW4FF2avRJVJHwPXOd+XiyZb5EgWVuOO6HzBBqI/tsdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfN0o+SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C44DC4DDE2
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 12:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715084542;
	bh=g3iy20UZZen+/X3G/H0IhrX0VRAIdEqNjvUFy/dIJuk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qfN0o+SCSDvAQN3DCPA+wTmTGr5xGdT2E8kjRVJ195yCNB3HUYamGaycQCTYvH/NN
	 JkkfYpAe/rTQYk1jppinvRiO343OgAyHVvMiW8t1UP/C/jdGHGXA5lm7xV63RH3G/+
	 PEBldutswhuHA4xjNnr+cqoro8cvqdYYtN0CgghGT9+yIC829pUwEVtRJejoa1+v1u
	 IfMMYva+8KYcLjPygugY9UdHAlraP1Wy2TipPbvwGLJa8o/V5F0hL3TpvbLBv2Kg9H
	 uWvpX0e4RO/3LlV9kuSaaxByZ8gguYHbrb/FjfQiz4ncsIHT0NWR1bsTSUqm7sA7Wa
	 3tuXZ0LYqMxGw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 66275C16A72; Tue,  7 May 2024 12:22:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218759] 6.9-rc kernels - with Ryzen 7840HS CPU single core
 never boosts to max frequency
Date: Tue, 07 May 2024 12:22:22 +0000
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
Message-ID: <bug-218759-137361-189yQdEzlE@https.bugzilla.kernel.org/>
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

--- Comment #26 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
But that might need patch 9 too, we'll have to see what really makes sense =
for
stable.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

