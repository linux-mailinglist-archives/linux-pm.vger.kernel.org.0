Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7E42E97C2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 15:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbhADOzd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 09:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbhADOzd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 09:55:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9046C061794
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 06:54:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g185so19591540wmf.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 06:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DpHGltspxMhExeXCD2M8iy7UXwt02ap3yUVEe+ukNp4=;
        b=BLNO24aBxclXPq1knA7zsxL6tK+L79z/uFRTEvzGB0mlYz/4zGvbeShTPI03F1EMgz
         ZzJdS7AZBo0n6b05V0MDfgk26wXuH2FJtFmLGA3q0+Nj1VRlL36V9gUz4snzqSbCHLEU
         b+qfcfvoQ6kLvqFQgU3zSLjcf1yCGOvOwnidX55nd7jiQ433EjiWXhIbAsG+y3sGw2FT
         t8AKhiVQ29zQ8uSf/Y3RWVAbMD9c8Q7ipm4A7eHXkqJV9gv+wuWC+tpaEACLWfG7Kb70
         2CwFS0AaTBriCoxYbhrRytN7LLqD+7Ti7x+WTtjvLjCN4vsafjEOrEh55cykzXoesGB/
         BldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DpHGltspxMhExeXCD2M8iy7UXwt02ap3yUVEe+ukNp4=;
        b=I0oZkrNKgXVh7+nggsXCuGpHRlLeiWRfLGCUfnhhG8PKCfnlo5guoGkNgt6usvwaXj
         EZw+e7YYNcXRNnA/HNrK6eGsQnDVLHOYZ0US1mOFKRJnzS1Y8N+hXvBhlzfvhFR4yrwW
         mCfNb+28phu9hMh3u3MJnozW3530tXKl+3dCxUzW2SsGAkDirVfQJQ2OzmqU5Yr6vn4H
         Odp6DErGkEkWu39fZEbnl099FPu44e9Om85cJAWMvb96RkU5C3ehvbQxpq3jnqH0wNwl
         nTI5cbrVY5nmHs1LnYAyOtHFwNru+Fn9Achkoyg8Su0L5DW6HpClW8F6hDEYWewHnxht
         oHRQ==
X-Gm-Message-State: AOAM532L+sZ402XXj9s0vs4JDbncwb/6sWhs1OUQBcTjJoNSVk4mrthe
        e9aOZ97CjMd7DGwLCNFi2t7sMEKgXTfWTw==
X-Google-Smtp-Source: ABdhPJwxUVTnawb6mnke+VwptBGiNkDJW2XHI1KSZoDKIOWDfiA0cNDaAeLBq7soJ6k/8pZRS0lXQQ==
X-Received: by 2002:a1c:2785:: with SMTP id n127mr27527398wmn.148.1609772091353;
        Mon, 04 Jan 2021 06:54:51 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k18sm99686806wrd.45.2021.01.04.06.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:54:50 -0800 (PST)
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20201210100906.18205-1-martin.kepplinger@puri.sm>
 <20201210100906.18205-4-martin.kepplinger@puri.sm>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3 3/6] arm64: dts: imx8mq: Add interconnect for lcdif
Message-ID: <89be6e92-dcc7-7796-9258-fa3a480a193d@linaro.org>
Date:   Mon, 4 Jan 2021 16:54:52 +0200
MIME-Version: 1.0
In-Reply-To: <20201210100906.18205-4-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/20 12:09, Martin Kepplinger wrote:
> Add interconnect ports for lcdif to set bus capabilities.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 3617b7238952..7c4b68bda6fa 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -11,6 +11,7 @@
>   #include "dt-bindings/input/input.h"
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/interconnect/imx8mq.h>
>   #include "imx8mq-pinfunc.h"
>   
>   / {
> @@ -522,6 +523,8 @@
>   						  <&clk IMX8MQ_VIDEO_PLL1>,
>   						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
>   				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
> +				interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
> +				interconnect-names = "dram";
>   				status = "disabled";
>   
>   				port@0 {
> 

Nit: IMO, the dt-bindings patch (4/6) should come before this one - first
document the DT properties and then use them. Otherwise looks good to me.

Thanks,
Georgi
