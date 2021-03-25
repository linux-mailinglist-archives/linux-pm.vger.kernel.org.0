Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82398349857
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 18:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCYRim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 13:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhCYRiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 13:38:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60454C06174A;
        Thu, 25 Mar 2021 10:38:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f16so4248442ljm.1;
        Thu, 25 Mar 2021 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IWF2rjUL4RNwP8tqxzEk+CP2xWiPvF7wgM2YggJx29k=;
        b=Glpk9vDYOel/oYy7nTxAS0XwpNBQzx7ylsJKz74gzs46Eg2558qdSoJDyl+XTKMsk0
         oNmILuqlxpG+5fw8XZLVvup+A0wXMbs17UWj68DkZcO09STg6NO7DjiYbRIQ4gsCpKx3
         +ZZE5UKC36gzw4bW3qXcVbLik+GHLeGdbfJoTyIVeWJUpHJLgVtayZsMG/3vgT9Cmncn
         qihMzZ8p1ZeL89p9vF6AkWK6AFMlTC+slsTCRCqLG8r7GzIlxy6SUuE5RcHojopU8gnP
         yJ263VxCri8YwQJ+RqpS7Tn6CSAsc7v7H3GV3b1J0dwAd6Hs21OoSBdVLSYVV6ztZ/+I
         0mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IWF2rjUL4RNwP8tqxzEk+CP2xWiPvF7wgM2YggJx29k=;
        b=pWWjIhjXWTVh1vGkkNYvIlKxO9OJ7C9I/YZVSveCQkQ6RY1sXYdFqUG/hoKF7qZp/1
         JblIBJFoCL77Uqm12f26QrUfPhxz5NHjgwzhhXVKrVSpnx0dDFvh9xHASnDujdNuw9Sp
         oNuHEA+mK8tMB5ag5wAxoN+Z/7MSwDoOix9xJsLaTW3lR9wzbnaQQFotJYCRVZAwHVB/
         Rso2+6Wanz8I8970kw8hW6W9a36E8Gc9FwB16vYpgUznB9wrCelQrm4SU8V4g7xdImMi
         VtHOf6I8WP+f9UPpkKLQdcRC/TFhGqAB5nEmQVBp1XjsAbFXySKqQCQ/cZT6xSkXEB50
         cC6A==
X-Gm-Message-State: AOAM533r+emAQIVXPk97IwJSxB0/qEUWF4eszdHksuIut9b95wGSvDPx
        kC7eoAuSkK/q93zBZG96ytXvtXgG8aY=
X-Google-Smtp-Source: ABdhPJy+HFyDQ+YADIRrHEHy+wVQ5U68wTuP3H8gv88XId02H1UxV0aV3nF1ktHee9bm7TnbQmkaWA==
X-Received: by 2002:a2e:8051:: with SMTP id p17mr6307832ljg.130.1616693897519;
        Thu, 25 Mar 2021 10:38:17 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id m20sm836193ljj.93.2021.03.25.10.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 10:38:17 -0700 (PDT)
Subject: Re: [PATCH v4 3/6] dt-bindings: power: tegra: Add binding for core
 power domain
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
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
 <fd60e507-37b4-acc1-b19a-a3904cd13f65@gmail.com>
 <YFyjDNYAkbTQU5G0@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <80410199-3b5f-13b7-25b7-3fbd009c31e7@gmail.com>
Date:   Thu, 25 Mar 2021 20:38:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFyjDNYAkbTQU5G0@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

25.03.2021 17:49, Thierry Reding пишет:
> On Wed, Mar 24, 2021 at 02:01:29AM +0300, Dmitry Osipenko wrote:
>> 24.03.2021 01:48, Rob Herring пишет:
>>> On Sun, Mar 14, 2021 at 07:48:07PM +0300, Dmitry Osipenko wrote:
>>>> All NVIDIA Tegra SoCs have a core power domain where majority of hardware
>>>> blocks reside. Add binding for the core power domain.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  .../power/nvidia,tegra20-core-domain.yaml     | 51 +++++++++++++++++++
>>>>  1 file changed, 51 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
>>>> new file mode 100644
>>>> index 000000000000..4692489d780a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-domain.yaml
>>>> @@ -0,0 +1,51 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/power/nvidia,tegra20-core-domain.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: NVIDIA Tegra Core Power Domain
>>>> +
>>>> +maintainers:
>>>> +  - Dmitry Osipenko <digetx@gmail.com>
>>>> +  - Jon Hunter <jonathanh@nvidia.com>
>>>> +  - Thierry Reding <thierry.reding@gmail.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: power-domain.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - nvidia,tegra20-core-domain
>>>> +      - nvidia,tegra30-core-domain
>>>> +
>>>> +  operating-points-v2:
>>>> +    description:
>>>> +      Should contain level, voltages and opp-supported-hw property.
>>>> +      The supported-hw is a bitfield indicating SoC speedo or process
>>>> +      ID mask.
>>>> +
>>>> +  "#power-domain-cells":
>>>> +    const: 0
>>>> +
>>>> +  power-supply:
>>>> +    description:
>>>> +      Phandle to voltage regulator connected to the SoC Core power rail.
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - operating-points-v2
>>>> +  - "#power-domain-cells"
>>>> +  - power-supply
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    power-domain {
>>>> +        compatible = "nvidia,tegra20-core-domain";
>>>> +        operating-points-v2 = <&opp_table>;
>>>> +        power-supply = <&regulator>;
>>>> +        #power-domain-cells = <0>;
>>>
>>> AFAICT, there's no way to access this 'hardware'?
>> correct
> 
> To avoid exposing this "virtual" device in device tree, could this
> instead be modelled as a child node of the PMC node? We already expose a
> couple of generic power domains that way on Tegra210 and later, so
> perhaps some of that infrastructure can be reused? I suppose given that
> this is different from the standard powergate domains that we expose so
> far, this may need a different implementation, but from a device tree
> bindings point of view it could fit in with that.

At a quick glance this should be too troublesome because OPP and regulator frameworks require a proper/real backing device.

Perhaps we could either turn the whole PMC into a core-domain or add a virtual device as a child of PMC, like this:

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 79364cdafeab..717273048caf 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -850,6 +850,12 @@ pd_mpe: mpe {
 				#power-domain-cells = <0>;
 			};
 		};
+
+		pd_core: core-domain {
+			compatible = "nvidia,tegra20-core-domain";
+			operating-points-v2 = <&core_opp_table>;
+			#power-domain-cells = <0>;
+		};
 	};
 
 	mc: memory-controller@7000f000 {

but then this is still a virtual device, although in a bit nicer way.

It feels like yours suggestion might result in a hardware description that is closer to reality since PMC controls fan out of all power rails within SoC.
