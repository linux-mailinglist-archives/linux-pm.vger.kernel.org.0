Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182FF78B879
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjH1Tex (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 15:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjH1Teb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 15:34:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660CE1AA
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 12:34:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5256d74dab9so4822391a12.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693251266; x=1693856066;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2coO1h012/oKjichr/wIa11w8Pbfe2OzSpP2nef9GgQ=;
        b=jjNxcPpKqgHSNUm/qblIO2MCLRET1PFeOPng3VWSGaJGXfrIEBHooMtQgmoD+gMOAQ
         KXuInjpAFMJBKtJ1rRsrWDJWQGyN6D2efjJcDd5J+Iqr5LdvZHow+I8UJpbiU84y8V4M
         4ZIhALkZy9Tm+4NEUKhTUjmwP9FPQUeedCRGb6fSSb/esWN+09G1a//5YzyZZtXA5ro+
         w5hhyuJ1tO4jmaoHoJLF9pM9ccsSkh0m3jy3btuMV6/7WECej/sjZz5ibKoynvftWoeC
         S3U7ErSe04OFr1bQ0xBGuTrg60w0WIh8VSl4zgGZI45EvHWuMJDfWHUQFWxURoQIGWuc
         bmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693251266; x=1693856066;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2coO1h012/oKjichr/wIa11w8Pbfe2OzSpP2nef9GgQ=;
        b=j06a+/16kLFzUunkJfMgThQzh1kEfMaJ/+9cmW1/aFah03Oi80c5vQtibycwdOa0Te
         lYjAz6/1LK6GSNKIdefgB87DteU7CHDQTW/WsFCR7AMHqwlEOt8JML+qfqf6cdOqqYu8
         drI71hVnXCmwbBQMaoaiSyJlS5+U9kVVF3nPow4FVzSDXW+uhQM4D/1BdcrsTmX6vwsO
         w+55IUhF6dTNLA+41Q3pxeBKNxhHzXvsABjN4V4G9PrJ2t8Sbc3WiPVja/14uALtBDsd
         /8jZ4ica1+m0Bk5QLE7U7EW5i6mBvkFFO2T+GqhdxB7Qo/W6SKa0cNT0lzOUro3Vf6M+
         MQYA==
X-Gm-Message-State: AOJu0Yz9dzsbLnJ6yI45rPfWO6JrpfPxiOvaK8gVVJs+HBBCcfwbHPn1
        YXynMK4lhTF3bnYyiwEff9q9Jg==
X-Google-Smtp-Source: AGHT+IFWdt05+lelrHt3ly0RYGyDoWzb5bDDXZMDKF9y6ivOHq267LiJCFqK9wIyj5FoIv5nrMBGQw==
X-Received: by 2002:a05:6402:398:b0:523:2e30:aaee with SMTP id o24-20020a056402039800b005232e30aaeemr18513536edv.32.1693251265893;
        Mon, 28 Aug 2023 12:34:25 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id o7-20020a056402038700b0052565298bedsm4741436edv.34.2023.08.28.12.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:34:25 -0700 (PDT)
Message-ID: <867ec3f0-1a43-8d1f-1475-363fc660ab60@linaro.org>
Date:   Mon, 28 Aug 2023 21:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 7/7] arm64: dts: qcom: ipq5018: Add thermal zones
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-8-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693250307-8910-8-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
> IPQ5018 has 4 thermal sensors (zones). With the
> critical temperature being 120'C and action is to reboot.
> Adding all the 4 zones here.
> 

Not much benefit of having it separate patch... You added the
thermal-sensor for this purpose.

Best regards,
Krzysztof

