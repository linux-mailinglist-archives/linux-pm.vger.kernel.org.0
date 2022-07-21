Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5409A57D1A6
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jul 2022 18:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGUQhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jul 2022 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGUQhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2022 12:37:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E037B1D7
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2022 09:37:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z22so3637286lfu.7
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2022 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=egOPuEF9TqE75gZWwUjjn7qf+5eCfzce3I3zf+IUXOo=;
        b=lMktJyzrq1TEYow7Koe8TieEr0tXpOkNUlPK+blhOL7s0Kdtidyp+G2N+ZZ4qxbmXJ
         Rp4er8nUP2ZdowjxcqDVBUkgezKRr5hUiYpnrx98MPVLhAM3+X+EQhVKwNyndbiAlJp3
         VH6Olpyynvcz84fZOsOVU59G2lmJ4LI6pWUQxKBLL94P2AplGDGP8lN4I2DLdhUhz7kY
         1xByz8ImHNXldbxUkRDgSNOH5Nawi7AdKQpzfQ1W4cAQ/W4xVS3tx5VH3pskOBv8zBfz
         UlF+ESATrroO7a3GCavLz6U6tF1XOePATh4c/zdgh17bppeuyk23VaHEMB81w+UmMGn9
         deiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=egOPuEF9TqE75gZWwUjjn7qf+5eCfzce3I3zf+IUXOo=;
        b=Xl3DQE+A8Ndm6FDTAX84X2DtwEWVNTQNrA+LeEFWyWn0GqQ81aroeiMr7d5wpS1JPr
         IzW3RLsa2E2UsVE8bndQRDqNrsEQs2O0xomERFz5NafoZiBkhG0Fly6jPIjbU6DeGlW9
         d60z8DNlxAvpO/W8l2DdgEF3bzueU8yWfB4ZOHdlAE4lSIwzUaWMEoHlPnpoZWBSpBg0
         cqnSRGxDf0a2L3qlLgog7idWAUONaZ0SUNHGe5G93+1wfEWZxKYuTpiI002TZI9ROX5o
         eKjtFVfeupngfvKCi1dpcL075H9lSbHSRi1B0OWNu024EYZUkApU2hf0SEStZEUq8hbF
         oxgA==
X-Gm-Message-State: AJIora/ad1j85l1gE3pMmMjFLJEZACB1dz4X105ih3v0eNG2h52RbQcZ
        2jRqc2Pu5GS1Nx76b01mTz0ykp9TMluFb47e
X-Google-Smtp-Source: AGRyM1si6G1spc2SptdyuVnAcORyTN034fH8EFU/ukJye3I59DI2LMn3mMICtmSEXg4uCa3HJG1r2A==
X-Received: by 2002:a05:6512:3996:b0:489:d526:93e5 with SMTP id j22-20020a056512399600b00489d52693e5mr23205070lfu.534.1658421435329;
        Thu, 21 Jul 2022 09:37:15 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id k6-20020a192d06000000b0047f674838a5sm188263lfj.231.2022.07.21.09.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:37:14 -0700 (PDT)
Message-ID: <67796aa8-6509-620f-f96a-ff22218f1b0c@linaro.org>
Date:   Thu, 21 Jul 2022 18:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] thermal: mediatek: add support for MT8365 SoC
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
References: <20220720181854.547881-1-aouledameur@baylibre.com>
 <20220720181854.547881-3-aouledameur@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720181854.547881-3-aouledameur@baylibre.com>
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

On 20/07/2022 20:18, Amjad Ouled-Ameur wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> MT8365 is similar to the other SoCs supported by the driver. It has only
> one bank and 3 actual sensors that can be multiplexed. There is another
> one sensor that does not have usable data.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

Just like in all other cases - you miss your SoB which is necessary for
the chain.


Best regards,
Krzysztof
