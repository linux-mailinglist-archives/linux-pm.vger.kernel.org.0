Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ACD29C89A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829634AbgJ0TTf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 15:19:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33578 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1829620AbgJ0TTd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:19:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id l2so3848479lfk.0;
        Tue, 27 Oct 2020 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/pIfDJ0AkidTbcRkJJnWMl8aJ4kgSl+CTCoDBuFpBc0=;
        b=UScwURpxgTZFS8xiQzfvvhi+CifiknqBp6iMvNs+6Wb0nNRNnC/zO0J9OaAsHDwEZT
         AQJCazQGt04Yo6sPjoxHdIsrvc+4mtm2MIpr/EsQqQ9AzCuHfILl9/kpzyROX9v/JMYh
         hXtkpgUdjMsyskYAoVVEgMI+bty9hBevb4OzTpddCLlrGqpxJDVcjsQVr2AyZTTrzOE9
         KzIdDAACwwH3hsvPHxXp7Kth5lFvX9PR6NnbIPoKL8MjSpnBTdqR/EcRmXU8n7pH5oK6
         l6PNRg2eUhOyB1zu0DnQwDhkNAchozPRXy1xsP3Elsx7h+RkngwlCaKL+TlX8jcE8jhB
         06bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/pIfDJ0AkidTbcRkJJnWMl8aJ4kgSl+CTCoDBuFpBc0=;
        b=I+yHgcBTahmyr6f+SVfftLW+JMAJuhYv09uPYruAsIxg0g+Y22tIJlGjSilbJm3ihj
         BSqEYTUl+TbbT65p65xz8plk5E99kspdDyzWW3nR1uHpohhQzmSBuL5wMfMhlV13lZJy
         CAcJ3F9P8Ri6vNxOEhQNV6mQMLN2M5esPyriPVQK6OXDWU63ydlovYnLtBYhEJAlfTdA
         wGQ9C8pyxbnx6+iePs8Ap2IYDnXc9oHlqYjN9tEDy0XuhXE+jV+Hw7GlZqwqmMJQq+8F
         pVslAxyLt/rZiPFnMOz8+4BP6vfBBiKknhWR9HbH14FUDi8+0lJknmwGpXFbj5YYUjWd
         4jPA==
X-Gm-Message-State: AOAM530h28W+YZ0f6v6gptFZJbApUtra60nhJwdEqCF5x+RUjrn/qLJB
        zu4LR5cmvRXzCWhjshmsDxzarag8iNA=
X-Google-Smtp-Source: ABdhPJzrLiSB7V8GZRxzvrHOF+cQNWPrcMqy1pZLxufDhMT9At8Xhhbg8y/oFfWB+HSFnV39X9bidw==
X-Received: by 2002:a19:4ac1:: with SMTP id x184mr989056lfa.140.1603826370353;
        Tue, 27 Oct 2020 12:19:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id q15sm260867lfb.231.2020.10.27.12.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:19:29 -0700 (PDT)
Subject: Re: [PATCH v6 13/52] dt-bindings: memory: tegra124: emc: Document new
 interconnect property
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-14-digetx@gmail.com> <20201027102506.GB17089@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f38984b6-d53f-a43d-0387-e787b3c1924d@gmail.com>
Date:   Tue, 27 Oct 2020 22:19:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027102506.GB17089@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 13:25, Krzysztof Kozlowski пишет:
> On Mon, Oct 26, 2020 at 01:16:56AM +0300, Dmitry Osipenko wrote:
>> External memory controller is interconnected with memory controller and
>> with external memory. Document new interconnect property which turns
>> External Memory Controller into interconnect provider.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../bindings/memory-controllers/nvidia,tegra124-emc.yaml   | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
>> index 278549f9e051..ac00832ceac1 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
>> @@ -29,6 +29,9 @@ properties:
>>      items:
>>        - const: emc
>>  
>> +  "#interconnect-cells":
>> +    const: 0
>> +
>>    nvidia,memory-controller:
>>      $ref: /schemas/types.yaml#/definitions/phandle
>>      description:
>> @@ -327,6 +330,7 @@ required:
>>    - clocks
>>    - clock-names
>>    - nvidia,memory-controller
>> +  - "#interconnect-cells"
> 
> Another required property, what about all existing users of this binding?

EMC/devfreq drivers check presence of the new properties and ask users
to upgrade the DT. The kernel will continue to work fine using older
DTBs, but devfreq driver won't load.

>>  additionalProperties: false
>>  
>> @@ -345,6 +349,7 @@ examples:
>>  
>>          #iommu-cells = <1>;
>>          #reset-cells = <1>;
>> +        #interconnect-cells = <1>;
> 
> You meant '0'?

'1' is for the "mc" node in the example (not "emc" node).

Anyways, I'll move this hunk to the previous patch in order to fix the
kernel bot warning.
