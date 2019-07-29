Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3278BD8
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 14:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfG2Mem (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 08:34:42 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:42579 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727625AbfG2Mem (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 08:34:42 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 270DC20376;
        Mon, 29 Jul 2019 14:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1564403676; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qqmyrL0xuxOoHnbtajOEKx+rhyikST36MrsY2R3mGJg=;
        b=Sde8UgRU4cY4OD8Z0LKRI+R8KuJug+f9TGX0uZWPOLwwijft3D1CAPInecQtMS2Qqmqyqx
        XE23TELsm+v5ZC+2lnXAmpn+XkPJiArueec34b9h9lThtRFFii4zpuWV1hta15n/vrpC48
        ix3KJgiA6e1PT+ui+GGWnHfkYw4LWGVeOLTThtc2UbnAM6v3hTMuw0ndbYbe7DdyN1Fp+b
        LYxIbL8LZ5c9DL8RyZ9c/7XEobo2Vuu7UpicQBxTu95Wf7LUptxiDJOTBPiqnm3CW3a82r
        wavrL5TxBqYbMlfHgzHNII+rqI9sCLsvF/PeT5xAyxU+WLnitxH8NN41qSjeJw==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 7AD32BEEBD;
        Mon, 29 Jul 2019 14:34:35 +0200 (CEST)
Message-ID: <5D3EE7DB.9070706@bfs.de>
Date:   Mon, 29 Jul 2019 14:34:35 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Colin King <colin.king@canonical.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] drivers: thermal: processor_thermal_device: fix missing
 bitwise-or operators
References: <20190729120323.15838-1-colin.king@canonical.com>
In-Reply-To: <20190729120323.15838-1-colin.king@canonical.com>
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
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Am 29.07.2019 14:03, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable val is having the top 8 bits cleared and then the variable is being
> re-assinged and setting just the top 8 bits.  I believe the intention was bitwise-or
> in the top 8 bits.  Fix this by replacing the = operators with &= and |= instead.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: b0c74b08517e ("drivers: thermal: processor_thermal_device: Export sysfs inteface for TCC offset")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: Add in &= operator missing from V1. Doh.
> 
> ---
>  .../thermal/intel/int340x_thermal/processor_thermal_device.c  | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 6f6ac6a8e82d..97333fc4be42 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -163,8 +163,8 @@ static int tcc_offset_update(int tcc)
>  	if (err)
>  		return err;
>  
> -	val = ~GENMASK_ULL(31, 24);
> -	val = (tcc & 0xff) << 24;
> +	val &= ~GENMASK_ULL(31, 24);
> +	val |= (tcc & 0xff) << 24;
>  

IMHO GENMASK_ULL(31, 24) is a complicated way to say 0xFF000000
In this special case it would be better to use that (or 0xff<<24).

just my 2 cents,

re,
 wh


>  	err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
>  	if (err)
