Return-Path: <linux-pm+bounces-16580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD30C9B333C
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 15:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884891F223A3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61CC1DB350;
	Mon, 28 Oct 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB9DMd7u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D413D539
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125253; cv=none; b=EhydomVS6fk7BN0K1F35b4v6nLyrMty33oaYBTUeQ3ohYrM2xqs6gi6wow+poXRW30xL3XmxioRqpVAZL8V/AVSIbHj4jvAMCgeLgO0zZi2Xc6GIQ/G2dnh/2/qSdV3O2xxjR9M1tSt5q/3CyqfDdkVYQzI46v5D0u1/fqbUVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125253; c=relaxed/simple;
	bh=SW9Ac7MSYoQolzdV+9WrkgUcPqTUJlHrbU8IFNeX02U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z3+70+QJwZE87faeTCyvmqKJjeKOGMK2z1NvYiLf17Pb8mgTPcL3wlP7/c6xO9ifMmruHtV11WFxkLGmfwfHW0PVJfXHV7hw8E6B79/cozMdcnWIMQC2w93FBgk8ogRDIWRxxpEos6L3dwOFO0lq7aNQuLSw9eS+a+ZKkl3MKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB9DMd7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77820C4CEC3
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125253;
	bh=SW9Ac7MSYoQolzdV+9WrkgUcPqTUJlHrbU8IFNeX02U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OB9DMd7uicPb6b292NrlD5Z2D+4EXWWmMT05p1NZYA74tqtbqIeqT9wQKGeLGvEgX
	 RO1cQ+zrE7ggIuDqEZ/6AYqqjE9kDO6GgRV0xdO7mluUmEwvBE0t+GcRFl0ohPGEke
	 miOoVKlY344ojrxg0CvcZZ9h/6ZBkdks2ltR/WaRw/w1FcF53Q9MBgM+98bGKUtIlD
	 FYTpTMppjLZeNu+CkNEjqW0olQA8fyc5WkIkGsQevkKmGP1nK9BtDvPwTZi2e22Jsi
	 hAZGgpEiV4s09DKnmGnoFuqb5a9j/ltNpY6V1y6fB9a1SBtPeQSPeAZt1aogN73jeZ
	 0OXlhJv//OkYg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 666D9C53BBF; Mon, 28 Oct 2024 14:20:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Mon, 28 Oct 2024 14:20:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: intelfx@intelfx.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-219431-137361-O08obUIqLv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

Ivan Shapovalov (intelfx@intelfx.name) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Attachment #307075|0                           |1
        is obsolete|                            |

--- Comment #4 from Ivan Shapovalov (intelfx@intelfx.name) ---
Created attachment 307079
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D307079&action=3Dedit
dmesg w/ dynamic debug on amd-pstate.c/cppc.c/cppc_acpi.c

(In reply to Mario Limonciello (AMD) from comment #3)
> Can you repro on 6.12-rc5? Can I please see kernel log with AMD pstate
> dyndbg on the kernel command line for your system on 6.12rc5?

Reproduced on 6.12-rc5. There was nothing from amd_pstate.c before the warn=
ing
message, so I also enabled dynamic debug on cppc.c and cppc_acpi.c.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

