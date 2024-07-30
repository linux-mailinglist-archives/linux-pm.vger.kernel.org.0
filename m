Return-Path: <linux-pm+bounces-11692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FDD941F39
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 20:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFC8284A51
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD586188003;
	Tue, 30 Jul 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqNsgUiy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928A33999
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363006; cv=none; b=TFPGnRYpTElVfa95fxq8rL4Od9X6MIauGY3a+qV1zJ6ajdsfRo3+H1lrhJkkPmNunu5BRmkfPpN+n5PQEf5STPNaDlPeQxg5rjPEfO6HANJ4zHDJ+bCIdXalRgHRFXfXTr/pwGf3vr0K9dAirXn0mtZzIju+TFHH1kZhF7sbZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363006; c=relaxed/simple;
	bh=JQCDJDZKMaMWHHzl/TsiWVv0F5qrYCj6VCeQ558r8oc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OA79Qu1qbxWvXxeTSPHPUZLj+SQTtbCaBP0h9pi9nFMiPO6GDjnko6HOvO0FV7RIy1af7fpHh7C17Xl84JLrblyLOytpXtI9M764upKqtIEnC+D0nSaWQyJ+vy9B2wyWD0iyXw40iabNpSJ/2lFnreQv9qZRcsB+pVqxqU2xfq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqNsgUiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33F2FC4AF0F
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722363006;
	bh=JQCDJDZKMaMWHHzl/TsiWVv0F5qrYCj6VCeQ558r8oc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LqNsgUiyLMjO16OsuDDo6xabZgpBLTo/FEF3qWIur3Pat71qV3rT3nLs/a+CJSrQ6
	 8vAb55KfjjhUcDZxQlFDnr2kC1XvZHpj7uYDNweXZ6QhnKb+hyYKNB5l/3SeJ/mQTZ
	 n/G67d68b/OfOroKqfFD5OvOyA5GQ3tDJ4D83yU/n23hJVCp5TFTzFgTXqyIt73HTl
	 2Jb5/24dbo3KHDQ1j3ft5vI7IuQP0VKaFEU6SfgWwzMQVNNUUFNSdSvtuDoW3luFJw
	 Etm2kKmDAO8qAZRZmVCXfFP3RFb+6/UqQK3XbbDCncmyJ6TuCg8F+bDkHBUhIwkrg7
	 E0REQ/u1zQ1zg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2D7BCC53B7F; Tue, 30 Jul 2024 18:10:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 30 Jul 2024 18:10:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: xiaojian.du@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-NV93Fg3wOr@https.bugzilla.kernel.org/>
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

--- Comment #59 from xiaojian.du@amd.com ---

For this output info:

> CPU 14:
>    0x80000008 0x00: eax=3D0x00003030 ebx=3D0x111ef257 ecx=3D0x0000400f
> edx=3D0x00010000

Fn80000008_EBX bit27[CPPC] =3D 0, it remains "0", means CPPC is disabled.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

