Return-Path: <linux-pm+bounces-2411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CBF833724
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jan 2024 00:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F271C20BFB
	for <lists+linux-pm@lfdr.de>; Sat, 20 Jan 2024 23:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400EA39F;
	Sat, 20 Jan 2024 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="istvZt3H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55B14AAA
	for <linux-pm@vger.kernel.org>; Sat, 20 Jan 2024 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705795069; cv=none; b=t+u2F4ndcdObhhCtObHj/gnQa00h1PMo2ucRIlWuCPYkP/fcdBIN1w9Ul35boievMqrgvkg23epXENvM5oFG5A1wudLvRWoWSm8hXINfs6OEM7I5ByY5BZrLnzU2HcTdOjxOCOpddV9ZOttolEci+zujeE84HyacHnbd18U9Dew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705795069; c=relaxed/simple;
	bh=KxS5Zny800Ekbzm7F+c+1UauWSau9bsKJePX5CcRSDk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYSnRvvPLcLVinoLjGQY/ZCsTGwdA9DxdRF681HNgp8Ea6zYZhgviCINNZSB8TD0bjEziQo7eKA4yyY5Q4otcRmHQxdMY6QHlI5d5L/bGiwFmsLgudYod4deYYGgqI1vvgnqI3cNd1F2IwS/BvlX71pI1Y1i2VgUT+TLUnn36+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=istvZt3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A51F0C43394
	for <linux-pm@vger.kernel.org>; Sat, 20 Jan 2024 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705795068;
	bh=KxS5Zny800Ekbzm7F+c+1UauWSau9bsKJePX5CcRSDk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=istvZt3HDJPSQHApOwTVsOdY6AaqOdn6BKNcNDmgktCPQhQf1h2SCbOV4T3tAWeqZ
	 xYYCOOW9XozATcBgyuv6FOICfvAwx8XyfndWO/9PTLXhDCSm1uF+mWTgBxPSZiJrgk
	 SrHOj4mvEumLT7L/IU8uYEHb6i6jRqG6l4JyKDWyOVh6azQNQycPT9nluKFJMAZXaY
	 OWGlZLB0EWCE9jJypQ3YMXSwOowkX/3h4QJ2aV3f+rX4EcvO/Mfg4QwvK1mcZ+qr3+
	 TVrvwXe5JtNkdVe8vDSNe7jXHupvuiiehMJphfjmdQZvudklvmjBLQlt8JqdHmnsfH
	 Rup+CDFYfmexw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8DA18C53BCD; Sat, 20 Jan 2024 23:57:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Sat, 20 Jan 2024 23:57:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: alex.delorenzo@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-5DRVSYR5Fv@https.bugzilla.kernel.org/>
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

--- Comment #37 from AlexDeLorenzo.dev (alex.delorenzo@gmail.com) ---
(In reply to Mario Limonciello (AMD) from comment #34)
> Can you guys please test this:
>=20
> https://lore.kernel.org/linux-pm/20240119113319.54158-1-mario.
> limonciello@amd.com/T/#u

I applied the amd-pstate patch to 6.7.0, and have been running it for the d=
ay
without problems. There were several suspend/resume cycles in that time.
Haven't used ryzenadj or rebooted.

Before the patch, I would experience the issue within a few hours.

After waiting ~20 hours, I tried using cpupower to set the maximum frequency
and was successful. Didn't have to do it twice.

The patch seems to be the fix.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

