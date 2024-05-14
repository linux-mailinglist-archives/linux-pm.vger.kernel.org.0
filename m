Return-Path: <linux-pm+bounces-7854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB58C5B0D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 20:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A527B217A0
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2024 18:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172781802DC;
	Tue, 14 May 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUQuWypF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F961E487
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711138; cv=none; b=RKirCxUzp9MtEMWccFWu89XZ+0tvBmuQIpsAaDU7C733mSLD2G6z2Sq4yFbnU7rCFUZecimtGZFxIOVUWAOXrRqZmPIZH3CUA4C6+5RnoLiGuZgsQ2MjT7orDsAoNk3z5xmShvSyf4Td04JYzJ7BQDdQjejQmVHYXB7UrYp/7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711138; c=relaxed/simple;
	bh=0I1xEZSMT/kNkUF8ZXQQ0eYjGB6i6dr9r/WjvjTfiI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FUVrjyTuWVmt4r+yQNV514+zhkPyPSXcMqYn0Tpn9xnR5+uM532tL1ni9x8bchGGfQ/MWYQES0xAqX11o1loE4RQIUGkrgqwG5Iwi7Bxhel8VW9Tkej4+8LQlVw7qIVz8KrAEote5pgXQdfCiH3MK3JX0bCVFPg0JxUh0Gev6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUQuWypF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67D1BC4AF07
	for <linux-pm@vger.kernel.org>; Tue, 14 May 2024 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715711137;
	bh=0I1xEZSMT/kNkUF8ZXQQ0eYjGB6i6dr9r/WjvjTfiI0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PUQuWypFDEMEayAazwYAl36HW7Ht7qCHjiEjW+uNlSSXNLb+pjU6lQ301CuIAoWts
	 j36bIv1tpLndi9Qq6XuxLRe/2MModRj0XNVJe7yr1qy+G9DRBVcpGZgHP8gknYdib+
	 6sBvxbE2adXS04/CuTw7dMBGyVmrWZYQjij2SRLB6mUgbEn7Dd2KOjMBCFqTxvejGa
	 8DaZGBXXNAx4mt+G1ESr1dNDHRLq0EwJRqwf3uiIDrQtf0PJSyZMkZjevMpvn9bVie
	 dnKglFq8MbtLGhXhW2KJ979WlRHnObFviHuJXqIy9SVMJN1u0PadnvheMNrEH9JaQi
	 0wYquGJRYJMiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 55EF5C53BB7; Tue, 14 May 2024 18:25:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Tue, 14 May 2024 18:25:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nielsenb@jetfuse.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-mwYtLQBixI@https.bugzilla.kernel.org/>
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

--- Comment #30 from Brandon Nielsen (nielsenb@jetfuse.net) ---
(In reply to Perry Yuan(AMD) from comment #29)
>  Hi Brandon,=20
>=20
> V2 patchset had been sent out,
>=20
> https://lore.kernel.org/lkml/cover.1715356532.git.perry.yuan@amd.com/
>=20
>=20
> the patches need to be applied to linux-pm/bleeding-ege branch,
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/
> ?h=3Dbleeding-edge
>=20
> Perry.

I can confirm with the V2 patchset applied to linux-pm/bleeding-ege, the AMD
P-state driver loads by default on my system with no kernel arguments
necessary.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

