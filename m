Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC8F262B51
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgIIJHy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 05:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgIIJHu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 05:07:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD033C061755
        for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2020 02:07:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so2081695wrn.6
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2020 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/jpvCnRB/HY9hnqXXH+ktB0xBbVQklIkg8Ire344+nU=;
        b=c2tPwYEYDjUGLEkoxbELD4SOFyNJ1uMDf3DaMpmr5L23YBmeDVB1C5npwyTPw1WK06
         K1d4QKR4qlTQliBvduKLq2Da7+mSkgWOgS4PyzzE8aiJU+xsaU+eiqtgoaR6avtzKoRD
         LiNJsbWUf9QqrxJn508NGBUukWU9ClLaHdVgooXs7kVn2unNnN49foc5nZ8fr2Ismgdg
         SlJerKYGYASYXzTNWxpZ3vT7CvRVs78SuZu7bwcQNWpA1PbEYpkgUUi/5ybXsnsRVkrh
         fZGE/PXHTi5frPG3Fy5g/ACszH2OmOmCKMNKwxhh4cPjColZrnT2aZwXvzMn1qEkeV29
         HDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/jpvCnRB/HY9hnqXXH+ktB0xBbVQklIkg8Ire344+nU=;
        b=daPc9rsc+12mG79L8+3BcXhz3m2PM5OnKQiYTe9wX8p52+IanAOAu1ifuRA2Tg7iMD
         w59bPqel5JjPT3tyJvW+XC/WXYAzpq39j4kTAytdDvQjswmkOmVpN4pNwpznx6qK3ICL
         E/K6ZTcz8LrRzGKpckxod/rlX/6ZKhQmdWIrvQuFVJ6GnRnPH4klbsFsRlzIRgSmX7bj
         vAs/S1W7c3rNQeAlsfq0UbSsCrrs0D3gE1PsGlyGD3NtOtDRyUA8Z1Ia2enyhiwcWQvh
         i6/dCc10MTT7Erw8iDIxWdT/sCCyBP2409dWZAf07hSFyxV9RqW/H84A5U9B4veGMt3M
         NMOw==
X-Gm-Message-State: AOAM530NTy0W5pvjgkrZzG6MDgDWprs6EpwnJbYxhYiY5KikAdrShGFd
        GxXhvSIWiF5/uUiwoTkDdRuiZA==
X-Google-Smtp-Source: ABdhPJwdL1SulUvOGytNTBBIIfnQR9CTiQxJ7ytzerFaEVPi8TWrlKtJMKE9CkIsFMUJ4V/0NIyKaQ==
X-Received: by 2002:adf:f24d:: with SMTP id b13mr2750980wrp.316.1599642468243;
        Wed, 09 Sep 2020 02:07:48 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b11sm3196985wrt.38.2020.09.09.02.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 02:07:47 -0700 (PDT)
Subject: Re: [PATCH RFC v6 1/6] dt-bindings: exynos-bus: Add documentation for
 interconnect properties
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh@kernel.org>
Cc:     cw00.choi@samsung.com, krzk@kernel.org, devicetree@vger.kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20200702163724.2218-1-s.nawrocki@samsung.com>
 <CGME20200702163748eucas1p2cf7eab70bc072dea9a95183018b38ad3@eucas1p2.samsung.com>
 <20200702163724.2218-2-s.nawrocki@samsung.com>
 <20200709210448.GA876103@bogus>
 <65af1a5c-8f8a-ef65-07f8-e0b3d04c336c@samsung.com>
 <35d9d396-b553-a815-1f3b-1af4dc37a2ca@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <b711257d-c34b-b609-3ada-312871967b98@linaro.org>
Date:   Wed, 9 Sep 2020 12:07:46 +0300
MIME-Version: 1.0
In-Reply-To: <35d9d396-b553-a815-1f3b-1af4dc37a2ca@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sylwester,

On 8/28/20 17:49, Sylwester Nawrocki wrote:
> On 30.07.2020 14:28, Sylwester Nawrocki wrote:
>> On 09.07.2020 23:04, Rob Herring wrote:
>>> On Thu, Jul 02, 2020 at 06:37:19PM +0200, Sylwester Nawrocki wrote:
>>>> Add documentation for new optional properties in the exynos bus nodes:
>>>> samsung,interconnect-parent, #interconnect-cells, bus-width.
>>>> These properties allow to specify the SoC interconnect structure which
>>>> then allows the interconnect consumer devices to request specific
>>>> bandwidth requirements.
>>>>
>>>> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
>>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
>>>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>>> @@ -51,6 +51,13 @@ Optional properties only for parent bus device:
>>>>  - exynos,saturation-ratio: the percentage value which is used to calibrate
>>>>  			the performance count against total cycle count.
>>>>  
>>>> +Optional properties for interconnect functionality (QoS frequency constraints):
>>>> +- samsung,interconnect-parent: phandle to the parent interconnect node; for
>>>> +  passive devices should point to same node as the exynos,parent-bus property.
> 
>>> Adding vendor specific properties for a common binding defeats the 
>>> point.
> 
> Actually we could do without any new property if we used existing interconnect
> consumers binding to specify linking between the provider nodes. I think those
> exynos-bus nodes could well be considered both the interconnect providers 
> and consumers. The example would then be something along the lines 
> (yes, I know the bus node naming needs to be fixed):
> 
> 	soc {
> 		bus_dmc: bus_dmc {
> 			compatible = "samsung,exynos-bus";
> 			/* ... */
> 			samsung,data-clock-ratio = <4>;
> 			#interconnect-cells = <0>;
> 		};
> 
> 		bus_leftbus: bus_leftbus {
> 			compatible = "samsung,exynos-bus";
> 			/* ... */
> 			interconnects = <&bus_leftbus &bus_dmc>;
> 			#interconnect-cells = <0>;
> 		};
> 
> 		bus_display: bus_display {
> 			compatible = "samsung,exynos-bus";
> 			/* ... */
> 			interconnects = <&bus_display &bus_leftbus>;

Hmm, bus_display being a consumer of itself is a bit odd? Did you mean:
 			interconnects = <&bus_dmc &bus_leftbus>;

> 			#interconnect-cells = <0>;
> 		};
> 
> 
> 		&mixer {
> 			compatible = "samsung,exynos4212-mixer";
> 			interconnects = <&bus_display &bus_dmc>;
> 			/* ... */
> 		};
> 	};
> 
> What do you think, Georgi, Rob?

I can't understand the above example with bus_display being it's own consumer.
This seems strange to me. Could you please clarify it?

Otherwise the interconnect consumer DT bindings are already well established
and i don't see anything preventing a node to be both consumer and provider.
So this should be okay in general.

Thanks,
Georgi
