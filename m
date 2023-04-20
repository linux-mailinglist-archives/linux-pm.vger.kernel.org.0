Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CC76E9E00
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjDTVkJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjDTVkI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 17:40:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870CD30F1
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 14:40:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2fa36231b1cso635010f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682026805; x=1684618805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiKofJxLpzcK1POL74XTZyiqo6DoCaEtr8igEFYC4N0=;
        b=V2dH4vpRLVU0oUQozrZ4aUjCxexgGCk8qrGT1JSJH0oX+TF30NsX/XeVSEbTU7IV9G
         gUHhi5fTlDrKtuyn46BrT4Wf7XpVbtRVLzcpKEz1jvyiyjhXRIpVr7NRTunj+nyomeYc
         159R2BOM9Y9Lfk+uKZzCb+4kZW5K1sAgAygsHH2lAC4aLnRxWXWV6TCkJCYIIGGPwtC2
         qjF1Nh5tiT8x2zjqMcYTYXo6rLkNg0dO0QvtVD6Rxrl+pMKFcsKLOIi4tW/W+R/lTYX1
         MAV9op715wtaX08kXJ/4AuacKyNZIfeZ//ntFQf/3PPJKjvlVMZ2spOyrMuqbWCtruwA
         y40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682026805; x=1684618805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiKofJxLpzcK1POL74XTZyiqo6DoCaEtr8igEFYC4N0=;
        b=lR3JK1/shnGl+A5sQiQklbSGKyFhGBdahL4Ad64bGK0laEM8w5fenJDWV5WvidspgA
         yjKZ9zu7hUPvm3fXtyQ2Ie3FtXKRxPBveW8zfu9HO+79EtrokJtWX5I0x7RD0w3sXUc/
         GvRFx4EcwRW8UAaOyJ1g4vOnfUMQG5eICJXUezs/hqpsEmABMhmx4BDOTx6yBSP+tvQN
         MTOi8+jXi9cmVMAU+DvfTT8dwvhFXY6rSsbgk33IPxi0t7i/ZTikmAHCbP9p19E42oop
         FfurvvoDG7xadR2KEp6Ia+aP/pIG1rxgnhHQntgvrtJG5X6KfmKNWWhXC773G+b9b1nf
         zzAw==
X-Gm-Message-State: AAQBX9do4y9oHjeVGxxYFcvVCbKnox7hTxeDIidNPh/rtv/s4MQenp/j
        sRGrHd8x/23O2SJGvz6I5lthgbAPfAeE7eQtYl4=
X-Google-Smtp-Source: AKy350aKUvhXcbdvVhj8HlnP8pqn62/PVNayCFHM8SljUDL0UqCy2dveIPqqaObMyOoz9TxPqKtM/Q==
X-Received: by 2002:a5d:6182:0:b0:303:2702:6d66 with SMTP id j2-20020a5d6182000000b0030327026d66mr676582wru.63.1682026804799;
        Thu, 20 Apr 2023 14:40:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4599:1915:621d:5b00? ([2a05:6e02:1041:c10:4599:1915:621d:5b00])
        by smtp.googlemail.com with ESMTPSA id bi26-20020a05600c3d9a00b003eddc6aa5fasm2701860wmb.39.2023.04.20.14.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 14:40:04 -0700 (PDT)
Message-ID: <bcc96406-3f74-b79b-3f75-0c3bd88c5eea@linaro.org>
Date:   Thu, 20 Apr 2023 23:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 6/6] thermal/drivers/intel_menlow: Make additionnal
 sysfs information optional
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
 <20230419083343.505780-7-daniel.lezcano@linaro.org>
 <CAJZ5v0gi4j=kJBnXCotQ8_+t39CzOFSBie9Yc6x8BV=TYxsjPQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gi4j=kJBnXCotQ8_+t39CzOFSBie9Yc6x8BV=TYxsjPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/04/2023 19:24, Rafael J. Wysocki wrote:

[ ... ]

> After looking at it once more, I think that this driver isn't really
> functional without the additional sysfs attributes, so if
> CONFIG_INTEL_MENLOW_SYSFS_ADDON is set, the driver effectively becomes
> dead code.
> 
> That's rather unfortunate and I'm not sure how to deal with it ATM.
> 
> I can queue up the rest of the series for 6.4-rc1 (in which case it
> will be pushed in the second half of the merge window), but this
> particular patch requires more thought IMV.

I'm fine if you drop this one from the series.

Thanks for looking at it more deeply


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

