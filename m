Return-Path: <linux-pm+bounces-39421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DBBCB45C2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 01:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE59B301227D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 00:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149EF2222D0;
	Thu, 11 Dec 2025 00:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j4mJZWqS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GuKWHS2+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52970221F1F
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765413738; cv=none; b=btNNot/bxz1UkZAztKO/8zMLxGj8cwLI5lvKqnVCS0+Zu7AWxusZHLDBG01EgKYdXpK7o6cCerIyHm6yZhkRFFAwlYPxx9ia1wZ5kp7vTHvZsmN8yspNpCtEHXdMog8Va9C4j+c55eioGjIozLq4bNI/nvtZR0OTbpWVmp6Yk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765413738; c=relaxed/simple;
	bh=NOnK/W40x7knkTf4m28AQ5aw+F+jKj0hLSikZ5fNCwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bk/WxXalcxNHlAuitenwNDau6SBcbbmLoKbTLwN5PMGd9VIdN1HlT/k5nvjoAYOZa2qw09r6bQPl1jiQzBAMYlQlZc7lXypayNujB37OJXm5wxx80WtFqwehvfGwCTF3yN9IyIu7VEFOUCLk3EXg9Fng1CcH7YblWxg/GAr9pAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j4mJZWqS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GuKWHS2+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BALVF204061619
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 00:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EYOh9CKt3yKfImURGfqZ8xiIJqWoNk/RHXJwsQk2azs=; b=j4mJZWqSfcVh4aKm
	0BYTQL2xT8+RI5zXkDwUo5mvDy6t2yt1WuR7aE9/Ii66XvKFFcIpJstbMtTmpE/0
	ZcSq8T3k/j1GvBBAx4AlQiBzrI6nXFIy9ErNpS2ml7KcEWJlDPR2mw8Mq1icGQk3
	+4IC8J36OQr0oH+Se4RhjJn7kxCeFiXEI8NxdVPaL0TqJAXnXHoZvoj2jJcfjAmC
	v4RnOs4NT1OB3SwibsK7ALELZ7UGFUPl4w4EzlIyrmXpb8QOREjFl2DCfLAu/lzI
	f3bxhTiMDDU5YlvT07Pj4lLRCTpSk7b4qNRk94i70M+gDuUpuS8tGm+hqix8GMrK
	0gENtQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayguqgcvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 00:42:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-340ad9349b3so835669a91.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 16:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765413734; x=1766018534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EYOh9CKt3yKfImURGfqZ8xiIJqWoNk/RHXJwsQk2azs=;
        b=GuKWHS2+PKaOtMTTKsN0p/ZBu9AdUjXxBxZfT02zPppZ+jDn4v9PJHG+xft5gNQFO2
         mDXa1jgTl6DRjJpWArL+EkKmXTC7bFaPe495g0MMO5wk7g3dWPWhnqvya83M/3rEzkQK
         iJrBUB6Y54wy7OjDSzvOF7LB/MNF0VpisuXrI6X1tVcJh8NDTrYD9kEA0362pqWLCLPE
         XxdaGsS4oi9IBQB+LDdl7/DsxN4UvxGgmgJ7PnpEpjSXM/Fj/8h7PBExm3eXERo6UlQJ
         BujRF88oXTxJbW8TVQFgLpvNWM42NafdzvmyD+pHF+1qrPyhS1oSugaG5t4pqTqkqO39
         W6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765413734; x=1766018534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYOh9CKt3yKfImURGfqZ8xiIJqWoNk/RHXJwsQk2azs=;
        b=UtPPDn/Qxsa+oEZ6rqezOUNfcjY7+iasplEcBTJrmCdvCxYPut+LCHmO8Lb1I6AjYW
         p806gfDyzW1xXSfKkIfXYCsnXxX7pEU0mTvf1/IjRVPuowvEQCr9Urn13ImQ2NFbiCvu
         qlPnOb+ndEn4AK7nVBZajIBdaATLznSKF8GiF6x7X1olkHR0X+FBxVu/ktoySihFz6Yp
         397e3n+oa5os4RO7LDzm3XGiaypOloC3h552jN5xoa/fdB6cwjVLDMbVfsjq6Fnltu1Y
         k8+Q1h+er/8H6jHn+rrHox5PfEWduNMjWkvraXWfKOFBhBGx+WE0S6qpymlhJEC8JPUm
         7i+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaOvezDnvaM4PGdikwOFAHPdGWchSAicAjmTPNs02NeEFnFc6uyx9Wsv25sw6oDJfyseFpqI+XlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/pVrUhC5V0QOti3jDBxDDVm6PNmMX5MypG3oEUWlcXcV0PDE
	12+CD40fyqyujtOn0Zlz5bcMGCDmR5wxKV93XSp7QIX3xscSzsNyfDMdSOITKZqrxjkSJpHsVVh
	clOqwADTrBVvrac1wPTrp6ACybUb2uY+fJOgWIorYkja9tDkOCLqKlCSyGxNlVA==
