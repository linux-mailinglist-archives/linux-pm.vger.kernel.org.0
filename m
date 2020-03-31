Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23A419A228
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 01:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgCaW77 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 18:59:59 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:18351 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgCaW77 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 18:59:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200331225955epoutp04b9b76ff5cd8b9e175ab0489a18f47860~Bhb5BIr0X0901109011epoutp04M
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 22:59:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200331225955epoutp04b9b76ff5cd8b9e175ab0489a18f47860~Bhb5BIr0X0901109011epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585695596;
        bh=cp03SGTakGmVgzpFFw5xpcGW130Uflqr7VsMCqzjjwM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cWK/lHsHMNF76c541bTW9LRwiMgcPqZdq2DstPdYxll74Z4CpSxfGkHdhpDGzwO0z
         aasGeAPNGt0XaHmGTgY4CYR14B6YwK2cNNpTV+iN9hxXyuImfdUJS48J1iRwCfmbIw
         VeXeVinQgRec6xz3UW/FjZpFia/x3ZoKFQb+iz2Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200331225955epcas1p45ffea529fc50f8bb9cf6f3f5cba37916~Bhb4SdLIu2949529495epcas1p4K;
        Tue, 31 Mar 2020 22:59:55 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48sPt03fFDzMqYlm; Tue, 31 Mar
        2020 22:59:52 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.FF.04145.86BC38E5; Wed,  1 Apr 2020 07:59:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200331225951epcas1p40ae4eff7ebbf4e21821f38628af4b2df~Bhb1Qr3EA0452704527epcas1p4b;
        Tue, 31 Mar 2020 22:59:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200331225951epsmtrp1cbb2b7775d09fe76497f21a1cb079089~Bhb1PcNMv1348113481epsmtrp1Z;
        Tue, 31 Mar 2020 22:59:51 +0000 (GMT)
X-AuditID: b6c32a35-28dff70000001031-a1-5e83cb681aa6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.D4.04158.76BC38E5; Wed,  1 Apr 2020 07:59:51 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200331225951epsmtip1590e75b13b20f717d6aa4364f5f4e865~Bhb01H2sJ2062120621epsmtip1-;
        Tue, 31 Mar 2020 22:59:51 +0000 (GMT)
