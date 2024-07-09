Return-Path: <linux-pm+bounces-10862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E786192B9D9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39AF2870D1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3AC15A878;
	Tue,  9 Jul 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QiHsdkKk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA915A843;
	Tue,  9 Jul 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529162; cv=none; b=am3zEiuVRxIjGDhsGEtaPd2DLIBOEO99YkHZZ2kHDC5wCQF5KGwHopM1iXK+roOmluCCL/weyfi1dFxwtBAB+MreBW4MlgIFHDKfsbK0SJeDXO9zKPT7a+w/4e8SBsQHmv8qhdogvCpKR+TXFTYq7oygFvQR7Qt+ub1phrM8pXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529162; c=relaxed/simple;
	bh=KhGCpF9+4C9lhLpzovRkcOdOulVyY6j6TJFNBVO9Mgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RujjSvnyKMJMELRHf/5pR6sPWxOw6FSdyyXukj5AZVQ3HBmvn/V1aQj9URxHWG9QMdMJC5WEMtpax0rnpiqag5kw4M5N5f6PIQEXw75ABBCCmlOlT8HzdIHiZI1FO4SyVxz352wrv2mLgiK51G74n+Crc2BVE3ygzGIoEGqWQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QiHsdkKk reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A6E3240E0219;
	Tue,  9 Jul 2024 12:45:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VD-pFPC05sQC; Tue,  9 Jul 2024 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720529149; bh=JosnYsiQ8muEBwIj8n6+1SHLQMI42y2o+rvr74ZNtYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiHsdkKkeNcF6pwOLTgSc1EoIuBcSImBBE22aZjEi/0q+d8KCAjohZkf3TwTLq92L
	 ylwdAJMt/tTaKOo4YIWf+fQVIRFdgcPlAtBh8VwhNmz62dXB/tI4gKrX0u3xdgoKfz
	 NDIgTtJOMV+LOm5ZruQpiZVgNhJmBAOfG5XnDqhePOAZOQzgAurjiUE8Kzc6P4cTsi
	 7c3ELnuHtM6WHLVIPhGo+vJRXbozwF0oTxns2Qb0vo/nvPquvS+ATeJYooq4hPkT8F
	 ZVjHxvsxvnnzwcAoIMjN51bUczQrmk2rN7A3ePj/tfPiQH3OC2ROeItmVg4KggZL2Y
	 ZgC6PX8eB6L/UKnGSxuysyvPWtclmkLSSkQ33q7atlMKwHzpGrjJ8Qv8w0IGL7Ue4m
	 3Hha935jgKcx7asKS4cS96uyO87pFfFgrI9gso5onQAPWI661Derebld1JI3tlXaoX
	 QiTRiCjFAQxgRYt3lP67QeglCZTVKH6p17yoCVOPOCD26L0wMeE58ookakJJM2wems
	 wkuUX5Bgpf4aNaPalYdfYJN7YRKiAy/F97cUVVmJJfppq3BVgEDC/epEroxfIHLyTH
	 Jn5AdCQqMrFgsI9Getz9DK0w3laBQIN05JOHKqEo5f/Hz4eJGuSTgZE+L1PBbVcpOe
	 vqtzbkO38YrFwL+e3MppSY6M=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4409C40E0206;
	Tue,  9 Jul 2024 12:45:29 +0000 (UTC)
Date: Tue, 9 Jul 2024 14:45:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v2 1/9] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20240709124524.GGZo0w5G2XXya77Vbm@fat_crate.local>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-1-f927bde83ad0@linux.intel.com>
 <20240628080305.GEZn5uOSnW40fVgaNA@fat_crate.local>
 <20240628173209.wzpc6pwnw4p6u57h@desk>
 <20240703230724.GEZoXZrIavchI2Kj-P@fat_crate.local>
 <20240709012418.jyzkxvp3h4p2oda4@desk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240709012418.jyzkxvp3h4p2oda4@desk>
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 06:24:18PM -0700, Pawan Gupta wrote:
> The draft version had it in cpuinfo_x86, but it later got moved to
> cpuinfo_topology as it appears to be topology related. Below is from AM=
D
> documentation:
>=20
>   E.4.24 Function 8000_0026=E2=80=94Extended CPU Topology

That's the name of the CPUID leaf.

>   CPUID Fn8000_0026 reports extended topology information for logical
>   processors, including asymmetric and heterogenous topology descriptio=
ns.
>   Individual logical processors may report different values in systems =
with
>   asynchronous and heterogeneous topologies.
>   https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/=
programmer-references/24594.pdf
>=20
> I can move it back to cpuinfo_x86 if you feel strongly about it.

Nah, it just felt weird. Not a biggie and we can always move it if we dee=
m so.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

