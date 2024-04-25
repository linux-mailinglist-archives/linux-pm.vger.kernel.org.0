Return-Path: <linux-pm+bounces-7046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC9C8B1997
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 05:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96F61F2183B
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 03:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ACB17550;
	Thu, 25 Apr 2024 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwK0NTxB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0572943C
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016212; cv=none; b=KFuJjBTdFRmVgLe9wRE9NOd/8EkaIH9FM4zSBNXktqbGITeMg2C1nKtYLMiZlK2/b+VkjYqD6RVSwnGry5bQi4WXRJ3qGAj4eK39I/LqKjUn0y36wxoyZFKEQqLvGvhuDNmdEbXC4vlYJeGQNzRZSEL+sG6/CYixdviHWNgr7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016212; c=relaxed/simple;
	bh=Yb8YcX2X6xucKUl0217/JKy+FombzZRwFIbe/sVg2yY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBUk/OKSIyUN/g1Yl42kCljvFUozUffP1NjRHVuji5dquvujDLd6fwQB/u8W5xgXfhDkzk9rmu3yNMXLaAVtSrDhwtg5dkymh+NLXAjzaa33+t00ckDf4iVXBDcSPZo6vJrJIiNUlxPI3UQCn5hTQ362aooZJyCOeTjUM8ZGpwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwK0NTxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F069C2BD10
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 03:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714016212;
	bh=Yb8YcX2X6xucKUl0217/JKy+FombzZRwFIbe/sVg2yY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XwK0NTxBi6H8KD3HPrrn0PGCLcGAtNthG30uODA4AkyrFvGAs14yRNcY8olhBRcPZ
	 scLC9usiNhVR9fe43rPlmy8e+oAsi7PRRL8ISiKJpLpeq+NKoGPpnYTQE+4+l1SblF
	 WFge7pD8ENgCxSGmTkamd+osTkCC6n1xyz58J29XoP5B9I3wKO/rV5e8e751qOitMy
	 Pdfy9Bf68EbgLhWcq7ofwpDdDutink82/4NUMho/RFUV4gLVVkzGp8ym6tVOA3tGNa
	 CKMgjQqHRUcmTdp721quVJK30Hezb44VJirVFIwpn2QfFSeXDnEJD7+jbKmiK6qO6r
	 P7iZ1S5UC3Bzg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 413A1C04222; Thu, 25 Apr 2024 03:36:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 03:36:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218705-137361-08aX5RSJ6j@https.bugzilla.kernel.org/>
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

--- Comment #6 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
I have confirmed that the CPPC capabilities are valid to enable pstate driv=
er,

1) sudo nano /etc/default/grub
2) add ``amd_pstate.dyndbg=3D+p`` to kernel command line.
3) sudo update-grub
4) sudo reboot

then share below logs to me.

# dmesg
# lscpu -ae
# cd /sys/devices/system/cpu/cpu0/cpufreq
# grep -R .

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

