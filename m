Return-Path: <linux-pm+bounces-27221-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E600AB91C3
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F163BA24872
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0736289352;
	Thu, 15 May 2025 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Era89RFd"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BE2550A6;
	Thu, 15 May 2025 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747344206; cv=none; b=n4hkWc8OvzdPpV5XVUw5P9nLy6196L/+ISc1JAzOsENVhqNZzHfPE53il2dKCs/QEx7QaZw6aKxMk1MyVKgddXqh7exF9BJPAS650+4g7tMd5JLn1S6LEkulgu0VWyY/Rnqvq/0KISaNwimK7afUToTi9OcLAEdaHpqbV9+1iYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747344206; c=relaxed/simple;
	bh=oVYbB4mvS5cfWCiHQJsTQZyBYXY5ZEDYJpI67V0lKb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cunh2oHtRfuh/pYlXOcY332yIHaxP4s4scZZy5SXg4QMm99pYOuhQu3wr3ZKq3Qw0hPfNjLp+OtO+OrIHZCasEGU8MW9vlwfCoJKfPYioaFPudcBbFY9L91FGiuyDFgYuY6UJsOrO4SdQkNNN3YcT34eLcxj+gRbGBYPzoc6UQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Era89RFd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZuFYpEebz7eNMFM2Au2qK78qxUP2XIO3+2uAIGKCqFo=; b=Era89RFdEYToePNFSYPchDIGdE
	GIgWTfTw826wSiHIo4qlKg2jvVe6sy2ThdpsC+0BnPvoDbDmMUwwbDfFeWgfGqLM4asa8Hb5PERy0
	1i8mUE5545Z6nD6s079M3JvU9NVw8KetFgApzRAGLPQUNN/y34bP6ecnxnj2SV+XZc3EY89Hkm1iJ
	VLO6YTdtBMdgpFfwWp8yzvFpCM4JW9qA16i73P3ZScH3jfPEpR/Tp6UgiWvL2KV+wr/7wIGi9eaEX
	mCKa3vryZZ3EY36Y2jNgNL7rmc28JtK5nXW7QWgSiHLu95k2wPDFW3wDPlAfpdZEJ/M8xOx9rXc9P
	4jebtc3g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uFg2f-0000000Ha4B-3VvL;
	Thu, 15 May 2025 21:23:06 +0000
Message-ID: <e0e6a6cb-3b73-471f-97f8-415fd6ac5333@infradead.org>
Date: Thu, 15 May 2025 14:22:56 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
To: Mario Limonciello <superm1@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
 Huang Rui <ray.huang@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20250515211950.3102922-1-superm1@kernel.org>
 <20250515211950.3102922-5-superm1@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250515211950.3102922-5-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

just a coding style nit:

On 5/15/25 2:19 PM, Mario Limonciello wrote:
> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
> new file mode 100644
> index 0000000000000..476e4a9ed67a9
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +config AMD_HFI
> +	bool "AMD Hetero Core Hardware Feedback Driver"
> +	depends on ACPI
> +	depends on CPU_SUP_AMD
> +	help
> +	 Select this option to enable the AMD Heterogeneous Core Hardware
> +	 Feedback Interface. If selected, hardware provides runtime thread
> +	 classification guidance to the operating system on the performance and
> +	 energy efficiency capabilities of each heterogeneous CPU core. These
> +	 capabilities may vary due to the inherent differences in the core types
> +	 and can also change as a result of variations in the operating
> +	 conditions of the system such as power and thermal limits.

Help text should be indented with one tab + 2 spaces.

-- 
~Randy


