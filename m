Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00477DE30
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243710AbjHPKHs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 06:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243736AbjHPKHT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 06:07:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5992727
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:06:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe4cdb727cso64473615e9.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692180410; x=1692785210;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbB0m9jG4429KI47XkJsVs85hA3EGeFnXeCiJDrb/4k=;
        b=r9gn5CeiUSXfg+w1EI5cqkxp28xR87PUwiWYn2eefFZJfOqMMFn1CDOOzLMg0e2e/D
         2lMbEqH6MulqSl63hi+Bd9TrMcfAJCy+/JOzr7cWjrhrn4lCmcKQIOLqcLmBxvs9GtMD
         Rtocrug9Rnww7uuW9jFAPsEV47g5pVmz0vXDozvIyzqvfwiP4lOri+WD/9iE/v5v7rWf
         JxVf0eSsbGeNl/CT8SqtUGA61x+Q+gnPbyQrAwqRe2qDwL/CE1KNV03a/gY9eXqj+Lbq
         K9JkPpBnsNq/Ae2MraylUXCrwD/IuKSkDJEQRQF0la12TAoZGgrMtXJ3d96iFfr2EGzJ
         B9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180410; x=1692785210;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbB0m9jG4429KI47XkJsVs85hA3EGeFnXeCiJDrb/4k=;
        b=H6xfbS0KGYnpu/tiIB9cds9CgNFx51/ebbeJ+WJ3wtSpYVM9cea+VJ9z4xpywjHRYh
         D8cxY5zLY98aq69KjQK3ggUnZNSFfjU7qtXquQVKNTYdeYZ4qoju5oq3jLTqymEIQ2Qn
         GJpQhrft+onHWGABcODIOfv3T/E2L6RGVZjQgqtoo4ofkvKXiYZv1FNOp7oj4HqWuv/8
         +/50jDcaA23nLRuiSdT3XGMVcCeYnK4eSZCQetUeYXUQaHX31AwOEq/WpDziL5RDDt4N
         QxZYmuk88vBR2uzhm5838xLvwVN8wUsdYJrLckietqUguDCC701smzBfPAh1jkdz0PyI
         1TOQ==
X-Gm-Message-State: AOJu0YyMvePWx65xLG4dG2xTgf4DhMVaPRolbeA6ZJGQ9cvg/iHOTd1x
        Q+K/FnnHI0vQVAic1U7YeDllWA==
X-Google-Smtp-Source: AGHT+IGWY/WCLAfZebyqWJoXw+L01sLw0TskurC4DcPHDorGVHqeHdru6MlwysH4nH9IQcec3JPUCQ==
X-Received: by 2002:a5d:456d:0:b0:315:ad00:e628 with SMTP id a13-20020a5d456d000000b00315ad00e628mr1033039wrc.47.1692180409880;
        Wed, 16 Aug 2023 03:06:49 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l18-20020a5d4112000000b003144b95e1ecsm20731349wrp.93.2023.08.16.03.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:06:49 -0700 (PDT)
Message-ID: <5545c715-0c30-7da5-fe5f-d414681ca7e9@linaro.org>
Date:   Wed, 16 Aug 2023 12:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] thermal: Clean up redundant dev_err_probe()
Content-Language: en-US
To:     Chen Jiahao <chenjiahao16@huawei.com>, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        wenst@chromium.org, robh@kernel.org, frank.li@vivo.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230802094527.988842-1-chenjiahao16@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230802094527.988842-1-chenjiahao16@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/08/2023 11:45, Chen Jiahao wrote:
> Referring to platform_get_irq()'s definition, the return value has
> already been checked if ret < 0, and printed via dev_err_probe().
> Calling dev_err_probe() one more time outside platform_get_irq()
> is obviously redundant.
> 
> Removing dev_err_probe() outside platform_get_irq() to clean up
> above problem.
> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

