Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106743A6EB1
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 21:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhFNTSV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 15:18:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34912 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhFNTSV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 15:18:21 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lss4H-0007Q5-58
        for linux-pm@vger.kernel.org; Mon, 14 Jun 2021 19:16:17 +0000
Received: by mail-ed1-f71.google.com with SMTP id p24-20020aa7c8980000b0290393c37fdcb8so9643255eds.6
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 12:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TUzkmOme0TmCtd3RoNGL+uA/YnlcaGPBaNMGhiut9mY=;
        b=ewUTd4bItb3n91pEH0Oiac6jEQX+vLWq84Xzy+JnckOBB+Jp4Ju0+bffpgbZKcxPC6
         IKOsUWctf6Pq5/XTYY0GxA7DIL7IB9rNpF8xJv40AOWszNnlqZ1m1B0hMFvp2ZrrYrDn
         bpIDEM3WVnK1TmUlZDHFGwX76g8+KNs4K+4ovMOmpLrOWZQa+BpGswxaEsNSCVcUxJe+
         tINBx+/BW03a3rzoUVNEGM9YVZM9V/qIKVhMQcmeEdEh8daAvrBOuzOa15Zgw/I02bXN
         0S6psWQ46E7I6GFkSIbjqF5pVcFk5yHMd8myDy1kuLJWQvxGUlg+IdUU/YRM44NBY6ht
         Yw6g==
X-Gm-Message-State: AOAM530S3R5WxAGlAjxc7NcKDKoEO0TOKe4zEq0nFZAOVA0SBIuk3B4n
        V9R3AiiCH4UArDqwzLuoq1tCVld3b9xz2Gi3v/3fy+M/w4+s+CrTZkHll6b7D0KznyDlbu3+kaf
        pns9VAfKzOY9S15r5cxcyxtCW+Xg2SVjcp2MD
X-Received: by 2002:a17:906:9615:: with SMTP id s21mr10253104ejx.505.1623698176646;
        Mon, 14 Jun 2021 12:16:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo0/zvVAJ2MFxa5ky6KH956YgBy4z5Av7KsVRKr654YOAXxqBt+BY0ViGLcsNCBwMHq6Eszw==
X-Received: by 2002:a17:906:9615:: with SMTP id s21mr10253086ejx.505.1623698176515;
        Mon, 14 Jun 2021 12:16:16 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id gz5sm7937332ejb.113.2021.06.14.12.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 12:16:16 -0700 (PDT)
Subject: Re: [RESEND PATCH 2/2] thermal: sprd: add missing of_node_put for
 loop iteration
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210528115036.18222-1-krzysztof.kozlowski@canonical.com>
 <20210528115036.18222-2-krzysztof.kozlowski@canonical.com>
 <9d4b9827-74fb-43ea-bcc0-5c780296e6c0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f7213eb3-5b34-7a66-2a71-615e97a5c3a4@canonical.com>
Date:   Mon, 14 Jun 2021 21:16:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9d4b9827-74fb-43ea-bcc0-5c780296e6c0@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/06/2021 19:28, Daniel Lezcano wrote:
> On 28/05/2021 13:50, Krzysztof Kozlowski wrote:
>> Early exits from for_each_available_child_of_node() should decrement the
>> node reference counter.  Reported by Coccinelle:
>>
>>   drivers/thermal/sprd_thermal.c:387:1-23: WARNING:
>>     Function "for_each_child_of_node" should have of_node_put() before goto around lines 391.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
>> ---
>>  drivers/thermal/sprd_thermal.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
>> index 3682edb2f466..2778971aaf03 100644
>> --- a/drivers/thermal/sprd_thermal.c
>> +++ b/drivers/thermal/sprd_thermal.c
>> @@ -388,6 +388,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
>>  		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
>>  		if (!sen) {
>>  			ret = -ENOMEM;
>> +			of_node_put(sen_child);
> 
> Why not a new label for the rollback routine?
> 
> eg. goto out_of_node_put;

Indeed, this should work. When loops end, the sen_child is set to NULL
so of_node_putting it should be fine.

> 
> Or a new function devm_for_each_available_child_of_node() ?

Since there are multiple flavors of this for_each_loop, that might be
too much...


Best regards,
Krzysztof
