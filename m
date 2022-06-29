Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0F560A2C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 21:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiF2TR3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 15:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiF2TR1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 15:17:27 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 12:17:25 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1753C72A
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1656529877;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=3hHfIWpV+x7WyjiHFVeyfhViAFLAvFBESTeE075T914=;
    b=bFm8cR2R3YsDjM82CB3n+yFcNWfMZuAw5s40TERoW/8suU6C29ggArandpmBiOQRoc
    4UUwATwRvSzyIwFiLI69xOZRUGcQ18yOThwf0wlkY3AhTvX4IKJAw9FR1Ntm1sNN2JZz
    DGiQEb1TlxS2OOXoFhmG5pCtI41GcCgO+5ZRMjpIxTxfeWpKHjxTjIxuJ979+SDV5rUe
    lTpgMn+jMnwblwBHBFjjjEUDYPF61aUB5PYYLgH+/M7p384jnJjy7CFr1zeIvL/qFiF/
    kc1MhtRTbvs+241ondEHLwqmY0EgvPHfrQiRKxwf5C421uMxMCxgLHGpXIKdKZXN7Sau
    QnLg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrK8+86Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id yfdd30y5TJBH0fQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 29 Jun 2022 21:11:17 +0200 (CEST)
Date:   Wed, 29 Jun 2022 21:11:16 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND PATCH 4/5] cpufreq: qcom-cpufreq-nvmem: Rename qcs404
 data to cpr_genpd
Message-ID: <Yryj1Nv/Yu8wShzo@gerhold.net>
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
 <20220629130303.3288306-5-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629130303.3288306-5-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 29, 2022 at 02:03:02PM +0100, Bryan O'Donoghue wrote:
> At the moment the CPR genpd based code is named after the qcs404 however
> msm8936, msm8939 and other antecedent processors of the qcs404 can also
> make use of this data.
> 
> Rename it to reflect a more generic use.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

There is another power domain that needs to be scaled together with the
CPU frequency on MSM8916 and MSM8939: (VDD)MX. How do you handle that?

In downstream this is part of the CPR driver and specified as follows:

	qcom,vdd-mx-corner-map = <4 5 7>;
	qcom,vdd-mx-vmin-method = <4>;
	vdd-mx-supply = <&pm8916_l3_corner_ao>;
	qcom,vdd-mx-vmax = <7>;
	qcom,cpr-corner-map = <1 1 2 2 3 3 3 3 3>; /* MSM8916 */
	qcom,cpr-corner-map = <1 1 1 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3
			       3 3 3 3 3 3 3 3>; /* MSM8939 */

On MSM8916 this means to vote for MX corner 4 (&rpmpd_opp_svs_soc) for
the first two frequencies, then corner 5 (&rpmpd_opp_nominal) and corner 7
(&rpmpd_opp_super_turbo) for the remaining CPU frequencies. It's similar
for MSM8939, you just have more OPPs there.

There was a semi-related discussion about this in [1] (a bit mixed with
potential ways how to do CPU frequency scaling without CPR). It's been a
while but I think the conclusion back then was that it's easiest to
attach both "mx" and "cpr" in this driver and then scale it as part of
the OPP table.

[1]: https://lore.kernel.org/linux-arm-msm/20200403013119.GB20625@builder.lan/

I'll attach an excerpt of the changes that I used on MSM8916 at the end
of the mail. Note that it does not actually work as-is: IIRC at the
moment there is still nothing that actually enables the power domains
listed for CPUs. The CPR driver does not check that, but rpmpd does and
just ignores the votes.

I submitted a possible patch for this but it just got stuck at some
point because of all the complexity involved:
https://lore.kernel.org/linux-pm/20200826093328.88268-1-stephan@gerhold.net/

Shortly said: I think you do not just want "cpr" here but also "mx".

Thanks,
Stephan

static const char *msm8916_genpd_names[] = { "mx", "cpr", NULL };

cpu@0 {
	power-domains = <&CPU_PD0>, <&rpmpd MSM8916_VDDMX_AO>, <&cpr>;
	power-domain-names = "psci", "mx", "cpr";
};

cpu_opp_table: cpu-opp-table {
	compatible = "operating-points-v2-kryo-cpu";
	opp-shared;

	opp-200000000 {
		opp-hz = /bits/ 64 <200000000>;
		required-opps = <&rpmpd_opp_svs_soc>, <&cpr_opp1>;
	};
	opp-400000000 {
		opp-hz = /bits/ 64 <400000000>;
		required-opps = <&rpmpd_opp_svs_soc>, <&cpr_opp2>;
	};
	opp-533333000 {
		opp-hz = /bits/ 64 <533333000>;
		required-opps = <&rpmpd_opp_nominal>, <&cpr_opp3>;
	};
	opp-800000000 {
		opp-hz = /bits/ 64 <800000000>;
		required-opps = <&rpmpd_opp_nominal>, <&cpr_opp4>;
	};
	opp-998400000 {
		opp-hz = /bits/ 64 <998400000>;
		required-opps = <&rpmpd_opp_super_turbo>, <&cpr_opp5>;
	};
	opp-1094400000 {
		opp-hz = /bits/ 64 <1094400000>;
		required-opps = <&rpmpd_opp_super_turbo>, <&cpr_opp6>;
	};
	opp-1152000000 {
		opp-hz = /bits/ 64 <1152000000>;
		required-opps = <&rpmpd_opp_super_turbo>, <&cpr_opp7>;
	};
	opp-1209600000 {
		opp-hz = /bits/ 64 <1209600000>;
		required-opps = <&rpmpd_opp_super_turbo>, <&cpr_opp8>;
	};
	opp-1363200000 {
		opp-hz = /bits/ 64 <1363200000>;
		required-opps = <&rpmpd_opp_super_turbo>, <&cpr_opp9>;
	};
};
