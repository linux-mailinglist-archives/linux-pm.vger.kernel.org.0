Return-Path: <linux-pm+bounces-37336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 475D4C2F08A
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 03:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A9134E18D1
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 02:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDA525DB1A;
	Tue,  4 Nov 2025 02:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+AUa0pJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF71FFC6D
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 02:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224924; cv=none; b=GTfjpetSCKVTuY5h5z/tKXmRWquMXMR0dvnqFNEgzubRScxkWqYNo5cKzhh7hON1QZh1fYdvv+pkAo1wLxQo/WQbb2VM3nLpUWO2dl3A3/a1FftDbsBKf3caepFVEqJU4ssaFyIxrHGNUYByVfuOKyK6bZyCw7mq//+Ygtn6Iho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224924; c=relaxed/simple;
	bh=DzindCvsmcIGyVzwPQRoEe+00xgQdAMs5df4ZeAqxZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=boB06+GkwyyzQyd9X9xzf7dWXawNwfmSRJfzadWxzXv+/UcGxwn3W5hbwE/DRfo6YOB78vtqrbj2028y1kuFLL6LJ7DwxTt8cpBbQ8zBpatIK8iwGP2eDGIJiL9KA1H8xq9soFDkhp+JOxki+vnxVbNbaP66sArmPvWpmxNLebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+AUa0pJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 538E7C113D0
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 02:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762224924;
	bh=DzindCvsmcIGyVzwPQRoEe+00xgQdAMs5df4ZeAqxZM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U+AUa0pJkRYOkxV7Tl+pPtRpdHSj7BSDH91p6CKCb7Ag5YmMpOpp2TwOMYIWAMDMu
	 scgC2xWTT6UyWprCrzBatMw1Sh89ElashFPGwBUs78BqdQ4N67WOx58s1X2OFX0mWy
	 XtUSgrd+Ec/0ps7FVD7LzR3U60s9l4p+dspjnxZpkTwc+PqIs+hKDVBU+fB1lHcG1P
	 OFh1laQLF3mDzm0J8UoyuOCV0la5NrMBBlt8I06NHWry0ODZPfJJW+XmDrtLYJOTHh
	 tAfKIUBMlKELq/a+yCjK2tSvAGwIQzpnf567zwSzZUaiWidgdtxnDWgCp6bRzwTopM
	 +MRN/n+yNCZkA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4E0DAC41616; Tue,  4 Nov 2025 02:55:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220715] [REGRESSION] AMD P-State fails with "_CPC object is not
 present" on AMD Zen 4 between 6.10 and 6.11
Date: Tue, 04 Nov 2025 02:55:23 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220715-137361-2iOUosBGmN@https.bugzilla.kernel.org/>
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

--- Comment #14 from Chris Harris (chris.harris79@gmail.com) ---
Created attachment 308889
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308889&action=3Dedit
acpidump-6.17-patched-final.txt

- Complete ACPI table dump
- Same as previously provided (ACPI tables unchanged)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

