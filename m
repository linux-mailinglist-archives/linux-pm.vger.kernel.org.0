Return-Path: <linux-pm+bounces-23708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B21A5863F
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 18:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6BD188BEFE
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7070F1E51FD;
	Sun,  9 Mar 2025 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CKAGUGdU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044031E98F8;
	Sun,  9 Mar 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541408; cv=none; b=lj6Cv9pXYLp63U3lOdN5DtxEFm9KL4SfrMc8LuzxvI0YXoGNI4jmuOpEQ+b8cej9gVIa73DtVC71ypVkOjnAQr1PrhEFlwO2x8OwztM51nMfbC4ZZM+xkI9jUjfJY6PmM0axwi7w+4zUKGfG1BreG2k7G+FeZBZhPq8XFtDd1ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541408; c=relaxed/simple;
	bh=NBHMxEzCCfSdjqrL75N+ctfjfe/b2U+RJPdkNTWuPkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOpbGrRzACMn9uy2QsJQujLYQbCbhNC8OlXO5hG5oNAcbzupm8stMH3IXGwOnbSCisZDg/nhgNrM9+v1dBVkH99q12oC/ZS1eZVqBCbCbuWxn3HCUisikfykkeC9wZ4kUz09LY8ySrJ0Snhs40V35Od7xhsgCoLEn+AnpPOJY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CKAGUGdU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8119840E0214;
	Sun,  9 Mar 2025 17:29:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jY-gbk4qE0X4; Sun,  9 Mar 2025 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741541391; bh=V2ZqBwyXro5zqn3KAotpK1GPzA6yL7YjkTWyX1JdXnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKAGUGdUJ+yjbjqKhtqS2QhBMyARyh2oQFoonRepdter6J1EKAINqUzg+0gb8h+jI
	 ZN+sn9Y1gi0HbIe4BrPnbfNNJgUS0mRrhIfXLn7gOrtNiDsCCCvWgZ4HhgzVjQ7ea/
	 gFV9TRgGJ9EQ8D54lnbke3VnR1+gWzqRWAg0YWq+EPYWcB1nVo95Me62lIEDFeoUx7
	 YQ+g0Z27nZ/JYi+NGaiFioY6Fyr6fHO7pJ2BCh+UYcgBOd+MexDthmHGr442rMzQqP
	 DZyZtz/Z10KhFwJTuBOKWX4x53rRlkvFsAJgFTOTc/s6eI77UssqRIrIN8F56rg1SS
	 6NQK1p2UVR1Ng9KKU/2+UONAmY1/ranhDNPc8rX4rFOhuJhbfwDdKs0uIE5IYPAVwD
	 3QuBLPwfptOJKpR1X/voYw74HEm4Y7vOz5KI2GbHfgD0y+pX3fBtIL4zeyRCHEndDs
	 V/Ianieh3lKzve6aXpf4zrzfhFYbrSRJeo6xRR58//D03EVyjAQeOvw+yWh7f0lC9Q
	 dKJGihBdI7+SprjjFNeE0KhM8uR5dyKslgCcHoZ4w0SDApYzhKdwDUhC2QLgXNuVlM
	 U0QvvFKGfN4Xaa0l68dfVrL+cHGtH/pmhGrNy52I5F46UZcdE9sAH1fJFZe3LzRR+h
	 BTjoj5hbQgq9jvnCys+fbmVA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0194040E0202;
	Sun,  9 Mar 2025 17:29:30 +0000 (UTC)
Date: Sun, 9 Mar 2025 18:29:20 +0100
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
Subject: Re: [PATCH v7 1/4] x86/cpu: Name CPU matching macro more generically
 (and shorten)
Message-ID: <20250309172920.GBZ83P8ClXskqjmira@fat_crate.local>
References: <20250306-add-cpu-type-v7-0-f903fb022fd4@linux.intel.com>
 <20250306-add-cpu-type-v7-1-f903fb022fd4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250306-add-cpu-type-v7-1-f903fb022fd4@linux.intel.com>

On Thu, Mar 06, 2025 at 06:18:03PM -0800, Pawan Gupta wrote:
> @@ -106,13 +94,10 @@
>   * @_data:	Driver specific data or NULL. The internal storage
>   *		format is unsigned long. The supplied value, pointer
>   *		etc. is casted to unsigned long internally.
> - *
> - * The steppings arguments of X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE() is
> - * set to wildcards.
>   */
> -#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data) \
> -	X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE(vendor, family, model, \
> -						X86_STEPPING_ANY, feature, data)
> +#define X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model, feature, data)	\
> +	X86_MATCH_CPU(X86_VENDOR_##vendor, family, model, X86_STEPPING_ANY,		\
> +		      feature, data)
>  

That one is unused. Zap it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

