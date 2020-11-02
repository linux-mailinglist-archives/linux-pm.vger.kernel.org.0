Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBFA2A23D2
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 05:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgKBEqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 23:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgKBEqk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 23:46:40 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4422FC0617A6
        for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2020 20:46:40 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id o129so10020066pfb.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2020 20:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQ3iOk8BoCoi2iqvb/hLP0oQvCh6DVO14yrJFe2O1m8=;
        b=eJFCRZDh+rqxFEmeiJqlTNffj8ChdNtV8mn2K3wgSiJ8wB1OgUKZMeMn4+jaFHRJ7C
         phGn87B91MscIk3ErGbRRKHJsOZJi7JUSJ+nyIvGIUjjMVCPnbxMEuv3UHYKdlAsX15Y
         1iibyJr7WiD4mqp0/rEaFZ3G+Xyk/qipW6qRGlZtkWVDY/iOqpQ6wDaPGND5POthHPrM
         Lt8Q/TTyfdQIAJccOk0BYdVF0KN31Ox9c7O/+Rw+clocGf+ZgrH450x0ySoUV2CaETa8
         217wsGhoZQoDGYkwVyGSEZjRA34FhN8jYv4QjSJgUQmN+XF65DVt7v+ryKYBhx8e+KaJ
         P/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQ3iOk8BoCoi2iqvb/hLP0oQvCh6DVO14yrJFe2O1m8=;
        b=QOkeiph3fpqsq3XoSvS7LLidQgsGCIjjkN0zq8LQnvitSVOlWopWhDCkeoHhQGdheV
         Qovc2uip86Qy+ajroWEPhemM4w6rtWyX0CTkKNO71rdCk85GF2gnddpriBoKk+8sbBNB
         ugVyya/afLY8Mv0yAm278kY875vI4d2nsCralE6BuspO+8y54BaR61eykhT6SYbn/vsb
         ATvI0Lq2DVDEPHWUna/do06EDqpf8xiebcyB1EFoyRANfwIgoxY8eFQ7wQ9Q7pIHS7Bb
         B+s0yF3ErH+N4yblSj2EN7M8/u1JZCRXc9eQhQIN4sw3dXK5eHhhpSkkQDNOkoOlenm9
         Liow==
X-Gm-Message-State: AOAM532LqSTz7LbhO3xOJb3/bRX483dzKFr3MFSco0Yl61gTNt4O0coj
        q/rSNOdWJ9BD8RnTYZQqW1FbMQ==
X-Google-Smtp-Source: ABdhPJz3jcatIWWoon+TrrMLm8fQmtiU5y1+YWus4gi+3rBSHZR2HWHip7D9EadzNqdtUsKN8bQShA==
X-Received: by 2002:a62:3782:0:b029:15d:2c3e:ca14 with SMTP id e124-20020a6237820000b029015d2c3eca14mr20170899pfa.38.1604292399735;
        Sun, 01 Nov 2020 20:46:39 -0800 (PST)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id t15sm12401285pfq.201.2020.11.01.20.46.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 20:46:38 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:16:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: add missing
 platform_driver_unregister() on error in mtk_cpufreq_driver_init
Message-ID: <20201102044636.2hwblwjxrfll6w5h@vireshk-i7>
References: <20201031011854.137261-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031011854.137261-1-miaoqinglang@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-10-20, 09:18, Qinglang Miao wrote:
> Add the missing platform_driver_unregister() before return from
> mtk_cpufreq_driver_init in the error handling case when failed
> to register mtk-cpufreq platform device
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 7d1212c9b..c03c76a0c 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -572,6 +572,7 @@ static int __init mtk_cpufreq_driver_init(void)
>  	pdev = platform_device_register_simple("mtk-cpufreq", -1, NULL, 0);
>  	if (IS_ERR(pdev)) {
>  		pr_err("failed to register mtk-cpufreq platform device\n");
> +		platform_driver_unregister(&mtk_cpufreq_platdrv);
>  		return PTR_ERR(pdev);
>  	}

Applied. Thanks.

-- 
viresh
