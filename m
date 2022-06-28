Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7112755D988
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245667AbiF1Hw2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jun 2022 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245729AbiF1HwW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 03:52:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622D91171
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 00:52:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n1so16356344wrg.12
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5wtHtb6a4km6y1q/2Gud2nKYl0FjGtl/d3/Yc67raLo=;
        b=gNopNL4TjvZr1GFncUxCPJwnmzkhQwU/DDC9PVrWnC/fwJo1kJBGw/yk0yfJgzg34d
         lf+8l7VgLdHhdycA3aKmQqehBkmpR+Q6FYo2ggjixo/0hwm9zX7uNtXDBJSh0A/YUZkn
         iAJmAwuUx9PDL8c2JWSasMs9gBPMXXB6YCxP4oPPqeoZWSORkDdtr/VWnA2gc+6g1q1a
         uC7o0B2jCAe3J2ueKQwj+JY/9tqcckOhYt6NOlaTXb+79ZRTJXtuS4q7aCZD8eEhB/1/
         aWfXjMm6I71ALA363gpoAaZbailT9UF0MCSqNRYSkDTaOsV+yt51NbDokJEkjLVLRb6Z
         T5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5wtHtb6a4km6y1q/2Gud2nKYl0FjGtl/d3/Yc67raLo=;
        b=g2QMESYbX/Cr7mo5WSnwixumb8lhMeeVgGeipy86xrnZJcj1Y9J1e+qpqK/haryEBx
         AlGJg7y43HhJmLvKlbotftccs+f8axpWqSMMqB1J61Ua/k/tLbEIgSxfbyxf2KXs/8De
         gXF9sQdh6kbczLCajRLyi7ek5YxP6WqE4V6gEdxfCSYOlYeF1eHVfdrQ+zh6F2W11suO
         ihg7zLX7jtz/7JniQulMCnVNhotngryq4I/PUbCQQ1ofybi8GtVolFj3dYqKpHHW2mE3
         1m3ZdrScLWu0pT0wOTfk5svccfdZzUmLRfQTcFdHAiPnjKZ1PmJZoO72tSnDLjAEyjP4
         QgUw==
X-Gm-Message-State: AJIora9qddl+lFi96gqFIpM0UXT7QS5LtjWxmoROkB3krgEsXFGA9LnA
        ISopjAz5s8RLZAWXJUDIbEOHUw==
X-Google-Smtp-Source: AGRyM1vNvljPQ++qCrBVJeHCd22sqlJI9hgRYvAcuXWk0IjXScw3qn4brfBRq0r+ULDubADavAus2w==
X-Received: by 2002:a05:6000:1052:b0:21b:927c:1559 with SMTP id c18-20020a056000105200b0021b927c1559mr15880906wrx.303.1656402739989;
        Tue, 28 Jun 2022 00:52:19 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d43cf000000b0021badf3cb26sm15403886wrr.63.2022.06.28.00.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 00:52:19 -0700 (PDT)
Message-ID: <4c8aae23-cf6e-cc68-38a2-a9f8abcc1ba8@linaro.org>
Date:   Tue, 28 Jun 2022 09:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-cpufreq-nvmem: fix board
 compatible in example
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220627143340.477120-1-krzysztof.kozlowski@linaro.org>
 <20220627195040.GA2840123-robh@kernel.org>
 <20220628004507.kghkkf6vx3l2hpqe@vireshk-i7>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628004507.kghkkf6vx3l2hpqe@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/06/2022 02:45, Viresh Kumar wrote:
> On 27-06-22, 13:50, Rob Herring wrote:
>> On Mon, Jun 27, 2022 at 04:33:40PM +0200, Krzysztof Kozlowski wrote:
>>> In the example, alone compatible "qcom,qcs404" is not correct.  Add
>>> proper board compatibles for QCS404 Evaluation Board.
>>>
>>> Reported-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Can be picked up independently, although the issue reported by Rob was
>>> caused by:
>>> https://lore.kernel.org/all/CAL_JsqKXDs=QHKob2Xy6vAFZfnkM9ggfmqf9TNA1hv8TScTmgQ@mail.gmail.com/
>>
>> Best to go in that tree unless it's going to take weeks...
> 
> Lemme know Krzysztof about the timing, I am going to send a pull
> request for cpufreq fixes very soon, so I can take it as well if you
> want.


Thanks Viresh, but I think Rob has a point here - this should be rather
same tree, otherwise checks on your tree complain about undocumented
board compatibles from this patch (because they are in this original tree).

I'll take it and add to my pull request for Rob or Bjorn.

Best regards,
Krzysztof
