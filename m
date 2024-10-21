Return-Path: <linux-pm+bounces-16116-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA139A7146
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 19:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F9F1C229D5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0311E572A;
	Mon, 21 Oct 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TG1lREhQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E815028C;
	Mon, 21 Oct 2024 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532755; cv=none; b=us2jns3QMInzG9TppJvoYmU8a8ukbxOgK0ncHbVOFuixzp6rbl8MRFJ2sZmPoY6Jpwzu66WOmH8QiGY9qUS3V+oIx9I1VdwojGEOYy9nUBaKrQH/w8e9i/VvMZEsYz9ryfAPhTeFLKdo6Fmd9j9WyPn1JEDHlxh8CneRLo5Rvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532755; c=relaxed/simple;
	bh=K1244QOye3wf+xMcvjh/wKrTBXhK53QFrFb5VJextIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riGGuHyFod5N5rAwVNIggIkQF/tXaw0lK/jchQXLP0DQqEQuZdhsKZlsdn/s9PbPHTjFnuabZ/Y0+IFjTjUd06ZCjGzR/BgFKudZv1PEaAkU97G3VIlrtUKtWKM5SnzI2tmtbRtUYHLVLs0M5GFzwzu/k1A/4Jh0/hfsHzHyhrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TG1lREhQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 08CB840E0194;
	Mon, 21 Oct 2024 17:45:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NUTJvmhMzHNt; Mon, 21 Oct 2024 17:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729532746; bh=qVXw11o3fTQ4SrofK9F4rmkunE7a3EEHp7kqO/1k6Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TG1lREhQTfVhkvwxf7ZUXbrrnOdFd5MGuNHQzXq2B5Ri+9F29u6EjvkTFYGCmSWFR
	 fjBypvQSlBysOyCqM5zwaKYF8NUmfcfdSV50vObgFREU9VfHh5E/oUXuCC1qwuGAof
	 cbRTlyZIylv5BvhM6DjKH/IplOOhG5pxjAN1doVqKeR3n0sKp0ZGYDaC6khMddCnsk
	 JOMetH5BpqEtS0MV0sn/GuovBsZQHXSl0NNJABc1e+8olCDFMjK6EEVyc+NzTXSJ15
	 l3s5CL4UMDoqGpN8IELZULjHjOFaALBueMEl9dvXhxxx7fNEIURbtQqoav/uNRpYl3
	 qGKjSEzRhmVcRG0e7V/Gbsiebt40M6Vcns40lIHy03bblRca2UnIXje+AaB5vxU8Ng
	 IRXH6SAQtz+bRrxJEPXY8Q584ho3erIEl1sDTg7zJWDdhfFRLDGAY8SYnpULN5IdkB
	 dtxj/+tlDTCwQvBBeTZsL4cNO4NjKKjIZh3xhI6q9V7klVbLl+Y4UivsjdQhTbuiWa
	 QRU8AeQtQMzCZEm57QejGtNW7+2SejlIxu/FjJjEJId5bXy58aUgM0jvet4yDDRt7O
	 pjOSVbrXIH7OwXydFufoygWl7Oko/SfPnNjufrSla0rCX3CqpOb1F/w1IlRGyDP5Vj
	 ml9pLj9QeJXtTi+80n14FgCI=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C1ACE40E0169;
	Mon, 21 Oct 2024 17:45:25 +0000 (UTC)
Date: Mon, 21 Oct 2024 19:45:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20241021174519.GIZxaTL7o85C_w2ucR@fat_crate.local>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
 <20241018161956.GCZxKKrLeTg0VTdfWA@fat_crate.local>
 <20241018203053.2x6oyws3dkxfw6rm@desk>
 <9534B53F-7B91-4525-97DC-889EC3836658@alien8.de>
 <20241021163656.zyyugk4vyqyhzh3i@desk>
 <SJ1PR11MB6083A4F82CCC844D4C8C7D6AFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083A4F82CCC844D4C8C7D6AFC432@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Mon, Oct 21, 2024 at 05:13:41PM +0000, Luck, Tony wrote:
> Example from <asm/intel-family.h>
> 
> #define INTEL_ALDERLAKE_L               IFM(6, 0x9A) /* Golden Cove / Gracemont */
> 
> #define INTEL_RAPTORLAKE                IFM(6, 0xB7) /* Raptor Cove / Enhanced Gracemont */
> 
> The native model number could be helpful to tell what each of your P-cores and E-cores
> are based on. Could be useful when the same base core is used in more than one SoC
> generation.

How am I supposed to read this?

Gracemont is the "native", base core and from that they do a Golden Cove and
a Raptor Cove?

What does that have to do with the P- and E-cores? Are those above two
different types wrt performance?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

