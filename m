Return-Path: <linux-pm+bounces-7047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC4E8B1998
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 05:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85A0B22ED1
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 03:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112241E492;
	Thu, 25 Apr 2024 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM6crt5Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E929D05
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016213; cv=none; b=D2zE/9KQRblTE5AvQvwvkNF2IfRScaLqvcOm7r3v4W5ETkHmONp3GyGB8guArysZLhY6GEMkIa41k6+95vMlaLBm09YEJjs60K2IkM8LSAP3sf73XnkTmgQgHewgfgq6iSLUvvY61bPpnxHgPabYHg83TNKcT+HWaEBuiV1/fv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016213; c=relaxed/simple;
	bh=aGnlyO1Wu0uBf/TTxRsA62ODOxRQ0Jxa03wOOkVqzOY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mXcuX4VZdDDyDf1T4vsOZ283cXTOz0wwL/c+hts+o8N1+oSl8HOY6LeMYV8o3skSwqYGQTUWf0bJdtWXAVVvAhvxD+O1TB99f8XDbTWLtNV7SS8yYt/wWj0n4XMB4J5CA0ZnK9om4aQAyPzUlEQkpWsH4Kq6G6g2fkfpWaoi88k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM6crt5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76EC2C32783
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 03:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714016212;
	bh=aGnlyO1Wu0uBf/TTxRsA62ODOxRQ0Jxa03wOOkVqzOY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kM6crt5ZEoc0W48oRkbMenODd08aIK6EW+ugnkafggeFFXCXUanyvtewxmHdFf2lV
	 c5ISF9Mk61PM1CzYFMzEKNAwt2z/1xdyaskkRNQwH3U1ZxKkTnrYCL47MuCR7P3GdQ
	 pGpvI0YyhXJESYqtRjxh4LBWqELkRUBtvLFtoLW0fDOrZFihVMoz9+p1PqqPbsSqGJ
	 IlFUSrPVeye512MgjbaaoqXp0d1gh4viCXQ+YqOXS8+83bnxnqdFZm5VbL204nWoC2
	 m9PkExhc3mSwu4wXcLtpOo7eA+MJ6VOwcol53q3nq6Jmpgm8ldAHE5ZkwUBLCd136u
	 FNL6W/Z9WdOAg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6B2D3C433E3; Thu, 25 Apr 2024 03:36:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 03:36:52 +0000
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
Message-ID: <bug-218705-137361-KbGvoekWGI@https.bugzilla.kernel.org/>
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

--- Comment #7 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
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

