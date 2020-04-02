Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0819B970
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 02:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbgDBAOC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 20:14:02 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:55179 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732994AbgDBAOB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 20:14:01 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200402001359epoutp01f684255aff478891b3207f6db1f31bd1~B2F1oFSfF1193911939epoutp01R
        for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2020 00:13:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200402001359epoutp01f684255aff478891b3207f6db1f31bd1~B2F1oFSfF1193911939epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585786439;
        bh=blo/55zUirLBxlsaZGktNUtO2h3kSeGMhMgMtSldTCk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=q6OEhPdEm323v8S2KYjeYB/1rtDhZmaci9XyTwfHEFomBExaWSIFy8VDBeRCJ8udA
         u1Jzi4YuELQidGUjF7S95XbCOBjnumVaZZyLZm0wn0L2FENRTPYcmvXQ/1M3CoiJIw
         milKC3KeyBJT+ty3+3xISc1I1TAM9A5te60064Wc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200402001358epcas1p45097928b1a81b43180413071ce1c259b~B2F05QzCW2702627026epcas1p4t;
        Thu,  2 Apr 2020 00:13:58 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48t3T04DBLzMqYkp; Thu,  2 Apr
        2020 00:13:56 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.AC.04074.44E258E5; Thu,  2 Apr 2020 09:13:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200402001356epcas1p3f3ceee60cb3a5116d502c2b977d6ee01~B2FyiQWmr1511715117epcas1p3W;
        Thu,  2 Apr 2020 00:13:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200402001356epsmtrp2a4d629c5a5cc322fec55b389762a0030~B2Fyg35Bk0622306223epsmtrp2I;
        Thu,  2 Apr 2020 00:13:56 +0000 (GMT)
X-AuditID: b6c32a39-58bff70000000fea-b5-5e852e444ac0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.07.04024.34E258E5; Thu,  2 Apr 2020 09:13:56 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200402001355epsmtip205c842a78e9cce3baa469626350b5dc9~B2FyB_41Q3178931789epsmtip2k;
        Thu,  2 Apr 2020 00:13:55 +0000 (GMT)
Subject: Re: [PATCH v2 3/8] PM / devfreq: imx: Register interconnect device
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4c3601b0-1f9d-f57b-e9c3-7ea5ff1992fd@samsung.com>
Date:   Thu, 2 Apr 2020 09:23:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <a6f9657a66e510bf5507daea140465c40c117e3d.1585751281.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxTVxzd7Wtfi1nnW+XjrokKbx8ZbMXWUneZQGZWl8dgCYtJ/5hZuxf6
        bAn9Sl/LdGYZEMuwg01CGiMfAlFmqZpB6QQJhKx2c7gAq24FhwayauLcxLBCYajL2j7M+O/c
        c34n557fzRVhkoBQKqqyOBi7hTaR+Bb+pSu5cpk636WVN/+Sg+ZPuwBa+ekaQF9f/x6gZc8I
        hqLzcwANnapEXaEpARoYnOOjk2N+HPk8l/loerpfiCbr/xIi7+0lAfJHIwLkXu/DUKw5BFDv
        TJiHIt4WAYr1RwEKX9uP5uq8ODo/9R2OOpc9GHKNhYTIHXyCo38jA3x0L5CFes9EMDSwQr21
        nfK4vYC6cPoCoB7OuoRUe22YT3X7nZTfdxynbkVGcWrw7GfUwOIwj/rqiZxav5JBfRnwASrm
        31Eh/qC6yMjQesaezVgqrfoqi6GYLDuge1un2iNXyBSF6A0y20KbmWJSXV4he6fKlFgKmV1D
        m5wJqoJmWXJXSZHd6nQw2UYr6ygmGZveZCu05bO0mXVaDPmVVvObCrl8tyox+FG18WTPY9wW
        lh5u7P+RVwvOZbhBmggSBfCuqwe4wRaRhBgGcG1mAUsKEuJvAHsaDnFCHMBvH9wFTx0dK508
        ThgDcG6yFecODwFcinWn7NuIMng/GhcmcTpxFJ6YrE85MCIshPMts7ykgBN5cPzeLJ7EW4kc
        +OtaNBUhJkrgo8dTKZ5PvAQvNs0LkjiD0MCJS8c2Zp6HE6fu8JM4jdDC3/+ZTvEYkQV/u9PF
        4/BOOPSgA0sGQ2JUBJs7QhjXQQ2HwqsbfbbB+1cDQg5LYWxxDOfwUdg3EcI5cyOAgfGfBZyg
        hOO9rYkEUSIhF34zsoujc+DlR50bl3gOLq40CZIjkBDDxgYJN/IivLFwm8fhF+CZz4/jJwDZ
        tqlO26YKbZsqtP0f1g34PpDJ2FizgWEVNtXm5/aD1I/JKxwGP0yVBwEhAuSz4sPGY1qJgK5h
        j5iDAIowMl3crk5QYj195BPGbtXZnSaGDQJVYtstmDSj0pr4fxaHTqHarVQqUYFij0qhILPE
        nhmTVkIYaAdTzTA2xv7UxxOlSWvBwdUdE6U9uWfbt5NV9eVbfa6RUa1Aac/02yTLa/F3X3+m
        7hX5iGRvX0Rz4GZaw74C3nXNuQWy9bX1W0v7u0vSDd66lsXST//UhCRNF3eKsb3gPbMzLjtE
        3LQ3H2zAdMtlpXmlgz6N+mrNvhsvyz72nqc/bNUHVzNnit7v+uOLV+MknzXSijzMztL/ATT4
        roBHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGeXfOzo7S6rg5fF0Xa2SStKkY8X4w8UOXQxFEUZDk9KiHKbk5
        drxWlEWmje6xbPMamdqymDNSyyindjGcTNnyFoNmFuGFmNptRc0R7NuP53l+8P/wJzFRHV9K
        5moKWJ2GyZMRofjjXlmUfIeiXBk/qceQu64coMW3AwA1DfcDtGB4giGPewKgDmMWqu+z81Fb
        +wSOqp5ZCWQ2dOFoaMgiQINnZwSo5f1XPrJ6XHyk/3kPQ95LfQDdfefgIVfLNT7yWjwAOQZ2
        ookzLQS6b+8hUO2CAUPlz/oESG/7TaA/rjYcfX4Uge7ecWGobZFOWUsb9C2Abq1rBfT8aLmA
        ri5z4HSDtZC2mi8Q9KSrm6DbG0/TbXOdPPrK73j6Z6+EvvzIDGivdd1+YWpoUjabl1vE6uKS
        M0Jzqm77CK1DWlJpec0rA80SPQghIbUV1izW8vQglBRRTwEcqPDyA0UkvOnox/SA/Mdi2NvL
        BTazAD6ft2D+jZjaC794lgR+DqdOQN/0K8w/wiinAM58auD5CxH1AcAXjzP9TFCx8PnnUcLP
        q6gN0PndA/wspJLhL599OcepjfDBRffyERLqMOxq9PACmzD4xjiF+zmEUsIPP4aWXYyKgb66
        YSzAEXB8qp4X4CjYMVuDXQViU5BuClJMQYopSGkAuBlEslpOrVJzCdoEDVus4Bg1V6hRKbLy
        1Vaw/DWxmzvBSGO6DVAkkK0QluScU4r4TBFXqrYBSGKycGH1jn+RMJspPc7q8tN1hXksZwOr
        SVwWIfyoeXlERKmYAvYYy2pZ3f+WR4ZIy0BaT1FxhXDTitYCYyWNyaedC7uTY3YdkCeFMVec
        l9xideTMmm/Sobgl/vlDqYadXd/E9Qpjwz5pyhalZPuYRDjnHKRvmGPsa2TjY2XJ/Ssf5oXd
        lFuYjOhMNLI+OvHk7h77QeOtEJNKqmhKDKuIP7qtI+b62uma5s65U9170uQynMthEmIxHcf8
        BWeQy6cxAwAA
