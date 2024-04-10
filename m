Return-Path: <linux-pm+bounces-6142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FE89EAA1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 08:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424742812AD
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 06:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB37E26291;
	Wed, 10 Apr 2024 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFHQq3y6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870612628B
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729866; cv=none; b=b5crS7dFiaGPvxtySIQgFc9ekBx0Ulo8tgg55KdKUEKQFF8HccpH1UvT/tWkb6cC9c9rOTHb+L4475kkrPujmA/jdvhlV3LkRU0KRO9ZImeiqO2+veUYbVJwU5a15/mOc95bfo7Bh8wbhrswmpjEIn+nttLcPyli9LPDkl1IOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729866; c=relaxed/simple;
	bh=cSCg/4eqmd22rQLvMPFiorrbenJHTkpd+tmWcyFhV/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C4i1FspNqo3VxOxOhEoYLasWshXKhV5GMqJRyRtln3m4JsH702LXm5YxgKX2bfgDtTkyEboNi5Jx/ltK/NQiEBwfR4Oy7DKXktXWyW3zAYHVouWPgdYkFMAEfgJoAkw/Ie5k9uaGK80/PH1Mi0Q2vAUcREHzP4dNmiUV3H/n2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFHQq3y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16E0BC433C7
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712729866;
	bh=cSCg/4eqmd22rQLvMPFiorrbenJHTkpd+tmWcyFhV/g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gFHQq3y6twzkx1l8Ebqiy08Ae6QDnF6w59CFrpJlkQhHUYlBVZF+oAKdpiL7cedrD
	 em36uYV5Ztvci1H9YfJc44mTr5wW1QoFPAvNxbPIvwxmr/E3sYI4m859eiQQiaAke+
	 Hc3OEL36EfCEw5bhaC9bmooC4DFmJM2n92MNMvEhulvI7teyrErQZ0YLvgDAL4zv1B
	 8wvE7aURU2xUys0FhordErZ8lVvMHZ04gG5s1fgXqWVYp/1Ix7/+gUeTU3B7DNrQlT
	 6hGmUwD327boNp4UmgQBl2p2FalVCWpZsjsYNhqvlCU9l9/0CIAU4cznzXZCCfAzAf
	 jZd+49RftvP6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 083BFC53BD9; Wed, 10 Apr 2024 06:17:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Wed, 10 Apr 2024 06:17:45 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-ecnEKqRcnG@https.bugzilla.kernel.org/>
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

--- Comment #8 from al0uette@outlook.com ---
Created attachment 306117
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306117&action=3Dedit
output

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

