Return-Path: <linux-pm+bounces-27048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFB8AB3B4A
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 16:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C91886914
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EEA22A1E5;
	Mon, 12 May 2025 14:48:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4D22A4E0;
	Mon, 12 May 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061323; cv=none; b=jdpb6N1QnX3wIFoHsSdGjceUoQuzt4SiUjRmvZqXCVTTUYUIFuzHsb44olDlRsMkUWOaPZvXezP7fcF5RrXs7FnzCBHSq1FJPT6xT95zacRX7VfpRdTUPVHgLb6jSjYgDH5o2c9ZboX81k/A+PTZqW+GERKA4COSx7Pxm7knVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061323; c=relaxed/simple;
	bh=0b15kIXbgFlwa4g3yf6vatgi9G+rtNuEqi5cjFIvLGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndF2KS8FEy7sxtpYK7A8k4xfxAKfDf0VZSNo/oDwvI94TeMy/oxXPo3tqrOGNGrW0ECDz+lQ1ENHxFOZpPa4D7Cybw1D1smyCOT7Hl2Eqvln5YuL0axHyxMy8X5pdiK6XVzHC4P9lh65IJqG9TLJMThNIOPXT1KCpkIvsmnwhVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5F954601EBF02;
	Mon, 12 May 2025 16:48:18 +0200 (CEST)
Message-ID: <f6ce9e16-7cb4-4648-926f-6ac13e2ce100@molgen.mpg.de>
Date: Mon, 12 May 2025 16:48:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: thaw_processes: Rewrite restarting tasks log to
 remove stray *done.*
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250511174648.950430-1-pmenzel@molgen.mpg.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250511174648.950430-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[add change-log]

Am 11.05.25 um 19:46 schrieb Paul Menzel:
> `pr_cont()` unfortunately does not work here, as other parts of the
> Linux kernel log between the two log lines:
> 
>      [18445.295056] r8152-cfgselector 4-1.1.3: USB disconnect, device number 5
>      [18445.295112] OOM killer enabled.
>      [18445.295115] Restarting tasks ...
>      [18445.295185] usb 3-1: USB disconnect, device number 2
>      [18445.295193] usb 3-1.1: USB disconnect, device number 3
>      [18445.296262] usb 3-1.5: USB disconnect, device number 4
>      [18445.297017] done.
>      [18445.297029] random: crng reseeded on system resumption
> 
> `pr_cont()` also uses the default log level, normally warning, if the
> corresponding log line is interrupted.
> 
> Therefore, replace the `pr_cont()`, and explicitly log it as a separate
> line with log level info:
> 
>      Restarting tasks: Starting
>      […]
>      Restarting tasks: Done
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---

v2: Use log message texts suggested by Rafael.

>   kernel/power/process.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 66ac067d9ae6..1938fafa9172 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -189,7 +189,7 @@ void thaw_processes(void)
>   
>   	oom_killer_enable();
>   
> -	pr_info("Restarting tasks ... ");
> +	pr_info("Restarting tasks: Starting\n");
>   
>   	__usermodehelper_set_disable_depth(UMH_FREEZING);
>   	thaw_workqueues();
> @@ -208,7 +208,7 @@ void thaw_processes(void)
>   	usermodehelper_enable();
>   
>   	schedule();
> -	pr_cont("done.\n");
> +	pr_info("Restarting tasks: Done\n");
>   	trace_suspend_resume(TPS("thaw_processes"), 0, false);
>   }
>   

