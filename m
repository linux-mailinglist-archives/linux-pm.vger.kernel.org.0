Return-Path: <linux-pm+bounces-16523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C179B1FBD
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 19:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6973B2814CA
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DFF13E04B;
	Sun, 27 Oct 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDiuG39W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA301CABA
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730054625; cv=none; b=Xp+dTUygSViEWnubZUwpIHnRT0+bvKZxupdEVhSAphdxTx/q9OQkp2XKLjV4uxdVtzhz5Sdc78KRjNaLLhLGKPQJVVTeWDjpxjkeSzegTVyO8Fj/vv6GkbPAWTp6pVfRso+z9FBK7Iad60gAfTZemTLi3I/HjgNXUc1QRB8Tc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730054625; c=relaxed/simple;
	bh=D/lfcVUHSimehMOjSF5mPhmXp5jPUNg57PJvNbN5bo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iqGMX9KOeGTB20AhS1SIko19VoN9KuIYRagzRmHTpIxXfC3XtgRvmymh2kXcVgVivDL61rsCHyTDndnWcKNmUU8wTgbjpXIj6T0aquLZ6BcUhkwEirSyKd4sFc1xVH57v9BvgDDc+dczmmlwaRSAIDNh5Cird+mLdF51HaDLNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDiuG39W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4525AC4CEC7
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730054625;
	bh=D/lfcVUHSimehMOjSF5mPhmXp5jPUNg57PJvNbN5bo4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nDiuG39Wq/hIv9GMVfDv9IXoqokWrBJZxxdMdUrZQJF4VT2Rqrgzro72CQUcXZ51S
	 uzd0h4xJu5dgV2BfYdRDPGNV39ZlsXxgqGWdTT6+IBmLEpq1THxFKn9ht0eXPD7S+a
	 OIw4LpUQpgET2bp9i5HswlYG8djkconnfoU8CZZBlrNQ3L8uK28RsVxirduVkJ+P0K
	 vkI8/2krZg4KXWQw+2tqTG0Si4ks9wQTtWcGHo9jqQPsqkrOoe+FNVXsWJIJDKn+98
	 5lbu3MhtG7sbLaSlsD+kbUX85IwE3pEsKguBw7u3If1G4mmHFB+CR+OTnGpZsZo0O5
	 nT+jKRlgOW3/Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3E518C53BC5; Sun, 27 Oct 2024 18:43:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Sun, 27 Oct 2024 18:43:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: intelfx@intelfx.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219431-137361-oyP6arVkG5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #1 from Ivan Shapovalov (intelfx@intelfx.name) ---
Created attachment 307076
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307076&action=3Dedit
/proc/cpuinfo

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

