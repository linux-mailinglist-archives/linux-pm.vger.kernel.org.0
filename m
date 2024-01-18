Return-Path: <linux-pm+bounces-2353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A28AE8321B7
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 23:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0702B2204F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jan 2024 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3643B673;
	Thu, 18 Jan 2024 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzOU3mKb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFBE10E2
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618006; cv=none; b=oLhFihazWH26/iRajvn4ezD7nX9o2ctz00cEWxIlwsu8puTGr7SeCwzVf8PIuJiS26W5nHnCyddXQbNevenR+vPLl3TXBR3GaAu3uyIQwbsI/kUxZ/amJFQ/I52RUHtKIEUwJQQx5n8z/10SFQ7hryT0MSjDR++yUiJFBmEuMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618006; c=relaxed/simple;
	bh=mE3ygpiq404IyzwdpU73oCoSP6FXgqo8Ig+PlE22clU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2Zw/fI1lcpuuIcBGRpca1IlxabgPCcEG30E2z3l47R2tmgXB0IBklFGK5pgxYAshL9gPuECLFyJoIWLypIFwzNhL4EF3H1HcsabR8gescAeA0FkZPr+w5xKl/9dwpdcxhs2qFN4cKiqPn+jibWAdZwHHdanQ/6zJaOzjtkh888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzOU3mKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4240AC433A6
	for <linux-pm@vger.kernel.org>; Thu, 18 Jan 2024 22:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705618006;
	bh=mE3ygpiq404IyzwdpU73oCoSP6FXgqo8Ig+PlE22clU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DzOU3mKbRawOkKIzbayrIPU8ijltpl9LzRuKvGM+o3MKyVf3/CmBmtwapqCgA0CIu
	 mblmg5dnoq3Uj1HyqlDbZEZMRjwMr9JFUY1Np0bXhBCrTTledfsdbA8wm60ZrxRil6
	 TMrEDeqRKhI5p6yVWAmSboGBLbZX+iwtYorqjSa4h0sFyuM8/ycYl3TGqoJt0iwWXz
	 UCXo+ILSNPMQO2YZ5VibGrSZeMI4i+oAPp9adGSUxH0YgaSJkh3OvtXDzYzOWhOioc
	 bMVL0G9Ewnkt19WVDDYPFeJEfcctjHoHYeEHWIglE8ecwK5uIyZMnaSeeKLpgmJjG7
	 0YcNnFZbEELOA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 30FD4C53BD1; Thu, 18 Jan 2024 22:46:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Thu, 18 Jan 2024 22:46:45 +0000
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
Message-ID: <bug-218171-137361-mowpOMcAOR@https.bugzilla.kernel.org/>
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

--- Comment #31 from Pedro Nascimento (pnascimento@gmail.com) ---
Thank you, Gino and Perry. I've opened a ticket with Gigabyte as recommende=
d.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