Subject: Re: [PATCH 3/8] PM / devfreq: imx: Register interconnect device
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kepplinger <martink@posteo.de>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
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
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ea021693-c22b-27be-8346-011673ae0831@samsung.com>
Date:   Wed, 1 Apr 2020 08:08:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <f4553b6aacc88a91ed407eb709097e2cd1bf1a19.1585188174.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc/teXx/Gzrcq44Kbq2+gkQTsE8quDMzicHnLjCNZsj+WWXyj
        L5TQX+lrnW5ZVqew0ilqtHMyBYUya3GBViwFJWxY4oCIMEMl6wgVHOicGAYoc9Gtv8z473PO
        Pd9z8j03h8RklyRpZLnezJv0nJYmluG+qxsUWZqB/SpF+NnLaLyuEqCFgX6Avv+lF6B5RyeG
        JsdDALWfLEX1gUEx8lwM4ehEl5dAbkcHjm7caJWg61/+KUGusVkx8k4Gxcj+5DyG5g4FAGq6
        NSxCQddRMZprnQRouH8bCu1zEah58CcCnZ53YKiyKyBB9p6nBHoW9ODoblsKamoMYsizwL75
        CuuwuwB7oe4CYB+OVkrY76zDOHvGa2G97mqC/S14hWAvOr9gPTN+EXv4qYJ9cjWZrWlzA3bO
        u6ZY+mFFgYbn1LxJzutLDepyfVkh/e77JW+VKPMUTBazGb1Oy/Wcji+ki7YXZ71dro0shZbv
        5rSWSKqYEwR645YCk8Fi5uUag2AupHmjWmvcbMwWOJ1g0Zdllxp0+YxCsUkZKdxVoZltnhAZ
        W1bvOXIqhFvB/WQ7SCIhlQsDV77G7WAZKaP8ALZMTYviwV8A3rc+EMeDRwAuHvsGfy6pHutO
        SLoAdP4wkpA8BNDj3EfYAUmupFg4fO+NaH4V5QQwEHwcU2CUSwKrfOdirQgqE3bfHSWivIJa
        C0cWJ0GUpdQWOOscwqKMU+nwcocjlk+mPoB9vgOJmhdh38k7sT5JlArOn/tXFGWMSoG/3qlP
        8Kuw/cEpLDoYUn4S9oamJHEPRfD2j40JXgn/uNaW4DR473BVgj+D5/sCRFxsA7Cte0gcf8iB
        3U3HRFGbGLUBtnRujKfXwo5/ToP44BfgzMJBcbQEUlJoq5LFS16DN8NjojinwsavqokjgK5d
        Yqd2iYXaJRZq/x92BuBu8BJvFHRlvMAYmaX/7QWxk8lU+sHxwe09gCIBvVwqz9+vkom53cJe
        XQ+AJEavkhLvWVUyqZrb+ylvMpSYLFpe6AHKyLaPYmnJpYbIAerNJYxyU05ODspl8pQMQ6dI
        Hbe0KhlVxpn5Cp438qbnOhGZlGYFxXWrF/Zk3J74e/1Qpdvma5prVwwQzOfLZ4vGfZ2PLIv+
        5sVM0ZRrXXCUF8y9H237fd3EiW+nr3OfSMKtikNbCz5ec1yFZ1+beezOONiXaqupDx94R7/1
        bDg9fcq2M6PcMzLN9WsvYdXqfEVD6o4CPVljayjK/blhxc2xPE5trqNxQcMxmZhJ4P4DZ8sD
        ikgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTYQCG+XbOzo7D6eem+Knkz7CMQaVh9JG2oh84N1kXKtSFNvQwLefG
        jlpWlDo1HVYarHD+LGqWqaDOKM1M3EyskTrBJa0ynRdKWYkORcpqWuDdw/O+791LE+IGfiid
        nZvHanMVOVJKSD61ScN3Ke26tFh98T481VgGsMf+BuCH468AXjY8J7B7ygXws9oMbBoc4ePO
        LheJ7/ZZKNxi6CHx6GiHAL8t+SrAzR8X+djidvKxfu0xgZduDALc9M7Bw87mGj5e6nAD7Hhz
        HLuKmyncOjJA4YZlA4HL+gYFWG/9ReF1ZyeJ554E46YHTgJ3epjD2xiDvhkwbY1tgPk+WSZg
        6oocJHPPks9YWiop5oPzBcV0ma8xnd+6ecytX7HMmi2IufmkBTBLlvBTojPCxEw2J7uA1e6R
        nxVmLbbO8DTtYRer611kEfgSpAc+NILxqPJjP6kHQloMewFaKZvhbQYh6I7jFaEH9F+WIJuN
        2+wsADQ+30t5vQQyyDGf4K0HQjNA5umT3g4B2wSoxHyd8gZiOAPQj/tyL1NQhvrnJje8P4xC
        E6tu4GURlKNF8xjhZRJGo94ew4YPgqmox+zmbXYC0OvaWdLLPjANLT/6veEJGIN+No4TmxyM
        3s+a/vkI9GyhnqgGEuOWuXHLxLhlYtwyuQfIFhDCajiVUsXFafbmshd2cwoVl5+r3J2hVlnA
        xmlksm4wPJxuBZAGUl9R1AFdmpivKOAKVVaAaEIaKKJOFqWJRZmKwkusVp2uzc9hOSsIo0lp
        sChCPXRaDJWKPPY8y2pY7f+UR/uEFoF805W1y/yX8Tmf+bq6eE2/X167n/xEVam2bod8bD9I
        8BxMFsXW6NjMJNtQqObqdh28fWy1IinZNFwZUqMcOCe0h38yrL/vqfZMpFTNJ5YP50UXVEqF
        kXMxmStT2N9+1HNAbZ02JUlm4JGU8p2FV9UVEb5NpZwkMlVzyF0cICW5LEWcjNByij/lw9sV
        MAMAAA==
X-CMS-MailID: 20200331225951epcas1p40ae4eff7ebbf4e21821f38628af4b2df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200326021638epcas1p1626d266c8dcfa051b7c590838e62b097
References: <cover.1585188174.git.leonard.crestez@nxp.com>
        <CGME20200326021638epcas1p1626d266c8dcfa051b7c590838e62b097@epcas1p1.samsung.com>
        <f4553b6aacc88a91ed407eb709097e2cd1bf1a19.1585188174.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 3/26/20 11:16 AM, Leonard Crestez wrote:
> There is no single device which can represent the imx interconnect.
> Instead of adding a virtual one just make the main &noc act as the
> global interconnect provider.
> 
> The imx interconnect provider driver will scale the NOC and DDRC based
> on bandwidth request. More scalable nodes can be added in the future,
> for example for audio/display/vpu/gpu NICs.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/imx-bus.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> index 285e0f1ae6b1..e9b13e43bf0a 100644
> --- a/drivers/devfreq/imx-bus.c
> +++ b/drivers/devfreq/imx-bus.c
> @@ -15,10 +15,11 @@
>  struct imx_bus {
>  	struct devfreq_dev_profile profile;
>  	struct devfreq *devfreq;
>  	struct clk *clk;
>  	struct devfreq_passive_data passive_data;
> +	struct platform_device *icc_pdev;
>  };
>  
>  static int imx_bus_target(struct device *dev,
>  		unsigned long *freq, u32 flags)
>  {
> @@ -60,11 +61,42 @@ static int imx_bus_get_dev_status(struct device *dev,
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

Better to add following comments without 'imx_bus_init_icc() -' comment.
/* Register matching icc provider if required */

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
> +	if (!icc_driver_name)
> +		return 0;

Recommend to add the error or warning message.

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
> @@ -112,18 +144,25 @@ static int imx_bus_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(priv->devfreq);
>  		dev_err(dev, "failed to add devfreq device: %d\n", ret);
>  		goto err;
>  	}
>  
> +	ret = imx_bus_init_icc(dev);
> +	if (ret)

Recommend to add the error message.

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


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
