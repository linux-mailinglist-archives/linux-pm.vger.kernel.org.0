Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9CF314C463
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 02:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgA2BYO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jan 2020 20:24:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43379 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgA2BYO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jan 2020 20:24:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so7957217pgc.10
        for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2020 17:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ABEaCl8eghaB63SlspLn6OWSOfbEB+69FRLfk57jKew=;
        b=EJlH9jGdkWKVSguyJVfmQBTJ5NeJpIP3u1q/DrM1f/oEIt8AqWPPhQFYdTidDimERP
         R4xlzFe4jg5q7RZqboH+BnQhCBYfPcTPKolCBnW00OrziW8SAqc/gqALlAiZmo//9mgW
         H9EnTD9jr3RcBl1lE93i7D6NITgAq6mqcbEXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ABEaCl8eghaB63SlspLn6OWSOfbEB+69FRLfk57jKew=;
        b=TzDnMg4G/YIDmxlY1+sGuKw7mRSXxABzMS4uHQvnRh93Vgr8eT1R/BSGxHP4T2HhIL
         UMH0+HxSKvhg3lHB1liRSKcn91Iukz0H0ciyGQKfB9Vw8XGjOtrc4MAuNw+GQmzZKGb8
         QAw3K9RkLuOqhSizFew8vNFagevYEHO6pjZPXSletI5Cz/shtw95LkPE6aUDoRJbEbRh
         7kBCSqDAGq+0npvjrbIeVydGvyXE+u+Wg0DC3KAct92edM0LWFfq8JqbFHLsfxSqp06q
         nvVt2AniYJKpPXVg2YkWs8Vscy+isuqjI0pwDN5SDv1QlNx87EjxB7oR07+4xGj4eBuN
         SmDQ==
X-Gm-Message-State: APjAAAXw6V6chLU80cv6GoRkfAIktD1c0/OESzemoXOqzSQt76fFS3kw
        9echExqOASyUI232N7FDSYgDaw==
X-Google-Smtp-Source: APXvYqy0fsqJgkgNmjAYKqDfm+xayl+seLu9bJsiaQkshHwfjny7qJQa0p/fg20lUSyxfvS//wUEcw==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr27309683pgh.96.1580261053832;
        Tue, 28 Jan 2020 17:24:13 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a10sm289964pgm.81.2020.01.28.17.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 17:24:13 -0800 (PST)
Date:   Tue, 28 Jan 2020 17:24:11 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org
Subject: Re: [RFC v3 09/10] arm64: dts: qcom: sdm845: Add cpu OPP tables
Message-ID: <20200129012411.GI46072@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-10-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127200350.24465-10-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sibi,

On Tue, Jan 28, 2020 at 01:33:49AM +0530, Sibi Sankar wrote:
> Add OPP tables required to scale DDR/L3 per freq-domain on SDM845 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 453 +++++++++++++++++++++++++++
>  1 file changed, 453 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c036bab49fc03..8cb976118407b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -199,6 +199,12 @@
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_0>;
> +			operating-points-v2 = <&cpu0_opp_table>,
> +					      <&cpu0_ddr_bw_opp_table>,
> +					      <&cpu0_l3_bw_opp_table>;
> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc SLAVE_EBI1>,
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;

This apparently depends on the 'Split SDM845 interconnect nodes and
consolidate RPMh support' series
(https://patchwork.kernel.org/project/linux-arm-msm/list/?series=226281),
which isn't mentioned in the cover letter.

I also couldn't find a patch on the lists that adds the 'osm_l3'
interconnect node for SDM845. The same is true for SC7180 (next
patch of this series). These patches may be available in custom trees,
but that isn't really helpful for upstream review.

I would suggest to focus on landing the dependencies of this series,
before proceding with it (or at least most of them), there are plenty
and without the dependencies this series isn't going to land, it also
makes it hard for testers and reviewers to get all the pieces
together. In particular the last post of the series 'Add
required-opps support to devfreq passive gov'
(https://patchwork.kernel.org/cover/11055499/) is from July 2019 ...

Thanks

Matthias
