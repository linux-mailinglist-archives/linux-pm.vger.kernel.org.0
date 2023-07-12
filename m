Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1CA750958
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGLNPY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 09:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjGLNPX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 09:15:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB011981
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 06:15:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f954d7309fso963480e87.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689167713; x=1691759713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXqt09tdVvvcw6pgsvaXQsZ0EYrCqzV7f8woQeEpum4=;
        b=vOkATjh7+4it75svgAaTbe2ftmfOzH2OkYa5n+GWzYADnzKD0qv4h0QFV3FYNFSw9E
         SnWMmnyS40nHU7Hj8Gba2JX5X98fplCo1SpcLHSFbp7ddomVWfFzY5/RoGti6mBT4b2w
         QZOmD4zOnhDFTjCTmQ2qkbuQwvRsKbnl8B2UcYlLmJpze1WIVi88gLLTdfz9iC9+2blH
         oRDU6wIvns8OANNueYhsWJjr0enXdb9E08kHFEG/Qbh2NRpx5kAWGn+0CfeImHk4OZGJ
         BwGyc0//tOwvjFNfNVImsxF3iDyIQ2zhw+JKr6WyGCWDLYGn5/b67sseHDDSS4y0RUvG
         fjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689167713; x=1691759713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXqt09tdVvvcw6pgsvaXQsZ0EYrCqzV7f8woQeEpum4=;
        b=TwfzVAPQrDwtTJdcjP4In+24Ru+bxg4XknLttNt8OT8gK/eyMfOfCYWBLOWG0whBmr
         kWdTnHMDU1gnCOjC7G5fR1nZeMxgtzvo1ncnAynzvMmQtAqSLeK3B3/30Pizr21c67JH
         IUSjOPBgNCisEbuUOawY4DUam4TSiW9oKfV/s7PSBqd59Mg4Y6+KqnV0QMa6UgNthrkG
         nzqCqULRCHqyQlYTK5KTgNT+ZP9j0/Z3N+Heaqj8UAWX2jNH7oqpnnDf7G6opXTYkyux
         vscoJkMST56rTSHZPjkP0WYE3kSfTOuOLEcvnrC4fmjywCvuWybQAGdPpT5+8nHyREEO
         s2fQ==
X-Gm-Message-State: ABy/qLZjoDuua+1dnqLyUa33ny0kjfCzUXkXXWVUmX6kRSzOBvhfgUOy
        6Cc6ckGBNDsOrHsv1Xxon4IJgA==
X-Google-Smtp-Source: APBJJlGJTt/9jUsw1+sCODIYotgo3mCBSUX95DB0ildo4FP9AFPo1PEBBYeQSP5gEJCrEVJIepwBJA==
X-Received: by 2002:a05:6512:3c87:b0:4fb:9f08:2909 with SMTP id h7-20020a0565123c8700b004fb9f082909mr790297lfv.3.1689167713270;
        Wed, 12 Jul 2023 06:15:13 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id p4-20020ac246c4000000b004fbe7b01b15sm713243lfo.62.2023.07.12.06.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 06:15:12 -0700 (PDT)
