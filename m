Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA542FBA7
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhJOTGK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 15:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbhJOTGJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 15:06:09 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258E6C061762;
        Fri, 15 Oct 2021 12:04:03 -0700 (PDT)
Received: from [192.168.1.101] (83.6.166.47.neoplus.adsl.tpnet.pl [83.6.166.47])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 7360F1F4F5;
        Fri, 15 Oct 2021 21:04:00 +0200 (CEST)
Message-ID: <112db3a6-9930-bb6b-589c-e0ccab0b1edf@somainline.org>
Date:   Fri, 15 Oct 2021 21:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 8/8] arm64: dts: qcom: msm8996-xiaomi-scorpio: Include
 msm8996pro.dtsi
Content-Language: en-US
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
 <20211014110024.5869-1-y.oudjana@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211014110024.5869-1-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 14.10.2021 13:00, Yassine Oudjana wrote:
> Move msm8996.dtsi include to the end of the include chain.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 3 ---
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts  | 1 +
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts | 2 +-
>  3 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> index d239b01b8505..831cd39aff14 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> @@ -3,9 +3,6 @@
>   * Copyright (c) 2020, Yassine Oudjana <y.oudjana@protonmail.com>
>   */
>  
> -/dts-v1/;
> -
> -#include "msm8996.dtsi"
>  #include "pm8994.dtsi"
>  #include "pmi8994.dtsi"
>  #include <dt-bindings/input/input.h>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> index 77d508e5164a..8ea5390f86ab 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
> @@ -5,6 +5,7 @@
>  
>  /dts-v1/;
>  
> +#include "msm8996.dtsi"
>  #include "msm8996-xiaomi-common.dtsi"
>  #include <dt-bindings/sound/qcom,q6afe.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
> index ea2ca271fe7d..4ffe7be34285 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dts

If this device uses msm8996pro, perhaps the filename should reflect

that? I don't know whether renaming it would be "legal" though..


Konrad

