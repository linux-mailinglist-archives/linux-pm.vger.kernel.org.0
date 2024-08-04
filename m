Return-Path: <linux-pm+bounces-11902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68029471D3
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 01:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AA41F210FF
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 23:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421DE13AA2A;
	Sun,  4 Aug 2024 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0ubvqGz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C14418046
	for <linux-pm@vger.kernel.org>; Sun,  4 Aug 2024 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722815406; cv=none; b=GGd03n8/jbHLPjw47LchfZPEuSt9EQ+OEyEklRz+tzqsWQFoyC2nsz0HXWzpOvw1eGarSz2tMJeybzy/Ye6nvDTXIh0RSLsZy7J6QovkDyP5777hFcdCDuC/F03hC912mZBeIhSFsMs5bBzQLowRV0lKFL+mN8ECf0pZoFA6pBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722815406; c=relaxed/simple;
	bh=xZPd3blsBsg71p+Zv3I7MV49/finIqEV0OGAxq3L0VU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0R0z5QUP/HTbu3FQQK32bzxVN6PKXiezK3Gw5acXeaQqUKlXk6SrSofNMmZCEGiLPw41v6jOV/WNu4q/U4z/elJSs7MCnWEFrxljHvJFfEy9TnbeaGSZtnm5lXNvuLQWYFGyX5hKyf8j1l0hnZUYqFEPCxyD9rueU7RJRms+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0ubvqGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A70D8C4AF10
	for <linux-pm@vger.kernel.org>; Sun,  4 Aug 2024 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722815405;
	bh=xZPd3blsBsg71p+Zv3I7MV49/finIqEV0OGAxq3L0VU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E0ubvqGzMGdC86iJL+qtjR/IcMtWKH167R7Y7o5e8qJv+TsVTlxjAiLItfgIDHirl
	 hxa72TCvDxZguBmLFI10yAO2K+igIRhps9FwKsBIfKOiqLRyB8XELrvmqDlpqXQVRL
	 SgAGgITNY6d8EEYqHKDcJMYmcUy5W+1szXSyHq9ZtMwaJl2YCf0yoztP5/z8uR6/Bu
	 +fibnpQuOXRfTzw6rQZ5S5r3+jLok3Kh4B7pzCB35PHsgoHTUeyfIvdbJWhAFHSlqD
	 yJE2cqVO+kk/bZYezUpxNc4J3liBvPeO4poLX075n4eLvOjjFgvo1OVQU1AeGmn9ob
	 VnRltcJ/sUeKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9F489C53B50; Sun,  4 Aug 2024 23:50:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218686] Fail to set energy_performance_preference of amd
 processor on asus ga403uv
Date: Sun, 04 Aug 2024 23:50:04 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218686-137361-CIYQZMRBV8@https.bugzilla.kernel.org/>
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

--- Comment #72 from Chema (chemasanchezgarabito@gmail.com) ---
Created attachment 306666
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306666&action=3Dedit
ACPI tables looks ok

Ok, I have done many things since last comment that might shed some light to
this matter.


I have disassembled the ACPI tables of the laptop with latest BIOS (306)
The attacment is the ACPI table that contains the _CPC objects definition.

As UEFI defines:
-
https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html=
?highlight=3Dcppc#collaborative-processor-performance-control
In the line 381 it defines the _CPC object of the first thread of the proce=
ssor
and in the line 522 it defines the CPPC Enable Register as in the ACPI
specification, and it seems that the register is implemented correctly.

So three questions raises here to me:

  - Why smokeless UAMF is not showing the option?
  - Why is not linux reading it correctly if it is implemented?
  - I am reading wrong the ACPI table and this means oher thing?

So to me looks that we cant do nothing in the ACPI tables to enable the
register as it is already correct in the current tables.


Also I have searched through the kernel code implementation of arch to see =
how
the CPPC thing is being enabled, and looks like the code of the function
functions in two ways:

   - Hardcoded condition for some processors to enable by default
   - Or lastly check the CPUID bit 27 is set to 1

https://github.com/archlinux/linux/blob/b1bc554e009e3aeed7e4cfd2e717c7a34a9=
8c683/arch/x86/kernel/acpi/cppc.c#L14

I dont know why is it not working the last part as the register is correctly
implemented. But what I know is that this system configuration has a
configuration of:
    -  boot_cpu_data.x86 =3D 25 or 0x19
    -  boot_cpu_data.x86_model =3D 117 or 0x75
Done with command (lscpu | grep 'CPU family' && lscpu | grep 'Model:')
So clearly the hardcoded conditions do not apply to this system configurati=
on

Given this for me only 2 posible solutions appear:

    - Asus fixes this, but, may not seem probably to me as they do not supp=
ort
      linux and also the BIOS seems to correctly implement the ACPI tables.
      And of course the fact that they didnt say nothing about this matter.

    - We try to debug why the system is not reading/setting correctly the
      CPPC register or what is really happening

    - We path the linux kernel to include a condition to support this system
      Should be pretty simple, only add an "&&" to the if confition.


And I dont know if also a possible solution my be to not implement the CPPC
Enable Register in the ACPI table so that OSPM enables CPPC by default as s=
ays
in this link?
https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html=
?highlight=3Dcppc#cppc-enable-register

Of course it would be needed to create the updated table and use intrd to m=
ake
the linux kernel
https://docs.kernel.org/admin-guide/acpi/initrd_table_override.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

