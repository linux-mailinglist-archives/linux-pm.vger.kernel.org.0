Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2680E12594
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 02:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfECAho (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 20:37:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:20694 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfECAhn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 20:37:43 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190503003739epoutp03e9891a619933275592a88d9fa5928dae~bBT3byZEF0246502465epoutp03L
        for <linux-pm@vger.kernel.org>; Fri,  3 May 2019 00:37:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190503003739epoutp03e9891a619933275592a88d9fa5928dae~bBT3byZEF0246502465epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556843859;
        bh=KRiTcCLONHAf3ZOccDuMVHOfG8NnD0V80VdNty/1po4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jn3DC53jAz8jyRomRfK0d9j1a+fXEpFwWIbLmsL5/Hj6mPlu9GpGsbTI/SDusGg7B
         JLxazJXshzgut8cn5Q+1RlPh2Q+YTtzygt6DRXI93H9A5EsANCi326m8yVemq614YF
         zR82vSH5IhavXtpLX3ip2p27SQlTrW4M8xQHMcjw=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190503003736epcas1p37d0532eeef19bbd82beec699e08a12b1~bBT0vVVMG1501515015epcas1p3M;
        Fri,  3 May 2019 00:37:36 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.34.04108.05D8BCC5; Fri,  3 May 2019 09:37:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190503003736epcas1p1931ca897b3e8d0b062ae3f889c1fe82e~bBT0aDhW81473614736epcas1p1m;
        Fri,  3 May 2019 00:37:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190503003736epsmtrp27ebc4796af6103b873b211809d1d45a7~bBT0WE_J-2618626186epsmtrp2Q;
        Fri,  3 May 2019 00:37:36 +0000 (GMT)
X-AuditID: b6c32a39-89fff7000000100c-59-5ccb8d50ca83
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.39.03692.F4D8BCC5; Fri,  3 May 2019 09:37:35 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190503003735epsmtip29efd006b32d27ac2d4d1100ae346f5fd~bBT0AcSbU0152201522epsmtip2f;
        Fri,  3 May 2019 00:37:35 +0000 (GMT)
Subject: Re: [PATCH v5 3/6] devfreq: rk3399_dmc: Pass ODT and auto power
 down parameters to TF-A.
To:     =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b7daf957-1dd3-3045-4752-fc6a01b9821b@samsung.com>
Date:   Fri, 3 May 2019 09:38:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502175820.25382-4-gael.portay@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjOubf3Upwdd8WPlyZz5Tp/0ATkCmWni2UmuuUmmoxkczEbWb2B
        O2D9tLeYMX8IEhyyuuhc4qxMmcLQihMLsqYbVjrsAk4CGMCMNCAwMxjBIcGPiWFtb83495zn
        fd73Oc/5UJLqZVqjLLO5RKdNsLD0KkXHrxlZmQVHbxVmu8MaPBP5F2Hf/AMKz7T9QuOz3X0U
        vv1DF41bRkMINwZmabw88TeFn7T2kritz03hxRPNBL59aDYJ+yaHKXwnUE/jhaPdCD8cXyZx
        08gAgUerLtC4prM7aVsq33KmBfGnKwcUvD/SiHif9wjNtzUe5J97ggr+q3Yv4n8aPkPy1ZGT
        FH95olXBL/g2FLz0oXlrqSgUi06taCuyF5fZSozszvdM2036vGwukzPgN1itTbCKRnbHroLM
        d8os0Xysdr9gKY9SBYIksZvztzrt5S5RW2qXXEZWdBRbHAZHliRYpXJbSVaR3foml529RR8V
        7jWXhr1VhONH/Wd9PT6yEt3U1aFkJTC50Hn9BqpDq5Rqxo8gONijkBcPEVzuuk7Ki0cIRgYv
        0S9aepfvJQqdCELhR1SsoGYeIBhtMsZwKlME009HiJhoDdNMwaXBAIoVSMYIVVefETFMMzoI
        /nU3PjWFSYehJ5NxjYrJh+DosTivYF6Haw1/xvVrmT0wFm6lZM0r0HNqShHDycxb0Fo9RMnz
        18MfU2cJGb8G1ddOx3cKzHwSROprCDnCDugfeJqIkwozv7UnyVgDC3OdCf4AXOzppuXmWgTt
        wX5KLuRAsOlEdJAy6pABVwKbZbOXYW7RTcVoYFRQe1gtqzfCnfFIwjYNzn9xJDGeh8f++8Qx
        lO5ZEcezIoJnRQTP/2YNSOFF60SHZC0RJc6hX3ndPhR//DqDH4X7doUQo0TsapVjvLdQTQn7
        pQprCIGSZNeoPp6PUqpioeJz0Wk3OcstohRC+uhpHyc1a4vs0a9kc5k4/ZacnBycy+XpOY5d
        r7qybXuhmikRXKJZFB2i80UfoUzWVCLzp29XhWHW3/8N4haP32vMm/qIuLW7zLz03ST1fuWz
        vZ+sM8ytHq/J37dU8XOzcueGBXCbvk53Wb58NbW/6/H302m6873ntIeXUrz1Y3VXDWnTmRvt
        5j35wyc35XYcCBxszhi7r7sBH+y7m/J7w8REx6bnF991nzt085TwD1mL5r8dYhVSqcDpSKck
        /AfqCPUoEgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGeXcuO85Wp83w9Za0BHGgKVm8kGn0pRMI+SUrkWzpSSU3147O
        jEHa8oPmREmNZt7CSpfG3PKSZeY9LYVpmiaCVzIzRUVYWiy3Efjtx/M8P/5f/hQm+oF7UsmK
        NFalkKVISAHe3C3xDbyg+xQbPGsOQ8vT2wCZ1tcItGx+R6LKnmECDT3vJFH9VBdANW0rJLLN
        /SSQ1TiIIfNwPoG2Hr7goaF7K3xkmh8n0GjbExJt6noA2pixYejZVwsPTWXXkiinvYd/RszU
        V9QDpizLgjOt0zWAMRlyScZcc5f5q+/AmYLXBsC0jFdgjHb6EcE0zBlxZtN0OMo1RhCWwKYk
        q1nVsfBrgqQ+QzZP+erE7eEBE5YFeqV5wIWCdCgctM1ieUBAiei3AL7facechQcstfTuMrXL
        YtjdzTk3vwCs2tY5cjEdD58aFPbcja4jYIm+gW93Mfo0zG7c4TmFfgB1bzp59oKkpbBjaYK0
        8wH6CByzzgM7C+lw2DFV6Mhx2g82VS069ofoy/DzWi3u3ByEA48XHOxCR0CjdoxwHvOHfypG
        MCe7w28LlTwn+0JtUxlWCMT6Pbp+j6Lfo+j3KFUANwAPVsnJE+VciDJEwWYEcTI5l65IDIpP
        lZuA4wGkAa1gtCauC9AUkOwTKmcGY0WETM1lyrsApDCJm/Dq+m4kTJBl3mFVqXGq9BSW6wJe
        FC5xFy4q+q6I6ERZGnuTZZWs6n/Lo1w8s8D9mCWg9J7iT0TbmiczLla6vYyKtF1vmW58UFCn
        8TZWESPBrrmnbugiNPNt+1f7NySrmkvVfviH8tyTASUitcz3tyaorXi0QXeurLjXEim9FRhK
        FlVYF47urAVt+ZdOlp8vchF185MyvTbP5mvV7pRPzndr9ZcGRfTH4+M+7QUSnEuShUgxFSf7
        B+flJwb8AgAA
X-CMS-MailID: 20190503003736epcas1p1931ca897b3e8d0b062ae3f889c1fe82e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190502175830epcas4p24538d3c364ce1dd1608b474fba133f22
References: <20190502175820.25382-1-gael.portay@collabora.com>
        <CGME20190502175830epcas4p24538d3c364ce1dd1608b474fba133f22@epcas4p2.samsung.com>
        <20190502175820.25382-4-gael.portay@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi 

Also, this patch was applied to linux-pm.git for for v5.2-rc1.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=adfe3b76608ffe547af5a74415f15499b798f32a

On 19. 5. 3. 오전 2:58, Gaël PORTAY wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Trusted Firmware-A (TF-A) for rk3399 implements a SiP call to get the
> on-die termination (ODT) and auto power down parameters from kernel,
> this patch adds the functionality to do this. Also, if DDR clock
> frequency is lower than the on-die termination (ODT) disable frequency
> this driver should disable the DDR ODT.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
> 
> Changes in v5: None
> 
> Changes in v4:
> - [PATCH v3 3/5] Add Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>.
> 
> Changes in v3:
> - [PATCH v2 3/5] Add Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>.
> 		 Remove comments.
> 		 Move pmu dt parsing after dt-parsing of timings to fix
> 		  data->odt_dis_freq value.
> 
> Changes in v2: None
> 
> Changes in v1:
> - [RFC 3/10] Add an explanation for platform SIP calls.
> - [RFC 3/10] Change if statement for a switch.
> - [RFC 3/10] Rename ddr_flag to odt_enable to be more clear.
> 
>  drivers/devfreq/rk3399_dmc.c        | 71 ++++++++++++++++++++++++++++-
>  include/soc/rockchip/rockchip_sip.h |  1 +
>  2 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index e795ad2b3f6b..daf19e121c99 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -18,14 +18,17 @@
>  #include <linux/devfreq.h>
>  #include <linux/devfreq-event.h>
>  #include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/rwsem.h>
>  #include <linux/suspend.h>
>  
> +#include <soc/rockchip/rk3399_grf.h>
>  #include <soc/rockchip/rockchip_sip.h>
>  
>  struct dram_timing {
> @@ -69,8 +72,11 @@ struct rk3399_dmcfreq {
>  	struct mutex lock;
>  	struct dram_timing timing;
>  	struct regulator *vdd_center;
> +	struct regmap *regmap_pmu;
>  	unsigned long rate, target_rate;
>  	unsigned long volt, target_volt;
> +	unsigned int odt_dis_freq;
> +	int odt_pd_arg0, odt_pd_arg1;
>  };
>  
>  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
> @@ -80,6 +86,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  	struct dev_pm_opp *opp;
>  	unsigned long old_clk_rate = dmcfreq->rate;
>  	unsigned long target_volt, target_rate;
> +	struct arm_smccc_res res;
> +	bool odt_enable = false;
>  	int err;
>  
>  	opp = devfreq_recommended_opp(dev, freq, flags);
> @@ -95,6 +103,19 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>  
>  	mutex_lock(&dmcfreq->lock);
>  
> +	if (target_rate >= dmcfreq->odt_dis_freq)
> +		odt_enable = true;
> +
> +	/*
> +	 * This makes a SMC call to the TF-A to set the DDR PD (power-down)
> +	 * timings and to enable or disable the ODT (on-die termination)
> +	 * resistors.
> +	 */
> +	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, dmcfreq->odt_pd_arg0,
> +		      dmcfreq->odt_pd_arg1,
> +		      ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD,
> +		      odt_enable, 0, 0, 0, &res);
> +
>  	/*
>  	 * If frequency scaling from low to high, adjust voltage first.
>  	 * If frequency scaling from high to low, adjust frequency first.
> @@ -294,11 +315,13 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  {
>  	struct arm_smccc_res res;
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.of_node, *node;
>  	struct rk3399_dmcfreq *data;
>  	int ret, index, size;
>  	uint32_t *timing;
>  	struct dev_pm_opp *opp;
> +	u32 ddr_type;
> +	u32 val;
>  
>  	data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
>  	if (!data)
> @@ -354,10 +377,56 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	node = of_parse_phandle(np, "rockchip,pmu", 0);
> +	if (node) {
> +		data->regmap_pmu = syscon_node_to_regmap(node);
> +		if (IS_ERR(data->regmap_pmu))
> +			return PTR_ERR(data->regmap_pmu);
> +	}
> +
> +	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
> +
> +	switch (ddr_type) {
> +	case RK3399_PMUGRF_DDRTYPE_DDR3:
> +		data->odt_dis_freq = data->timing.ddr3_odt_dis_freq;
> +		break;
> +	case RK3399_PMUGRF_DDRTYPE_LPDDR3:
> +		data->odt_dis_freq = data->timing.lpddr3_odt_dis_freq;
> +		break;
> +	case RK3399_PMUGRF_DDRTYPE_LPDDR4:
> +		data->odt_dis_freq = data->timing.lpddr4_odt_dis_freq;
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +
>  	arm_smccc_smc(ROCKCHIP_SIP_DRAM_FREQ, 0, 0,
>  		      ROCKCHIP_SIP_CONFIG_DRAM_INIT,
>  		      0, 0, 0, 0, &res);
>  
> +	/*
> +	 * In TF-A there is a platform SIP call to set the PD (power-down)
> +	 * timings and to enable or disable the ODT (on-die termination).
> +	 * This call needs three arguments as follows:
> +	 *
> +	 * arg0:
> +	 *     bit[0-7]   : sr_idle
> +	 *     bit[8-15]  : sr_mc_gate_idle
> +	 *     bit[16-31] : standby idle
> +	 * arg1:
> +	 *     bit[0-11]  : pd_idle
> +	 *     bit[16-27] : srpd_lite_idle
> +	 * arg2:
> +	 *     bit[0]     : odt enable
> +	 */
> +	data->odt_pd_arg0 = (data->timing.sr_idle & 0xff) |
> +			    ((data->timing.sr_mc_gate_idle & 0xff) << 8) |
> +			    ((data->timing.standby_idle & 0xffff) << 16);
> +	data->odt_pd_arg1 = (data->timing.pd_idle & 0xfff) |
> +			    ((data->timing.srpd_lite_idle & 0xfff) << 16);
> +
>  	/*
>  	 * We add a devfreq driver to our parent since it has a device tree node
>  	 * with operating points.
> diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip/rockchip_sip.h
> index 7e28092c4d3d..ad9482c56797 100644
> --- a/include/soc/rockchip/rockchip_sip.h
> +++ b/include/soc/rockchip/rockchip_sip.h
> @@ -23,5 +23,6 @@
>  #define ROCKCHIP_SIP_CONFIG_DRAM_GET_RATE	0x05
>  #define ROCKCHIP_SIP_CONFIG_DRAM_CLR_IRQ	0x06
>  #define ROCKCHIP_SIP_CONFIG_DRAM_SET_PARAM	0x07
> +#define ROCKCHIP_SIP_CONFIG_DRAM_SET_ODT_PD	0x08
>  
>  #endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
