Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C86F223251
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 06:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgGQE0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jul 2020 00:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgGQE0d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2020 00:26:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63046C061755
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 21:26:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so9539155wrw.12
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 21:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LoCUtP8byPHdkiL2VvJP/PIMUDoLEvSomGOoDI3TEH0=;
        b=eUL8MwSUooNOIy0u9skl2Et94Mj8yJVYuS5nVceQJbHXsMvsPHn0KDAuVB15zh0oGw
         2xt3MzqRtVJEJpZCtg7TtxoScYas+7vKfWz2nHVllEWxogynfT04AK9E3jpffboYshhH
         irioSZYr4JkX7p8mwgL9IMwfDlkPBF3i1YTQxZEJiWIVnVPz/pnRf0vAm9HLvlPrSR9w
         6c4Hcqj5kgOxmal0KQP0pDedkmviWlTWTv3wMsVKNhP5mfT5XoWtsu20WpAlkzsEoqsp
         752Cz6phrviS+klq1GMCG+ykHczCZK1VZnXVC29zsFe43T436Zjnv2lysudyF05nas/2
         2Szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LoCUtP8byPHdkiL2VvJP/PIMUDoLEvSomGOoDI3TEH0=;
        b=Np+VUkEgt53L6EuCBRBxEhhgusyss5OCg3QAskF42JBTe/xgWZd2D1TGUSax5qf/td
         CLAzEcLKR8KvjoAuqxnd3H1+vIRPGiLn2GD4VKXuSaAI3o4qrFCDxFHjVEY836eiLUuQ
         3GoHW3HV49wN3Nd5INxMv+5gzdx8NMKPNHTHD6HBnjezX8r9PWY1v+u6z8Ewrdx5fgwa
         y6OyVrGqONvhpUG7sK8p6D6J7mtPAZwyKcQt8QTIiakYA3UGU5O9iJjip/pIffe6gpD5
         E3menSvVH23fBqURWPeMVxt1ngNXU8xTs7a9QFDrcg7Uhhu2xD6sjLhkLE990KfD4+pj
         xkeg==
X-Gm-Message-State: AOAM530ZTcc5awC+UNNOCy/zL0Tbq5WA8nhSBSGiCWk+52V4Gu+L3XUf
        oMI8XZtYl7tdIBLWMkI2mgImrA==
X-Google-Smtp-Source: ABdhPJxZRpGSv5FtriBWUwmet70Rne8lc1DFz2TGU/bz/xpz6vX0D33o8sMUKQ35HSmG//ceMjFJ8w==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr8883201wrq.175.1594959991866;
        Thu, 16 Jul 2020 21:26:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id 138sm7191805wmb.1.2020.07.16.21.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 21:26:31 -0700 (PDT)
Subject: Re: [PATCH v4 08/16] thermal: sun8i: add TEMP_CALIB_MASK for
 calibration data in sun50i_h6_ths_calibrate
To:     Frank Lee <frank@allwinnertech.com>, anarsoul@gmail.com,
        tiny.windzz@gmail.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, mripard@kernel.org, wens@csie.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com
References: <cover.1594708863.git.frank@allwinnertech.com>
 <b8761e036b25f20873534e5f8d10b37b5d2ce72c.1594708864.git.frank@allwinnertech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4771acd6-ecd3-b8e1-8605-75d78720b1d3@linaro.org>
Date:   Fri, 17 Jul 2020 06:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b8761e036b25f20873534e5f8d10b37b5d2ce72c.1594708864.git.frank@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/07/2020 09:13, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> For sun50i_h6_ths_calibrate(), the data read from nvmem needs a round of
> calculation. On the other hand, the newer SOC may store other data in
> the space other than 12bit sensor data. Add mask operation to read data
> to avoid conversion error.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Reviewed-by: Yangtao Li <tiny.windzz@gmail.com>

Can you clarify these SoB ?

Frank Lee==Yangtao Li==frank@allwinnertech.com==tiny.windzz@gmail.com ?



> ---
>  drivers/thermal/sun8i_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index 74d73be16496..f423d44b9290 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -244,7 +244,7 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
>  	ft_temp = (caldata[0] & FT_TEMP_MASK) * 100;
>  
>  	for (i = 0; i < tmdev->chip->sensor_num; i++) {
> -		int sensor_reg = caldata[i + 1];
> +		int sensor_reg = caldata[i + 1] & TEMP_CALIB_MASK;
>  		int cdata, offset;
>  		int sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
