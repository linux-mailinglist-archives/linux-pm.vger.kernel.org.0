Return-Path: <linux-pm+bounces-1712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A975382169B
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jan 2024 04:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C77280F1C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jan 2024 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28553A48;
	Tue,  2 Jan 2024 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1QBM4lo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72320F8
	for <linux-pm@vger.kernel.org>; Tue,  2 Jan 2024 03:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A4B0C433CB
	for <linux-pm@vger.kernel.org>; Tue,  2 Jan 2024 03:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704165812;
	bh=y5pZ8GH4xZYQjG9zYnsfR/EvZQawP79ue7Iy9Pt178g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y1QBM4loOEwjGMH3yfPR4tjfqpQhpzCBVvDQPJpi0LRlj7rF+Sm5AvPCijDlbzTY6
	 Id8nEW4F55BniyFziHwDlpL7hZwFxC/YwQ+eXtz+CyId2khTVElySlGAHDBWw26IiQ
	 44CT616pQNcauwBgGRyaBE8vpCNiu68ImuDbvLi7r/wH5mqr5ALYJ1Ox/BkvI57JLt
	 /eA1rJ9cyUZjyT4Vk+ZvC5Ko8G3sNfwJ+hNwbyPOTCVlefXZWi04LrpeYB66Ioy1My
	 rt/fiORE2nGiMF7bDDq7hizeOJtMiC5/EZQxv2yXPXEYinIfEZEPfL3GiQ4bF7troX
	 LMxqdy2jg99Bw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 610A8C53BD0; Tue,  2 Jan 2024 03:23:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Tue, 02 Jan 2024 03:23:32 +0000
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
Message-ID: <bug-218171-137361-sRGe94r8pO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218171-137361@https.bugzilla.kernel.org/>
References: <bug-218171-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218171

--- Comment #23 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Pedro Nascimento from comment #22)
> Created attachment 305671 [details]
> ACPI dump for Gigabyte TRX40 AORUS PRO WIFI with a 3970X TR
>=20
> Here's mine. Note that this is a Gigabyte mobo.
>=20
> Machine:
> Type: Desktop System: Gigabyte product: TRX40 AORUS PRO WIFI v: -CF seria=
l:
> N/A
> Mobo: Gigabyte model: TRX40 AORUS PRO WIFI serial: N/A UEFI: American
> Megatrends LLC. v: F6
> date: 09/07/2022
> CPU:
> Info: 32-core model: AMD Ryzen Threadripper 3970X bits: 64 type: MT MCP
> cache: L2: 16 MiB

Hi Pedro,=20

The BIOS and some PM firmware are shipped from board vendors, I can see the
pstate driver can work well with our CRB board, but the final BIOS release
comes from vendor, If you would like to get CPPC work on your board, I would
suggest that you request support from board vendor.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

