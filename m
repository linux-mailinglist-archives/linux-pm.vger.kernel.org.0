Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE399672D60
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jan 2023 01:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjASA1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 19:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASA1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 19:27:18 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C75FD72
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 16:27:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so2555433wmb.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 16:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tx6cRZKvnZ7rq9MYTtjXCQ9AszC1w5ywquPAzlDSXkw=;
        b=vbw9CGoQd7mhE1Joa0KgVsq6sCf5NqDNfR9Y0SDghPP6Kf+IMiX2dJJFaRsJxy9cUe
         5xdhXIzf6R+mEDZ/lLalkqliv6mFIUB0I/rsl2xGlasH+CRDF7QBeozmlwTcd2SVXc7j
         bgfj946a0zBSjPx9mlJy9epGuSwzUmnZ6XRrRaGikSwhdto9e0DUv6eIpY+U6r114kDj
         Emn7bz9zQRVODLhxM18Ks2EEXY+Jb5fRUO9ZuS8cpeR42lLSvnnNGhZy5DaKW3wLyns0
         zlSg2eDyFTovbHMuZDtjUtoDZCjhIRGmWx9F/YUA/n+3VuScZfcq3vkITNIP7z+H6d6Q
         LdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx6cRZKvnZ7rq9MYTtjXCQ9AszC1w5ywquPAzlDSXkw=;
        b=GoKeYWreRnlI5jPIsNQ9lpk/eLcMf2qmCQlkF0woL5iQ7j0hptRiJvM9HpqmiT3Ngm
         gTZfAzogn4ickERCp8ENpZdINB1F68RL1Pz5rCrCd34hiy3aTxas/ly3Gjf4P2Mj0O48
         kBPee+LHyy+tsDPhA3CCKuoL/p7Z8frr7Yk7dGfwTA55w87yAvXj7+5IRd1KXgml9Hr2
         /f3xnvx8mxs5mC6+CGlA4AsHS9h3Rlpr4t6Xvx3umtUIb9EWA20qUKXho6LHub1TpSeA
         q6jVkIAu48xU/ZqY+58f0OGrvHw8DTjRbTI76Zl9muWPdNimNieUux29l6bsSLvNSgoE
         /ZSg==
X-Gm-Message-State: AFqh2kpJpLZf1fmHTkaEnPxudLg2skjjbvqpIanFUxgVNnINGL4e6JZn
        uP+GsH77wiZCBTBpnJqrGKGXng==
X-Google-Smtp-Source: AMrXdXv3/fmENJS2XtzEEt2uykAEBXhQ6eeLzSMpKg0Hr4+09EPBs6UEChZKITU0BFvZeuyGZJLK0g==
X-Received: by 2002:a05:600c:3c92:b0:3d3:4007:9c88 with SMTP id bg18-20020a05600c3c9200b003d340079c88mr8679015wmb.18.1674088035956;
        Wed, 18 Jan 2023 16:27:15 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id bg1-20020a05600c3c8100b003db09eaddb5sm3103660wmb.3.2023.01.18.16.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 16:27:15 -0800 (PST)
Message-ID: <eac4a16e-c6b2-64ae-f5a2-84dab64476df@linaro.org>
Date:   Thu, 19 Jan 2023 00:27:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/9] interconnect: qcom: rpm: Always set QoS params on
 QNoC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
References: <20230116132152.405535-1-konrad.dybcio@linaro.org>
 <20230116132152.405535-3-konrad.dybcio@linaro.org>
 <8673ef49-a37e-2d76-b800-bf9b10875006@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <8673ef49-a37e-2d76-b800-bf9b10875006@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/01/2023 20:36, Konrad Dybcio wrote:
> Would be very nice if somebody could test this one in particular
> on QCM2290 to make sure it does not regress that SoC..
> 
> Shawn, Loic?
> 
> Konrad

I have a 2290.

Since I'm already helping with review, I'm happy to help with test too.

---
bod
