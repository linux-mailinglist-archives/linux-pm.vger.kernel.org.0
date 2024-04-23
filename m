Return-Path: <linux-pm+bounces-6885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8F38ADDF4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 09:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2621F22349
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3BC286A6;
	Tue, 23 Apr 2024 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stKpWkbi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DC28689
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855796; cv=none; b=CksCp1BdQpdUI/EzkLmP9enWA+bWnGJk6qIUgHib3gHBuh92wODwburPthNCDYtYedkHXI0/h2mOdMNlYha98+FVRf93nFutLXzP5MGGfbaCynDktg9wXOsBnmV1CQBJpQgbQfTNpSRXgZKz/vX4SCQqkAR545vKR/4vwcA2m5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855796; c=relaxed/simple;
	bh=IaaTk/EWdXZ0b03D4MtgH3hZRIkscD8zrzp8RQw6qL4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mr9AUF4ksZ6QjyVa22yPxsJ5xkFs4/0mEH/Yhz0rdYo/o5omAzpPdUzZbFpRQgBgBpoPVz1dkhg3NqsnlGZo5oZz95dcUEKnavfsavekGQaFQZVJnDyWTe6EBcxwCWnc99KQABKLx1qtz37fGHE2wbTkK1B8EAEBLh/hkUt+5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stKpWkbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AA1EC32782
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 07:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713855796;
	bh=IaaTk/EWdXZ0b03D4MtgH3hZRIkscD8zrzp8RQw6qL4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=stKpWkbiWxNF4KEI2m5yPzviso6b/zzypJ0ktDE/M277DWTDDNF+DGShALxCiTrn8
	 Wxa1qJb2qHrN4hbVljfDFqdxqObJcgvW60IuPMAQMdYaZkpzrpRolNafuAuwid4fRt
	 4I5nDCHqLtsPCwfjw0Uj3h80LS63DwV6aOvLD9UQj5vYW5rpQWbBiDEgQTZd+ZV5Vi
	 XTIbVdQD0VLCCbxPMM2NJPjNpsSVWyifjfOkpPF+ijRd5x4jJS31vrofmHlHnSlkCe
	 E0uKO/xQLTkCb10mWZ9wlsM70DXJVf/E52NmLiX9zOoiPFPirRw6Pd9LP+shcdnQMj
	 02iJAVCIhXqOQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4E8C9C04223; Tue, 23 Apr 2024 07:03:16 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 23 Apr 2024 07:03:15 +0000
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
Message-ID: <bug-218686-137361-m3NqKatWWK@https.bugzilla.kernel.org/>
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

--- Comment #43 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
The issue has been confirmed that CPPC is not enabled by default on the ASUS
GA403uv BIOS release. AMD has requested ASUS to enable CPPC in future BIOS
releases. If you wish to expedite the release, you may consider contacting =
ASUS
customer service.

Perry.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

