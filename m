Return-Path: <linux-pm+bounces-11922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 273AE948315
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 22:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A544FB20A8D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF2A146A6F;
	Mon,  5 Aug 2024 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2xS/on3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764C13CF86
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888989; cv=none; b=JxxVzl059r4qkUbPrJXxiuTVDnWJ9IShtjyekY6A4FJBTUTpxvWJ4imRG7BJlrimGBZxDuImD5BrBB6Pa8n3XMIecvv6rQU6UI2d9pTcfszNBRN//JDh2wgc5g5rsbq6GRTD8vi3rkPf4m1KgQgm7TollLWGCOFks4H2HpOiVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888989; c=relaxed/simple;
	bh=liFt3sjRucVnKRT2fhghhw4ZXk8BL4v+giYsmCwKtE8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J6xbu2zMysy8dvD9gARr+N8f8rXgKSLfb+M32RNdm5OYSxTGw+bJ1LJ8wmbMXBo1HWOWz7Z4+A87griE+Yah04WirIuHw3SV9cP3J4atU346SBlG6AR04WEFAdzY1o85YGSZMdQfdyFbvA0jkhiLsSwiBqOytNo+Q7OcONqg73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2xS/on3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E065FC4AF13
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722888988;
	bh=liFt3sjRucVnKRT2fhghhw4ZXk8BL4v+giYsmCwKtE8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B2xS/on34BNGyp3E+IADyws9uiCcpfrNtHM9ILixxmz7ZmdihrsuNkQfDUdG1EDhx
	 B9xdp6aMpDpqpjqLatwPukBE2YC9kEKltOsVVIea0rUUNTLAHJfQj0Mh5wMuF8jI8D
	 O2LrOwwp2a37t9NFBoYoO/WFXadrAzQTniDJ28d8tUe9h6ddlkJEzp3YDlgh80ig+g
	 /Pn9JJuETQfPdWD1v7JGwc+Jw+UR5BRHiLNBUktvHcRHMctqp27nBdbrcap3wwzJDT
	 TOB/2cO2u9l/F2NB6MYX6nNQULycbAWVgQUDwgdgF678hd4k+JSVwVYpjnZHg44ksN
	 uBu05jti11jfg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D2343C53B73; Mon,  5 Aug 2024 20:16:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Mon, 05 Aug 2024 20:16:28 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218686-137361-RAtFaK9Rks@https.bugzilla.kernel.org/>
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

--- Comment #75 from Chema (chemasanchezgarabito@gmail.com) ---
(In reply to xiaojian.du from comment #74)
> I checked on my desktop PC, based on Asus B650M mainboard.
>=20
> "Advanced option-> CPU option -> PSS disable/enable"is the switch option =
of
> CPPC.
> Disabling *PSS* option will make Win11 OS switch to generic ACPI processor
> pm management.
>=20
> Back to this issue, somehow ASUS has enabled CPPC support in bios,as it
> showes "PSS ENABLED" in this video.=20
>  https://bugzilla.kernel.org/attachment.cgi?id=3D306662
>=20
> But the key CPUID bit of CPPC func enablement still is not written "1" in
> this new version BIOS, besides, the dmesg log shows the _cpc obj  in the
> ACPI table is null,
> "ACPI CPPC: _CPC in PCC is not supported".
>=20
> So the conclusion is, CPPC func is enabled in this new version BIOS and W=
in
> OS is using it, but it doesn't support Linux OS.
>=20
> Maybe ASUS didn't put too much notice to the user case on linux os?

Thanks for checking

It seems that way, asus has made it work in windows but not in the standard=
 way
needed by linux. But either way the amd pstate driver is working, but the e=
pp
change is not working.

What could be the easiest to try to solve it from our part, modifying the
kernel   in some way? If windows is working it should be a workaround to ma=
ke
it work maybe disable some checks or something like this
https://github.com/archlinux/linux/blob/b1bc554e009e3aeed7e4cfd2e717c7a34a9=
8c683/arch/x86/kernel/acpi/cppc.c#L14
or this
https://github.com/archlinux/linux/blob/defaf1a2113a22b00dfa1abc0fd2014820e=
af065/drivers/acpi/cppc_acpi.c#L1491...?

Cause ASUS has not made any comment about it, I dont know from your part it
they have internally said something to you.

Thanks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

