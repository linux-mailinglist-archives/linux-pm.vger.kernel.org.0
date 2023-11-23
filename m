Return-Path: <linux-pm+bounces-102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC47F58A4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 07:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B603B28167B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 06:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B3C11C80;
	Thu, 23 Nov 2023 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv34knoG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC902125A2
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 06:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E6BCC433C8
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 06:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700722389;
	bh=fS3BVq0dqx/PKszjpYBuVPqQDwYYAeQkLjNATWpoT0k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Lv34knoGMHwN4gtk6iAYJ9KDz5aqIaoXF1ZOvuGb5632TCJHQiRH68/J0rDQhLkmP
	 LWVFuXCleWGvotEKBGYV4LekBZ5k5giviXtYgxQu5AkBvNCdkYGmswpqH8qwt6UcBt
	 PJN94rH3rVbx+ja5j06NW4UmKSRidtKK/vTjpUeyqvk216UrVM/EE/tiKoKxRXq/35
	 s1dTfxp/kSU+QsxKv7Lq4YqrxHZdNdRqyAIDY9bODMozZJRdmZno/wegNH0yb1Yvql
	 Wdem7vZUKIyuFiKuEcWZ7cQJ+1b3b956/q01WMVp+B3f8J/B3VjmgldlLW4vZSKLfv
	 WTAqk407s39VA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 59F19C53BC6; Thu, 23 Nov 2023 06:53:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218182] CPU stuck at 4.1GHz for amd-pstate on Linux 6.6.1
Date: Thu, 23 Nov 2023 06:53:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component version assigned_to product short_desc
Message-ID: <bug-218182-137361-aHxwS88gIp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218182-137361@https.bugzilla.kernel.org/>
References: <bug-218182-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218182

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Kernel                      |cpufreq
            Version|unspecified                 |2.5
           Assignee|linux-kernel@kernel-bugs.ke |linux-pm@vger.kernel.org
                   |rnel.org                    |
            Product|Linux                       |Power Management
            Summary|Kernel 6.1.62 cpu           |CPU stuck at 4.1GHz for
                   |frecuencies                 |amd-pstate on Linux 6.6.1

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