X-CMS-MailID: 20200402001356epcas1p3f3ceee60cb3a5116d502c2b977d6ee01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200401143323epcas1p32c5792eff0ce38084c79fa932727bf2f
References: <cover.1585751281.git.leonard.crestez@nxp.com>
        <CGME20200401143323epcas1p32c5792eff0ce38084c79fa932727bf2f@epcas1p3.samsung.com>
        <a6f9657a66e510bf5507daea140465c40c117e3d.1585751281.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 4/1/20 11:33 PM, Leonard Crestez wrote:
> There is no single device which can represent the imx interconnect.
> Instead of adding a virtual one just make the main &noc act as the
> global interconnect provider.
> 
> The imx interconnect provider driver will scale the NOC and DDRC based
> on bandwidth request. More scalable nodes can be added in the future,
> for example for audio/display/vpu/gpu NICs.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/devfreq/imx-bus.c | 41 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 7915d7277349..240eeea66f13 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -14,10 +14,11 @@
>  
>  struct imx_bus {
>  	struct devfreq_dev_profile profile;
>  	struct devfreq *devfreq;
>  	struct clk *clk;
> +	struct platform_device *icc_pdev;
>  };
>  
>  static int imx_bus_target(struct device *dev,
>  		unsigned long *freq, u32 flags)
>  {
> @@ -57,11 +58,44 @@ static int imx_bus_get_dev_status(struct device *dev,
>  	return 0;
>  }
>  
>  static void imx_bus_exit(struct device *dev)
>  {
> +	struct imx_bus *priv = dev_get_drvdata(dev);
> +
>  	dev_pm_opp_of_remove_table(dev);
> +	platform_device_unregister(priv->icc_pdev);
> +}
> +
> +/* imx_bus_init_icc() - register matching icc provider if required */
> +static int imx_bus_init_icc(struct device *dev)
> +{
> +	struct imx_bus *priv = dev_get_drvdata(dev);
> +	const char *icc_driver_name;
> +
> +	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
> +		return 0;
> +	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {
> +		dev_warn(dev, "imx interconnect drivers disabled\n");
> +		return 0;
> +	}
> +
> +	icc_driver_name = of_device_get_match_data(dev);
> +	if (!icc_driver_name) {
> +		dev_err(dev, "unknown interconnect driver\n");
> +		return 0;
> +	}
> +
> +	priv->icc_pdev = platform_device_register_data(
> +			dev, icc_driver_name, -1, NULL, 0);
> +	if (IS_ERR(priv->icc_pdev)) {
> +		dev_err(dev, "failed to register icc provider %s: %ld\n",
> +				icc_driver_name, PTR_ERR(priv->devfreq));
> +		return PTR_ERR(priv->devfreq);
> +	}
> +
> +	return 0;
>  }
>  
>  static int imx_bus_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -109,18 +143,25 @@ static int imx_bus_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(priv->devfreq);
>  		dev_err(dev, "failed to add devfreq device: %d\n", ret);
>  		goto err;
>  	}
>  
> +	ret = imx_bus_init_icc(dev);
> +	if (ret)
> +		goto err;
> +
>  	return 0;
>  
>  err:
>  	dev_pm_opp_of_remove_table(dev);
>  	return ret;
>  }
>  
>  static const struct of_device_id imx_bus_of_match[] = {
> +	{ .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
> +	{ .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
> +	{ .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
>  	{ .compatible = "fsl,imx8m-noc", },
>  	{ .compatible = "fsl,imx8m-nic", },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, imx_bus_of_match);
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
