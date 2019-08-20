Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF195B11
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 11:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfHTJfH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 05:35:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40608 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbfHTJfH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 05:35:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id e27so4461134ljb.7
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2019 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hTvsFcOmSwggdm7PgrD1IJjN9bzFDClMt1u/HcunehU=;
        b=pYwMho3J5PMYtyIzLlzyRFcsPsBb+P6BTE2MZHiEQBcRqt+f9Jz+khkLvoi5Ngt254
         ZGwBYFbhdsmQ6YmsTzlkIkjauww4it8jmFXyqP4py9lHNIlG9faxZAgP+erhDyNebWBL
         4KSexr2QaR3QMuQ1lNMy9RiwFF+JtJomrwt1jXPZWErvZnMV6jxOogjxVvpLc5GowChL
         fgwV4OEiV5D47t8inBDHbidFcoXqhb3GwVDho35s55PBp9tAX1oYZ4/Ld6kKm5S7ZLvf
         Y1wVIvO/qFqfxsxJLNIlts46l0fR+E+f8/8WPTVTjkK2TCA1RO+AladojpZM712fb6z4
         ZZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hTvsFcOmSwggdm7PgrD1IJjN9bzFDClMt1u/HcunehU=;
        b=Y8ZMc2yMg2zzjI8SpxH1n5Yipc57zca2/Xa8KPAqhNNFGSC2qbnHYUmowzgrXn+Bqw
         /LX4sOQqPPwpv23PzZv8dyrzOTjuFSphQlJgnNRjekhQUuo7frllITKSlPxEt5FpzSEA
         ruGIMG9f+IcN+oOlOQ6acQyyDWxd4Y6T9vCcYZDqJNGwme4Dnx3cO06R4Yqe4+drCVC4
         I2/SEnm8SnYn4G/q65mFQE9JXU99eYjX4VAgcm9dHTD5SP8qB7FG+d/HmwUOtEATHU5t
         HZwdmmnqoWOg1jILVHPwZ1636B0JSl8SAIDf3RBkHLE1S0DjASn3//PQ2INo42kvGbV/
         438Q==
X-Gm-Message-State: APjAAAXOHRlLCU3cC09yljllJXWv+9Arvphnl3Zzr/YAVH/AoeTAWWJ1
        VMB4Dmc7vduQBxLsc6wmQURVt2jh98I=
X-Google-Smtp-Source: APXvYqyvVDnssfzkEcE0lLTlxkxh4aA/7WLmrToi/RHVH5+iW6Z7neHR7Z56pl2XgwrgAhL8Oo7eww==
X-Received: by 2002:a05:651c:153:: with SMTP id c19mr5188412ljd.152.1566293704102;
        Tue, 20 Aug 2019 02:35:04 -0700 (PDT)
Received: from [192.168.27.187] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id d16sm2782440lfi.31.2019.08.20.02.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 02:35:03 -0700 (PDT)
Subject: Re: [PATCH 1/2] venus: use on-chip interconnect API
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Aniket Masule <amasule@codeaurora.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20190814084701.25455-1-stanimir.varbanov@linaro.org>
 <20190814084701.25455-2-stanimir.varbanov@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <cc85f55c-3d21-c3b2-6848-e48513263e39@linaro.org>
Date:   Tue, 20 Aug 2019 12:34:59 +0300
MIME-Version: 1.0
In-Reply-To: <20190814084701.25455-2-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stan,

On 8/14/19 11:47, Stanimir Varbanov wrote:
> This aims to add a requests for bandwidth scaling depending
> on the resolution and framerate (macroblocks per second). The
> exact value ff the requested bandwidth is get from a

s/ff/of/

> pre-calculated tables for encoder and decoder.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c    | 34 +++++++++++
>  drivers/media/platform/qcom/venus/core.h    | 14 +++++
>  drivers/media/platform/qcom/venus/helpers.c | 67 ++++++++++++++++++++-
>  3 files changed, 114 insertions(+), 1 deletion(-)

It looks like venus can be built-in, so how about the case when venus is
built-in and the interconnect provider is a module? Maybe add a dependency in
Kconfig to depend on INTERCONNECT || !INTERCONNECT?

> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 0acc7576cc58..19cbe9d5d028 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/clk.h>
>  #include <linux/init.h>
> +#include <linux/interconnect.h>
>  #include <linux/ioctl.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> @@ -239,6 +240,14 @@ static int venus_probe(struct platform_device *pdev)
>  	if (IS_ERR(core->base))
>  		return PTR_ERR(core->base);
>  
> +	core->video_path = of_icc_get(dev, "video-mem");
> +	if (IS_ERR(core->video_path))
> +		return PTR_ERR(core->video_path);
> +
> +	core->cpucfg_path = of_icc_get(dev, "cpu-cfg");
> +	if (IS_ERR(core->cpucfg_path))
> +		return PTR_ERR(core->cpucfg_path);
> +
>  	core->irq = platform_get_irq(pdev, 0);
>  	if (core->irq < 0)
>  		return core->irq;
> @@ -273,6 +282,10 @@ static int venus_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = icc_set_bw(core->cpucfg_path, 0, kbps_to_icc(1000));
> +	if (ret)
> +		return ret;
> +
>  	ret = hfi_create(core, &venus_core_ops);
>  	if (ret)
>  		return ret;
> @@ -355,6 +368,9 @@ static int venus_remove(struct platform_device *pdev)
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  
> +	icc_put(core->video_path);
> +	icc_put(core->cpucfg_path);
> +

Do you have any plans to scale the bandwidth on suspend/resume too?

Thanks,
Georgi
