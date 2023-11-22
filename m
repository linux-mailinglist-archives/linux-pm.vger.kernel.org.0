Return-Path: <linux-pm+bounces-69-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B9C7F4188
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 10:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B539D2817A0
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2362137C;
	Wed, 22 Nov 2023 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9hZnKrU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1811DA5B
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 09:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BADDBC433C7
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 09:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700645155;
	bh=eByhMiPejJ6e1vNOOxQFI65gZ5ms/6nTQeIQUg+Dups=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X9hZnKrU2AAuFkY54tUtBAFiezcFTboMk1GJOvKfRmdXzymsogStKIa5RzAQIPISQ
	 tUsm8XdCmrgDvDlsH3ujA0ej3Yur5XrRPPk6l6OhwPsqOZLPrQDJ68e29uEs5MRbKb
	 wfv3m3nHo/VyuEo+eZAT8s+BltyEdbgac9OC6n6ZHbcylAd+MIHoEp5Gw8O1uvd+Bp
	 BbtMdG9lasGHCXIk9BfeeqlDSH4PQ++CRyltvf7k5scGIrDzGXqtYlLC5U2KxR9IPv
	 N5uFBXgMxo+OLJDw+XWvabKZi12RKzVJBtZ7Bam94KM3xtEpDtGkTSxRXQsHwn8T/W
	 EdSoIiC2Gtftw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A4932C53BD1; Wed, 22 Nov 2023 09:25:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 218171] amd-pstate not loading on zen2 threadripper 3960x
 (trx40
Date: Wed, 22 Nov 2023 09:25:55 +0000
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
Message-ID: <bug-218171-137361-3oXyQNU1Lo@https.bugzilla.kernel.org/>
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

--- Comment #11 from Perry Yuan(AMD) (Perry.Yuan@amd.com) ---
(In reply to Gino Badouri from comment #10)
> Hi Perry,
>=20
> Unfortunately they're not present:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal freq=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> cat: '/sys/devices/system/cpu/cpu*/acpi_cppc/nominal_freq': No such file =
or
> directory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dnorminal perf=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> cat: '/sys/devices/system/cpu/cpu*/acpi_cppc/nominal_perf': No such file =
or
> directory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dhighest_perf perf=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> cat: '/sys/devices/system/cpu/cpu*/acpi_cppc/highest_perf': No such file =
or
> directory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest_nonlinear_perf perf=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> cat: '/sys/devices/system/cpu/cpu*/acpi_cppc/lowest_nonlinear_perf': No s=
uch
> file or directory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlowest perf=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> cat: '/sys/devices/system/cpu/cpu*/acpi_cppc/lowest_perf': No such file or
> directory
>=20
> But I guess this is expected as the driver still does not load with linux
> kernel 6.7.0 rc2:
>=20
> [    0.640246] amd_pstate: the _CPC object is not present in SBIOS or ACPI
> disabled
>=20
> But if you look in ssdt7.dsl from the attachment I just posted, you can
> clearly see the _CPC entries are present.
> They look like:
>=20
>         Name (_CPC, Package (0x17)  // _CPC: Continuous Performance Contr=
ol
>         {
>             0x17,=20
>             0x03,
>             ....

Yeah, I saw that, looks like the table is not defined correctly.
The values offset are all zero, let me check with internal team to see if h=
ow
can we fix that if the table has problem.


Package
{
   NumEntries,                              // Integer
   Revision,                                // Integer
   HighestPerformance,                      // Integer or Buffer (Resource
Descriptor)
   NominalPerformance,                      // Integer or Buffer (Resource
Descriptor)
   LowestNonlinearPerformance,              // Integer or Buffer (Resource
Descriptor)
   LowestPerformance,                       // Integer or Buffer (Resource
Descriptor)
   GuaranteedPerformanceRegister,           // Buffer (Resource Descriptor)
   DesiredPerformanceRegister ,             // Buffer (Resource Descriptor)
   MinimumPerformanceRegister ,             // Buffer (Resource Descriptor)
   MaximumPerformanceRegister ,             // Buffer (Resource Descriptor)
   PerformanceReductionToleranceRegister,   // Buffer (Resource Descriptor)
   TimeWindowRegister,                      // Buffer (Resource Descriptor)
   CounterWraparoundTime,                   // Integer or Buffer (Resource
Descriptor)
   ReferencePerformanceCounterRegister,     // Buffer (Resource Descriptor)
   DeliveredPerformanceCounterRegister,     // Buffer (Resource Descriptor)
   PerformanceLimitedRegister,              // Buffer (Resource Descriptor)
   CPPCEnableRegister                       // Buffer (Resource Descriptor)
   AutonomousSelectionEnable,               // Integer or Buffer (Resource
Descriptor)
   AutonomousActivityWindowRegister,        // Buffer (Resource Descriptor)
   EnergyPerformancePreferenceRegister,     // Buffer (Resource Descriptor)
   ReferencePerformance                     // Integer or Buffer (Resource
Descriptor)
   LowestFrequency,                         // Integer or Buffer (Resource
Descriptor)
   NominalFrequency                         // Integer or Buffer (Resource
Descriptor)
}

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

