Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD642D7955
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 16:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbgLKPat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 10:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388379AbgLKPad (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 10:30:33 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED03C0613CF;
        Fri, 11 Dec 2020 07:29:52 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m5so9424447wrx.9;
        Fri, 11 Dec 2020 07:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zERc61e6q0jyeQa9DII4Gd3+QcLplYsxEQ++mmlkRqE=;
        b=kAPBD5ididRwkjsfOLZM27vUwQTDQh5Tvkvr2H9LSKoBN1/Tjgz8j0J7BC6GiT3yc7
         rsyYBvQKGPipWFGSkGYpw9QZUY4lU1EFgOdThLzewOMDzFhr3cHdbMFDhQJrrt22YCjE
         tttxzDbbGnR2C+APmaFEooKNqOlOerIIBqFrJC4X1PTfKg2ugGVKMYVkoT4JLyq5DG52
         MFTAeYJfvaTlk6zb7U93xoS37Zasqzn70eLhGHFBUHcuiS0MfGMldYYNBRp76UR20l5J
         bTVcKDilQoV/mKGAyfGCr4YoVWVPYKBejSiUAk8oVhrRNZvNuMscTS2/DFV6BvmANrNW
         zk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zERc61e6q0jyeQa9DII4Gd3+QcLplYsxEQ++mmlkRqE=;
        b=n17nMdGu9iVj9lZ2NvUoOLbMWCSqwvC0Pv2L9djSWWuOv54N6BsXOv+lrrKxVhSTft
         u+QaEuz0lX182TNMo8Cmm2vJBqCmJh7x8dX+ev40dLLLmuQHJGH/lTZY0SA9IFPYMy7L
         6UbSky3e54k5CRNuhGoHF8CVfxNfJJWFrRO4XxIjKQ2aLCfMEB8hBOp4aIookiIkE9jy
         84uN/2uSzzrrPLa+5AH+oV4vEjbyFMk9+wovH15HLahr1yaOw6s7ruUd1U4gSMn6f8WP
         Wl3hMpTD15zPqmrf5f+HIfvsyDMgS8tD4Py2oX97fNa82VCPvg0tL05HM2HmCs3FrKS0
         wyrg==
X-Gm-Message-State: AOAM531jBMUyPlKHRdU4XFrccWQG7HRXTCczKUDPnbaJDQC3KJn9ZUci
        t17fTRrfZvqF2kNYOvYEq+k=
X-Google-Smtp-Source: ABdhPJzwPIxc9K6r4gJOoLnDqXZc4XcR3ebtAXpwrJFtq3lWVSRQSceS8zmuKv46R5yN9iv1T3rOmQ==
X-Received: by 2002:adf:e64b:: with SMTP id b11mr14391204wrn.257.1607700591324;
        Fri, 11 Dec 2020 07:29:51 -0800 (PST)
Received: from [192.168.74.106] (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id d9sm15262283wrs.26.2020.12.11.07.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 07:29:50 -0800 (PST)
Subject: Re: [PATCH 11/18] ARM: dts: qcom: msm8974-lge-nexus5: correct fuel
 gauge interrupt trigger level
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Matheus Castello <matheus@castello.eng.br>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Angus Ainslie <angus@akkea.ca>,
        Hans de Goede <hdegoede@redhat.com>
References: <20201210212534.216197-1-krzk@kernel.org>
 <20201210212534.216197-11-krzk@kernel.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Message-ID: <14e52c51-23ab-6877-dcec-2b1add958d71@gmail.com>
Date:   Fri, 11 Dec 2020 17:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201210212534.216197-11-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 12/10/20 11:25 PM, Krzysztof Kozlowski wrote:
 > The Maxim fuel gauge datasheets describe the interrupt line as active
 > low with a requirement of acknowledge from the CPU.  The falling edge
 > interrupt will mostly work but it's not correct.
 >
 > Fixes: 45dfa741df86 ("ARM: dts: qcom: msm8974-lge-nexus5: Add fuel 
gauge")
 > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
 > ---
 >  arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts | 2 +-
 >  1 file changed, 1 insertion(+), 1 deletion(-)
 >
 > diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts 
b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
 > index e769f638f205..4c6f54aa9f66 100644
 > --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
 > +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
 > @@ -575,7 +575,7 @@ fuelgauge: max17048@36 {
 >              maxim,rcomp = /bits/ 8 <0x4d>;
 >
 >              interrupt-parent = <&msmgpio>;
 > -            interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 > +            interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
 >
 >              pinctrl-names = "default";
 >              pinctrl-0 = <&fuelgauge_pin>;

According to the datasheet for max17048 the ALRT pin is active low, so that
looks good. The reason it was implemented EDGE_FALLING is mostly due to
fragments taken from downstream, and the fact that it worked :)

Acked-by: Iskren Chernev <iskren.chernev@gmail.com>

