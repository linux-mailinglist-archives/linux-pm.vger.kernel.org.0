Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F722C8FD5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbgK3VTg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 16:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbgK3VTg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 16:19:36 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A284C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 13:18:55 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id z7so18206771wrn.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2020 13:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s7wwZHLUMkDnhr9/aYAQJmVhdyp9Eo9ZP7O6yPKd4Fw=;
        b=e3sJg9NA01Ho6sn0dskGdnlObYK28DnbJbvya+7sT+AeuPKhm+WJkjeeHEweBd2hxr
         op+0Z9ZqgEcwxYK0plgEuksn6IbKiQui24veBQ2u6j7rbQUZec5NVuqUl06lMVFM5k6q
         KXFYaXyoMLPoGdB9we+6kO//3OBx4B3dZXiU5kn0vmecqVWshvl3kRPTPxrf8N2uP042
         BU6oCDARvrn24C0tPRE19NjOr6JIzfVWz5W2McikaaeCzESpfHp71YCCtYSq+SJ2ujG8
         GEJqxtf1xyg4Vjt01y74XqdxyIQ9zaw8DHDeLGjZBnwu5zHgeNWw+clU2tq/xM4K1SD1
         xppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s7wwZHLUMkDnhr9/aYAQJmVhdyp9Eo9ZP7O6yPKd4Fw=;
        b=B2AWumhaav6YWQRRASQeVreCvHNG4vawR4yhNI7fcHGRppV/SFQTcCiIs2e3UM8HHN
         FruANfSiYRiIdJn7Qtv86H2raWySrDiUFfXaoU/EcNpQsl6ve0VRWV/SML41w7dmuItt
         X60lN/W4Fh164IbGLnib/2xJKIdDRKw+Rld5TZZKubWIe0nD5TkppKV9agaWExWtEOj0
         gA/ZrstASQ7i28/Jk905d5L//0e0q4XvnOcZrSN+kKprfZqGRCrKVf+3lT8hytBrQ7A2
         pwtQe6KoPUMHKvY4YkMBXs02EDu7wQc049kLlqWLDHNfBIlV+MTqVsMzGAxPIsLY2O/M
         c6KQ==
X-Gm-Message-State: AOAM531jrNRe/9otV/FIdkr9u6yQ/WWi8PGK+PdgfQA7aEC+MbEknf4A
        Qhk92h+rG62M2wgOhtIE/eRZEQ==
X-Google-Smtp-Source: ABdhPJzfMbLtdJhC0FhB3sK2q1s5HodTszSQ9WX1+qbU/CmfwXi3uRZfZXi5/0zZbC/ptWCrxFnJ3Q==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr31010095wrb.132.1606771134028;
        Mon, 30 Nov 2020 13:18:54 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id f7sm1679578wmc.1.2020.11.30.13.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:18:53 -0800 (PST)
Subject: Re: question: interconnect: changes in 5.10 / imx8mq ?
To:     Martin Kepplinger <martink@posteo.de>,
        Leonard Crestez <cdleonard@gmail.com>, akashast@codeaurora.org,
        Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <c110af2f-635a-71f5-735c-1346b7af0ef9@posteo.de>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <bae4ae77-4d4d-6298-0af7-1d8db7dc7afe@linaro.org>
Date:   Mon, 30 Nov 2020 23:18:52 +0200
MIME-Version: 1.0
In-Reply-To: <c110af2f-635a-71f5-735c-1346b7af0ef9@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30.11.20 22:34, Martin Kepplinger wrote:
> hi,
> 
> what I've used on v5.9 on imx8mq in order to hook up dram frequency to 
> interconnect (via mxsfb/lcdif) - and has worked fine - is:
> 
> * add the NOC node description with "#interconnect-cells = <1>;"
> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/8a6b8486a3e94e2886bde01000f9532e03d243a4 
> 
> (original author is Leonard. I'll preserve authorship when submitting)
> 
> * add "interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
> " to lcdif:
> https://source.puri.sm/martin.kepplinger/linux-next/-/commit/6c4bbcdc315da01a9dc8bbda36290587ce1ed33a 
[..]
> 
>   node                                  tag          avg         peak
> --------------------------------------------------------------------
> NOC                                          2147483647   2147483647
>    30320000.lcd-controller                0            0            0
> DRAM                                         2147483647   2147483647
>    30320000.lcd-controller                0            0            0
> (...)
> 
> 
> 
> what am I doing wrong on recent kernels?

Hi Martin,
This looks related to sync_state. Please try the change below.
It would be nice to get these DT patches merged into mainline.

Thanks,
Georgi

diff --git a/drivers/interconnect/imx/imx8mq.c 
b/drivers/interconnect/imx/imx8mq.c
index ba43a15aefec..9bb951b075e9 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -94,6 +94,7 @@ static struct platform_driver imx8mq_icc_driver = {
  	.remove = imx8mq_icc_remove,
  	.driver = {
  		.name = "imx8mq-interconnect",
+		.sync_state = icc_sync_state,
  	},
  };
