Return-Path: <linux-pm+bounces-22183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F10A37C1C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 08:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4475188AB0D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9D418DB33;
	Mon, 17 Feb 2025 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKD+WR/G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95BF178372
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776996; cv=none; b=MM9NVHO2QZXOifjandzSG4V2i08h4wuv5YDTE+79vS8ODy6JxjmvGSXbCYyUJsPtczWgmiRpcgXaUDoo3pOSJQ5Cs5KuU9lEQb4xHa3vsnja7/dVAUAyTVe6Qze9gomZDFJA/lUDPXgnbOnH5g7Md3AVyk7gGeX6MUYHj/M7vWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776996; c=relaxed/simple;
	bh=/9qJNWrpZGQiqCDTcEiCx5KmknWNdnasiuXB/4CMV1Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cpnVMNT8QXJV+9Kgt+UMIV+ALE+1ADv8z/ncIHI61vUWeSIRKFUSn9Wt1uiGPIbO2dXcIhVc0BVLc6faiQg5Kursp/lEdYf1667wrwR05Ujpo5l7M3a2WuMzu7CFxdvetxMSOLSpw8Wlon1qWzDtBUhTNVyMeh35adtVQ2qOMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKD+WR/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45183C4CEEA
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 07:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739776996;
	bh=/9qJNWrpZGQiqCDTcEiCx5KmknWNdnasiuXB/4CMV1Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EKD+WR/GFL886k2txP5iZ7opDxNw5ceOl8uzB22Ym3PgYS/bNsAsn4CKvZGODd9Uq
	 Kt3GhGdYqca0SeT1brFlupFf0jZeHgWQcchruuyHhdzyiTo/WASm6T/tBrihMQbyWG
	 rWawZfFNSUSRLa1Kwg6DvQJ2taf+829ZdmYodg+mlgT3mmoIJPQgw1W2ZIhdEHLxva
	 bV3gZLYLi9/oN7R/CLHxxStQFcEo5ll3pMCcByxJOaddOAVHJUGMiRQ94c+W7RvlqG
	 fLON2PeYqE8dP7Sa+aEDvb6T+QSZAscDc3tVOsxzrHsgMO1UdfFJenIg9q0qD9D80e
	 0hgr7hIUDHp+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 37469C3279E; Mon, 17 Feb 2025 07:23:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 217931] amd-pstate lacks crucial features: CPU frequency and
 boost control
Date: Mon, 17 Feb 2025 07:23:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: miroslav@pavleski.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217931-137361-Ctn8TlUwAb@https.bugzilla.kernel.org/>
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

Miroslav Pavleski (miroslav@pavleski.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |miroslav@pavleski.net

--- Comment #63 from Miroslav Pavleski (miroslav@pavleski.net) ---
amd_pstate still is going haywire, testing on mainline 6.14.0-rc2. Upon fre=
sh
boot, both active and passive drivers seem to adhere to scaling_max_freq.
Passive definitely.=20

After S3 sleeping the machine, it goes haywire, even boosting CPUs (ignoring
boost flag) and going above the set limits. It is really frustrating on a
notebook machine, heating up and draining battery too fast, without some
significant workload, making it unusable as a portable.

I went back to acpi_cpufreq and the machine is much more well-behaved, even
though the minimal frequencies are much higher.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

