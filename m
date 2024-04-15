Return-Path: <linux-pm+bounces-6389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D2D8A4A7F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 10:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB701C20EDA
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36232CCA0;
	Mon, 15 Apr 2024 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpFw0n4F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54938389
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170233; cv=none; b=Fi8ShDlKuRsymq3oLqcrazVObJdKr7cENETrlnpPVFokqwUKzWZaQDqIllFnqE423KfuDdwfWqLqZqYEn9ehpY332Sl8VtIgTSRqLcALV3//Q0hRiuoYM7e2yxZmb9KTsOdNtF+DwPjFh7vK3wdcSZTZrtpaygBryybIF8EL5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170233; c=relaxed/simple;
	bh=AX4s3fShXnJ26QFLn0OCLio1KBeMpwcv4L/sOGHdR0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oh0mKFyxc9Yf1q1mfQRG5FJFSCY+FDfgTD00A17Fct3YVZ9IbPfl53rxBCzP5FTF7G9ST9+ls9lhnfBPqgrAhJoawjY0xvAYYxLHKQK9cc7Pb58YNb7dVS5GXEmYFBBhai5M+ApdOQM7btlPCZaRXd5gfVA4SherLe1g+flKaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpFw0n4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45F02C32781
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 08:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713170233;
	bh=AX4s3fShXnJ26QFLn0OCLio1KBeMpwcv4L/sOGHdR0c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RpFw0n4Fu1XkQWsnrTke6RTpftXxNDD08Opg+GcWpUHTzNusSJmkJWyjFkMIUvmlw
	 CuvbeeHnI0n/EiHIwDXVSRBFhI1TQ7DtWow7jDnG44DWFBOgN8on/8yZQeAvd22eT6
	 oHxXkaDjD0YQVbWZJSnSHnjIQoe6H3lLvPsSO8LKEdDW6G4DaC7e5WFqFGi+LT00y7
	 necNV0RZRcOc6XQUduvoG27y9CETSfKjkxHR8/5HNQ2obRUxA2x7PSwEndlYFWGuKM
	 TSU7xQgKt9xt+aSFYdcTS4p48tYUXRF0lFzkYYnCnwCQGadOZ1RwHnj2p+xPEu/nLN
	 KXeIH1Him6dLw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 39DCFC433E5; Mon, 15 Apr 2024 08:37:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 15 Apr 2024 08:37:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Perry.Yuan@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-8PwQziWfPd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218686-137361@https.bugzilla.kernel.org/>
References: <bug-218686-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218686

--- Comment #38 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
Hi,

sudo apt install cpuid
sudo cpuid -l 0x80000008 -r

Please help to provide this output.=20

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

