Return-Path: <linux-pm+bounces-24810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A71AA7BD3F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 15:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8D83B4E4E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1FC1E1DFE;
	Fri,  4 Apr 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZSXrU7O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C11DF73D
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743772163; cv=none; b=FH3H8FHfM3Nelh2mBp6YhI3Az7IpTFJ1msLjTIY/xzKNLm7E818XSCImLP2N4U/i7oca0EUdDjqF5LcDbKqzuLtCmBTPPw0hYBzK2P8WqeF+hH5zccMSlDErzukdzcz3zNZVTYrYvEy8l6lhgzM1TZof917K7GqWWDOupsWcrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743772163; c=relaxed/simple;
	bh=jS+01n6UwLvjSlTLoFEgglhBblokzoCCFLKVl1CjzPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nf+ifaLfyYBppRrh1AExbxCZWK+aNgcHIYgm0FGY7atCLSYRNxkrDEr9RWPd1ClblcotmyACa/GkFVuLjfNuYZvsk/jZG5PifoMbPddtr7mkDaNHpBERAZ6/R0wPs5hXcujWChu8lQ7dXRXtea6nuTv11RLLEskYvS79EjW42Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZSXrU7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CB90C4CEED
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 13:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743772162;
	bh=jS+01n6UwLvjSlTLoFEgglhBblokzoCCFLKVl1CjzPo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fZSXrU7Ovbm2XmWlxH9WAnvG9wTsanJkWuRN+kGn/o5Dqax3d0wyrdBICttQK6AU/
	 +9e14xk9A7sBJkig7jWsbEByq/jJtg1mXwtsn8yxC2305pmsE7rIiCllhUKimUMBDn
	 8ObZsWB/0FVqpvHK54RNWYWNqdUXeZvXnZXmXmm394y6mPpBEMAAmLX+JnN0GnWkTm
	 pkhcWe+TXXLv7eiaYxye4vyKiUuFQ7kASngUBtMmQ5J0tuxoSXwPyZe9+jaCDo0ecd
	 OcOG7c2/59TX3PquoEqFsa0uM+5fGVR0CbXwPGEUzvG/4lIJKwTZhWY3zuWbkajNp5
	 96BUMKruoIBXQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 422C2C41612; Fri,  4 Apr 2025 13:09:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 215938] amd-pstate ignoring scaling_max_freq after waking from
 suspend
Date: Fri, 04 Apr 2025 13:09:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: vincent.maurin.fr@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215938-137361-Ydaevpan9W@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215938-137361@https.bugzilla.kernel.org/>
References: <bug-215938-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215938

Vincent Maurin (vincent.maurin.fr@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |vincent.maurin.fr@gmail.com

--- Comment #22 from Vincent Maurin (vincent.maurin.fr@gmail.com) ---
I am seeing this issue back with 6.13.8

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

