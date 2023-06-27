Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D8073F5DD
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jun 2023 09:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjF0HkV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jun 2023 03:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjF0HkU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2023 03:40:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E653E58
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 00:40:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6985de215so38181201fa.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 00:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687851616; x=1690443616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6NTcpMVbPtfKRTcDrSmD8MoUfkjuvD8dm7rw3ArPL9I=;
        b=swdKSXqee4DsixhpEGqQyNNW3XBWrUevNKszorloHuIBaCA0PcMPOfsuOzl9+QiTte
         4wOsYWBVcN7F8Tj78icmZyMkGYOi7Dm+2krXIRn7atuzwAfMsfDBMaOZ9rnRRGBreFTM
         T6w9ELsAX328Q75z7uohV2hndIY+XECbVG2a2EjOF+5CpugPTygos1zEsS/Efj66b8rp
         FE/YMAM82KyOJcjbDpIYUnEKa3Caf5z4C/YQN9PxDLKCsMG3Si0/KaASqAsXFCONmnQL
         9zuEFehYEYN9wLs03oc5+iWVK1iVNsitw/5ptAAcaTVhDNfxMHzKllJ7PBJJ9IiaC2h3
         ItEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687851616; x=1690443616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NTcpMVbPtfKRTcDrSmD8MoUfkjuvD8dm7rw3ArPL9I=;
        b=g0SiZNiyN5DOOLwBEtvzmO24uaDONg9dAasj5+BO/CneBnMLYa95GHxJbLOaNZZC4M
         Q+pLgQRzicVouLsavRAqGVKBOZqASOt+XcJIQiRMH1VBtXr3TlVWknRwv8nrAq+tFpVP
         qbPK2xSK/9J9n+ST7T+qAkXynkFdtDNfnSO3ha72DjWva+k6WTNIcvTcMscHGRL37+Ch
         1OztC1z+v8+HBmyd/l1NJET0Yc1lhOotAUZbqr3NIj+4Et6TKORdFv126IMUhYn0OJFI
         anaFKJ45derNc9diIzWUkR20NM1eRTILgGbVHN4yKDiifVFFxeRqjUImwjMH+6Ubde38
         IWAQ==
X-Gm-Message-State: AC+VfDzXz2XsjEOckewDuRpTgCvwjVTvGbdEk6naxV7OJVNVWRqu48z3
        Hnrw+1IKaYKMceVHtqfh3KptBg==
X-Google-Smtp-Source: ACHHUZ5+P/WxO4oUioGdTlGmHsZgaxSX0SXG7cUKhxcYXN9myY+XUcQUBUCnCbqT23LWO6u4jDOXNg==
X-Received: by 2002:a2e:7e11:0:b0:2b5:95a8:412b with SMTP id z17-20020a2e7e11000000b002b595a8412bmr7300556ljc.52.1687851616523;
        Tue, 27 Jun 2023 00:40:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bca4e000000b003fa786b5195sm9823842wml.42.2023.06.27.00.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 00:40:16 -0700 (PDT)
Message-ID: <61f9a781-81fe-d553-6c85-eb069174e6f0@linaro.org>
Date:   Tue, 27 Jun 2023 09:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 13/15] thermal/drivers/rockchip: remove redundant msg
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, shangxiaojing@huawei.com,
        bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230627071707.77659-1-frank.li@vivo.com>
 <20230627071707.77659-13-frank.li@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627071707.77659-13-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/06/2023 09:17, Yangtao Li wrote:
> The upper-layer devm_request_threaded_irq() function can directly
> print error information.

I don't understand. "Can print"? It does not matter if it can, if it
does not. Currently it doesn't, therefore change is not correct.
Otherwise explain a bit better why this is redundant.

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Best regards,
Krzysztof

