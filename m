Return-Path: <linux-pm+bounces-14901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF19895A8
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 15:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDD51F21154
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2024 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8825E1E50B;
	Sun, 29 Sep 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWstnQc9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C6AD24
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727616277; cv=none; b=IFiXSJgflNPCpOKY70BB2Jzb2k7khDMwsoPByxLUd3sRHK0VLUH9c3nXuAFb4dnXDDGtktfQVC2eJ+EEAL/pVtRuyVKvaZpYCBg3YqjhoBVvyS9lVWeAUexwpHf9U+8I6xo5iK7Qc3I6gApWwIiFWewmk//p0D/v3haPHOTbTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727616277; c=relaxed/simple;
	bh=7OmB8953VLJbVKUmLzsw+2aajNTllyj7E9lmyPCNrc4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XMGmqQ41StHTDyWXDbcBvQJ0Elec/GhvL/dSJ7og74kjlBtR1R8kFrW6zIbdXOtbDfGRnNVOCyEPlqoKxRXua+pAcG3hZFsiwNE5w4C0+f4fE9WxZuc+V05Wi/RzF5jEmmZPZy+24h0You38IcqMiiDbxw0zyX9CdI3fPsm77QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWstnQc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBC3CC4CECD
	for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2024 13:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727616276;
	bh=7OmB8953VLJbVKUmLzsw+2aajNTllyj7E9lmyPCNrc4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bWstnQc9HcQztdkmGqfPe7FiC4KJsz9cmbBcz9KoB89o3sfcPQOSEG+FNHMhj0Thu
	 2IznrrBSd+YtfR3694zJfcXFjU1eAuhyv5YmpmsYyD3cRiOSazmssBEq8ihilkbUp8
	 45NjDYudPCA67oH7rXzZ5eaYLlsYzbnSp4s3M/FX3dzLyswU5lTQM+9dDQeh3kdfaY
	 /Q7AhP5En7sdDPg7uJrK/QObau5vSDhG/fUGGQGQGUXVNhFW3eVwr9akYa7XSYz6CD
	 7uLLKsNLMZsvwKXsNx+llyggIpjf5omyfFKEzFqEsQHvBKEyrPwceeKxtAdiRIPrgI
	 rMraGNckTvw5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 92EA3C53BC7; Sun, 29 Sep 2024 13:24:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMTkzMzJdIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2Nw?=
 =?UTF-8?B?dWZyZXEvcG9saWN5MC9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZTog?=
 =?UTF-8?B?RGV2aWNlIG9yIHJlc291cmNlIGJ1c3k=?=
Date: Sun, 29 Sep 2024 13:24:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219332-137361-UipnDTqQrh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219332-137361@https.bugzilla.kernel.org/>
References: <bug-219332-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219332

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
What I also do NOT like at all, is that in Linux 6.11 amd-pstate gets loade=
d by
default and there is no information about that in dmesg.

Please kprint() that amd-pstate has been loaded and is active.

Thank you.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

