Return-Path: <linux-pm+bounces-24393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76FFA6BF7C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 17:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349813BA1AF
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A68116D4E6;
	Fri, 21 Mar 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHh7rxBd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBDE1E47A9
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573716; cv=none; b=Mssbcem59L53KO6lZrdlmodmSZhtH/MuU61CZXvg7vI+GQ7VtWN/ZnVdu0Qp3NtZSJA+6WDkfjXKRv4xg1bjcCc+E9cCYDAmzifYZw0Bun6LHlCpw8QVQ/wOm/UoA+3il6NZ3IofhMkSAIZeaPj0/XwA2/ZiVgc7VFBoEZkpQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573716; c=relaxed/simple;
	bh=pMjkzGsUshhNAdQC6Dpa6MYf92O3V+BBDPXVRkMJbCo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8swIGIfJqbtaXHtxLmaIyx4AY2/CiDdxGff72q5uLY0J02sPy6P6IV+A2p4MLBQw3e6P+tMmlJtZL8IkidTXnnrraK7//kzTLQsn8bD+sRe/JBoX0Wl5NALVCxJsczzO5YRoB9Z8hSMoH8LD4IMbkclufXacIfyjga1626QcPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHh7rxBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 971F8C4CEEA
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742573715;
	bh=pMjkzGsUshhNAdQC6Dpa6MYf92O3V+BBDPXVRkMJbCo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SHh7rxBdc/WJXO+yLK6BO6JBiI0e/tPeu+KZRS4I37BbIxeCoDGJGpjRqeB9kBw3V
	 utU0YDl3PGQ50FsbQVGNt12W4VohUEb+lW103RXdKkW/n0GfiyT02DRHphy7X8iRI6
	 t50NAXL7q+kvD+QnQkN0K6Kyo8vJIwxD59KELDWRehjsuV5Qxh9LnFGPFctW7RjY2a
	 Ir3i+ByYnHXv8ZqBIGUL/FQe1PuRtBN6anAo7hpxMNUeglwnKBq0F+1VKuzbRUDBcN
	 UGQ5v1E5d3OvnItqid4+ls54uiNkOdmbB6VSggPESnxbMDrtAzWTsIB47bBXcMt575
	 VkKXRIcAHcM/w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 80DC6C41612; Fri, 21 Mar 2025 16:15:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219858] AMD Zen 2 broken power management after sleep
Date: Fri, 21 Mar 2025 16:15:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219858-137361-q6PPpgHNyO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219858-137361@https.bugzilla.kernel.org/>
References: <bug-219858-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219858

--- Comment #6 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Got it; this is a non-MSR system.

Try this patch

https://web.git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commi=
t/?h=3Dlinux-next&id=3Db7a41156588ad03757bf0a2f0e05d6cbcebeaa9e

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

