Return-Path: <linux-pm+bounces-7100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB058B2511
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BA9B2650A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Apr 2024 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781E914AD35;
	Thu, 25 Apr 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l192hC3o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269214AD2E
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058798; cv=none; b=nQqkMxY7Z9GXnIOd/2SsFgYz1tKGx7ZRr4QqGcltfg+dG4zxEoFysbIN7Q43pNiWISdt/91pQtkUGvBI8eYRNJdjlkPZ095sSEeEYBru3dhQVETD6TtLK1/GM9I8TniYWYi3FHL8lKIinp38n1wyF7R66VGF2zLl7U+W/lgQcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058798; c=relaxed/simple;
	bh=a65zkfHGiDbqAcaZhO1NPDY28w7/UoVvoyUBB63IhSM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qOkOmZRg5vp07/iSLRdC0c4Yyg09e2FATcHXMHuGdv1BvKEp9RHefIeJqHEUCAh4+lOchwHpG86UPttdxtMmGLsFVvIFQfAlwDnHr55J1Q9wpX+QDf58cIrJGCUktxOFxIf73J9V3SjFPBqr3KDZU/YzNviM7DCAwCm5P0wROws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l192hC3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27909C113CE
	for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2024 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714058798;
	bh=a65zkfHGiDbqAcaZhO1NPDY28w7/UoVvoyUBB63IhSM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l192hC3oqOZi4bDPDgXx75UB6Ilmj1Dv4Fb6eWh5+bKTMMzFv/35M6D+8Bfj/LebI
	 W3vMT8oB9H7xmecpPcGn5F2MxGkSj+gYsbA3rzOtfvv7aKG2JwlqRL1LQEboTnSavM
	 +cAfsJBswWGJfNDrc3vC+dfuHu4niUWDbiVL/3hIbTMr+3EjB1Obj6EuPM6A4HbwiE
	 DeS4us5W6PI3MAXrnOPHF7tW4/OTeQzklIlO7fwgu4pYGz+NxSzeJUZpt9G/5U+Ofb
	 nzHiNp4snxpqwbOX8dsEunrUyNf9ZX6lfFTa3wib3u9YGlkWsi9/KjTvmBAtVEWVDb
	 cOTOc1gZ+O83Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1F1D7C43230; Thu, 25 Apr 2024 15:26:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218705] amd_pstate fails to load on AMD 5950x with Asus ROG
 CROSSHAIR VIII DARK HERO x570
Date: Thu, 25 Apr 2024 15:26:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andamu@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218705-137361-UM8t03mhc1@https.bugzilla.kernel.org/>
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

--- Comment #11 from Andrei Amuraritei (andamu@posteo.net) ---
Created attachment 306209
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306209&action=3Dedit
lscpu -ae

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

