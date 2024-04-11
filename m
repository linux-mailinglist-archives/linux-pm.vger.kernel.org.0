Return-Path: <linux-pm+bounces-6256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB548A070C
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 06:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7038286B70
	for <lists+linux-pm@lfdr.de>; Thu, 11 Apr 2024 04:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B708C13BC33;
	Thu, 11 Apr 2024 04:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCbRQbRh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F012A1DC
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 04:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809219; cv=none; b=l73yEQdteLtDXd3OtMIxFnfSXcOjuZpwtp5KDOIopVjJp4n0b7cqlypSdpULmTsRepEZI7aa/FMl2dYCj5k0KLdBxu4/csPkXoUzMr8FM4nfSEoJnQlb4gXxb9BDdi7IMpi40D8+5EVFwmge/rMYUQfMCLRhPI1v5SD9HPcJL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809219; c=relaxed/simple;
	bh=C9WZB+11w0Alygf6AaxMeS3FkKBDxphGhx8SENn8yNg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trB3ruIVdBPMcumAu86GJOKnDvkHI7W7q1xK/1FyYRnImk2Kmjo66Ah5AVfiVZaLJ/N3QN9O3nmEnMeem1lPXrxBR1drnCZzMNPfQSL7vRXz4VgpEXat789XzUcY4GBa8rbJE3TSfAJS0tvz1H+FRZ6cxnZ4mKRrQrxN+lDD5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCbRQbRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70D82C43601
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 04:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712809219;
	bh=C9WZB+11w0Alygf6AaxMeS3FkKBDxphGhx8SENn8yNg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cCbRQbRh5fsDzx6fbh87yej2yc0+b1pdcdjq02oE75sjFAxjTFNP6GzDVC/5qU0nc
	 IHT3wpaXGW1uthSeGMTd08Pkil8e41abu3s4Yc9aabD/1dQmnO796rGbFMVA/Zuom6
	 7khqYfP36UN9o2ZDR0U+aAxug2gfGjInvrv5OIGO9z61DBUff25tHDLgaq5HP/Lzmo
	 qNc8wIRsACPnS+MZokuRhCEnl0bMkAiy3bRr2EC1z+TAlcOZ0B/KbaQ+0KhnJnLxC0
	 K092CmgwqyO4q+JBWEKERelOyNdSe8llgm2ovYLKz6zGiKU2BibTphwFqK0qJLGNhF
	 Gtm2Ig9OqkBSQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 60D16C53BD9; Thu, 11 Apr 2024 04:20:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Thu, 11 Apr 2024 04:20:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: al0uette@outlook.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-MhIyGibJ28@https.bugzilla.kernel.org/>
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

--- Comment #27 from al0uette@outlook.com ---
Created attachment 306127
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306127&action=3Dedit
Screenshot of Windows event viewer

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