Message-ID: <e6a5129a-db07-977d-2ecd-328a52cbcdc0@linaro.org>
Date:   Wed, 12 Jul 2023 16:15:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 11/14] scsi: ufs: host: Add support for parsing OPP
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/07/2023 13:32, Manivannan Sadhasivam wrote:
> OPP framework can be used to scale the clocks along with other entities
> such as regulators, performance state etc... So let's add support for
> parsing OPP from devicetree. OPP support in devicetree is added through
> the "operating-points-v2" property which accepts the OPP table defining
> clock frequency, regulator voltage, power domain performance state etc...
> 
> Since the UFS controller requires multiple clocks to be controlled for
> proper working, devm_pm_opp_set_config() has been used which supports
> scaling multiple clocks through custom ufshcd_opp_config_clks() callback.
> 
> It should be noted that the OPP support is not compatible with the old
> "freq-table-hz" property. So only one can be used at a time even though
> the UFS core supports both.
> 
> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/ufs/host/ufshcd-pltfrm.c | 116 +++++++++++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
> index 0b7430033047..068c22378c88 100644
> --- a/drivers/ufs/host/ufshcd-pltfrm.c
> +++ b/drivers/ufs/host/ufshcd-pltfrm.c
> @@ -8,8 +8,10 @@
>    *	Vinayak Holikatti <h.vinayak@samsung.com>
>    */
>   
> +#include <linux/clk.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/of.h>
>   
> @@ -17,6 +19,8 @@
>   #include "ufshcd-pltfrm.h"
>   #include <ufs/unipro.h>
>   
> +#include <trace/events/ufs.h>
> +
>   #define UFSHCD_DEFAULT_LANES_PER_DIRECTION		2
>   
>   static int ufshcd_parse_clock_info(struct ufs_hba *hba)
> @@ -205,6 +209,112 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
>   	}
>   }
>   
> +static int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
> +				  struct dev_pm_opp *opp, void *data,
> +				  bool scaling_down)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +	struct list_head *head = &hba->clk_list_head;
> +	struct ufs_clk_info *clki;
> +	unsigned long freq;
> +	u8 idx = 0;
> +	int ret;
> +
> +	list_for_each_entry(clki, head, list) {
> +		if (!IS_ERR_OR_NULL(clki->clk)) {
> +			freq = dev_pm_opp_get_freq_indexed(opp, idx++);
> +
> +			/* Do not set rate for clocks having frequency as 0 */
> +			if (!freq)
> +				continue;

Can we omit these clocks from the opp table? I don't think they serve 
any purpose.

Maybe it would even make sense to move this function to drivers/opp 
then, as it will be generic enough.

> +
> +			ret = clk_set_rate(clki->clk, freq);
> +			if (ret) {
> +				dev_err(dev, "%s: %s clk set rate(%ldHz) failed, %d\n",
> +					__func__, clki->name, freq, ret);
> +				return ret;
> +			}
> +
> +			trace_ufshcd_clk_scaling(dev_name(dev),
> +				(scaling_down ? "scaled down" : "scaled up"),
> +				clki->name, hba->clk_scaling.target_freq, freq);
> +		}
> +	}
> +
> +	return 0;
> +} > +
> +static int ufshcd_parse_operating_points(struct ufs_hba *hba)
> +{
> +	struct device *dev = hba->dev;
> +	struct device_node *np = dev->of_node;
> +	struct dev_pm_opp_config config = {};
> +	struct ufs_clk_info *clki;
> +	const char **clk_names;
> +	int cnt, i, ret;
> +
> +	if (!of_find_property(np, "operating-points-v2", NULL))
> +		return 0;
> +
> +	if (of_find_property(np, "freq-table-hz", NULL)) {
> +		dev_err(dev, "%s: operating-points and freq-table-hz are incompatible\n",
> +			 __func__);
> +		return -EINVAL;
> +	}
> +
> +	cnt = of_property_count_strings(np, "clock-names");
> +	if (cnt <= 0) {
> +		dev_err(dev, "%s: Missing clock-names\n",  __func__);
> +		return -ENODEV;
> +	}
> +
> +	/* OPP expects clk_names to be NULL terminated */
> +	clk_names = devm_kcalloc(dev, cnt + 1, sizeof(*clk_names), GFP_KERNEL);
> +	if (!clk_names)
> +		return -ENOMEM;
> +
> +	/*
> +	 * We still need to get reference to all clocks as the UFS core uses
> +	 * them separately.
> +	 */
> +	for (i = 0; i < cnt; i++) {
> +		ret = of_property_read_string_index(np, "clock-names", i,
> +						    &clk_names[i]);
> +		if (ret)
> +			return ret;
> +
> +		clki = devm_kzalloc(dev, sizeof(*clki), GFP_KERNEL);
> +		if (!clki)
> +			return -ENOMEM;
> +
> +		clki->name = devm_kstrdup(dev, clk_names[i], GFP_KERNEL);
> +		if (!clki->name)
> +			return -ENOMEM;
> +
> +		if (!strcmp(clk_names[i], "ref_clk"))
> +			clki->keep_link_active = true;
> +
> +		list_add_tail(&clki->list, &hba->clk_list_head);
> +	}
> +
> +	config.clk_names = clk_names,
> +	config.config_clks = ufshcd_opp_config_clks;
> +
> +	ret = devm_pm_opp_set_config(dev, &config);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to add OPP table: %d\n", ret);
> +		return ret;
> +	}
> +
> +	hba->use_pm_opp = true;
> +
> +	return 0;
> +}
> +
>   /**
>    * ufshcd_get_pwr_dev_param - get finally agreed attributes for
>    *                            power mode change
> @@ -371,6 +481,12 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>   
>   	ufshcd_init_lanes_per_dir(hba);
>   
> +	err = ufshcd_parse_operating_points(hba);
> +	if (err) {
> +		dev_err(dev, "%s: OPP parse failed %d\n", __func__, err);
> +		goto dealloc_host;
> +	}
> +
>   	err = ufshcd_init(hba, mmio_base, irq);
>   	if (err) {
>   		dev_err(dev, "Initialization failed\n");

-- 
With best wishes
Dmitry

