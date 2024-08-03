Return-Path: <linux-pm+bounces-11876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E9946AE6
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2024 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F255C28169D
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2024 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E2E182C9;
	Sat,  3 Aug 2024 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGKYBcEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E317BB5
	for <linux-pm@vger.kernel.org>; Sat,  3 Aug 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722711253; cv=none; b=TaCPABKMqe9gMjm8yQ27R/yMeKJe/0fCctBLMT4f8CRW/fkoqGf9m1FpNCWZIuwr+tRD9ZtNVMzSJiSv0DCC8FyiQCH4wL+9otLowUl/A3IFQ0EYEIAQskBkI4ILVT8mEVipQEzhddN+oiOloaAK+BgqPRVwmszjc2JmHHHY9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722711253; c=relaxed/simple;
	bh=t2+OxIHd+OLm53dnOJ3nbE4wxWrQSwqR2i/TKCrNx2I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlE/Hz+l26/k+4WnMH489MrzOFGCNkEbWoj4wKmCZ0Lv3+tvW2I+tisWtZmcnFyNkwrRHKP2wz0p0dbld1xh8oSBssTdZqHGvSo4Hoh5F2s6fWQBeh1cgUyeHFqK1cbhWRma5qmQOOoqQndRI/p8j9Ys7KhTLrVmS1T8T/FK420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGKYBcEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 673A2C4AF0F
	for <linux-pm@vger.kernel.org>; Sat,  3 Aug 2024 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722711252;
	bh=t2+OxIHd+OLm53dnOJ3nbE4wxWrQSwqR2i/TKCrNx2I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mGKYBcEF532xMSYNvnFxn/0rdzGqgCs76XovDN7R3vsftVEKhYII5By3RI2WEz5uM
	 3oHMxe1bpNY0G1+1RTkEQ1sBCYKhQ1n9YKpuul79MqqfGZuzODjqaTbPH3Owe2KNuT
	 FNi1YigSCHlY+oyI1IrMZPUBR81bKUr6Vxfc/r8WI2a7fP67gooXXtcEt1RHFeKv0H
	 2Kf+ldfOBqF1SedatOjjei/OmKDwW0AafvJhyBM540LHTbh4YfYAUIt+Yieol4FbiX
	 xsWDYqwqvvxyYk3xyko8eIRdyNyUlwEZvLdrzWQfFe8keZiJBK2APCJi21o6VxJdCf
	 RLLwlU1UXLxhw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5E26CC53BBF; Sat,  3 Aug 2024 18:54:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Sat, 03 Aug 2024 18:54:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chemasanchezgarabito@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-HbZF0howna@https.bugzilla.kernel.org/>
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

--- Comment #69 from Chema (chemasanchezgarabito@gmail.com) ---
Created attachment 306661
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306661&action=3Dedit
Smokeless UAMF options

I have booted Smokeless UAMF to see the hidden settings in the bios

But so far I didnt find anything related to CPPC in all the aviable paths

The only thing that seems similar is something about "Custom Core Pstates"
option and PPC adjustment in the CPU configuration page.

I attach 2 videos, one showing all the aviable bios options and that there =
is
not one for CPPC and the second video showing the CPU configuration page.

Sorry for the bad quality of the video, but the max size attachment is 5mb,=
 I
can provide links to videos in higher res.

Hope that this sheds some light.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

