Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C44332BD1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 17:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhCIQWS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 11:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhCIQWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 11:22:11 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0A0C06174A;
        Tue,  9 Mar 2021 08:22:11 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id p21so9100414pgl.12;
        Tue, 09 Mar 2021 08:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=epYXOj0a23UYo6KGluvXPsddDr0IApQn+if8TyHD91k=;
        b=YddDgNJhrfBHRzG5hYh/0UXdt+pd/+kaeF0T98l7yB+mZSAFlbtZTkMVkPd36SDyDd
         RKxOuX3j4HFR6HktPOUZD8AE503zePz3RjNSH7YV5XaBCCAH5KjEXoT95S0l9c1D2E8d
         O9QCUa/uh2kDJpyGuNL+05YmTRofZ2T/R22ez9pg5my3AI3Tk8aUfh6GJwaYJJtZBJMw
         ePcZoqNdhVy+XURydgrcr/V4UdHaiWsguCl4W7zjMgw5fbLL7RsD58khH52NpS3mNjZa
         Ts4TOGdcD62/iaStWlGHsz94DUXE/hFyPQy5tJRiGmqFQUPCTp+BKoLLXZC3KqttfiP1
         F6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=epYXOj0a23UYo6KGluvXPsddDr0IApQn+if8TyHD91k=;
        b=iIb5jxQDSw5HF9CYlzfFpNIBy34Frni2A7XPngGSQKGPAWHRUSN6NQuY/b1k27OB2h
         n+/T5OHpQPGuLsFDayPwUT5jTcBD2evH8MAGVb67CIQDRMSd91o5vPQt6F/zjD3L9UWK
         TlekjtHri0EpK5+7ftIgUtVsI508+KS3ZC62OwXlCMG6PkCJQmYqWzNiiphIGVD4dJ6Y
         ODPSYvQSAbMmYv40JaxF/MxRCobZWZc0BpryFAhJTe2n9huDZYAzh1fIZp0HQ5aSyLMQ
         1YFaVNNuz1Sl8iRWt7Rd+iYCmuftLn89XvuNS/7DpMBLeBPUFJthaxg+2gTDdxaZ9nD+
         tv4g==
X-Gm-Message-State: AOAM530i1EmnaB5B/Xyvv0xRWmSXPjSwru3lx2HHdUSpIGkpZxAftpu6
        plJmaMshQw4TGSCUGj6dmBs=
X-Google-Smtp-Source: ABdhPJxeTrvswxWvrzQ7oBpiWNyUbs1yrmJ0I9YLUzN/2YpQP/QgoLsjJj8TBUzbmbiXOJty1ARI8g==
X-Received: by 2002:aa7:9f52:0:b029:1ee:db83:dac6 with SMTP id h18-20020aa79f520000b02901eedb83dac6mr4070793pfr.45.1615306930807;
        Tue, 09 Mar 2021 08:22:10 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id j23sm10017380pfn.94.2021.03.09.08.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 08:22:10 -0800 (PST)
Subject: Re: [PATCH 10/11] PM / devfreq: imx8m-ddrc: remove
 imx8m_ddrc_get_dev_status
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-11-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <ece39c80-a398-a9e4-6922-5805aba5254a@gmail.com>
Date:   Wed, 10 Mar 2021 01:22:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-11-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> Current driver actually does not support simple ondemand governor
> as it's unable to provide device load information. So removing
> the unnecessary callback to avoid confusing.
> Right now the driver is using userspace governor by default.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/imx8m-ddrc.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index bc82d3653bff..0a6b7a1c829d 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -280,18 +280,6 @@ static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
>   	return 0;
>   }
>   
> -static int imx8m_ddrc_get_dev_status(struct device *dev,
> -				     struct devfreq_dev_status *stat)
> -{
> -	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> -
> -	stat->busy_time = 0;
> -	stat->total_time = 0;
> -	stat->current_frequency = clk_get_rate(priv->dram_core);
> -
> -	return 0;
> -}
> -
>   static int imx8m_ddrc_init_freq_info(struct device *dev)
>   {
>   	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> @@ -431,7 +419,6 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>   
>   	priv->profile.polling_ms = 1000;
>   	priv->profile.target = imx8m_ddrc_target;
> -	priv->profile.get_dev_status = imx8m_ddrc_get_dev_status;
>   	priv->profile.exit = imx8m_ddrc_exit;
>   	priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
>   	priv->profile.initial_freq = clk_get_rate(priv->dram_core);
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Will merge this patch after finishing the discussion of
prev patch related to.get_dev_status.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
