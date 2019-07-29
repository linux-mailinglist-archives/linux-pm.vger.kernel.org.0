Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D927778A69
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbfG2LYz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 07:24:55 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:51171 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387450AbfG2LYz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 07:24:55 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 120DA20189;
        Mon, 29 Jul 2019 13:24:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1564399490; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmlXqkmds8g4l2sZZVC0NbuTSq+L6u5Hywts6yOE/DE=;
        b=P2gaG9Qshu1YGUCXyU+ZC5GpryOcsTWcN7tbGQESId4jsD25pqFqkmyJg66rC9RvsA7Km+
        I4URapGaWUD3/kphIFWZUdRH+lUE3hRTRPFCVNsACe3ILW31KM1Gd11OIwi2oLYG5CK2MR
        q26XQGwRSrcBxzhM/5/Dz7Wqr+V0tKz1kVcdmJSKPLEvN/caaKks6AD0Pxuq/R7ZHk8Dct
        xTfoyupYtOcChJLGbi6kg6Sk8htEXDFrdT0c62Pis2nidEwybR44f6kGOLxuPCKuXV51JH
        R7cBpn/a1STF+ExZsFv7tSiglBCz/ivpx17Dp0Pl6kW6mi8m/+6VqRa9jSjZJg==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 75646BEEBD;
        Mon, 29 Jul 2019 13:24:49 +0200 (CEST)
Message-ID: <5D3ED780.7010407@bfs.de>
Date:   Mon, 29 Jul 2019 13:24:48 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Colin King <colin.king@canonical.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drivers: thermal: processor_thermal_device: fix
 missing bitwise-or operator
References: <20190729102930.2956-1-colin.king@canonical.com>
In-Reply-To: <20190729102930.2956-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.10
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Am 29.07.2019 12:29, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable val is having the top 8 bits cleared and then the variable
> is being re-assinged and setting just the top 8 bits.  I believe the
> intention was bitwise-or in the top 8 bits.  Fix this by replacing
> the = operator with |= instead.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: b0c74b08517e ("drivers: thermal: processor_thermal_device: Export sysfs inteface for TCC offset")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  .../thermal/intel/int340x_thermal/processor_thermal_device.c    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 6f6ac6a8e82d..cb22317911ef 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -164,7 +164,7 @@ static int tcc_offset_update(int tcc)
>  		return err;
>  
>  	val = ~GENMASK_ULL(31, 24);
> -	val = (tcc & 0xff) << 24;
> +	val |= (tcc & 0xff) << 24;
>  

I do not think that GENMASK makes sence here.

re,
 wh

>  	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
>  	if (err)
