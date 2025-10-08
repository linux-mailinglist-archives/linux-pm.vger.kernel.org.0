Return-Path: <linux-pm+bounces-35801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6C8BC4439
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 12:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF87A189C979
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EEC2EC54A;
	Wed,  8 Oct 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y1AsvK+b"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFFA2EB844;
	Wed,  8 Oct 2025 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918457; cv=none; b=BUc8UxsMEPiHN/Yy6MuUKbOA29YryCs0UVNhE8QgtpOSgbLAo5XWukp2qA86AfxaEwCPorU/dw8pG6IJioW2E7fGwTVSb+g0oppuWHFlBIUk2qrrNnjZIFrhaYeIkWuejY/ZdjYWsOGuyeJWAmNy0k77ymq+Q9zxNLMzSgeiWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918457; c=relaxed/simple;
	bh=HmZnMOWyb5P72s2BHSxYZ6XFSBnGmhYyMG/SN2Itv60=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0gxFgQ1uo6gU7TsEvsiZn/NsyRP0WL3qdk1qS5akuT7mHvqLkQb1loElO+dHBmgMWaolHPqxoGMrfUzkxNSQqWn3bIhuvUD1XaswOcCUR0yyuCTnNNVBU9ciH/gQLLqFnU9l8ExduIPLRIYnDitDFxLuMnd/9Kc1fq/jx9d6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y1AsvK+b; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598AEAa3205373;
	Wed, 8 Oct 2025 05:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759918450;
	bh=Dg4SyzNBJ3da8Ij16SryqnijGuggPTuSajWGj+7cgko=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Y1AsvK+b3N8xhN85oTpEqdkTYYcRSldXC/5U3EUmUDucbLnobTGd2hy2U3IgmjmG7
	 OOTUUNzQ/JUW8X2TU16indiL/VbadwksHvoj6wKG3IQov5r171XmjzRItEiQ8UPwl/
	 ukst6R5rrbLv3A8cm85RYbn9W8Q+B67q8nY1R52A=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598AEADI1381926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 8 Oct 2025 05:14:10 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 05:14:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 05:14:10 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598AE8nn2380253;
	Wed, 8 Oct 2025 05:14:09 -0500
Date: Wed, 8 Oct 2025 15:44:08 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
Message-ID: <20251008101408.dj46r66gcfo26sgl@lcpd911>
References: <20251007063551.3147937-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251007063551.3147937-1-senozhatsky@chromium.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 07, 2025 at 15:35:40 +0900, Sergey Senozhatsky wrote:
> Add dpm_watchdog_all_cpu_backtrace module parameter which
> controls all CPU backtrace dump before DPM panics the system.
> This is expected to help understanding what might have caused
> device timeout.

This will indeed be really helpful for debugging some nasty bugs!

> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/base/power/main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e83503bdc1fd..7a8807ec9a5d 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -34,6 +34,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/devfreq.h>
>  #include <linux/timer.h>
> +#include <linux/nmi.h>
>  
>  #include "../base.h"
>  #include "power.h"
> @@ -515,6 +516,11 @@ struct dpm_watchdog {
>  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
>  	struct dpm_watchdog wd
>  
> +static bool __read_mostly dpm_watchdog_all_cpu_backtrace;
> +module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
> +MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> +		 "Backtrace all CPUs on DPM watchdog timeout");
> +

Have you considered runtime configurability instead of a module param?

>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
>   * @t: The timer that PM watchdog depends on.
> @@ -530,8 +536,12 @@ static void dpm_watchdog_handler(struct timer_list *t)
>  	unsigned int time_left;
>  
>  	if (wd->fatal) {
> +		unsigned int this_cpu = smp_processor_id();
> +
>  		dev_emerg(wd->dev, "**** DPM device timeout ****\n");
>  		show_stack(wd->tsk, NULL, KERN_EMERG);
> +		if (dpm_watchdog_all_cpu_backtrace)
> +			trigger_allbutcpu_cpu_backtrace(this_cpu);

IMO it would be useful to check the ret val of this as well, I mean just
incase this silently returns false it maybe confusing to figure out what
hapenned in the system inspite of setting the mod param.


-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

