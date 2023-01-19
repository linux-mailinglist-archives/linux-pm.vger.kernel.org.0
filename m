Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40108672D6C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jan 2023 01:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjASAcJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 19:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjASAcF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 19:32:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456DE5FD72
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 16:32:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k16so366780wms.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 16:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qmzwk8/U/7Lv93kNU/Wz5d/NOO8ccgvgGUTkadSCuS0=;
        b=tw86+56rWxlfYcMrGYPwTjczCEK6oCQk05UiefFjZ0tkvRnjflm/EQRHFNUIPRLHHZ
         B6OeYaBhFsniw8aslhUSB7vLXa2jqyWYLGgGH4OSb0T8gYbE3z310dB7pC4D8i/2rytp
         nGjUfR8up+seIhHhmWv8lMUB26j12DE8aNvmWveINeoSqUYf1LUQdPsjAEKGvjNW/GCW
         pRy8PXazTHyd2tF7SGXsuQm32jnIzy4869ERD1JflxUmXnwdPtV5+OSNLJRk92BdZB8i
         6xNNQf5wJi2pZ89sHEEeIwbQXoLfns3iHnfkTVzD5kdbPZNYH5Pc7A0AEu9kVP9iKGNt
         RC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmzwk8/U/7Lv93kNU/Wz5d/NOO8ccgvgGUTkadSCuS0=;
        b=3hIXIFAl3PFB1jEjCobnHalw31o6gJ4f6J8g0ZEaA6UZr5j+5jLnXL1BMyTTRMrjqq
         qLh5Rj4ehZUvPjvAS0+swJFCJj2bo++uEWpYqJDrj7Lz2M9yabKA8+CtARn6Ch9g0xLz
         a5WTSBFUI1LFYqFH3zDbPcgJdfm2xg/dny44FiSERgqvV5BUn6RuIlFDzyQ9+2xGwwMI
         IMFOe1yv7nxTESNyFZK3WUjKqOn5M67Bt1Tz2QLvzzuMGpI9ZUt7meNkY4R3TI73G73R
         Yl4MUqceQzGrHiWDkijEKAV5z2r97cu9McdzKUbVyqTm86GqXvtswVXAOwIMc8Gt7C3w
         kHXA==
X-Gm-Message-State: AFqh2kprbMpwBACqx1upQsOklxd3fm89/n5wWN+W3J+l5bMowAspqbfd
        1uaA9KSun4LF3wDyQa6ORM9UHQ==
X-Google-Smtp-Source: AMrXdXvYAQzDEUjAx0DnfT8hcJ6jeBoqdrpPfyEJ9ae0RjqaNvhg/pYPkp9Y1R0S9nYqkvq2iWx4QQ==
X-Received: by 2002:a7b:c5d6:0:b0:3d9:fb89:4e3d with SMTP id n22-20020a7bc5d6000000b003d9fb894e3dmr8703045wmk.28.1674088322834;
        Wed, 18 Jan 2023 16:32:02 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b003a3442f1229sm3805813wmq.29.2023.01.18.16.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 16:32:02 -0800 (PST)
Message-ID: <811dbab7-5f4d-5333-5049-45f74d6d0490@linaro.org>
Date:   Thu, 19 Jan 2023 00:32:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/8] dt-bindings: arm: qcom: Document MSM8939 SoC
 binding
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-2-bryan.odonoghue@linaro.org>
 <Y8eyIO8BqKzvulbB@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y8eyIO8BqKzvulbB@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/01/2023 08:47, Stephan Gerhold wrote:
> If we don't support the original bootloaders in a usable way upstream
> then we should not add MSM8939 to the allow list of broken bootloaders
> either, in my opinion.

Yes but, a vendor could just as easily cherry-pick the spin-table 
enabling lk2nd patches back to their lk implementation and begin to drop 
the ongoing burden of supporting the LPM stuff.

We certainly do and should support booting stock lk. There's no sense in 
setting the bar to upstream even higher by imposing a chainloaded 
bootloader on our hypothetical new user.

The right thing to do is to enable the vanilla path but, give the user 
the extra option.

---
bod
