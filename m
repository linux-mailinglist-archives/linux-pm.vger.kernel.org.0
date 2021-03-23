Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD362346DA9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 00:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhCWXCA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 19:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbhCWXBd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 19:01:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FF3C061574;
        Tue, 23 Mar 2021 16:01:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f26so27813805ljp.8;
        Tue, 23 Mar 2021 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=84HXR80VeHqLZESZc4iMlUDSruLJkHK/M+dHGF0r0qw=;
        b=Oz0KBishfAMWO1yb3BpbgXhz7TWlRcehMQEHkJwal80qEUOQUATrfcXELGBvDnJG7A
         pQydMuERCrpZLnZ8vLvJMkPPcIbRYJSxvUK8LZ1MGfRuhyb9aheNjSEMjq/dvwB4LpcV
         2GGTDvDhVMWjzoqypG+Kl2XhsK2dun22t6VmcbdyfuUnG4e9MWbEKh14Mg8WoZCHPJu/
         g1JCpUSJ65LrsVBftTHkXiljFCBUQF+RDwUS2JRKfKYWybis5CvDe3SaKI6RByO4utA4
         CbSZWPmabvcoO52k4I0KZa9ey/RJxea+24Kh2LayAB4KgVSIU1Ws87nQ3gcBadNGBSDf
         pjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=84HXR80VeHqLZESZc4iMlUDSruLJkHK/M+dHGF0r0qw=;
        b=HAafdFRUPa06lxaqSKIX07s+J0Xk1JHgS9crRw9xdrZg/AJ7dH6HKoEw+reahB2ZbP
         hmuRGBrWDldATv3zAl9s7LBZ8VF7c938wutyIEENzg/1wyjhkDw/lfjU8ECz99DNIiAF
         zjA+MFaPj8J9udnr0JpB4Up7g/6hFvaGiK+EBDYSZyKk4UXo2KAGrHfmN9AuqBF5KR8H
         VV6DzZ1McVuvvfq71Bdwd+kv9DgBEdIkaBS/4Vf2yzAz2INwiR7rfv36vxy2rmrwWmKy
         7GbPGyzu6tPSSbaRVbVfnBOk56z8h1dhIGjKSTk3MvSwgVT0R4S9NqPkUOSt5VEDuaE8
         if4Q==
X-Gm-Message-State: AOAM530J4U104LHlDynYGoiuc0UZdKfyY5FQPxZQtfHeEAfF+njIdlxc
        hDeEvyeNT2ankndwFXuzmJZ68nSbQCM=
X-Google-Smtp-Source: ABdhPJzzkICY/JETPG882gQh1Ch42Yd8ZvDm5b/QmppZiX2s1xgyZyQYX510NiN5cgrBxHKANQKwpw==
X-Received: by 2002:a2e:8e36:: with SMTP id r22mr131297ljk.427.1616540491159;
        Tue, 23 Mar 2021 16:01:31 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id j19sm41718lfg.225.2021.03.23.16.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 16:01:30 -0700 (PDT)
Subject: Re: [PATCH v4 3/6] dt-bindings: power: tegra: Add binding for core
 power domain
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210314164810.26317-1-digetx@gmail.com>
 <20210314164810.26317-4-digetx@gmail.com>
 <20210323224826.GA1490612@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fd60e507-37b4-acc1-b19a-a3904cd13f65@gmail.com>
Date:   Wed, 24 Mar 2021 02:01:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323224826.GA1490612@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.03.2021 01:48, Rob Herring пишет:
> On Sun, Mar 14, 2021 at 07:48:07PM +0300, Dmitry Osipenko wrote:
>> All NVIDIA Tegra SoCs have a core power domain where majority of hardware
>> blocks reside. Add binding for the core power domain.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../power/nvidia,tegra20-core-domain.yaml     | 51 +++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
>> new file mode 100644
>> index 000000000000..4692489d780a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/nvidia,tegra20-core-domain.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVIDIA Tegra Core Power Domain
>> +
>> +maintainers:
>> +  - Dmitry Osipenko <digetx@gmail.com>
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +
>> +allOf:
>> +  - $ref: power-domain.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nvidia,tegra20-core-domain
>> +      - nvidia,tegra30-core-domain
>> +
>> +  operating-points-v2:
>> +    description:
>> +      Should contain level, voltages and opp-supported-hw property.
>> +      The supported-hw is a bitfield indicating SoC speedo or process
>> +      ID mask.
>> +
>> +  "#power-domain-cells":
>> +    const: 0
>> +
>> +  power-supply:
>> +    description:
>> +      Phandle to voltage regulator connected to the SoC Core power rail.
>> +
>> +required:
>> +  - compatible
>> +  - operating-points-v2
>> +  - "#power-domain-cells"
>> +  - power-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    power-domain {
>> +        compatible = "nvidia,tegra20-core-domain";
>> +        operating-points-v2 = <&opp_table>;
>> +        power-supply = <&regulator>;
>> +        #power-domain-cells = <0>;
> 
> AFAICT, there's no way to access this 'hardware'?
correct
