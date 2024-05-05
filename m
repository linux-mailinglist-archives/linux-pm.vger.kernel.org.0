Return-Path: <linux-pm+bounces-7508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F868BBFDC
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2024 10:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEBD1F212F5
	for <lists+linux-pm@lfdr.de>; Sun,  5 May 2024 08:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1192B3D69;
	Sun,  5 May 2024 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJz2lU6q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABB6FB6
	for <linux-pm@vger.kernel.org>; Sun,  5 May 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714898927; cv=none; b=P7elD6qiKFe1QbJ1Gu68JVIuClTxWQ9zAo7HdB23k3IxnPpMBHcHEyUfEOl//EmbBQYQvp7J+MSXEg8nRgEoGFCvJj8WJX/bGykA0gBWZUUkQmL21lNcdCiUdlLDArcdgOmP9yv/OSkqBvj7fChqPGLptdEyg5BbD50QCkNvFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714898927; c=relaxed/simple;
	bh=1HtyMZM8FRvLARleSHfNizGw5ddNl2k+xsN+rZGBAZk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dYL4BDMrGuEYKZRDbGHhAZKIt3+A63vHWY+18+brs1Y2xatrrHeJIwqXrnqP1O8sxbzkYS3MsrOzSmOwtn7pRXRBvPcUk8RlLZCQQDT7NjYE1SCf03StVwB3e9Aw06YVaJyuoXTbJC9Q2tzazipe1zRdbMSJpd1LkRTB6DqN7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJz2lU6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72F68C2BBFC
	for <linux-pm@vger.kernel.org>; Sun,  5 May 2024 08:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714898926;
	bh=1HtyMZM8FRvLARleSHfNizGw5ddNl2k+xsN+rZGBAZk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gJz2lU6qK5L1X7AotUBsEXevNFaSqaUd/pLoCdEdM7AgJhyn3A/VLSKm8BWahpeok
	 W8SPgVZoR5772PAGYH8dPqADuHbzLtw5qlyayWFhqSoZK9sJSxrdzUN6AaCxOk/fXb
	 zRhaRwmusK3FZt6cmBtL3d36VnFGooOaqQyJAl3zaFc+6axwxBEQr/LXAwCbLi9krU
	 BB9Uh/2zo4zhZPc5C/qrD5J6uOiaV2ciMhwDc18sVLt+z/yfYvqro7+JvWXsE25ANB
	 NvShdCIhHhcQiy7Tkjp3YW8ho/OKEK+t8BDdLz3EblQoD7O6b+i0Z7nyk+R4EzyNXT
	 flQst0nGO5EPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 634EDC53B6E; Sun,  5 May 2024 08:48:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218805] CPU stuck to low frequency after resume from sleep
Date: Sun, 05 May 2024 08:48:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218805-137361-yJu2Ad55wM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218805-137361@https.bugzilla.kernel.org/>
References: <bug-218805-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218805

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

