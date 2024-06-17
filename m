Return-Path: <linux-pm+bounces-9318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163CD90AA9B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 12:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EBAB36FBE
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6EF1957EE;
	Mon, 17 Jun 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="MZ68j2wP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC71953BD
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617393; cv=none; b=cB/MQ4lZR5x4bPU3BTI6vpEMOf+Empwfy6lMrvekJDS5qc872usvWvSZkKpIWBUxDmrdbPJyFt59vA7pTzXkZDPL7IMkirB4l+HBTEYo76J3A2ubJZhhWpN4lA9Rf/4+4++w01BUkiYQOqoC+eqHx4ZEciHIb0hgQqxGQj9S34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617393; c=relaxed/simple;
	bh=rF5PzwgVYWS34FJ5aHOJf19Ffkj1uLw1E57bSfTzcNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imIMHglH174zZucQocZsz3p6j3chLFgG8N0QvCnPC/0/x4k0lZWuaZ38tJM4zSZr3E0LHfkO2b9Tl56A1ni4R4VB7yF9QLKtuclw2QgWYtbhuLeNMpzAqa1pzDExMIplgN2rETnMTbGACArc68YhtlDzlpM+SRiHcDDVMDn3nkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=MZ68j2wP; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b0825b8421so27209806d6.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718617390; x=1719222190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DdebO2avCx3Dwy3b1qGLNiajhQdcHp42Pj1pkryPF70=;
        b=MZ68j2wPy7t0f6umBnO4ydOWtRf6Qw7B6qzSHK/Bs3C360OXtCJKdMwf2VepHVXoBW
         BFNI/iQFZO+QRTFrq7DZzPQYqX4TfxRzQtskr/y7UNalCem2v40E8pz3ZHrYw5gvApid
         rHvb9t41wglw0TOnIOYSrgyiM1Yy+sYzADxQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718617390; x=1719222190;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdebO2avCx3Dwy3b1qGLNiajhQdcHp42Pj1pkryPF70=;
        b=KXV/ypr9Gsj1ocZtX3HIqZMhkAXjPzSCs08466Lzx/USekqd2A3mY4Q+NfHQsr/gRY
         8IbkZ5mzJe50tjdJVsQDJm1JeOJ8Mxo2wssMQxhmPRctcPer2nGPlQnalddx6GlbKV1N
         47Af3SyC9oqU6CzXvpHnBSwXzvZ5nGOSCPi5Fh1SDPzdBJ0fcV6BRgTUuAEh/gJ1u4qc
         3FMIVBJdNTHhUP7Vear30q/7rtvARYQoJDcaKsahmiygmyduBmgFjA1yRj+2v+HuGxoi
         WE+0YTqtG/GO7ALjbTIu/1WCmubbbezhPdWOkZ3xxVN4eECekih0hHQfkvJIYCR90Rvt
         7qig==
X-Forwarded-Encrypted: i=1; AJvYcCU7NZxb8xqX0VaAVIfFo+gL/bXGeYEq9F5QiPiCl9130RZjN6ckvo3NxT8HHOWbqYq5w2x7spKdsF4tgjrI0qctbdG9YCszb44=
X-Gm-Message-State: AOJu0Yyp511rSZuB+964UfauXNUvuAn/DsL7TFdONl82km5UbvW8KKxD
	LdPZVFJmIeCHAzc+2GB3qNBe0OZgB7sa6AUpa/a3RntTDnvPIoram1dRKfFLYsQ=
X-Google-Smtp-Source: AGHT+IEVa8I+X3/+dsdE5gFsINpX0K4f/QujrkbhBVv7cYBqJZXVfWjr7vQeA1ulKXZt61/5zrWrNQ==
X-Received: by 2002:a05:6214:1027:b0:6b2:bdcc:f45b with SMTP id 6a1803df08f44-6b2bdccf621mr63967336d6.47.1718617390520;
        Mon, 17 Jun 2024 02:43:10 -0700 (PDT)
Received: from [10.125.226.166] ([160.101.139.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c110aasm53440006d6.36.2024.06.17.02.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:43:10 -0700 (PDT)
Message-ID: <d7c70d92-4d19-4c1e-81c9-d4c0cd34eda8@citrix.com>
Date: Mon, 17 Jun 2024 10:43:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PATCH 9/9] x86/rfds: Exclude P-only parts from the RFDS
 affected list
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
 <20240617-add-cpu-type-v1-9-b88998c01e76@linux.intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240617-add-cpu-type-v1-9-b88998c01e76@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2024 10:12 am, Pawan Gupta wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 7e3b09b0f82c..73ec66321758 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1209,6 +1209,9 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
>  #define VULNBL_INTEL_STEPPINGS(vfm, steppings, issues)	\
>  	X86_MATCH_VFM_STEPPINGS(INTEL_##vfm, steppings, issues)
>  
> +#define VULNBL_INTEL_CPU_TYPE(vfm, cpu_type, issues)	\
> +	X86_MATCH_VFM_CPU_TYPE(INTEL_##vfm, cpu_type, issues)
> +
>  #define VULNBL_AMD(family, blacklist)		\
>  	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
>  
> @@ -1255,9 +1258,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
>  	VULNBL_INTEL(TIGERLAKE,		GDS),
>  	VULNBL_INTEL(LAKEFIELD,		MMIO | MMIO_SBDS | RETBLEED),
>  	VULNBL_INTEL(ROCKETLAKE,	MMIO | RETBLEED | GDS),
> -	VULNBL_INTEL(ALDERLAKE,		RFDS),
>  	VULNBL_INTEL(ALDERLAKE_L,	RFDS),
> -	VULNBL_INTEL(RAPTORLAKE,	RFDS),
>  	VULNBL_INTEL(RAPTORLAKE_P,	RFDS),
>  	VULNBL_INTEL(RAPTORLAKE_S,	RFDS),
>  	VULNBL_INTEL(ATOM_GRACEMONT,	RFDS),
> @@ -1271,6 +1272,8 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
>  	/* Match more than Vendor/Family/Model */
>  	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
>  	VULNBL_INTEL	      (COMETLAKE_L,					MMIO | MMIO_SBDS | RETBLEED | GDS),
> +	VULNBL_INTEL_CPU_TYPE (RAPTORLAKE,	X86_CPU_TYPE_INTEL_ATOM,	RFDS),
> +	VULNBL_INTEL_CPU_TYPE (ALDERLAKE,	X86_CPU_TYPE_INTEL_ATOM,	RFDS),

How does this work?

Being __initconst, this is only evaluated on the BSP.

P-only and mixed P/E systems won't see X86_CPU_TYPE_INTEL_ATOM, even if
there are ATOM APs to bring up later.

~Andrew

