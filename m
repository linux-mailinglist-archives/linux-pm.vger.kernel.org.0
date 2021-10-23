Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66EA4384D8
	for <lists+linux-pm@lfdr.de>; Sat, 23 Oct 2021 21:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhJWTDh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Oct 2021 15:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhJWTDg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Oct 2021 15:03:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E350C061714;
        Sat, 23 Oct 2021 12:01:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e19so136924ljk.12;
        Sat, 23 Oct 2021 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=muOB9MF9Zhxjrs6CIOof2t92nRpuIVGjz439fg/SEiM=;
        b=JXHGPXmRqY6rcGYrfW64Up3FOeUiauwg1ygSfpInAVbhXSdSVbR5oBDst1TmYO8km5
         vzKq/YPHqFV6dmo8CQ5nzzkH54EF1XAolDTLCkMjiay4m0OEOm1gTcEUthYG7KllJgIL
         U69IKRkpMydvFqMSzeOUeugLIcydzy9ud7N6dQ7XPhLeLa3Mtx0CbOQLnDO80+nd3mQV
         ZoU3rQJAhNiiJ9DfWDWorHqaWLz8Sffrk5WL9EiCEWX3kIux9Qe8HPIqyYe2tbHvpZzB
         v+/qVNO/7z1gukJG0p6auzfJOMwK/ehPJ5aCYGEzjbv6VJNFj5b8SFFIy4rn7oNx3tT4
         s5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=muOB9MF9Zhxjrs6CIOof2t92nRpuIVGjz439fg/SEiM=;
        b=e57RA8hwtG4rSf5pefL12NwSUNsPjjr4PjhyavhK7wimrVfRTmOXHcz6jucIv9haWs
         yTh7B1/c8bm4b8Ak4XU4orh9D2itP6w/sqon+PV5jgmrEksDxbK9kN94X8tfWfu7823X
         ECh5yY3eari5SMfVYyljda6ab2rKWwzCzjkHOdwgbob5D9vtNYHeqWZhbYi3kU8e1Tnp
         u+8bHliv78v0vBfFp/KaVebNCaLNCdlMBa/xy7wgULoFEjiYw0sKgqO9cSWPj+hsqkrG
         XyorYH0nmoym3vwhMpx6rOEByIC4K/8YjlMRHY6U4IaVB6h61cxScS3CNI3OV47ZYYTX
         /H/w==
X-Gm-Message-State: AOAM530ZF4ZwY8tGQ/vRxFpS5InVetzdGGFped7nn3zoLxEM7j6HE2ih
        0utdXapd2u8FgOZu847sdZmm5B69Ttk=
X-Google-Smtp-Source: ABdhPJxn4ym2ikSgbiOWVF5AkKLl6gZXz8NIu8EIvP2efm1lIb+6Ipj7nEM8bivqXuc/bVJKIquRhw==
X-Received: by 2002:a2e:b8ca:: with SMTP id s10mr8112349ljp.328.1635015674869;
        Sat, 23 Oct 2021 12:01:14 -0700 (PDT)
Received: from [192.168.2.145] (94-29-53-128.dynamic.spd-mgts.ru. [94.29.53.128])
        by smtp.googlemail.com with ESMTPSA id q2sm776855lfu.191.2021.10.23.12.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 12:01:14 -0700 (PDT)
Subject: Re: [PATCH v1] dt-bindings: opp: Allow multi-worded node names
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, David Heidelberg <david@ixit.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211019231905.2974-1-digetx@gmail.com>
 <YXAr4OlhucAibMlH@robh.at.kernel.org>
 <20211022044334.4yn3i4kwinbrjicd@vireshk-i7>
 <48de7f40-deda-739d-96ca-e61ec5a0b257@gmail.com>
 <20211022065029.x5a5oh7mh2sjofey@vireshk-i7>
 <9798d34b-4886-9d4a-9fb7-634aa323af02@gmail.com>
 <20211022074551.ro22d7xj3idisvzv@vireshk-i7>
 <356febd2-64a2-0451-2c73-9319e5223c57@gmail.com>
 <0d42e370-4c1e-13a1-9a5a-f8ae00d8512d@gmail.com>
Message-ID: <ab97d384-35ae-3cf4-6011-ce47449268bb@gmail.com>
Date:   Sat, 23 Oct 2021 22:01:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0d42e370-4c1e-13a1-9a5a-f8ae00d8512d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.10.2021 16:46, Dmitry Osipenko пишет:
> 23.10.2021 16:00, Dmitry Osipenko пишет:
>> 22.10.2021 10:45, Viresh Kumar пишет:
>>> On 22-10-21, 10:39, Dmitry Osipenko wrote:
>>>> What we currently have for Tegra is a tegra-opps.dtsi and tegra.dtsi
>>>> which includes the OPP's dtsi.
>>>>
>>>> the tegra-opps.dtsi has this structure:
>>>>
>>>> table: devname-opp-table {
>>>> 	opp: ...
>>>> };
>>>>
>>>> and tegra.dtsi:
>>>>
>>>> #include "tegra-opps.dtsi"
>>>>
>>>> device@0000 {
>>>> 	operating-points-v2 = <&table>;
>>>> };
>>>>
>>>> It just occurred to me that there is no need to move all tables to
>>>> tegra.dtsi, but change structure of tegra-opps.dtsi to:
>>>>
>>>> device@0000 {
>>>> 	operating-points-v2 = <&table>;
>>>>
>>>> 	table: opp-table {
>>>> 		opp: ...
>>>> 	};
>>>> };
>>>
>>> I thought you would have already thought about that and I was surprised when you
>>> saw the tables are big enough to be moved. I was wondering what does it really
>>> mean :)
>>>
>>>> Then there no need to change current naming scheme. Let me try to
>>>> implement it and see how it goes.
>>>
>>> That's good then.
>>>
>>
>> I implemented that approach and it works, but there are two problems:
>>
>> 1. I had to factor out OPP tables from SPI device-tree nodes because DTC doesn't allow to have them within SPI nodes [1] and dtb fails to compile.
>>
>> [1] https://elixir.bootlin.com/linux/v5.15-rc6/source/scripts/dtc/checks.c#L1141
>>
>> 2. dtbs_check now warns about every opp-table sub-node, like this:
>>
>> /home/runner/work/linux/linux/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-E1565.dt.yaml: memory-controller@7000f400: 'opp-table' does not match any of the regexes: '^emc-timings-[0-9]+$', 'pinctrl-[0-9]+'
>> 	From schema: /home/runner/work/linux/linux/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
>>
> 
> Thinking more about this, it's not a good idea to add new sub-node to
> nodes which already have sub-nodes because existing driver code that
> parses sub-nodes may not be ready to face the new opp-table sub-node.
> 
> I'll revert back to the previous variant with distinct opp-table nodes.
> 

I renamed OPP tables in accordance to the current opp-table-name
pattern, but still OPP entry names have multiple words on Tegra and it's
not feasible to change that without hurting readability. I'll prepare v3
that will only update pattern of OPP entries.
