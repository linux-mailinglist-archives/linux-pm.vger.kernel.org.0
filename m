Return-Path: <linux-pm+bounces-16105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC929A6A8B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 15:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3DAB230E5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E506B1F9400;
	Mon, 21 Oct 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F/vNCa5I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91244198E69;
	Mon, 21 Oct 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517921; cv=none; b=IxAhdl5j4P1BiDblkWBdtk1pZ2HjYg2GgK4Xs5RctoLdZJrDPo6SmDQejX/w34HNmvt8dZmt4GOZVrs6s20CuHbl+mTHtZtMcijRZdRz6XS4VmbKybEtxXYtS5h/hrD2+o/2e/VVwRnrlFA43wrvd43phSd6n+zE9IwyzRHVce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517921; c=relaxed/simple;
	bh=roOl+m/JGSK6QNvnXNhS7xQMy5AOm4j/0OQxVJPmtfk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kjYQNR9L+m+F8D61Pf8XedWhtZmJmwa5okL1JYQd+dz+vO72tl7TAVlH2WJxqWM3AmOdG3u5o0MMS5xURa/J+oiC88VcFy/++O365NJAZDM0QMK2UhL/DWW32+2yrzErA3kogOWUpYH74Wr6qeRQ/dz70dqPAwNeb2RMv5BjHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F/vNCa5I; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C195140E0194;
	Mon, 21 Oct 2024 13:38:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Nf8-6GFGTMfa; Mon, 21 Oct 2024 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729517911; bh=j22jsymwrbA8Fif24m1BaObFbbLpxzT/M5Qj+YoLY+w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=F/vNCa5ID66B+2TrmMnD2QSJM9XRKZsVknuXce/BEue8UnCCJVlXtYkK6sp7cbFFv
	 iaPrVhVtaxY/kHTsb1K5KfK+aveke6UpTcBYPG0gFBtIB8L91UuV+CwDriiLBUOoDf
	 0vEiQbbilH6albLIIlEajJ/L8BYyLgH73riAIl4nvGc51SRrzrB4OJZEWLiQHC46cY
	 rYPnfBOH33nJDTuDMh3NUsCdo+73fuPCVP9yEdVbJG2LvngKjMxqgTIVB8a1zc5FQA
	 nzdy2s3LImu+ax95YXAKrgfRD2W1498zVIStPeHZsQl7XoSF67Y2R+1Qtr9B3mfQnI
	 niEcRe6fF4jozutYRE64Kor6FY3pXFDd7LVAZ7kMEk5Z5E7Yumk1ntq0oLMfUJFaye
	 QbQzid8W8MGwB5jQadLeOixMKfHxSC1bAQE7Q3DNAOxBQ7PLM9hKVy7vTe5NEm3yae
	 BxIUYHm3ZkaICXTHB6glfiqwW7iu6gjCWFVhGDH/amXAkgyQvPeCCEM+B+eZRv00g7
	 +zr+nxPqwCZ6qrYEIx3fe0YpWG30aImZBLwR8qN9NOaRhcmHS66ENojSYJBktLqNUQ
	 e/FiuKpIgtoo1DwXVarmjzOPnK2M8/7psM3HhMiC2GH8+cPkx91zh+xi3SBVvOqOJY
	 jpz2ojCjgRwrf8dQIFtDv2vY=
Received: from [127.0.0.1] (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B6B640E01A5;
	Mon, 21 Oct 2024 13:38:10 +0000 (UTC)
Date: Mon, 21 Oct 2024 15:38:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Brice Goglin <brice.goglin@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <Perry.Yuan@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_02/10=5D_x86/cpu/topology=3A_?=
 =?US-ASCII?Q?Add_CPU_type_to_struct_cpuinfo=5Ftopology?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241018203053.2x6oyws3dkxfw6rm@desk>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com> <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com> <20241018161956.GCZxKKrLeTg0VTdfWA@fat_crate.local> <20241018203053.2x6oyws3dkxfw6rm@desk>
Message-ID: <9534B53F-7B91-4525-97DC-889EC3836658@alien8.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 18, 2024 10:30:53 PM GMT+02:00, Pawan Gupta <pawan=2Ekumar=2Egup=
ta@linux=2Eintel=2Ecom> wrote:
>I will drop "core", but can we keep "native"? "native" is used in SDM to
>define this field=2E Also model_id could be confused with model number=2E
>
>  From Intel SDM Vol=2E 2A:
>
>  Bits 23-00: Native model ID of the core=2E The core-type and native mod=
el
>  ID can be used to uniquely identify the microarchitecture of the core=
=2E
>  This native model ID is not unique across core types, and not related t=
o
>  the model ID reported in CPUID leaf 01H, and does not identify the SOC=
=2E

I'm still not clear on what "native" is supposed to mean here?

The core is born this way and then it changes=2E=2E=2E so this is its nati=
ve model ID? Weird=2E=2E=2E

>Yes, topo=2Ehw_cpu_type is initialized to TOPO_HW_CPU_TYPE_UNKNOWN=2E We =
should
>not ideally need the vendor check at all=2E As long as topo=2Ehw_cpu_type=
 has
>the core type, returning it should be enough here=2E For Intel hw_cpu_typ=
e
>also has the native_model_id, that is why we need the vendor check=2E
>
>If AMD or other vendors have similar use case, it makes sense to add the
>explicit vendor check=2E Please let me know if thats the likely case=2E

Yes, it either needs to be vendor-agnostic or you need to accommodate all =
vendors=2E Former sounds cleaner=2E=2E=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

