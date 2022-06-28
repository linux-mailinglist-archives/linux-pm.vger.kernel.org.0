Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF9A55C7AA
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 14:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbiF1IKB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jun 2022 04:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiF1IJ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 04:09:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E80275DD
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 01:09:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q18so10357599pld.13
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 01:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4RnN8f28Wulk/jVyz2Pu0AFmL+DKXdhJpmQjHifCIuk=;
        b=TtmePMQSWGcgrs/nnw3RcYmNr53evsSLpuxjQykQ5SfqpEh99Fa3BVmYjBrtYZzvE+
         nLgDpPDclC4BDYKmWcL5JnfSMvhOd2XMkCBobJRFN9cdkvvMK0VQHJhtHDQKquA0su04
         WrquO/3bgfDsPdzpvxpBQleO+50guMXUI6+mB3/wNhTnOdPjiiX6ZxeYjRvWx89Azu8W
         JbqdByzF4+jFr8rpzqulKfq3IGBxn4c5eFi11vxu1qx8utmgxXLiaw04dK4kRfNQXVKe
         Qk/VnzKC+3d53gNY9SPQwgx22v3n0hdGOKDYGxOh0agz3KTkNvNyGXNiqC9SpvCLv5w8
         JzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4RnN8f28Wulk/jVyz2Pu0AFmL+DKXdhJpmQjHifCIuk=;
        b=0/hrIs7wqgSrOSQXXRzCASMVV1BSGGz4DUczGwu6Q5/iykC9aTeGLu/yZ69thj10If
         U90iRTTGATbEd9jPWX/QGqUzxzVZ0ugWwSEcxOqf4rR9ogIDakv+8TYF9soPXCa6wzAe
         2PJ+iPMQxohhEPnU3dyN9k7CjSSCUt7Sy1cgzWzvc/fKJAwlZQl/Hy0lXH67gWopqPLj
         7o1E3kBZy4/i94T/2bW1R2uOqwCnoioKLZKrF+Aq11JQmGZ/Ad9YLrjpy9CA53GXk8Nh
         prQvaIDTS4MjwNUVLw9O005j2hEBQouJ0CpCYLBOxsQa1ClYb44W+hzfbHD0m2c7DAoC
         9New==
X-Gm-Message-State: AJIora9kUmXq/4uHBBUsQ14N8hSdWp6m+eJAsTvioy9WPYU7pxv7SfS8
        ZGZXC/FgloFUo2OFIt9glTo8IQ==
X-Google-Smtp-Source: AGRyM1taEy9Zc+52VE5JMWnVI0vSslas0OOT9IG6YqrEq6+1e2igaSBqB/cyyIf6cJPCygAwUxwaig==
X-Received: by 2002:a17:902:ea02:b0:16a:4b1d:71d9 with SMTP id s2-20020a170902ea0200b0016a4b1d71d9mr2534420plg.52.1656403798143;
        Tue, 28 Jun 2022 01:09:58 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id a4-20020a62bd04000000b00525714c3e07sm8690147pff.48.2022.06.28.01.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:09:57 -0700 (PDT)
Date:   Tue, 28 Jun 2022 13:39:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        rex-bc.chen@mediatek.com, jia-wei.chang@mediatek.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: Re: [PATCH -next] cpufreq: mediatek: fix error return code in
 mtk_cpu_dvfs_info_init()
Message-ID: <20220628080955.rw7gb3rnmhl7qujw@vireshk-i7>
References: <20220517133450.2266243-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517133450.2266243-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-05-22, 21:34, Yang Yingliang wrote:
> If regulator_get_voltage() fails, it should return the error code in
> mtk_cpu_dvfs_info_init().
> 
> Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 37a1eb20f5ba..3a2be4552020 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -474,6 +474,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  	if (info->soc_data->ccifreq_supported) {
>  		info->vproc_on_boot = regulator_get_voltage(info->proc_reg);
>  		if (info->vproc_on_boot < 0) {
> +			ret = info->vproc_on_boot;
>  			dev_err(info->cpu_dev,
>  				"invalid Vproc value: %d\n", info->vproc_on_boot);
>  			goto out_disable_inter_clock;

Applied. Thanks.

-- 
viresh
