Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9141D1144F6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfLEQi4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 11:38:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39975 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLEQiz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 11:38:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so4407752wrn.7
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+rPpV85Ioqv2xtks5OONWqK+n5i6dViTlGicJhAqFfY=;
        b=yRW0ila80HkXR5BZvLIDkxLL+sEVXfHq8Eg/gymPOM+KCLryjWVyIq9c1mgSciZMwv
         q2GTER2tsekvw/Etk/BArSlSi1jE7iIvOMh6nMX8dDhSBD5algPqnoUAliQXfkDguyZq
         tWAPYUBkr1m7+d4QKUfITKjxuBFP1xaF1k2ouuBe9pzosSX2ekntzu0YuIHAgP0ZfVrI
         CmPKWJD+D+wl5h30x64ThbDDKYSegClcXt3AdCZ3VuxVB3wVCZdl3AkU56+kFYb6mnFD
         xGAg5JYfW3gNngyBju1j5prq0ua1kprxlragbb+mql8f9ewVpoajHXoWUO40zHMxnZzf
         VuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+rPpV85Ioqv2xtks5OONWqK+n5i6dViTlGicJhAqFfY=;
        b=Vo65w6zXKzdRJW45Pz5ummvAVUis14iWv8lZaJSryWYayklszFlfrETWIq8030YDgG
         2fAQ+/Vdh9gicYn1frB5NrhD1PRzyBUGFhAjq4dMb995i8pyWjnHRD9bpnVqCX4p6TKI
         EIncF8uMQNvbWme5VARJZT3ykNPSxuhxyDhNIvmfsWHtDdKrE+tFCc8lYxhaKAl4wYgl
         AuWay6MS5oXUfPXIV+s6vPwNaKA0mIRSQroIms6trWluZZyV1Cnrel12WtHDP2fOk06H
         yAebiu5zLVW4uUOuS6CedRTmJ02lOQsoCrPE4tqupMNddxSnSAJrGHSazUyxx4bEm2YD
         u7dg==
X-Gm-Message-State: APjAAAWXEwIVJK2+QVNLimv5xLQj4RmPJ4EU7DfmdQlC5GfhtXsVMZhB
        a6MJU+dI4w4DEq+U4zEKIqhtcg==
X-Google-Smtp-Source: APXvYqwyMoJrdKNhs+fUTVnbzv+O/QQJtlYzjU+/jSJsY2EZgVlKFOJ3IJS6GGGHadEc2+MywNCOKA==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr10956740wrp.1.1575563932666;
        Thu, 05 Dec 2019 08:38:52 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6? ([2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6])
        by smtp.googlemail.com with ESMTPSA id m8sm417890wmf.8.2019.12.05.08.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 08:38:51 -0800 (PST)
Subject: Re: [PATCH v2 0/8] Add Mediatek thermal dirver and dtsi
To:     "michael.kao" <michael.kao@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <98c34033-91e0-ce9e-3245-c9b8ed2745f7@linaro.org>
Date:   Thu, 5 Dec 2019 17:38:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


What is the status of this series? Shouldn't we have a V3?

On 10/05/2019 15:26, michael.kao wrote:
> This patchset supports for MT8183 chip to mtk_thermal.c.
> Add thermal zone of all the thermal sensor in SoC for
> another get temperatrue. They don't need to thermal throttle.
> And we bind coolers for thermal zone nodes of cpu_thermal.
> 
> This patch series base on these patches [1][2][3][4].
> 
> [1]support for reading chip ID and efuse (https://patchwork.kernel.org/patch/10902131/)
> [2]arm64: dts: mt8183: Add reset-cells in infracfg (https://patchwork.kernel.org/patch/10908653/)
> [3]clk: reset: Modify reset-controller driver (https://patchwork.kernel.org/patch/10908657/)
> [4]PM / AVS: SVS: Introduce SVS engine (https://patchwork.kernel.org/patch/10923289/)
> 
> Matthias Kaehlcke (2):
> 	arm64: dts: mt8183: Configure CPU cooling
> 	arm64: dts: mt8183: Increase polling frequency for CPU thermal zone
> 
> Michael Kao (6):
> 	arm64: dts: mt8183: add thermal zone node
> 	arm64: dts: mt8183: add/update dynamic power coefficients
> 	arm64: dts: mt8183: Add #cooling-cells to CPU nodes
> 	thermal: mediatek: mt8183: fix bank number settings
> 	thermal: mediatek: add another get_temp ops for thermal sensors
> 	thermal: mediatek: use spinlock to protect PTPCORESEL
> 
> arch/arm64/boot/dts/mediatek/mt8183.dtsi | 158 +++++++++++++++++++++++++++++++
> drivers/thermal/mtk_thermal.c            |  82 +++++++++++++---
> 2 files changed, 226 insertions(+), 14 deletions(-)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

