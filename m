Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EBC7B1528
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 09:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjI1HkW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 03:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjI1HkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 03:40:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C930AC
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 00:40:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4054f790190so116093635e9.2
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695886818; x=1696491618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NS4C/mM/zBNdFiLrFor74up9kjjsQXCZO6F1jw5ZLDA=;
        b=CE9a5C5h2CbfituwOHByIg9wOcNtvJAmI54gaPQ0jElB11kurI/R/zRzKf/6jyBEMv
         04RZBV98LmxRoM4AL/UPzlytMGV01oqo4SwcinjQgsQwKsc0J6gTm7mCRcrLiphkblQG
         mlHTkUad93O2D9z4h/Rb84Unr9i+oUfb3Cb9BaoFFLC86rSz0jzoHX+prqYqQQL1siWO
         JiGYgmLUV8Zx1Cmv/8RyB1tGNfNBheimvaXoRySzkENBM9DTShreIJQS2V7VY7nBNwM6
         PHyHnBYYzQ27bz7JOg0We4l+UBRJ+zAl2ExojYECcDmRPPxQTGHVXkYn0B3KaBBbmW5I
         HkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695886818; x=1696491618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NS4C/mM/zBNdFiLrFor74up9kjjsQXCZO6F1jw5ZLDA=;
        b=VQMF2Iu5VwXH5+ylD8UJdu7HrnNZze1agVrh0Vc94MrSC0carW/fdG79Ah3X/D9+S9
         q81kKRPSKCeIoJ7nEnV5spbrxPMeUl6O7tN3tWvvpkbdPPTcpHg8rvQbyJxqbY8TzvIy
         hq3rKg3y0cphTw1Clvkpp2ZTVN4FgwLgUzvJ7JkHAzqa7ltAw6gs3wYn/HYNowBPg1Hl
         2QsZQs/kg86MKN/SwuPEX9ZYNdY+Z4afEZ2PjpsznHLmq9VhzxM7le99nhYVUkrUMm9y
         BcVGf1RSUGWTHdUsCGi/Ynrp8WUS2moVs8PhSAUUpGDymZByO159jfDl2b2Mg8g3k2ZL
         78GQ==
X-Gm-Message-State: AOJu0Yxga7XJW/KmxyLBD4Niuz6tkqVN5Piv1G69+X+Ucm9SbPq5gY7M
        tRmI/vDV3f3/vOvoTsZl4CZHog==
X-Google-Smtp-Source: AGHT+IFIIg/HkrSyr4dW/IdOOjc0GrxIwQDaDFz5Dl/EzewLiPMWA0QQ4iNuQOCvvX+eVWZzRAAM3g==
X-Received: by 2002:a7b:c4d1:0:b0:405:514d:eb13 with SMTP id g17-20020a7bc4d1000000b00405514deb13mr515848wmk.24.1695886817909;
        Thu, 28 Sep 2023 00:40:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id y8-20020a7bcd88000000b003fee567235bsm9924970wmj.1.2023.09.28.00.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:40:17 -0700 (PDT)
Message-ID: <7ca5819f-bfec-bd25-c2f8-8a303802df07@linaro.org>
Date:   Thu, 28 Sep 2023 09:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] thermal: imx8mm_thermal: Fix function pointer declaration
 by adding identifier name
Content-Language: en-US
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230917083443.3220-1-bragathemanick0908@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230917083443.3220-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/09/2023 10:34, Bragatheswaran Manickavel wrote:
> Added identifier names to respective definitions for fix
> warnings reported by checkpatch.pl
> 
> WARNING: function definition argument 'void *' should also have an identifier name
> WARNING: function definition argument 'int *' should also have an identifier name
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

