Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EA67A341C
	for <lists+linux-pm@lfdr.de>; Sun, 17 Sep 2023 09:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjIQHhz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Sep 2023 03:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjIQHhW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Sep 2023 03:37:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DB518E
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 00:37:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so54592391fa.3
        for <linux-pm@vger.kernel.org>; Sun, 17 Sep 2023 00:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694936234; x=1695541034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RvMkdgtkNGNiDefVNDejUYjyLoLcBedhxBbnbsWuV2o=;
        b=EdgNhkm2/OWh4eFVILZIOYcI4tTe76U7RLvW2g92A2GSGPxugLoWVmxHGdpAycljam
         fq5MdFWedy/dktk23hfw2K9ACk7LwQe7JpEQF9L4/Iv5f3E1hFDtioCAtAaJAvqpyBaJ
         G2D++qYjC9RkEfc51/aHN3dua0gL2Lo264sopwHFpKE9sbd+ZoMviY/m0n2wloSRLQy8
         n1Sjgf+AgDhI6Xvvyh24WxH8x5kt8vR10fDlkM+jMFjLCqU6y1FR7cP0/vRjiyYpIA/a
         DwDvCGT2iCPdGJKdFncI9yCemqv2KEiOfv3Tvc6GTPxxZPKnpgKifCmYmsGX3ukriy4+
         prcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694936234; x=1695541034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvMkdgtkNGNiDefVNDejUYjyLoLcBedhxBbnbsWuV2o=;
        b=kglOwkLL09zzS2D5h+k6pcycVZkHMUrCYWtBm1CXRzLDNUX8BFnq64ft3duE4BZjPj
         VH0D9E0ULfNKiXLK0PcykugaWs3ABGuG50cW4mbH8bDY1l1jBsDZ7Vww5EHajN8ehYQx
         fvsLZRXvSKxwg4TlLxQIC1UcPWK9ImvzYPwIYFf2wxGC8uYK9lknGYk6uALzr5myPRjV
         y0S5qC4HHMXzCBaqhyiQJekPAZ/HDl0lEmSOkD/05b8ag06tx1/rdPyCk0o8UIz6g6jO
         JsiHn3PwRJYn59RXMG+AWZwYK21SFL5lcnMRnTPoI44z7BwvyInF9WnibvSO2K5d6lFw
         ChYg==
X-Gm-Message-State: AOJu0YwTl5EV2TiVGGTOnCOqe6a+eJtmjHymx+u9arNcJWzyBJXkkWCJ
        G5kCxJuO6zaIWyWWh1ejSXxppQ==
X-Google-Smtp-Source: AGHT+IEL8NbLQzIyJwWj3iyNixBkp1V6UkVgGtcWAffqfVPS4lYuBlbxvc3fLnB6Mt/CSDQri1aZ8g==
X-Received: by 2002:a2e:9791:0:b0:2bd:1cd0:603f with SMTP id y17-20020a2e9791000000b002bd1cd0603fmr4929585lji.45.1694936233810;
        Sun, 17 Sep 2023 00:37:13 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id s22-20020a1709066c9600b00993a9a951fasm4739819ejr.11.2023.09.17.00.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 00:37:13 -0700 (PDT)
Message-ID: <bbf576d9-ec2c-e243-fddf-9f74ae44e0fd@linaro.org>
Date:   Sun, 17 Sep 2023 09:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dt-bindings: power: qcom,rpmpd: Add SM7150
Content-Language: en-US
To:     Danila Tikhonov <danila@jiaxyga.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230916175952.178611-1-danila@jiaxyga.com>
 <20230916175952.178611-2-danila@jiaxyga.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230916175952.178611-2-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/09/2023 19:59, Danila Tikhonov wrote:
> Add a compatible for SM7150 platforms.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

