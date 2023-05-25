Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB4710AAA
	for <lists+linux-pm@lfdr.de>; Thu, 25 May 2023 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjEYLRQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 May 2023 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240700AbjEYLRP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 07:17:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCDA10B
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 04:17:14 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 17AE06605842;
        Thu, 25 May 2023 12:17:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685013433;
        bh=WtKJ8VIwt3KMym+KTBKAb1FdnlblHiYe+qro4eOjHW8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n24nCTXbgfypBRN3U7fnJnu2up3ADScJwpc2JA0nFGui1qdmf5duZY9yePFWb0Ymo
         wFkRyo8k16ATEz5a23f736ySW4zS1rzRzKO8bZQS+MNNUHjylZL3n7xglvzdElxsMZ
         LScAryY9OVQGnAdO0XPlR6C19TYs/z1vWKzS/zzq9IBBvNHimjcBPUg5KrZjvby8Oe
         6iyBlHuk5T2UV9L+jhelwbe01MkvDIvTTS880A36gm/DOO904YJafpZVE7uhXGOXhv
         RAQVA9KaPKqldBBbvXGSVzv2fMxuvGAHyf0lke77i1f+3eC7kL1juBhNSE6X02w6kA
         wsZy3MgKhJyog==
Message-ID: <2bf27b63-2269-1e11-dd20-bf6a7691ee42@collabora.com>
Date:   Thu, 25 May 2023 13:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] Revert "thermal/drivers/mediatek: Use devm_of_iomap to
 avoid resource leak in mtk_thermal_probe"
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        matthias.bgg@gmail.com
Cc:     void0red@hust.edu.cn, daniel.lezcano@linaro.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        kernel@collabora.com
References: <20230525111417.3350271-1-ricardo.canuelo@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230525111417.3350271-1-ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 25/05/23 13:14, Ricardo Cañuelo ha scritto:
> This reverts commit f05c7b7d9ea9477fcc388476c6f4ade8c66d2d26.
> 
> That change was causing a regression in the generic-adc-thermal-probed
> bootrr test as reported in the kernelci-results list [1].
> A proper rework will take longer, so revert it for now.
> 
> [1] https://groups.io/g/kernelci-results/message/42660
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Adding context: the rework would require us to "probably" change this
iomap to getting regmap handle(s) and working with that, which is why
that wouldn't be trivial.

My apologies about initially misunderstanding the fact that
devm_of_iomap() behaves in a different way compared to of_iomap().

Ricardo, huge thanks for sending this revert.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


>   drivers/thermal/mediatek/auxadc_thermal.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index 0b5528804bbd..f59d36de20a0 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -1222,12 +1222,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> -	auxadc_base = devm_of_iomap(&pdev->dev, auxadc, 0, NULL);
> -	if (IS_ERR(auxadc_base)) {
> -		of_node_put(auxadc);
> -		return PTR_ERR(auxadc_base);
> -	}
> -
> +	auxadc_base = of_iomap(auxadc, 0);
>   	auxadc_phys_base = of_get_phys_base(auxadc);
>   
>   	of_node_put(auxadc);
> @@ -1243,12 +1238,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> -	apmixed_base = devm_of_iomap(&pdev->dev, apmixedsys, 0, NULL);
> -	if (IS_ERR(apmixed_base)) {
> -		of_node_put(apmixedsys);
> -		return PTR_ERR(apmixed_base);
> -	}
> -
> +	apmixed_base = of_iomap(apmixedsys, 0);
>   	apmixed_phys_base = of_get_phys_base(apmixedsys);
>   
>   	of_node_put(apmixedsys);

