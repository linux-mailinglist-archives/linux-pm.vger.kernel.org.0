Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F6E1A3520
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 15:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgDINte (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 09:49:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38064 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDINte (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 09:49:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so12021415wre.5
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2020 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xI/13ahNFkzIs4fIOUGU+GiPaJZFLk48sQn0t25jaGY=;
        b=afn5TbxaSodVr0dusUmbWTENkDb2K7KmcDYRZvC1s1/ABXD0YGMH+o0CUhuulFvK8D
         TiiyY59rpWL2aj/8BFvJcBbzZd3kS72CwBWjKimtNHITiDCpdWPXbpMyrq9VIGeapAoZ
         JFj9e9zNZjLMKip1oZo6xLrulUab5B0RopS2krK6YhQKUVhDJ6EV9zHcdxi/tlYmIp9P
         VHDGc9RTvC9FU8xTekWP6oBJ5KhFJfwCMx5E5AR/Co0fbbo4lyQbXK0Xvl4OjHtuEn8I
         +9cIQsqMGxquOA3ok8x7PkaJl2UIYpHP6F93Dfn0cMZrwnprNo9JjDjGiynZ3f4NEKRS
         oxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xI/13ahNFkzIs4fIOUGU+GiPaJZFLk48sQn0t25jaGY=;
        b=S/W/LSPHk6gZAgE/rbXR3diMQFC7/hinDwatIBT9g/veqoU6rK4hWOB3ECTTwJDXt6
         klj9IH0Rth5OOgv86vpltRJi5lakljiac1dlBYZCCbYbsKGokuOKD7JEt75xgpLUNW1A
         YFslm0GvNRPOchjJCk05pe3BI5HjAj+fyyi2xx4e1BdM1qjW51t2QjpBQ23WKBQsoWWa
         BcI11iUUgsK7jjOAXxxafYq+3oZeULVHXc43aGTiXt5VhLNWyb+I0+uosbp1u5ppoSBY
         1zw+iO/tATJFO8AgdVUxkkeLIJYrn998dDFvD0hqAhhZUbPHhjplygag4D1Jfo64n409
         dmYw==
X-Gm-Message-State: AGi0PubCCsVUOpFMd8WtskAETzB++QBESAFo116moMIyFRQ5P6Q5Zn30
        HQpwqNc1GRKaCbb87CNzDgbAag==
X-Google-Smtp-Source: APiQypLdC3AyJfiHJHy5bpqo/UY+01I+BfVknqM3QSrQr+ChtRt3Ew2TsNKjwXQyBVHN0NcAEWTNsg==
X-Received: by 2002:adf:aacc:: with SMTP id i12mr15309250wrc.116.1586440171850;
        Thu, 09 Apr 2020 06:49:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda? ([2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda])
        by smtp.googlemail.com with ESMTPSA id u17sm45525611wra.63.2020.04.09.06.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 06:49:31 -0700 (PDT)
Subject: Re: [PATCH v6 0/4] thermal: k3: Add support for bandgap sensors
To:     Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     amit.kucheria@verdurent.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com
References: <20200407055116.16082-1-j-keerthy@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3c69e3c6-5549-e891-fde6-95a2ecc49f77@linaro.org>
Date:   Thu, 9 Apr 2020 15:49:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407055116.16082-1-j-keerthy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Keerthy,

On 07/04/2020 07:51, Keerthy wrote:
> Add VTM thermal support. In the Voltage Thermal
> Management Module(VTM), K3 AM654 supplies a voltage
> reference and a temperature sensor feature that are gathered in the band
> gap voltage and temperature sensor (VBGAPTS) module. The band
> gap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Add support for bandgap sensors. Currently reading temperatures
> is supported.

How do you want to proceed? Shall I take patches 1 & 2 ?


> Changes in v6:
> 
>   * Removed bunch of unused #defines and couple of redundant variables.
>   * Reordered patches a bit.
>   * Minor reordering in dt binding patch.
> 
> Changes in v5:
> 
>   * Removed thermal work function which was unused.
>   * Removed unused preve_tenmp and a couple more struct variables.
>   * Removed couple of redundant header function include.
> 
> Changes in v4:
> 
>   * Fixed comments from Daniel to remove trend function.
>   * Mostly cleaned up all the unused variables.
>   * Driver from bool to tristate.
> 
> Changes in v3:
> 
>   * Fixed errors seen with:
>     dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
> 
> Changes in v2:
> 
>   * Fixed yaml errors
>   * renamed am654-industrial-thermal.dtsi to k3-am654-industrial-thermal.dtsi
>     to follow the convention for k3 family.  
> 
> Keerthy (4):
>   dt-bindings: thermal: k3: Add VTM bindings documentation
>   thermal: k3: Add support for bandgap sensors
>   arm64: dts: ti: am65-wakeup: Add VTM node
>   arm64: dts: ti: am654: Add thermal zones
> 
>  .../bindings/thermal/ti,am654-thermal.yaml    |  56 ++++
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  11 +
>  .../dts/ti/k3-am654-industrial-thermal.dtsi   |  45 +++
>  drivers/thermal/Kconfig                       |  10 +
>  drivers/thermal/Makefile                      |   1 +
>  drivers/thermal/k3_bandgap.c                  | 264 ++++++++++++++++++
>  6 files changed, 387 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
>  create mode 100644 drivers/thermal/k3_bandgap.c
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
