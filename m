Return-Path: <linux-pm+bounces-9317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C12E90AA10
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177F62912AA
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8CA197A6E;
	Mon, 17 Jun 2024 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ngq15WvL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FD196C9E
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617119; cv=none; b=nR5CWLsJVuyuaqrlvzf03WxGA97L34qsIhdNow9ZmMyL0v4bfdD7r3Ql/pfkmRgaaM6EmcsHUWHoXI2vhee/0C9HP5rNznv7M4+CaSO6RIxrjGWws8LxkqmZ4FPXKPEuAQH2XA+gM/ZsxNYvbm0rbZdFJIzckcdQ/UMeAOdUnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617119; c=relaxed/simple;
	bh=sr/HExMB2KmpIxEyu/qgU81RvDcP2SyCdvUAXFbeUzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0l05m9U9X1WYzuP2QVpqrMLwQqUoHDE2pEzgERFI1OMlMvBS1H6s4AIjAmorhgMtenAoSpzA2CUy8Td0rrhGHmPC7wO3cEt3aXd8tAZVOGik2wXu8Lvt3x6SuwD5OgxC0B6hBg+oRerDKScaTMqNnR3CppZOMkyomLXCADvANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ngq15WvL; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62a08092c4dso40723377b3.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1718617116; x=1719221916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ygiGn4cC18Me/bv30acpykkQziugaNdxLwcBfmb6qSw=;
        b=ngq15WvLLIPlB2agE9GtNU4CU383yFZhadkmajLjTPUEpkQKTlywZKxe7iP7pGxn3X
         26Ov7kjRJ1pOIxnlFXW5ghElFzCARPxW+6Sxn1kGzKbPg+Rqb9LhK7PuSUucRF6Ig4C5
         1nXgPvgfbTGdtX+MqOonhkEBe70CYSJfPm+PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718617116; x=1719221916;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygiGn4cC18Me/bv30acpykkQziugaNdxLwcBfmb6qSw=;
        b=bL2KyI/YeZtS7K1Ji0GxlAkgorP0xUvZxtLE7jFJU6L7B06yhk9Ik7JOmbJa02sTCO
         eMjUFt8cvuIwOVLxd/D/wnkNPNm6Rl7ezVSjCmUejFsyiMVZCaFZUTZofEyL/8RVlOnr
         f8dbSMk0UvDZSbzE/aS3hzgQA7cpkWo4R4SczErXKC1djivcSnasXQUOgffsSRJRawM2
         eQLIwrQNUpYTJ0sdXaa8ADp2UryMOBEu3b05OBgJvAvNQLIFe4S4mL3ewGtAz0Lu6eMb
         1hiHbTIm/HEkIH1V0AjiSelDCbSUBsz0pultq2j9HJtOLVf7z5k1E3iLsdg5zRWebY1K
         ObZw==
X-Forwarded-Encrypted: i=1; AJvYcCWGQdqacIGhvNqfceR4NhYIkCC/o+aqeLfEeGwgGE7KVC8+7U+b2ARGy+7xc5fBn2rm4QzWpB+sIB38FztiCbvze01jbIJ6FBo=
X-Gm-Message-State: AOJu0YzSn1Bqh9lkekzb79p38Uio6dD75jXfashCa00XXKEanwfdeNiD
	zCWOyYuoNYDvx/0ogp7HeCANEU/ayI5CYOJy3YAVOnDzOdg8v+e2/h/10BuVEXw=
X-Google-Smtp-Source: AGHT+IFC+D8ny/Dw5rvJfiAdV//IJGVVyL9jjkV7lcw389qZjtEYyNdxSITDCmMdMGELAiOGjGLRug==
X-Received: by 2002:a0d:e612:0:b0:632:ca12:8af with SMTP id 00721157ae682-6355f1a8952mr23183507b3.32.1718617115585;
        Mon, 17 Jun 2024 02:38:35 -0700 (PDT)
