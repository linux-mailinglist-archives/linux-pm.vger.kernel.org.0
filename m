Return-Path: <linux-pm+bounces-16994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA9E9BBCB6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523F6B2277B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDF61C9EAF;
	Mon,  4 Nov 2024 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kqmmFoFZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A418EB1;
	Mon,  4 Nov 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743237; cv=none; b=k58yCBmQUurnTBF9sdpuX5gkJI9nC5ZG1kR+aXMkgymY9ocuYaULKTpmqfJfslZBX0jiLMF0rqDH/aUikSCw3azkhGVsn/EbQ09J1i0S7y+w18T4W+kdErmpTea/cIDrMeDAPYk3XCP0tiuPy81JCiNX3fTr1hNS2xInwNTNttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743237; c=relaxed/simple;
	bh=l4ClbwKLAAUCIKk+H9sLcRUgk+8DLPI9VAyS+KjeJy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEZrEQsKbdpcyQknsv3oBYpPPIvJgTk0lEk0pfhBFrtDCSTns6M9aGbnKn4TRt39bRsu67XhPCoP5UnYtoEYsctlIghoany0d9vsaWRxd1ILMGWZ/GcOcGdaD5n5JiB1jm1+CZ1xtkuzn4g/o5atKp0OMaUyHmGoHuIoF1QN3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kqmmFoFZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=E1fQfudbR4NO1VNaKqotSsHuPMFHOb9T1HzqpLDUDRk=; b=kqmmFoFZlMBxlNL7guu+uAEGuL
	CjAyvw2Y3uIngSJsfQMhpP9DlavupameoKxseM32OJwZ0E5vc2BYSj5MwMWbbb+XV7bzXeb1tPGeb
	S9LlE+t0jLMEeH/2ctqWtCGHdcIwti/YvYNXvJ2m3nsYYquI5vZ1XX0nqU1EK7qmT2n0XKm8S8xA+
	co72pHyJ3NW4idW/a02gi65wk7NG4Tt2J/NOuwOmQ3u1iA39NT+PmW2wahcejC+goy5xTh6cHoQhp
	mnWDOwacTaSKc/46mL+gdcWNFJ8u3cjkg9rFN9ziwcBQ+7Un+0iPK8oshD0JU4rh5VTdf4wbxXM7F
	TQYkdxAw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t81NL-0000000BOXx-36QD;
	Mon, 04 Nov 2024 18:00:28 +0000
Message-ID: <123bd610-03d7-4c08-9314-616c0d3349d2@infradead.org>
Date: Mon, 4 Nov 2024 10:00:21 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/12] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
To: Mario Limonciello <mario.limonciello@amd.com>,
 Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241104175407.19546-1-mario.limonciello@amd.com>
 <20241104175407.19546-5-mario.limonciello@amd.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241104175407.19546-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/24 9:53 AM, Mario Limonciello wrote:
> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
> new file mode 100644
> index 0000000000000..79e3b0073275c
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Kconfig
> @@ -0,0 +1,18 @@
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
> +	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
> +	 selected, hardware provides runtime thread classification guidance to the operating system
> +	 on the performance and energy efficiency capabilities of each heterogeneous CPU core.
> +	 These capabilities may vary due to the inherent differences in the core types and can
> +	 also change as a result of variations in the operating conditions of the system such
> +	 as power and thermal limits. If selected, the kernel relays updates in heterogeneous
> +	 CPUs' capabilities to userspace, allowing for more optimal task scheduling and
> +	 resource allocation, leveraging the diverse set of cores available.

Please adjust the help text to fit in 80 columns.
Thanks.

-- 
~Randy