X-Gm-Gg: AY/fxX6uncdQ4bcseeIPM/tNzG0UKAz1FGbtv2tZqPtA7G6p5Y9L88dpmBdCuRZrmLi
	8cNCM/AUAtlCsXCJGwuLEKeBI6fLxdLUctOVeSD5fRMzdM9GlkerkqB0T2Nadhaa8CiU8ZP2Wz9
	4E5GKBzcAhi9FVPPpxGEgsB0ML/0qgmxbYTv2Usgqzn0D6QMFzBNqlxbJq8e7gvYw2S79xvez9p
	8c2zxux4Od6ymj4XqK+kjLF779zTzzsXx6Cs+Hl3777kTmmYdYvnOV5n+r31G+jyCK0JZ6G2uaS
	dNdnpsjdHLbMxkiXnZTUz3YpYMRn8aXBJ9/xY0t9RPAM6IFfi+lRh3c9T8MzMnN6jsS4WZO54Xu
	e3Hh/5mQxnekXJbCNKQCF0hVfgkM/s31Il5af6Hlg6EMc
X-Received: by 2002:a17:90b:1d04:b0:32b:9506:1780 with SMTP id 98e67ed59e1d1-34a7281a37emr4182441a91.9.1765413733693;
        Wed, 10 Dec 2025 16:42:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzVnt7zdOJV4tIVUdTd0Iljd79rdgfszDHAS9d7dWKHGfcheesKUfZDrWbLlhNo657TfxRfQ==
X-Received: by 2002:a17:90b:1d04:b0:32b:9506:1780 with SMTP id 98e67ed59e1d1-34a7281a37emr4182413a91.9.1765413733189;
        Wed, 10 Dec 2025 16:42:13 -0800 (PST)
