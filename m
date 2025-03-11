Return-Path: <linux-pm+bounces-23831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0568A5BC64
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 10:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646AD3B175C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044AD226CFC;
	Tue, 11 Mar 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aTWqcXAz"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024622A4EC
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685716; cv=none; b=hOqdkU4Ts3yeXYmFhcMQXO1HeH9RVIlDpLkxdyeMiq2LIAQgJq8nEgP6XunV36YfHlCNAsunYB1AfkktdnLd8pZ6OpZytxQF99nKB+00H3pvA9QPUz3Fb/4Z8yqDkB9XaC95qsB1FXTLIePd3JQuLJa1EG3Prvo7P0wUAVqoeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685716; c=relaxed/simple;
	bh=ktS716Ut5UD+HH38uMLpPTCWkHMpybJEZhiqU304vTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9bvXaSQZsTdVOFRt40ythGDUhkxtwDQLCMEQnwJt78PRFTobnzYl6ne0Uoif2wM57j4hkSWbwj5SsVQULwC/QmaGnr6YTW/NQy9DjWTd8QRKk9ST6PeF4w2Pk/hTZ4OPr/7smH4ezGh7lLhNjQbEflLu4LxgI/YauumAj+S7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aTWqcXAz; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aa840586-cd70-417f-82c2-bb887f337720@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741685711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wVsNKg9YkEQ7KSJyQziX/Pf5MNW/2LBII724NcKRvc=;
	b=aTWqcXAzSWTgWXO+B8RX7iWZngEyO3a1jHoDvm0k0X7XvWTj3V6GECXGR3ooUXgbororde
	6H+mxi8YqAjgzhuqWwr4p6ti7biIiW1JvnEB5yepdDfKJZLRgaXawAOIkgWvFgZr6j//J0
	9a1fDrz5yhnkLIvSmHodJk0bhubB2uE=
Date: Tue, 11 Mar 2025 17:34:58 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] vsprintf: remove redundant and unused %pCn format
 specifier
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Alex Shi <alexs@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250311-vsprintf-pcn-v2-0-0af40fc7dee4@bootlin.com>
 <20250311-vsprintf-pcn-v2-2-0af40fc7dee4@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250311-vsprintf-pcn-v2-2-0af40fc7dee4@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 3/11/25 5:21 PM, Luca Ceresoli 写道:
> %pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprintf:
> add %pC{,n,r} format specifiers for clocks") introducing them does not
> clarify any intended difference. It can be assumed %pC is a default for
> %pCn as some other specifiers do, but not all are consistent with this
> policy. Moreover there is now no other suffix other than 'n', which makes a
> default not really useful.
>
> All users in the kernel were using %pC except for one which has been
> converted. So now remove %pCn and all the unnecessary extra code and
> documentation.
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,

Yanteng

>
> ---
>
> Changes in v2:
> - update Chinese documentation (change acked by Yanteng Si <si.yanteng@linux.dev>)
> ---
>   Documentation/core-api/printk-formats.rst                    |  3 +--
>   Documentation/translations/zh_CN/core-api/printk-formats.rst |  3 +--
>   lib/vsprintf.c                                               | 10 ++--------
>   3 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index ecccc0473da9c10f45f2464566f690472c61401e..f3009e6ec80a864c330c8812efcd82c12f4066b3 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -571,9 +571,8 @@ struct clk
>   ::
>   
>   	%pC	pll1
> -	%pCn	pll1
>   
> -For printing struct clk structures. %pC and %pCn print the name of the clock
> +For printing struct clk structures. %pC prints the name of the clock
>   (Common Clock Framework) or a unique 32-bit ID (legacy clock framework).
>   
>   Passed by reference.
> diff --git a/Documentation/translations/zh_CN/core-api/printk-formats.rst b/Documentation/translations/zh_CN/core-api/printk-formats.rst
> index bd36d35eba4eb124be43a66227059a30429e4135..96a917ecc93f2a4872784b6d8e3f98bcb9f5f737 100644
> --- a/Documentation/translations/zh_CN/core-api/printk-formats.rst
> +++ b/Documentation/translations/zh_CN/core-api/printk-formats.rst
> @@ -523,9 +523,8 @@ clk结构体
>   ::
>   
>   	%pC	pll1
> -	%pCn	pll1
>   
> -用于打印clk结构。%pC 和 %pCn 打印时钟的名称（通用时钟框架）或唯一的32位
> +用于打印clk结构。%pC 打印时钟的名称（通用时钟框架）或唯一的32位
>   ID（传统时钟框架）。
>   
>   通过引用传递。
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 56fe96319292674c9f79559cf78dd0d99d1a1f06..143d55cb1c12acac21a6c6bafd255437e878f280 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1969,15 +1969,11 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
>   	if (check_pointer(&buf, end, clk, spec))
>   		return buf;
>   
> -	switch (fmt[1]) {
> -	case 'n':
> -	default:
>   #ifdef CONFIG_COMMON_CLK
> -		return string(buf, end, __clk_get_name(clk), spec);
> +	return string(buf, end, __clk_get_name(clk), spec);
>   #else
> -		return ptr_to_id(buf, end, clk, spec);
> +	return ptr_to_id(buf, end, clk, spec);
>   #endif
> -	}
>   }
>   
>   static
> @@ -2382,8 +2378,6 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
>    *      T    time64_t
>    * - 'C' For a clock, it prints the name (Common Clock Framework) or address
>    *       (legacy clock framework) of the clock
> - * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
> - *        (legacy clock framework) of the clock
>    * - 'G' For flags to be printed as a collection of symbolic strings that would
>    *       construct the specific value. Supported flags given by option:
>    *       p page flags (see struct page) given as pointer to unsigned long
>

