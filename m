Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E70712EA78
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 20:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgABT33 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 14:29:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44995 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgABT33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 14:29:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id az3so18163450plb.11
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NvU0yti40S840n5QG3gVP/0HZjtdrLIA9EgmtFMdjeY=;
        b=zu8FI6S0upnpm0ix25G3oaUOc0+/iGH++sv5Bcj2kBLoEdj4G5VLPaG3P9qofdE3jM
         kGUCcRTgL2gpIFpgfYy8+7EBIN+kA18SrgprqG1Hx2JUlzDb9GtY/RrrYMUXbtDVY2DB
         5cY4cvup5gLoGT5jtbYCYsnjZNTuWdUlxaDvbCd8bANScYTV7mYZG90qRPPJleqWen+C
         ZZpw+5VbdODX/MT7Q74c02z/z69qpq5ZkU6j45apQgPvUEMPYVW2IwjU0LH0Klr6uZx5
         EclAgxpf4f65o/gcdnf98we6dlSPeYiAHl1H1Mx+nTezrYAoOEKzzFbKGKSohdq2K+s/
         YwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NvU0yti40S840n5QG3gVP/0HZjtdrLIA9EgmtFMdjeY=;
        b=ZjDsjDbGqZcDmS7SwCE8wFKHydttnyNM7MWCp/YR/uS/gZ6pPnQLxtn3KJ1PLR3Evt
         JeD9D0jQdJNNo2zV9T0k2vWpADdYAWNdXR877KX8GCOMiaMuZvZ63n1tWJKDXIFgsPbX
         9AnfHbru75fXM8Gw8jb/vtICIKSBUJ/zfVPmivlQwJXWPofHczP9bB5rlD1iYogssx/x
         YW5WaJLRhoUPLeInc07jdoVmff6xgStAY2Sv48SZdTen6wyNhl7BvA/8hYk2FTqJzIwS
         p8w8GPShXkTYHTO3MOTiVBubZ/nW6fOrRB2RXklVI79Am9S3vxUBobYbv1pab9yKnC9x
         DG/g==
X-Gm-Message-State: APjAAAWttOnZJjkIn9MUbKdo3iZw2B+n/eLUREk2n8SLeM/EL+we6PON
        gF8vjbvH/+7Xps9LJU1CwEiL4w==
X-Google-Smtp-Source: APXvYqzK6klpqUHj5VLLlr49JBuhy2FCQTzFaMgfn5/VXfd20M9M3/Lj/GoFiNaoEiw0ndMfgfZ6Mg==
X-Received: by 2002:a17:902:aa46:: with SMTP id c6mr88130383plr.200.1577993368332;
        Thu, 02 Jan 2020 11:29:28 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b193sm56938366pfb.57.2020.01.02.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 11:29:27 -0800 (PST)
Date:   Thu, 2 Jan 2020 11:29:25 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/9] drivers: thermal: tsens: Release device in
 success path
Message-ID: <20200102192925.GC988120@minitux>
References: <cover.1577976221.git.amit.kucheria@linaro.org>
 <0a969ecd48910dac4da81581eff45b5e579b2bfc.1577976221.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a969ecd48910dac4da81581eff45b5e579b2bfc.1577976221.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 02 Jan 06:54 PST 2020, Amit Kucheria wrote:

> We don't currently call put_device in case of successfully initialising
> the device.
> 
> Allow control to fall through so we can use same code for success and
> error paths to put_device.
> 

Given the relationship between priv->dev and op I think this wouldn't be
a problem in practice, but there's two devm_ioremap_resource() done on
op->dev in this function. So you're depending on op->dev to stick
around, but with this patch you're no longer expressing that dependency.

That said, it looks iffy to do devm_ioremap_resource() on op->dev and
then create a regmap on priv->dev using that resource. So I think it
would be better to do platform_get_source() on op, and then
devm_ioremap_resource() on priv->dev, in which case the regmap backing
memory will be related to the same struct device as the regmap and it
makes perfect sense to put_device() the op->dev when you're done
inspecting it's resources.

Regards,
Bjorn

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 1cbc5a6e5b4f..e84e94a6f1a7 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -687,8 +687,6 @@ int __init init_common(struct tsens_priv *priv)
>  	tsens_enable_irq(priv);
>  	tsens_debug_init(op);
>  
> -	return 0;
> -
>  err_put_device:
>  	put_device(&op->dev);
>  	return ret;
> -- 
> 2.20.1
> 