Received: from [10.125.226.166] ([160.101.139.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c32428sm52942136d6.64.2024.06.17.02.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:38:35 -0700 (PDT)
Message-ID: <14d5ed1b-db72-4676-bce2-1ff3637a7e56@citrix.com>
Date: Mon, 17 Jun 2024 10:38:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PATCH 8/9] x86/bugs: Declutter vulnerable CPU list
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
 <20240617-add-cpu-type-v1-8-b88998c01e76@linux.intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <20240617-add-cpu-type-v1-8-b88998c01e76@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2024 10:12 am, Pawan Gupta wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index d4e539d4e158..7e3b09b0f82c 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1229,43 +1232,45 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
>  #define RFDS		BIT(7)
>  
>  static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
> -	VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL,		X86_STEPPING_ANY,		SRBDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_L,		X86_STEPPING_ANY,		SRBDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_G,		X86_STEPPING_ANY,		SRBDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_X,		X86_STEPPING_ANY,		MMIO),
> -	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_D,	X86_STEPPING_ANY,		MMIO),
> -	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
> -	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL,		X86_STEPPING_ANY,		SRBDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_L,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_L,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_D,		X86_STEPPING_ANY,		MMIO | GDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_X,		X86_STEPPING_ANY,		MMIO | GDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
> -	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE_L,	X86_STEPPING_ANY,		GDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE,		X86_STEPPING_ANY,		GDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_LAKEFIELD,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE,		X86_STEPPING_ANY,		RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE_P,	X86_STEPPING_ANY,		RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE_S,	X86_STEPPING_ANY,		RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GRACEMONT,	X86_STEPPING_ANY,		RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO | RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT,	X86_STEPPING_ANY,		RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT_D,	X86_STEPPING_ANY,		RFDS),
> -	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT_PLUS, X86_STEPPING_ANY,		RFDS),
> +	VULNBL_INTEL(IVYBRIDGE,		SRBDS),
> +	VULNBL_INTEL(HASWELL,		SRBDS),
> +	VULNBL_INTEL(HASWELL_L,		SRBDS),
> +	VULNBL_INTEL(HASWELL_G,		SRBDS),
> +	VULNBL_INTEL(HASWELL_X,		MMIO),
> +	VULNBL_INTEL(BROADWELL_D,	MMIO),
> +	VULNBL_INTEL(BROADWELL_G,	SRBDS),
> +	VULNBL_INTEL(BROADWELL_X,	MMIO),
> +	VULNBL_INTEL(BROADWELL,		SRBDS),
> +	VULNBL_INTEL(SKYLAKE_X,		MMIO | RETBLEED | GDS),
> +	VULNBL_INTEL(SKYLAKE_L,		MMIO | RETBLEED | GDS | SRBDS),
> +	VULNBL_INTEL(SKYLAKE,		MMIO | RETBLEED | GDS | SRBDS),
> +	VULNBL_INTEL(KABYLAKE_L,	MMIO | RETBLEED | GDS | SRBDS),
> +	VULNBL_INTEL(KABYLAKE,		MMIO | RETBLEED | GDS | SRBDS),
> +	VULNBL_INTEL(CANNONLAKE_L,	RETBLEED),
> +	VULNBL_INTEL(ICELAKE_L,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> +	VULNBL_INTEL(ICELAKE_D,		MMIO | GDS),
> +	VULNBL_INTEL(ICELAKE_X,		MMIO | GDS),
> +	VULNBL_INTEL(COMETLAKE,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> +	VULNBL_INTEL(TIGERLAKE_L,	GDS),
> +	VULNBL_INTEL(TIGERLAKE,		GDS),
> +	VULNBL_INTEL(LAKEFIELD,		MMIO | MMIO_SBDS | RETBLEED),
> +	VULNBL_INTEL(ROCKETLAKE,	MMIO | RETBLEED | GDS),
> +	VULNBL_INTEL(ALDERLAKE,		RFDS),
> +	VULNBL_INTEL(ALDERLAKE_L,	RFDS),
> +	VULNBL_INTEL(RAPTORLAKE,	RFDS),
> +	VULNBL_INTEL(RAPTORLAKE_P,	RFDS),
> +	VULNBL_INTEL(RAPTORLAKE_S,	RFDS),
> +	VULNBL_INTEL(ATOM_GRACEMONT,	RFDS),
> +	VULNBL_INTEL(ATOM_TREMONT,	MMIO | MMIO_SBDS | RFDS),
> +	VULNBL_INTEL(ATOM_TREMONT_D,	MMIO | RFDS),
> +	VULNBL_INTEL(ATOM_TREMONT_L,	MMIO | MMIO_SBDS | RFDS),
> +	VULNBL_INTEL(ATOM_GOLDMONT,	RFDS),
> +	VULNBL_INTEL(ATOM_GOLDMONT_D,	RFDS),
> +	VULNBL_INTEL(ATOM_GOLDMONT_PLUS, RFDS),

Take the opportunity to realign and fix this ?

~Andrew

