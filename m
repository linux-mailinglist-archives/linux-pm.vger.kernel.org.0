Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8FE5E8274
	for <lists+linux-pm@lfdr.de>; Fri, 23 Sep 2022 21:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiIWTUG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Sep 2022 15:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiIWTUF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2022 15:20:05 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A514F3B8
        for <linux-pm@vger.kernel.org>; Fri, 23 Sep 2022 12:20:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o2so1717840lfc.10
        for <linux-pm@vger.kernel.org>; Fri, 23 Sep 2022 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=X+pZTzxR7NFdMP7acTIOC+efMyMhH4oJXhe8mzyp8I4=;
        b=Spa1q1wivy4GC+E6/dSjtJbfVQPnHhPKpzPnPfAD8PsCic1EnFq1xZOYVVubHeWuWs
         ko4HFeyM8DutBa7npDeQSYZV2VS9NhapCE09OXBaCOA7SIjH3stv7BhRCZCr/njVXlTT
         7jVFZ+ZB7zWpLJNU4PkKaXObj58kIoaSGkGjM036lTFZivIX72flvShp2wpbauUSuFfR
         Qbqspk+ES2lhgUxsKBrLoz9ByUNZZgxlBlU/hk5BeWocRXq+Biiq7IgW+26G494RHXGR
         Nf4SPNymitJNY72Neho0oYlG4H8dbUrI7a5cASzI4IIL/qdg4hUbwzbHpYR8GaEiDRko
         Ncfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=X+pZTzxR7NFdMP7acTIOC+efMyMhH4oJXhe8mzyp8I4=;
        b=WVVFGD3O5jmv5aDuJ1GBhYJ1oIfh8DdZVQAJWDXtMlXX4AMk5N6wZywDPx2jPwoqlx
         9Ih/VEFuURQc12bYK4ZPDTlXicTs9rt7RGse6vxHTinznOUmC4QlyUSuCCJEsA7vAUXi
         QRl6QPTUKcLCxNgSrEjgT3/KpUYeHdOdG2pNfc56OmPaaqNrQk2dx1NtdPg0EReffHvd
         BsNCWr9l9u8jGXFYNu8HwBgMBdsgQCrOa2QY9XyjTtp0r/5yhr3WSsTMEQDL0knL7CjV
         woCP87/oyc4jF/V8Kl0m02l40p4diHrRip6u4FFkTDEGt/x5jpjh1jOURa5i0DRVQijY
         k33w==
X-Gm-Message-State: ACrzQf3cfgis8NoyQf+xM1SMbNcZkPpagyKUkXeyp/AHezDU1a45H1Wa
        hhBHMCkvXcpnwzua9XXNI50CIA==
X-Google-Smtp-Source: AMsMyM602Qhy18+AnYCVZhVVswsfETPSB4kFtqEUa5zezvD2F/6FGpQBX5I0x8KQD3GJSay38Fatig==
X-Received: by 2002:a05:6512:10d6:b0:49a:1fc0:cc62 with SMTP id k22-20020a05651210d600b0049a1fc0cc62mr4126007lfg.138.1663960801984;
        Fri, 23 Sep 2022 12:20:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id by40-20020a05651c1a2800b00261e3856abcsm1453061ljb.102.2022.09.23.12.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 12:20:01 -0700 (PDT)
Message-ID: <984929bf-8dfd-d6d4-2e23-f7d9a1f87a18@linaro.org>
Date:   Fri, 23 Sep 2022 21:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] interconnect: qcom: icc-rpm: Remove redundant
 dev_err call
Content-Language: en-US
To:     Shang XiaoJing <shangxiaojing@huawei.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        djakov@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220923100529.17107-1-shangxiaojing@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923100529.17107-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/09/2022 12:05, Shang XiaoJing wrote:
> devm_ioremap_resource() prints error message in itself. Remove the
> dev_err call to avoid redundant error message.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 39e43b957599..b808805557f1 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -478,10 +478,8 @@ int qnoc_probe(struct platform_device *pdev)
>  
>  		mmio = devm_ioremap_resource(dev, res);
>  

Drop this empty line as well, please.

> -		if (IS_ERR(mmio)) {
Best regards,
Krzysztof

