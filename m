Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE9F542E4E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jun 2022 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiFHKt6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jun 2022 06:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiFHKt5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2022 06:49:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1788A1E451B
        for <linux-pm@vger.kernel.org>; Wed,  8 Jun 2022 03:49:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u12so40658737eja.8
        for <linux-pm@vger.kernel.org>; Wed, 08 Jun 2022 03:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ppmJecFPUfINSV2AlV4steP2piT7HzfARnep8cf2hLk=;
        b=l8muK1/VkKkOhNmipiIQRvwi177Flgj0aiEyx7YjD/cRfWip7klyqKusOlBQxXNNdO
         aAXobXE/K2pB68YqljIPKpAlzLSH88GmGFULOB4aCiCGcCruAmgNxu2zBGC14aL16HJ8
         uGrM0lcciever+JLI5I0yNo2/4VHS9+rqfDqQJjjv9wr+nEkIn+nDulQKIE9G7USArh9
         5mfxi+7/1eMDWrTJ4NkOGQKz5DoGkvpWB+t0wTkO+g4X0k6DV1zl7hzbf0c1aGHJpEEA
         hDsXNTYaadYyefvY/M/SkLeP3hJG+RGGywu9lqesYSQlk1AwQeY5EWOK0OpqY6FbwG4+
         qJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ppmJecFPUfINSV2AlV4steP2piT7HzfARnep8cf2hLk=;
        b=rZupftqC4AjmoQ0X5zEIWDmBV4xx+hXRUWUWRoO5rTqO6LArewVl2wmAkRhVw72+Hw
         CTXMtYq3vYh7IogDLj+nJFov/Ep1aKtcwSxvzwrKPw9sf2VQrP6+SCJkC1Ll9BxPOGaN
         DI2DB3xIoFB65yeM90W/Wo7GYYtTA7hKw5z0OlkDu4sCwEZzRrvsGAiJYg0Rpj/VHLuZ
         9kRlK9JXdBbQaPOlimyvpO583rOVXDWRyODo29D6fY5jMe08Nfto/00u42WJ8XMqPDKt
         NOG4ZW8W1a/bZlzMb/1gT2ainVUBhQ6MrxvMfwbZzmS9nxNakMHkhk5X8NfFSX0JV28l
         gWXA==
X-Gm-Message-State: AOAM5312TZdi6ek6CaIBkKUo8p79Tw5ramk7o1LnZ7hHtOEuKjxy45zg
        mjAs2PAungEW8OFbjTN20qgZyw==
X-Google-Smtp-Source: ABdhPJxclTtVb0y5AgFpqkyKKvKcjKZGmtq23R0+NldcOLXjcuLItIBpEgk03/t8KGwrkAHZMhAeyA==
X-Received: by 2002:a17:906:c838:b0:711:d49f:687c with SMTP id dd24-20020a170906c83800b00711d49f687cmr12499044ejb.668.1654685391879;
        Wed, 08 Jun 2022 03:49:51 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709061dc900b006fea59ef3a5sm9025683ejh.32.2022.06.08.03.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:49:51 -0700 (PDT)
Message-ID: <30fbfe22-5c57-22b9-516c-fd435c7a754b@linaro.org>
Date:   Wed, 8 Jun 2022 12:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 04/17] dt-bindings: iio: adc: axp209: Add AXP192
 compatible
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-5-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607155324.118102-5-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/06/2022 17:53, Aidan MacDonald wrote:
> The AXP192 is identical to the AXP20x, except for two additional
> GPIO ADC channels.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Same problem...


Best regards,
Krzysztof
