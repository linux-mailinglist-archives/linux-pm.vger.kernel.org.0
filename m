Return-Path: <linux-pm+bounces-11945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29893949302
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36848B253A9
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 14:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E6F17AE13;
	Tue,  6 Aug 2024 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZQabWQk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038BD17AE0D
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954459; cv=none; b=NNH8RJ6QV7KwBPNDm9F8mEWMiaKZhh/rMac+Ohq9H6eYfzUvxM+Wljah1HFkEMiGEBBDytjv9R259fopQ7K7Hw6BhNUlRs1oGEVWyX1burQQWIiLFSC5wX5vj74gdkj073pPaPWckoVr62Isu45q57GRImjlvEgSdcnxtCGX634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954459; c=relaxed/simple;
	bh=7DkUlwgdBNYZks3twBhcfAnB6UkUVPSd4QHTRUMTez4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BuN2GmpNX2BNTsmO5ht56tYawGp0Db/8UqNnNcrvc77kv/tVjxNykIt0v551cOuhf/oLR9DHYE8747IRkin1bdQaxp3F6flVlhah0FRAlx9EIulMQ14Gnwcu9ziKTsbAI6KQU/L7pxixm2N/5FdKtFVK6jk0poMckjqhY/nMVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZQabWQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7263AC4AF16
	for <linux-pm@vger.kernel.org>; Tue,  6 Aug 2024 14:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722954458;
	bh=7DkUlwgdBNYZks3twBhcfAnB6UkUVPSd4QHTRUMTez4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VZQabWQkhwRg70bYQEpe+Q44a4FO0oBIv7iA2i3dkwKq5P7AXaq2pbTfyZEe07N3y
	 1yC7P1WscPef2DYMEfWAhKEWUv7irTWsHT78gdOn+bRdi0QCa2hZ8AAmPntOaC5ysv
	 B5BmwXoImcQsaBOVhBqpewBLWkWHGsjY06sl2TYNODebiY5tXfSQh9CWVrzBepv0L8
	 qPV7JHSmUwpG2XKdXw7lKEnrDI4NALWIOpxCrXpJblTCiSFdEVLpuJPBJOHTvyQ6Mt
	 txDrQ44DVIJwamx4OBXbkATUnQbpY9yQ6sUprB5AlT/O2PuAoAHQjhk8qkoX7boYl+
	 4W1ip0/xWOPTw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 64877C53BA7; Tue,  6 Aug 2024 14:27:38 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Tue, 06 Aug 2024 14:27:38 +0000
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
Message-ID: <bug-218686-137361-nlkJSrzWmC@https.bugzilla.kernel.org/>
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

--- Comment #78 from Chema (chemasanchezgarabito@gmail.com) ---
(In reply to xiaojian.du from comment #77)
> (In reply to Chema from comment #75)
>=20
> > Thanks for checking
> >=20
> > It seems that way, asus has made it work in windows but not in the stan=
dard
> > way needed by linux. But either way the amd pstate driver is working, b=
ut
> > the epp change is not working.
> >=20
> > What could be the easiest to try to solve it from our part, modifying t=
he
> > kernel   in some way? If windows is working it should be a workaround to
> > make it work maybe disable some checks or something like this
> > https://github.com/archlinux/linux/blob/
> > b1bc554e009e3aeed7e4cfd2e717c7a34a98c683/arch/x86/kernel/acpi/cppc.c#L1=
4 or
> > this
> > https://github.com/archlinux/linux/blob/
> > defaf1a2113a22b00dfa1abc0fd2014820eaf065/drivers/acpi/cppc_acpi.c#L1491=
...?
> >=20
> > Cause ASUS has not made any comment about it, I dont know from your par=
t it
> > they have internally said something to you.
> >=20
> > Thanks
>=20
> A simple tricky hack can't solve this problem.
> From the perspective of amd-pstate driver, it is the most reliable soluti=
on
> to check the CPUID register.
> Any other workaround to enable CPPC feature forcely and load epp mode in
> Linux OS is ugly and unacceptable.
> I recommand to wait for further actions from Asus.
>=20
> Anyway, acpi-cpu driver still can be the second option for now.

Thanks

But have you any initial idea of how a workaround could work? Obviously for
developing it my self locally and so people could have some solution while =
asus
does something, if ever does, considering they do not support linux

Yes, currently I use acpi-cpu, but powersave governor makes the laptop laggy
and schedutil that should be a balance makes it hot and drains battery fast=
er.

So currently for my self linux in this laptop is not much a good option, th=
at
why I was wondering if a local workaround would be possible.

Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

