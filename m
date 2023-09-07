Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D156B7974D2
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbjIGPl1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Sep 2023 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245375AbjIGP2o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 11:28:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C0E49
        for <linux-pm@vger.kernel.org>; Thu,  7 Sep 2023 08:28:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-402be83929eso12257535e9.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Sep 2023 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100444; x=1694705244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7Y6zFmhlb8oBiHulr6SNzDGIOTaQJEEOwxmUItsSBI=;
        b=VQ+XCowXUqQuM1kSlALF8l7wqdNvh1V7afuFku6r+ZLlA4z9kSvQQwSqJlCtY7nHxo
         brI6IrysFEEnG3LSOwIDSJh2z4Z7e4ibvhc5uoKOj2y1FSCaSN4KYhnJ+F44cxNQgxCT
         5uZt6+9oevnBWY9ffuSu+qtYqqt5NGsiur878q1qd8yiuoa956D0sXmaL5J1R3nlwgky
         Wm6UhDNAHLaiDDO1O2NkOlAtK1OQF61lxvH/vyjL4eBy4hiy7cm3sC+4IaIc8r3+JMxZ
         1wxjz9abmlTyx2lHScUqnVXXYNJnKUgszS8mXte4Skdc3872W6vjJoHTq4cKU+2AE25j
         28YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100444; x=1694705244;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7Y6zFmhlb8oBiHulr6SNzDGIOTaQJEEOwxmUItsSBI=;
        b=QRlVl5Kjg+V9XrRnuDazDjBRv5AfBgBqnw/kh5wzKSOeS+Yf9yZR3/w8gNsE2Q6ojh
         7lD3aKSuh/mBiSWBy2cVJmWi6jqxX2g+DymJFg7NDFmpnuM3myTE5ypTDPvsKJVPooE5
         cHEe9SeLA1IEUly5yqEeqF46IUk56Ejsbu5fExk22+Lz/W2I3lWxseg1Ez9n/ABszUzC
         J8rIywwMi5T9d/tCiT3j6tkGHpCbX1+McZWNpQ3uuuxg+EGiTL885db+GdEEyGgPH6dh
         bsPmSpiHCgtyCtbuDGdT2scrVH2e+9qC1BTHddoOK0S6tM8anuQ4MhKUIyGcNFkPp/UV
         TyCA==
X-Gm-Message-State: AOJu0Yxa97EymKDfV4mFaj82ZmKW4TSJPEFyuvPCzW9I0UQkAjpIxvnb
        qheWEec1wqnkjGT+Dral2J6l3ncA+Rd2IbvtZ2A=
X-Google-Smtp-Source: AGHT+IEKmnSNSlUtiCWpMx5epfLO+Rm4w2bJrzAa6Be3omHD0KXp967h3WlCKIuq9OnSAsdvXE+3AA==
X-Received: by 2002:a05:6402:3c2:b0:522:2dcc:afb6 with SMTP id t2-20020a05640203c200b005222dccafb6mr3798766edw.7.1694066597001;
        Wed, 06 Sep 2023 23:03:17 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id t3-20020aa7d4c3000000b0051bed21a635sm9237337edr.74.2023.09.06.23.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:03:16 -0700 (PDT)
Message-ID: <3f68d3bf-3273-2339-ea41-3362ced3c91b@linaro.org>
Date:   Thu, 7 Sep 2023 08:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 05/10] dt-bindings: cpufreq: qcom-cpufreq-nvmem:
 document IPQ5332
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <8fe23b5401362e214078648926a00f7ceefaa542.1693996662.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8fe23b5401362e214078648926a00f7ceefaa542.1693996662.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/09/2023 07:21, Varadarajan Narayanan wrote:
> Document IPQ5332 compatible for Qcom NVMEM CPUFreq driver.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

