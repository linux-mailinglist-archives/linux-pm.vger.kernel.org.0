Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48DE29C9FD
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441301AbgJ0UQf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 16:16:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37638 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409422AbgJ0UQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:16:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id j30so4008140lfp.4;
        Tue, 27 Oct 2020 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NZ/QoULjtElXVXQH2NSCFi85fHMToCHynpanEMruLAo=;
        b=W01C0YxDJA+JZP7S2bioKHSYjG2/2Ev1CsLzkaCvkGY6p5KDwKm77oEDUYGG4FELCi
         kzBdBCEdFEmfeoXiZnHElufMHoAsgDlmpjvAiBIgQxsjWS1DQYGRxYNzvkW+IlfB2MCy
         PSC0W7v13wyWzy3LE6D+WmefS9/IIwzmftdOaN7W7d8IHWoeAeQ2UcYkLoTmpihETbJ8
         PfuKxM1xunWQdbcvLDJqWpRG921c60S13LrXcSQBv2cMwDsLkt4YKkbYc7HZhdd+BkY0
         EEbDfRLKjeFDnasxFUGOjYGrVJChOEexx3+MdVTE5AAhbwZlScabGL5AFIMlQ0MKFKh/
         kyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZ/QoULjtElXVXQH2NSCFi85fHMToCHynpanEMruLAo=;
        b=h9gJrD8qaist4cv+Qc9AcKoSALpqqDNsUbpKtMWXK7SMwVeYzfLUUv5qLWFH0W0XPG
         FAixwpeI4XO+OC1tOq8dsuqZYFOVJ0zAdU56sdxyympK8AMnYD3VG0xFOAu0uwAFXHrW
         OLTLzjsEobQk0yxtZtYOkA9kifynRYAHRllh++hFylFjR5To9NRC0C5NE/XwhYKz1YI/
         xJvp1sAynopdKV8xYw89O4U/UobATHB4rqdIDtgf/eRMJOCkL16Zh441PG+NNGajwRWD
         xsOL2QWslogn9+MZLYzi/FLOhPzo6CigK+3XAU7bWYeV8NpSyfCPSaz1ialImKV9tdWA
         kgUw==
X-Gm-Message-State: AOAM530EOEIEp1OiJGZvXwUHxJst3THLiS6LeGBeaWbZnSKILzLIIHVw
        G+tlz+5uMUl6EicgHSTryxPo/h90Hoc=
X-Google-Smtp-Source: ABdhPJzhElyTa1Nm+0EwsDbXiq6YOVoLV9mChM3jCyg8PWOvYvdZKxeME2v9jB1jCLHlQP8elBRK5w==
X-Received: by 2002:a19:550d:: with SMTP id n13mr1374492lfe.526.1603829790828;
        Tue, 27 Oct 2020 13:16:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id t66sm241138lff.85.2020.10.27.13.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:16:30 -0700 (PDT)
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
 <f38984b6-d53f-a43d-0387-e787b3c1924d@gmail.com>
 <20201027194833.GE140636@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0a7aeebf-c5ab-13ea-3927-fa39512afd87@gmail.com>
Date:   Tue, 27 Oct 2020 23:16:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027194833.GE140636@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 22:48, Krzysztof Kozlowski пишет:
> On Tue, Oct 27, 2020 at 10:19:28PM +0300, Dmitry Osipenko wrote:
>> 27.10.2020 13:25, Krzysztof Kozlowski пишет:
>>> On Mon, Oct 26, 2020 at 01:16:56AM +0300, Dmitry Osipenko wrote:
>>>> External memory controller is interconnected with memory controller and
>>>> with external memory. Document new interconnect property which turns
>>>> External Memory Controller into interconnect provider.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  .../bindings/memory-controllers/nvidia,tegra124-emc.yaml   | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
>>>> index 278549f9e051..ac00832ceac1 100644
>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
>>>> @@ -29,6 +29,9 @@ properties:
>>>>      items:
>>>>        - const: emc
>>>>  
>>>> +  "#interconnect-cells":
>>>> +    const: 0
>>>> +
>>>>    nvidia,memory-controller:
>>>>      $ref: /schemas/types.yaml#/definitions/phandle
>>>>      description:
>>>> @@ -327,6 +330,7 @@ required:
>>>>    - clocks
>>>>    - clock-names
>>>>    - nvidia,memory-controller
>>>> +  - "#interconnect-cells"
>>>
>>> Another required property, what about all existing users of this binding?
>>
>> EMC/devfreq drivers check presence of the new properties and ask users
>> to upgrade the DT. The kernel will continue to work fine using older
>> DTBs, but devfreq driver won't load.
> 
> If the devfreq was working fine before (with these older DTBs and older
> kernel) then you break the feature.
> 
> If devfreq was not working or was not stable enough, then nothing is
> broken so such change is accepted.
> 
> Which one is then?

Definitely the latter. The current devfreq works okay'ish, but we rely
on hardware to recover from temporal FIFO underflows and it's a
user-visible problem which this series addresses.
