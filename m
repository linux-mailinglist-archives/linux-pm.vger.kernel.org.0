Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB1150FE1
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 19:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgBCSoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 13:44:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43519 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgBCSoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 13:44:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so8002918pfh.10
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2020 10:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rZdGZOqDjD3n3fgLpAk1XGLPy2PADvd5zLE0E7jYUWQ=;
        b=o+zfo+xocKgGlvffNlVJpuiZPclwA1pqYaqv535u3AzPwqN+Y5dKoPnjDLsuVp2s/E
         GNX0niorAfQrqGqvok4U304yhDvvCk4Ftk+SCOwYAhqZi194YWr6qka/OwgGHmIeJe5h
         qpj73dj70Y9r5a0A8lifIf4FZgh64BwbscbiESynehjc9DXo8XyZ+3pq7dwoKNDKm+SJ
         onRlfsoFVeHvWbML57uceFZL2bys5fCVxJjhsSDvFRUKnhxZsBeBYTyRiW2+TcHeapNI
         8E16rEF/V69IwJ7OHucmgoSnmTLmgfUC6ZUWFQ94zp3I95iDIwEVhanqzsfyqGQVlMvr
         Hnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rZdGZOqDjD3n3fgLpAk1XGLPy2PADvd5zLE0E7jYUWQ=;
        b=McMRGJc/ohIIX8JPaOeiFAoCucU/mQPDQOAh4TVFjOrWWSJ96cebOGSff0uLhtzrRK
         7slg4R/LcbH3d480ICVoNJYBgmO/II7OiZYtg1CDPkg3lq4s7loVJCz4oXo9Yqy4yGJj
         nJk9YRWm50zYMKyCdlekjKRPj8wZQElsnqPw31a64qe90j0W9MIW7i3d36EOrVnLWvR4
         ggTB11Zmtw7/S2M1opC2DyGaBjj/u3A05FBIsWcX5hoZD9AUKM2+oB07inkQDbUfZ0GG
         +mSyz4qc+kLPatXYJD1eFWbPPozfxvQ6XvaNV2BquuYBrOWxGgbw5xZ8FU+yJIfBQWxP
         lxlA==
X-Gm-Message-State: APjAAAUaBuocKcphNwkPeyznNqBO8knE9Q5Un8gHB1FPN4hOlEi6+zFM
        v/iK3Qp0mFm4gsjVEK++RlHV1A==
X-Google-Smtp-Source: APXvYqxeU6T15vSQJ+ceWMBH0wrIMk0vrUCf+jU3XjaiECYGOLfjziElApR4Z8zf4AAdxbSYqTrXbA==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr25860443pgh.331.1580755451162;
        Mon, 03 Feb 2020 10:44:11 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o73sm188234pje.7.2020.02.03.10.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:44:10 -0800 (PST)
Date:   Mon, 3 Feb 2020 10:44:08 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 7/7] drivers: thermal: tsens: Remove unnecessary irq
 flag
Message-ID: <20200203184408.GI3948@builder>
References: <cover.1580390127.git.amit.kucheria@linaro.org>
 <b6db92ea41420c907beb7643f82b6b8011645ac6.1580390127.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6db92ea41420c907beb7643f82b6b8011645ac6.1580390127.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 30 Jan 05:27 PST 2020, Amit Kucheria wrote:

> IRQF_TRIGGER_HIGH is already specified through devicetree interrupts
> property. Remove it from code.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 5b003d598234..9ee00c67144c 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -118,7 +118,7 @@ static int tsens_register(struct tsens_priv *priv)
>  
>  	ret = devm_request_threaded_irq(&pdev->dev, irq,
>  					NULL, tsens_irq_thread,
> -					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					IRQF_ONESHOT,
>  					dev_name(&pdev->dev), priv);
>  	if (ret) {
>  		dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
> -- 
> 2.20.1
> 
