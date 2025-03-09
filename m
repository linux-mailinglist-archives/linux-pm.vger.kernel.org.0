Return-Path: <linux-pm+bounces-23709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC1A5864D
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 18:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0399188DE10
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 17:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDC01DF724;
	Sun,  9 Mar 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QvmkxY6h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B81C5D78;
	Sun,  9 Mar 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541589; cv=none; b=ERhTnpd/oK2hKrGDCuIUA3waSNlCgEsYe1fQ1AjcBEs4vzRWkTVXtU+mSQbPsJewGvalyhVnyMjPBk23qdDgzS1GS9l/Jthlwyhm1lLemJHuNOjfjYxooiE3paB7SwPxJEGt9rGeQ2ElZn86Qk3b39YbuzhS1YiF1YLtCJd00Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541589; c=relaxed/simple;
	bh=DBdtiV38JvrK5apez6Z4gd9rOPGIqtIoKuhPJl81drU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmqjQ1BYxUEGsTOklJIhyBK7X9iPDt1ZEZrHbcwf3AG3MnM+eEMRoGIvFfWCMijaXdHFjcTlueO3PGm9LYpfKXBzfYrbAa49R2DaKa2/K9dX9wTWk7ZHgV0/8f6BGsyzIa3C40Iq1JvbM215cqeil/1aK15GQ8lhTYbtOXNUflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QvmkxY6h; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4EC1A40E015D;
	Sun,  9 Mar 2025 17:33:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WO0JmeVPD-1N; Sun,  9 Mar 2025 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741541580; bh=JE9z+8KfG9ic8fY+M0OmWcViQrJ70UNbKwvs4lEwbEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvmkxY6hDXFKYcuxskX/12KIrWNIR+YqqxWLI577Z55egcc1KJ+cGlQcMcHIWYApU
	 xhdAHZr1W18gwvjQlQpFSIhIftw/0/ZX4Uhfx0ySPR3J4vnzNCI0Iwbw1c/ByTeItT
	 tIJsc6VSEhk4V+AE5lfDM2IWVd0dRXowF2z+lYpHyTCp7JKVs4LpzEUyZq47BxXGzY
	 yjSB2VoHp1ObZZLL+Q3IWGuqNd/z1K6LfVXVlGCFmikcL6C2mwHyfpOByOl7H/Skc+
	 GI761HxrbR04DgX9XNGOkgoPwbvL0aCFZrK/veUrDlTgv8G/REWZdXt74RS6IcKGgs
	 84Zqn6WoTc2tClCZr88MLHV1xHASSVb+lLuWltPKO3iIex7fATNww+I8kPx3NTkKTM
	 k4z29ewk8snCyFeVr6j5sJdJAcVnllr2c4zOU1PwEIHcdJA/qai6OOeyA5qwdJB6ib
	 6PcxfDNx64FtOzjub4nAIKMdhxLthJXSJrkXsnQLTeZAk3Dam/71haGiDVNfD+1Apv
	 pS5AwANTz5yMrcYh6tc8bO8tZ1jJKI7yXWZalkrmg+J8ImIMAZOMDmFcRFjQtKyrkW
	 C8Uhc3EGQ/NGaoP8iQHPehIr27evpjeG3QDLHyrMwleZCLz2tWG68DFroCgTSKaOKA
	 yNvBU/vFybgYyWjNDVUzdx9c=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89D1240E0214;
	Sun,  9 Mar 2025 17:32:40 +0000 (UTC)
Date: Sun, 9 Mar 2025 18:32:39 +0100
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
Subject: Re: [PATCH v7 2/4] x86/cpu: Add cpu_type to struct x86_cpu_id
Message-ID: <20250309173239.GCZ83Qt2uxtPvMNxVL@fat_crate.local>
References: <20250306-add-cpu-type-v7-0-f903fb022fd4@linux.intel.com>
 <20250306-add-cpu-type-v7-2-f903fb022fd4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250306-add-cpu-type-v7-2-f903fb022fd4@linux.intel.com>

On Thu, Mar 06, 2025 at 06:18:20PM -0800, Pawan Gupta wrote:
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index d67614f7b7f1..18e996acb49a 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -692,6 +692,7 @@ struct x86_cpu_id {
>  	__u16 feature;	/* bit index */
>  	/* Solely for kernel-internal use: DO NOT EXPORT to userspace! */
>  	__u16 flags;
> +	__u8  cpu_type;

The struct is called "x86_cpu_id" and all its members describe a CPU. There's
no need to have more "cpu_" redundancy in the member names - just call that
"type".  It is clear that it is about a CPU's type.

The macro names having "CPU" - X86_CPU_TYPE_ANY - are fine I guess.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

