Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06891639A87
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 13:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiK0Md7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 07:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK0Md6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 07:33:58 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43703C76E
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 04:33:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d6so13478189lfs.10
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 04:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PENFU4tyb/ok0u+n8L5L/tdtIhAxV8WKIbXgJYCRZ4c=;
        b=J83nB1R8JQt9tNXauygafshSrUhbkafXaTg6yFyYUo4kEIozy2DZTKr3HlH/uqUv6x
         pnXk1U7+7OPJnzLeUw9S9wV8xZX44zdpjYrkIohA0Jc/Xody3tV8+qdKseqw5g8YOZfu
         9t82f/n5VQ2lUW+xSd+dohxvz02pHGYifa+ZpSd5vV91p8OWTzpPfRw3E+p2m/7G/8hz
         Yfta0w1hDUMR9Wgdzza5cUgN/S0vjhvzWc3U6N/1jxvap5kXSr1hN6PnrKmlxE1vZxFl
         m0zLcaccrSPgtvtoKlMOOJa32dYRuWXtapbI8avr6FRhjNDvewt+lWK5lXDdu8XmiUqV
         Nd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PENFU4tyb/ok0u+n8L5L/tdtIhAxV8WKIbXgJYCRZ4c=;
        b=25Owx7OF5sQcZB1Z7vSeiG/du+bAEbAM2IGKGYniKaZX3SI+H+kYZVL/fNuCj/dDHJ
         fa/qEgIL6NCvWPVDPolU7zFsRfOAaEhynU3ikiapW93/JE1H+WXrayeqfWxpmtuarBo6
         vFz6AzySwELdArOdr7mn31vzeRdoVD77BOSnCWR2TEessDp3hsSwzdEpLNOtd82SnyaQ
         lqpsEJ5lZhsqf4oh+zLut4VCA/CAWVpD8VfG6Z69YmgxdwHe2/MniCOtYeonIj0mgHOT
         KZHw4f0U5bMuM4iTByGnb0bZzwRPk1nb+qUIyq67Qv20tSH98LzF05Gu+9YPQD6kQvBy
         hJSw==
X-Gm-Message-State: ANoB5pk/M1jC2V1VSa00KYKny05VIyyVHOCOPkVkQWRSjXnjfxv4zE0z
        /39PdrVJY8BR9kPekrJeLGvZsA==
X-Google-Smtp-Source: AA0mqf6bsk+mRHVIZABLjwUAjBvqFKFqx32LjqUAnS7Wc/4rBV5tVwipyYKVCpNUnUrh2y106pFFkg==
X-Received: by 2002:a19:5e01:0:b0:4a2:2b5d:b95d with SMTP id s1-20020a195e01000000b004a22b5db95dmr15309572lfb.589.1669552435672;
        Sun, 27 Nov 2022 04:33:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b13-20020a2e894d000000b0026a92616cd2sm923805ljk.35.2022.11.27.04.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 04:33:55 -0800 (PST)
Message-ID: <e07bb325-e39f-8e40-dcd1-00adfadf3bf4@linaro.org>
Date:   Sun, 27 Nov 2022 13:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] dt-bindings: thermal: imx8mm-thermal: Document
 optional nvmem-cells
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Jun <jun.li@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
References: <20221126224740.311625-1-marex@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221126224740.311625-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/11/2022 23:47, Marek Vasut wrote:
> The TMU TASR, TCALIVn, TRIM registers must be explicitly programmed with
> calibration values from OCOTP. Document optional phandle to OCOTP nvmem
> provider.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

