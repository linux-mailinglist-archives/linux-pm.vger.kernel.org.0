Return-Path: <linux-pm+bounces-37256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D738C2957B
	for <lists+linux-pm@lfdr.de>; Sun, 02 Nov 2025 19:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8BF188B4D0
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34571F09AC;
	Sun,  2 Nov 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK9/2RFf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6A17DE36
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762109620; cv=none; b=rmFNGGDco9DcmHRR0WUC0m41W5/Jms9rpp2RChioMPK3Dr2OAp0Huf7azKZgTr7StM6GrMmHvqG4XeoRnipLQjPJsFJQnfzfKJTo/7W/nqyk05sek1uZkn1CDCkwVtoQA61EXMtKDefK6oguLg/Q5IvtZ8jBvgpxh4hzjTDItgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762109620; c=relaxed/simple;
	bh=XTknkfhZvkYD4iI+I6bqTQZ14nhMzsElCFuP6aK4LGo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBUF6aq+SPgRLD5YdHbLZ6RzD9KMkbTZGMx+uDULDuSVLhoy/DDRndeCvXdQNNzY8qD5oyIbqJfDxujpsaAVrMUQFFsOe+KSQdFhpvw5NQjCv7m3YiqVNj8WD4iLDHETPaxbh7NUSXOhoyvJATPFbx2G3k0Zgn6eHbNq0pDPPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK9/2RFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FF2DC4CEF7
	for <linux-pm@vger.kernel.org>; Sun,  2 Nov 2025 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762109620;
	bh=XTknkfhZvkYD4iI+I6bqTQZ14nhMzsElCFuP6aK4LGo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YK9/2RFfBnDXgs2SgqFj/H653DGP9ioDXE89JksbpU0sUQDjE4jMJtc6njrTMbFuR
	 A426Vhva1o0uCxXRkvMATL1f2QwoxHi/R9zNJO5KiseHg7+Fdy1t8tDRSHWymUJ08l
	 q9tgNk4jYVvTiUeLnUHXSCGxvBXPZw1Qr/Gxx2EknHLb7+RRvGLtTbKFyZmmKQhKRX
	 UK7nUNDpChftOsN4o+PECWLipZ09aZatu89CHQuk1+SMRrdmaRVmem8n5jWnwJnlJC
	 nrnC6wj30y94CArchGZxUr5uiKRKU3lX6DaFy1H+dtBwy3u9+L+7m/StY8hHclRdF7
	 giaC489UonfKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1188FC41612; Sun,  2 Nov 2025 18:53:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Sun, 02 Nov 2025 18:53:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chris.harris79@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220715-137361-hspE9muqDO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220715-137361@https.bugzilla.kernel.org/>
References: <bug-220715-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220715

--- Comment #11 from Chris Harris (chris.harris79@gmail.com) ---
Tested on v6.12-rc7: Unfortunately the patch doesn't fix it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

