Return-Path: <linux-pm+bounces-2852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3583FF79
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jan 2024 08:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52FE9B22780
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jan 2024 07:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B04EB4F;
	Mon, 29 Jan 2024 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um1ChlK0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70D5821A
	for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514828; cv=none; b=eXFd1U2RzaMfRQBinkFVPJH2JREDCtWAqQpdueT4ifd5Uc3vITWG4Z7rYpiocHNbV3jtocrHfoxt15JqjBC2V7BdYBKVaheP7xKzKwnxN06+sCCsfAENRo42WghXgIU7N4MF/p1AA5ofecsGItOQkK4nQGXmfiFiCBtMfh7RhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514828; c=relaxed/simple;
	bh=rqLnsGV0Dsr03J9/1S3Dm9xBB3DlyBy77N8L3fcc0pw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0d/fe5Je2lvOxxKOq2LKk8dC5lrHP19DKny2cPHWvr8DO/kghXtjvsZqZW51BXsTaX6s4boQxQnQ4U12wY9s94aytef5/bwEoZn0fcr79pHSYN5II0NsD0MhpnVAFUJb/cS0O1biGov6FQkUIw2nEKxLxyF6OXSwsPpGGAW3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um1ChlK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6B08C43399
	for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2024 07:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706514827;
	bh=rqLnsGV0Dsr03J9/1S3Dm9xBB3DlyBy77N8L3fcc0pw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Um1ChlK0ki4Pj3PmoW6AzYPYffh4/uBQeBaA4/LHHS8SDgQpGvGr373GBuMFF+u04
	 jZCSXoTpmNbwvNuoaxyjfjwFiXFUPVADrwl+iigPNv69PRYcw/a1opn31Q7UWsneVT
	 yofBlR0cmeNOMsKn9c+t+yU5whXsnyVdnpBWWImTlTQkcd6SngI0gO8p8SZPth5eEW
	 VgrZoJsQvFMoO0a3wJN4Yw4+nrCcOwkQgqNgRJufA4PdZqbQpJCmEZtzZLaEniO5GC
	 Tkap6gWirbMDAI8l2oqS5BWIq40qjj8pUyp601s8UXTsDiWMPLEi1nJB+7VdKZygVc
	 zMkj1aDCMUxvw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 91858C53BC6; Mon, 29 Jan 2024 07:53:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 29 Jan 2024 07:53:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217931-137361-xcBB98VCjq@https.bugzilla.kernel.org/>
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

--- Comment #39 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi all,

The new boost control patches are under reviewing now.

https://lore.kernel.org/lkml/cover.1706255676.git.perry.yuan@amd.com/

It will be great if anyone would like help to test this on your system if y=
ou
are interested in this feature.=20


Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

