Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509114383B9
	for <lists+linux-pm@lfdr.de>; Sat, 23 Oct 2021 15:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhJWNCb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Oct 2021 09:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhJWNCa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Oct 2021 09:02:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C9EC061764;
        Sat, 23 Oct 2021 06:00:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x192so101657lff.12;
        Sat, 23 Oct 2021 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+NSu/QnVZM5jPh0JEYqqX6lEuTLh9VBoJM2wyO5CrKU=;
        b=EHTkByWoNHwHDODLAzRVnLDC4gmGztzIeq0qMjVl61DeLbdUNNGE3sRv3JJ9Zptzuj
         i89ljGs8mEeazCkmFKgPf84byIegBDk0rWz93+KQgDf0Z8tz0W2v8Ja+N7yCCf2Cn1F5
         SFD53Op1TPCszVmEVTv+J42XTvaC2ls15n6e3OlrcjhcNlcOpUB7M/Ch3WqIFqiAHohq
         Z+nDwzzIRwpHuKfaDNLrecgp/Rvrhh1NnqvMsOBsUGLeQ4DZrxvyGpJgK1sSgrR6WuHI
         LCeMFPeSTJQaUUkuCt2TTvrd+pwUnFg/2GgIiWVhPdygCcjzl3tMwVw/N/m56kURty6B
         iDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+NSu/QnVZM5jPh0JEYqqX6lEuTLh9VBoJM2wyO5CrKU=;
        b=u1zuFoRyMGxi9FgzNgSoJ2yX0AgVURtcqek1Jh2xTNJ9IQfn1LqoHzjRw8f/fVNxSf
         d9N8UZANS27gJlVoQGPfxrfPcqlz3oINS7Qxfva5t/Tt8rlIpglT3bOgg267WE7qGXLI
         8nsaH938ChSyDVO4/wA8WPPe09hrNzENgyESva2s3tZ17d45QIiKU0OKZZ5hU4cfNXSu
         8PrkcxfQcKYRs23repFmG8U0iCuklux9wgqAvdWtWayzS6kFrOeKV57ckLF+X4cGeyl4
         du4V7IXEb7+iH2XjNG4CkzL68aO4JjO0tF2FEcyIfrNgjxN3gZWHCfZkYTeTeGtocoix
         8x4g==
X-Gm-Message-State: AOAM533gF/648qdGBmuEK7pWKpRdW2LauPPfyJFDbHTeMemt0AppafcI
        4aYvR4f5FCD9LBEfgRv7pTIwGm8pUKg=
X-Google-Smtp-Source: ABdhPJxDk2X0DcDvKiyqYs1250+vpJWhroRwznp1dn5v9eaZrSWqf5Mo6GW+eCIi023yuab5s8QxTw==
X-Received: by 2002:a05:6512:21b1:: with SMTP id c17mr3697636lft.266.1634994009472;
        Sat, 23 Oct 2021 06:00:09 -0700 (PDT)
Received: from [192.168.2.145] (94-29-53-128.dynamic.spd-mgts.ru. [94.29.53.128])
        by smtp.googlemail.com with ESMTPSA id m23sm1032851lfh.129.2021.10.23.06.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 06:00:09 -0700 (PDT)
Subject: Re: [PATCH v1] dt-bindings: opp: Allow multi-worded node names
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <356febd2-64a2-0451-2c73-9319e5223c57@gmail.com>
Date:   Sat, 23 Oct 2021 16:00:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211022074551.ro22d7xj3idisvzv@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

22.10.2021 10:45, Viresh Kumar пишет:
> On 22-10-21, 10:39, Dmitry Osipenko wrote:
>> What we currently have for Tegra is a tegra-opps.dtsi and tegra.dtsi
>> which includes the OPP's dtsi.
>>
>> the tegra-opps.dtsi has this structure:
>>
>> table: devname-opp-table {
>> 	opp: ...
>> };
>>
>> and tegra.dtsi:
>>
>> #include "tegra-opps.dtsi"
>>
>> device@0000 {
>> 	operating-points-v2 = <&table>;
>> };
>>
>> It just occurred to me that there is no need to move all tables to
>> tegra.dtsi, but change structure of tegra-opps.dtsi to:
>>
>> device@0000 {
>> 	operating-points-v2 = <&table>;
>>
>> 	table: opp-table {
>> 		opp: ...
>> 	};
>> };
> 
> I thought you would have already thought about that and I was surprised when you
> saw the tables are big enough to be moved. I was wondering what does it really
> mean :)
> 
>> Then there no need to change current naming scheme. Let me try to
>> implement it and see how it goes.
> 
> That's good then.
> 

I implemented that approach and it works, but there are two problems:

1. I had to factor out OPP tables from SPI device-tree nodes because DTC doesn't allow to have them within SPI nodes [1] and dtb fails to compile.

[1] https://elixir.bootlin.com/linux/v5.15-rc6/source/scripts/dtc/checks.c#L1141

2. dtbs_check now warns about every opp-table sub-node, like this:

/home/runner/work/linux/linux/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-E1565.dt.yaml: memory-controller@7000f400: 'opp-table' does not match any of the regexes: '^emc-timings-[0-9]+$', 'pinctrl-[0-9]+'
	From schema: /home/runner/work/linux/linux/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
