Return-Path: <linux-pm+bounces-11331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B20593A063
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB035B20EA5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96991509AB;
	Tue, 23 Jul 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbS+xe+j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406C17BD5
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721736621; cv=none; b=J7S3kIcYXwre+23BFIFSbeWt2B70z1qSNavUD6nN6ogyiWdVvIhEAXZab6X/3UezlPCr8XHQWGKykUx5fRC1RAHOD2gdxboHOy33jF/wJKQv+ltta0+1/uBFBi/NtUEqKpvKHw0k5jjpYUUp1GcD+FZdGhtVLNGMd/cGkw9lw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721736621; c=relaxed/simple;
	bh=SEEz80Lmsjqokr2omtYjv+I/Le0PS8ES/YVWBiUay7E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pRmP5Dm5wuI9QWYyI2ciOLLvuTgdxHGmQwCpImqSzp+ApThJXYjjIfxuiIM0Z+1Nv6OU778TzaKOBwfmZvVt+NHnuj1AhUwnRMFP+PilaDGio6ov9rZUeJXPlMxmMmTnOCkhw8yV2TYKwQTe32GFh2kbVOzvz2ids9tosOuejtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbS+xe+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48780C4AF0E
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 12:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721736621;
	bh=SEEz80Lmsjqokr2omtYjv+I/Le0PS8ES/YVWBiUay7E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fbS+xe+j/cZ5cHGl4uWMm3jxxM9C6x3ZDif0T8fOHTaHPf9Md/S2S1pgajZrNIbaD
	 EgKte1bajF9kverWX31GEz9kse3evC7B4TFSCWwN3Bo7GyF07xV2wJtCoOgNKHl9gG
	 YqyaR5nczDzkaWudRxPQsPVK53FJYT1JaaU7J/Xr06HZ4jVUQfVruVPls/1LRuxvX4
	 ZU5X4Q5aXAmva1JhA5OqUCk0anA7kUhbPjfKRzpKGYQilmVg3yAd5wpENbx9lOxlrP
	 We8GcuwzeYOXm2aeep31F1tLL1LwnypfcaLEd6nCvnwV7iG05s40dyf0lsf1R53Rgl
	 t4l7fKR2mEwzw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3BF66C53B7E; Tue, 23 Jul 2024 12:10:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219051] amd_pstate=active reset computer
Date: Tue, 23 Jul 2024 12:10:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: catalin@antebit.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219051-137361-dO1Nzo4wCA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219051-137361@https.bugzilla.kernel.org/>
References: <bug-219051-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219051

--- Comment #7 from Catalin (catalin@antebit.com) ---
Update:=20

It crashed with amd_pstate=3Ddisable after 15+ hours.
Also I tried Windows with crash in 4 hours, so it has nothing to to with
amd_pstate. You can close it. Most likely faulty motherboard. Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

