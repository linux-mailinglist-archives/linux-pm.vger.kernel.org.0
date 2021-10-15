Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12242FB9E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 21:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhJOTEH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbhJOTEG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 15:04:06 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AC0C061764;
        Fri, 15 Oct 2021 12:01:58 -0700 (PDT)
Received: from [192.168.1.101] (83.6.166.47.neoplus.adsl.tpnet.pl [83.6.166.47])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 668EC1F90E;
        Fri, 15 Oct 2021 21:01:55 +0200 (CEST)
Message-ID: <a8114098-f700-974b-e17e-54f5baebec46@somainline.org>
Date:   Fri, 15 Oct 2021 21:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 7/8] arm64: dts: qcom: msm8996: Add MSM8996 Pro support
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
 <20211014083016.137441-8-y.oudjana@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20211014083016.137441-8-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 14.10.2021 10:32, Yassine Oudjana wrote:
> Add a new DTSI for MSM8996 Pro (MSM8996SG) with msm-id and CPU/GPU OPPs.
> CBF OPPs and CPR parameters will be added to it as well once support for
> CBF scaling and CPR is introduced.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi    |  82 +++----
>  arch/arm64/boot/dts/qcom/msm8996pro.dtsi | 281 +++++++++++++++++++++++
>  2 files changed, 322 insertions(+), 41 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8996pro.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 94a846c3f1ee..5b2600a4fb2a 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -142,82 +142,82 @@ cluster0_opp: opp_table0 {
>  		/* Nominal fmax for now */
>  		opp-307200000 {
>  			opp-hz = /bits/ 64 <307200000>;
> -			opp-supported-hw = <0x77>;
> +			opp-supported-hw = <0x7>;

You didn't describe what's the reason for changing this everywhere.

If it's been always broken, perhaps make it a separate commit describing

the issue.


Konrad