Received: from [192.168.29.63] ([49.43.227.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0cd2880d96sm102560a12.2.2025.12.10.16.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 16:42:12 -0800 (PST)
Message-ID: <925c7431-823c-45e7-b446-ac1ed98eadd5@oss.qualcomm.com>
Date: Thu, 11 Dec 2025 06:12:06 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] PCI: Add support for PCIe WAKE# interrupt
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, sherry.sun@nxp.com,
        Len Brown <lenb@kernel.org>
References: <20251127-wakeirq_support-v6-0-60f581f94205@oss.qualcomm.com>
 <20251127-wakeirq_support-v6-2-60f581f94205@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251127-wakeirq_support-v6-2-60f581f94205@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDAwNCBTYWx0ZWRfX28lvvLtnkjfL
 Pvd/JRxXWqDlNBu6Bnp3Z7a6k6pcwJPj12Mm4LwH5CpBmMnEd2H7ofqsWOnbEUK0iMcVeZ2wDn1
 MBjUE10g8qCSqdYNzqHyBBRUJOO9Mtyq7QIAspYG+MQ9v/5q7QOTwmSgV3YXWuEIBgLTqBW21bp
 lzEiKB2cyUTuydXpmofpRcbafzPmxBLiaoukYzF2ZxgCYNG9whoyNzB0McfFtHVWiuG3b1YRih4
 9yAd9EgvTCaqM+EJhCykKYaNxPa/CP70dOdfTDmcFePRX43hG9guPo2p9MDmhg4hOHwno7Cx22V
 NPWLCjTF94ICX4L0B6yJ3SDNEwTI0rDlIXhBFOZqd56GS3LWpPI9uaK4SL5LYCqz6ULIo3gKvwd
 kBbh5z5bMI5aApUSvsrqQGGSzPAjqA==
X-Authority-Analysis: v=2.4 cv=deGNHHXe c=1 sm=1 tr=0 ts=693a1367 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fqkWdzeoxvaQSXQQJMpBPw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=KKAkSRfTAAAA:8 a=BO740POU_6FGrjW6UNEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: I2987lxsFb_OBwaX-Vk7c9mJFTS5aQmG
X-Proofpoint-ORIG-GUID: I2987lxsFb_OBwaX-Vk7c9mJFTS5aQmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110004

Hi Bjorn,

Can you review this patch?

- Krishna Chaitanya.
On 11/27/2025 6:15 PM, Krishna Chaitanya Chundru wrote:
> According to the PCIe specification 6, sec 5.3.3.2, there are two defined
> wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
> provide a means of signaling the platform to re-establish power and
> reference clocks to the components within its domain. Beacon is a hardware
> mechanism invisible to software (PCIe r7.0, sec 4.2.7.8.1). Adding WAKE#
> support in PCI framework.
>
> According to the PCIe specification, multiple WAKE# signals can exist in
> a system. In configurations involving a PCIe switch, each downstream port
> (DSP) of the switch may be connected to a separate WAKE# line, allowing
> each endpoint to signal WAKE# independently. From figure 5.4, WAKE# can
> also be terminated at the switch itself. To support this, the WAKE#
> should be described in the device tree node of the endpint/bridge. If all
> endpoints share a single WAKE# line, then WAKE# should be defined in the
> each node.
>
> To support legacy devicetree in direct attach case, driver will search
> in root port node for WAKE# if the driver doesn't find in the endpoint
> node.
>
> In pci_device_add(), PCI framework will search for the WAKE# in its node,
> If not found, it searches in its upstream port only if upstream port is
> root port to support legacy bindings. Once found, register for the wake IRQ
> in shared mode, as the WAKE# may be shared among multiple endpoints.
>
> When the IRQ is asserted, the handle_threaded_wake_irq() handler triggers
> a pm_runtime_resume(). The PM framework ensures that the parent device is
> resumed before the child i.e controller driver which can bring back device
> state to D0.
>
> WAKE# is added in dts schema and merged based on below links.
>
> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> Link: https://github.com/devicetree-org/dt-schema/pull/170
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/pci/of.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/pci/pci.h    |  6 ++++++
>   drivers/pci/probe.c  |  2 ++
>   drivers/pci/remove.c |  1 +
>   include/linux/pci.h  |  2 ++
>   5 files changed, 69 insertions(+)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f119845637e163d9051437c89662762f8..fc33405a7b1f001e171277434663cc9dfe57c69b 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -7,6 +7,7 @@
>   #define pr_fmt(fmt)	"PCI: OF: " fmt
>   
>   #include <linux/cleanup.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/irqdomain.h>
>   #include <linux/kernel.h>
>   #include <linux/pci.h>
> @@ -15,6 +16,7 @@
>   #include <linux/of_address.h>
>   #include <linux/of_pci.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>   #include "pci.h"
>   
>   #ifdef CONFIG_PCI
> @@ -586,6 +588,62 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>   	return irq_create_of_mapping(&oirq);
>   }
>   EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
> +
> +static void pci_configure_wake_irq(struct pci_dev *pdev, struct gpio_desc *wake)
> +{
> +	int ret, wake_irq;
> +
> +	if (!wake)
> +		return;
> +
> +	wake_irq = gpiod_to_irq(wake);
> +	if (wake_irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get wake irq: %d\n", wake_irq);
> +		return;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, true);
> +
> +	ret = dev_pm_set_dedicated_shared_wake_irq(&pdev->dev, wake_irq,
> +						   IRQ_TYPE_EDGE_FALLING);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to set wake IRQ: %d\n", ret);
> +		device_init_wakeup(&pdev->dev, false);
> +	}
> +}
> +
> +void pci_configure_of_wake_gpio(struct pci_dev *dev)
> +{
> +	struct device_node *dn = pci_device_to_OF_node(dev);
> +	struct gpio_desc *gpio;
> +	struct pci_dev *root;
> +
> +	if (!dn)
> +		return;
> +
> +	gpio = fwnode_gpiod_get_index(of_fwnode_handle(dn),
> +				      "wake", 0, GPIOD_IN | GPIOD_FLAGS_BIT_NONEXCLUSIVE, NULL);
> +	if (IS_ERR(gpio)) {
> +		/*
> +		 * To support legacy devicetree, search in root port for WAKE#
> +		 * in direct attach case.
> +		 */
> +		root = pci_upstream_bridge(dev);
> +		if (pci_is_root_bus(root->bus))
> +			pci_configure_wake_irq(dev, root->wake);
> +	} else {
> +		dev->wake = gpio;
> +		pci_configure_wake_irq(dev, gpio);
> +	}
> +}
> +
> +void pci_remove_of_wake_gpio(struct pci_dev *dev)
> +{
> +	dev_pm_clear_wake_irq(&dev->dev);
> +	device_init_wakeup(&dev->dev, false);
> +	gpiod_put(dev->wake);
> +	dev->wake = NULL;
> +}
>   #endif	/* CONFIG_OF_IRQ */
>   
>   static int pci_parse_request_of_pci_ranges(struct device *dev,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4492b809094b5794bd94dfbc20102cb208c3fa2f..05cb240ecdb59f9833ca6dae2357fdbd012195d6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1056,6 +1056,9 @@ void pci_release_of_node(struct pci_dev *dev);
>   void pci_set_bus_of_node(struct pci_bus *bus);
>   void pci_release_bus_of_node(struct pci_bus *bus);
>   
> +void pci_configure_of_wake_gpio(struct pci_dev *dev);
> +void pci_remove_of_wake_gpio(struct pci_dev *dev);
> +
>   int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
>   bool of_pci_supply_present(struct device_node *np);
>   int of_pci_get_equalization_presets(struct device *dev,
> @@ -1101,6 +1104,9 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>   	return 0;
>   }
>   
> +static inline void pci_configure_of_wake_gpio(struct pci_dev *dev) { }
> +static inline void pci_remove_of_wake_gpio(struct pci_dev *dev) { }
> +
>   static inline bool of_pci_supply_present(struct device_node *np)
>   {
>   	return false;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a876afe72af35a9f4a44d598e8d500..f9b879c8e3f72a9845f60577335019aa2002dc23 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2762,6 +2762,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>   	ret = device_add(&dev->dev);
>   	WARN_ON(ret < 0);
>   
> +	pci_configure_of_wake_gpio(dev);
> +
>   	pci_npem_create(dev);
>   
>   	pci_doe_sysfs_init(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index ce5c25adef5518e5aec30c41de37ea66d682f3b0..26e9c1df51c76344a1d7f5cc7edd433780e73474 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -54,6 +54,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   	if (pci_dev_test_and_set_removed(dev))
>   		return;
>   
> +	pci_remove_of_wake_gpio(dev);
>   	pci_doe_sysfs_teardown(dev);
>   	pci_npem_remove(dev);
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d1fdf81fbe1e427aecbc951fa3fdf65c20450b05..cd7b5eb82a430ead2f64d903a24a5b06a1b7b17e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -555,6 +555,8 @@ struct pci_dev {
>   	/* These methods index pci_reset_fn_methods[] */
>   	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
>   
> +	struct gpio_desc *wake; /* Holds WAKE# gpio */
> +
>   #ifdef CONFIG_PCIE_TPH
>   	u16		tph_cap;	/* TPH capability offset */
>   	u8		tph_mode;	/* TPH mode */
>


