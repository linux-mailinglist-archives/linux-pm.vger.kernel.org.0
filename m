Return-Path: <linux-pm+bounces-13860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D79097085B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9936F1C21475
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 15:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8060170A12;
	Sun,  8 Sep 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFqNqzOG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B487829CF7
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725808541; cv=none; b=IpQiMK7HreDHenY31SkBbgwwpN6ylK6vBhktNBsf1NlIKtUaM4hxmmGkW1WhNwJQRpfJQHeYUMzM7nIvH3+m9uh/Ts7HV1HkEMBSOwULTnfTU/R4Cf5Kxjo6+D5Nm9QUOaYaZPi4xQ4VmbLxdPuyQ5INJL/LmSGzX8rc5IEVhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725808541; c=relaxed/simple;
	bh=hyVRsCJlZVcnMhFGCShoQ9vnq7bTFB9NrehWCOylSSA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNIQNCzuMXOcUJ0MMhsfUiOvWDfPaPzl4Fl1r9aJ3QPRSG3rXPBWZIyCF7hAW7Mev+k4lLlsw3e1AC1MTCeDgIbp0unsfBB9UNSveQbitONbRcjIfKgmNy9+KJFHlh+0ifGALqzDJFwRX1/Z7592KfFkOM/EsImIqEkjm+j1X7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFqNqzOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30018C4CECD
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725808541;
	bh=hyVRsCJlZVcnMhFGCShoQ9vnq7bTFB9NrehWCOylSSA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aFqNqzOGCgEqVlN1HseeGnrzcG9QdxjJ4JciQ9bONztkbnxng4ICZEAw/XxuBrvCV
	 0ZX5of9trvnMLd9vKtG1cbol9lA4jYwstamIDf1t8SvfQQSCo6LqEoovW+DvNwzfiG
	 mIdIAKK5U1EtMPbOOk5/vo9zwp5zcpW06ERXjOQQPD6foANSyTR4BaDXS07n7oUxyu
	 0I1UgYoYMCMSmFOUFulPsCvOuKHzl3QRTrimrmDtGsoY/n5mSExqmUhmlCO5nlVBC4
	 nh00I/6sO+ZbPyKUBF2RKT6VuN941z1OlC281goIv5IU0TBhvRsXBQKqZfzaedRD6K
	 fYyvOiCWbm2MQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2A463C53BBF; Sun,  8 Sep 2024 15:15:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Sun, 08 Sep 2024 15:15:40 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-hLhp4WJMXF@https.bugzilla.kernel.org/>
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

--- Comment #79 from al0uette@outlook.com ---
Hi everyone, I have some new discoveries. I think the problem lies in that =
`if
(CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg))` needs one of the two
registers satisfies that `(cpc)->type =3D=3D ACPI_TYPE_BUFFER &&
(cpc)->cpc_entry.reg.space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_COMM`. However=
 in
asus's BIOS, epp_set_reg's type is integer, and its space_id is
ACPI_ADR_SPACE_SYSTEM_MEMORY, and auto_sel_reg's type is buffer, and its sp=
ace
id is ACPI_ADR_SPACE_FIXED_HARDWARE, so these conditions are not met. After
manually bypassing this check, another problem rises, pcc_ss_id on every cp=
u is
-1.

According to acpi specification, letting auto_sel_reg be a functional fixed
hardware is valid, so my question is, will functional fixed hardware be
supported? And what causes pcc_ss_id being -1 on every cpu? I'll appreciate=
 it
if someone can answer my questions.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

