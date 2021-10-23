Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C844383D8
	for <lists+linux-pm@lfdr.de>; Sat, 23 Oct 2021 15:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhJWNsY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Oct 2021 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJWNsY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Oct 2021 09:48:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F217AC061764;
        Sat, 23 Oct 2021 06:46:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so51587lfu.5;
        Sat, 23 Oct 2021 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4rKqaG58LsxP7jan+TfTxUtpkcjNd0KJcH+SvoPk9tQ=;
        b=Mml/w11SDttmlYPFEbEV4BKEePRyF05t7cyq+TZeeD6PPNOcKuqDDpOWKe2+zZZkmF
         kbuO+BgChVyXx9Ict4A9soGBZdNelHzweN2+trOLPYxxrq+M/IF4De/MLYpx8T/a+Kxc
         6DwRV65BaB27z3AanI3U3xm1IqVLidy65BIai06Nr+Mzjegu1Z9oWzXfetblbRpxLJgU
         WkJEv1duPeZTMdUZEx8HzZNLrzn0wPuk2CHKbZdg0Xm1V3hKr6qKMfPYT87435WnJOiA
         AUre0nnRhIpvgNMiBkcLzFCT6bNZSKcyIhZHS1AFjOG1w/Zh0lrLrnGu2ZJ34vaVfdth
         ugGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4rKqaG58LsxP7jan+TfTxUtpkcjNd0KJcH+SvoPk9tQ=;
        b=mAvXCBPBgLsIZMqmdOUfnC6/Cix8fAOXrFMfNJo78Cd6jSf+V5aQJlCtFJAbP/Exsz
         nn6PQ6n4f0mnFLsgXwQToQ+AYDQuDSTjWxBTG18ODaEvN5uIR1DTylnmZ9ri1SC3u7UQ
         wDk8PJSD4ZGiOH0nFIw4LdSVJ6Q59eMfWExUDTYW3wjzf2ejn/IsxAeeQDsUGaKXijni
         82NwnmOHKTsknqLu8CpxZbvS2nPGkrCaC9iqNc5/WJxADegcBdq1gAHOG3ciGIi/+wFn
         X/dCOyJn2OPLwlECd8jXBsETmPcxCjztCMtdDzPORvN3jl6f3B1iSA8/amTK1DzkZlCk
         Tcvg==
X-Gm-Message-State: AOAM531Wmn6aIQgQxQnJurSDF4EUi+oyH/P2All4A2rLe7V0fTJYv0J/
        XJ1MBEhkl7r32XUsQTH9DxjlPtQG0fQ=
X-Google-Smtp-Source: ABdhPJxK103geiOjZuq7CrRe1vrwPXqNxDK7QjdYAnhGDWcAOo9ga80f4JQwj9CaAjQ5V+9pDZfCNg==
X-Received: by 2002:a05:6512:3e14:: with SMTP id i20mr5732617lfv.121.1634996762212;
        Sat, 23 Oct 2021 06:46:02 -0700 (PDT)
Received: from [192.168.2.145] (94-29-53-128.dynamic.spd-mgts.ru. [94.29.53.128])
        by smtp.googlemail.com with ESMTPSA id d20sm1175519ljg.20.2021.10.23.06.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 06:46:01 -0700 (PDT)
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
Message-ID: <0d42e370-4c1e-13a1-9a5a-f8ae00d8512d@gmail.com>
Date:   Sat, 23 Oct 2021 16:46:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <356febd2-64a2-0451-2c73-9319e5223c57@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.10.2021 16:00, Dmitry Osipenko пишет:
> 22.10.2021 10:45, Viresh Kumar пишет:
>> On 22-10-21, 10:39, Dmitry Osipenko wrote:
>>> What we currently have for Tegra is a tegra-opps.dtsi and tegra.dtsi
>>> which includes the OPP's dtsi.
>>>
>>> the tegra-opps.dtsi has this structure:
>>>
>>> table: devname-opp-table {
>>> 	opp: ...
>>> };
>>>
>>> and tegra.dtsi:
>>>
>>> #include "tegra-opps.dtsi"
>>>
>>> device@0000 {
>>> 	operating-points-v2 = <&table>;
>>> };
>>>
>>> It just occurred to me that there is no need to move all tables to
>>> tegra.dtsi, but change structure of tegra-opps.dtsi to:
>>>
>>> device@0000 {
>>> 	operating-points-v2 = <&table>;
>>>
>>> 	table: opp-table {
>>> 		opp: ...
>>> 	};
>>> };
>>
>> I thought you would have already thought about that and I was surprised when you
>> saw the tables are big enough to be moved. I was wondering what does it really
>> mean :)
>>
>>> Then there no need to change current naming scheme. Let me try to
>>> implement it and see how it goes.
>>
>> That's good then.
>>
> 
> I implemented that approach and it works, but there are two problems:
> 
> 1. I had to factor out OPP tables from SPI device-tree nodes because DTC doesn't allow to have them within SPI nodes [1] and dtb fails to compile.
> 
> [1] https://elixir.bootlin.com/linux/v5.15-rc6/source/scripts/dtc/checks.c#L1141
> 
> 2. dtbs_check now warns about every opp-table sub-node, like this:
> 
> /home/runner/work/linux/linux/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-E1565.dt.yaml: memory-controller@7000f400: 'opp-table' does not match any of the regexes: '^emc-timings-[0-9]+$', 'pinctrl-[0-9]+'
> 	From schema: /home/runner/work/linux/linux/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
> 

Thinking more about this, it's not a good idea to add new sub-node to
nodes which already have sub-nodes because existing driver code that
parses sub-nodes may not be ready to face the new opp-table sub-node.

I'll revert back to the previous variant with distinct opp-table nodes.
