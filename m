Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F58672A5C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjARVYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjARVYm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:24:42 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB4260489
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:24:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2028548wmb.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFxZKl7hCmO0fLuY8+p3+x6sh8BJNlqy9dGBP7VEmYM=;
        b=K0DcXw86hQI0oQltDntbuTDBbjkVifmR5KNpltq/kd60KP3U7DDavClaPBtHg3zXHF
         3A2Jsgf6/5qg8tlO1jnZaHvpswBM5uhyuSRjuFUQ99cjr+/uA4roD8sWC0Z0wWkAsPz6
         YBsxXdcESvVO6NMJvvFXt+FlEeKHte25K7/7g7m26Lq9zF0zm7w4qnmOtU0AYfhRY134
         FPItd2dLcD3E2VBBO0/bOoIXmOj5U/Gid3IBBoC5lB9izmV0drZQJD84b7EgowtGsCR7
         FB6LQFHrgDJ0OTIh8Psj4JHHoNhdQsbJjkgdDgA8cQp2mpcUthTX5vWkEjckj4/2J1e6
         bhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFxZKl7hCmO0fLuY8+p3+x6sh8BJNlqy9dGBP7VEmYM=;
        b=0icm9k91W2qgYKeTu9xwTMlggQCwzRnohoz/GFhAmBgtVB22XldUWeHGIpb+F68yGg
         7B4SNqH5riPdaiuxngj4TYFBTVonIXe7g4uoc+oSQtBiGRToY/SNbr2Kqj7/AYR0/xQH
         N0CHusRq5qt3/PUzvLXGRrph4FtURp1+v0Zw9mtlEbNoY4Hrk93/TUSLwPYZU/EUBwtY
         rgIx20COY72rO/DTuUrfrtvXiTeIuDfFwJvDdL574pmEzpe3NvcDJG9YifruvtCKD5wP
         1C1zQwQs7DitwpcrSyCzEvyhcjLMDb+ZUytdlsmDnbjrAAXdezvY+MTTovSDSGRzr4t+
         nY3A==
X-Gm-Message-State: AFqh2koO6v1DAvUX649cZGaHzGjZs6Qky138IgwiS0uGu9uPAhUxvjg6
        /sltB/ykXfFl4MHFqnjZeRII7g==
X-Google-Smtp-Source: AMrXdXuGoYQ2ipyxKj9qImNlNeIu7/IywGxVLvg5V5HN3V4OIeWY5uR558/S2som56xTlfJPCXek7Q==
X-Received: by 2002:a05:600c:3d19:b0:3db:1810:8c9e with SMTP id bh25-20020a05600c3d1900b003db18108c9emr2851203wmb.38.1674077079858;
        Wed, 18 Jan 2023 13:24:39 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e36-20020a5d5964000000b002be0b1e556esm7594189wri.59.2023.01.18.13.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:24:39 -0800 (PST)
Message-ID: <a88d0ee2-5616-0362-0b8d-a9005176890b@linaro.org>
Date:   Wed, 18 Jan 2023 22:24:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_thermal/drivers/mtk=5fthermal=3a_Use?=
 =?UTF-8?B?wqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202301181637472073620@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301181637472073620@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/01/2023 09:37, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

