Return-Path: <linux-pm+bounces-21119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972E7A22B3F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 11:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47523AB2EC
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964416A395;
	Thu, 30 Jan 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OYAJGn7I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4277E0E4;
	Thu, 30 Jan 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231415; cv=none; b=i1k/dMhSn5C8u4RCfH1S6jgVB8UhFNXBtmxIgK4WO2kPMZ07OW8AlsfdwChgS8b4nTlloQZ0u19i2D2XJSEQQodsGQEpsekfDWuPWDPdV2I4Xu5G9ca/oz9uJkvNKES/nSd6nO4Ebn4U5wZzM1b68/mjOoUn+cOYclHytTgEchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231415; c=relaxed/simple;
	bh=2sXW4GBxPt/yJ3Q152hJbd3MBIixTAR4IBbse8RQ5NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XXEoZwu2TaE+fzwX3ZPXV/uyayJpE25k/vsExElO3koZ7xtMpkdn28Wdd91AS+rvyiPrgTdSD8j1UZkicZMcRVVCe0bZxkqo7nPpjm12M2k1xK24UiEYc4cAtzob31i7AG29Z+zK4SS6mbrPwt0hup1e/hAEFbVkSnlHtQ77qlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OYAJGn7I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U1dC6S023830;
	Thu, 30 Jan 2025 10:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZUGoZU9SmpWtYDyisJW6wY5gUB1sQNSLSjbLV3TJrP8=; b=OYAJGn7IV6Nd4mOf
	Q2mKdyj33Zu5SrlBzLhwdOwUJpcVPaH7xkHWpUpkrCkWIJtDWSQWCSuIaNjIaAY1
	lFGKS0XiQ1zRfnoVSjx3eKVUdEMcRFQa2I7SgliuE1ESL4nZQnbgNoCrg4Uf5cKH
	GEt2XaM9CkvyqX7l2PQQGE5x3o4lkyM4/i4J2AIt4DQeIFuZrCuoAykyQlnhZ7q5
	DOl0RxtnuEuXVin2GvqfHZFAafjibcq2YBZAhESfeJdw7+l70N7dSpYcW2XeOKGH
	/70+cLibjFa8jW/DeciPNUQBimC/HRnmXf4kZqaYvxQqqMnFQwJcQNy5/vElb4kG
	npJPcw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fyxnrth2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:03:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50UA3Mxa024644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 10:03:22 GMT
Received: from [10.216.8.207] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 Jan
 2025 02:03:17 -0800
Message-ID: <123a324c-561a-4081-be43-8d8ed0662acc@quicinc.com>
Date: Thu, 30 Jan 2025 15:33:14 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: qcom: apss-ipq5424: Add ipq5424 apss clock
 controller
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <andersson@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <konradybcio@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <20250127093128.2611247-1-quic_srichara@quicinc.com>
 <20250127093128.2611247-3-quic_srichara@quicinc.com>
 <47f7553d-74a2-4da0-a64c-cc49a2170efb@oss.qualcomm.com>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <47f7553d-74a2-4da0-a64c-cc49a2170efb@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ap5pL5MPNMORJ5j2I9WNVpI2JPP6wEA8
X-Proofpoint-GUID: ap5pL5MPNMORJ5j2I9WNVpI2JPP6wEA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300077



On 1/28/2025 5:29 PM, Konrad Dybcio wrote:
> On 27.01.2025 10:31 AM, Sricharan R wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> CPU on Qualcomm ipq5424 is clocked by huayra PLL with RCG support.
>> Add support for the APSS PLL, RCG and clock enable for ipq5424.
>> The PLL, RCG register space are clubbed. Hence adding new APSS driver
>> for both PLL and RCG/CBC control. Also the L3 cache has a separate pll
>> and needs to be scaled along with the CPU.
>>
>> Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
> 
> [...]
> 
>> +#define GPLL0_CLK_RATE		800000000
>> +#define CPU_NOM_CLK_RATE	1416000000
>> +#define CPU_TURBO_CLK_RATE	1800000000
>> +#define L3_NOM_CLK_RATE		984000000
>> +#define L3_TURBO_CLK_RATE	1272000000
> 
> Please inline these values
> 
ok.

>> +
>> +enum {
>> +	P_XO,
>> +	P_GPLL0,
>> +	P_APSS_PLL_EARLY,
>> +	P_L3_PLL,
>> +};
>> +
>> +struct apss_clk {
>> +	struct notifier_block cpu_clk_notifier;
>> +	struct clk_hw *hw;
>> +	struct device *dev;
>> +	struct clk *l3_clk;
>> +};
>> +
> 
>> +static struct clk_branch l3_core_clk = {
>> +	.halt_reg = 0x1008c,
>> +	.clkr = {
>> +		.enable_reg = 0x1008c,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(struct clk_init_data){
>> +			.name = "l3_clk",
>> +			.parent_hws = (const struct clk_hw *[]){
>> +				&l3_clk_src.clkr.hw },
> 
> 	&l3_clk_src.clkr.hw
> },
> 
>> +static unsigned long get_l3_clk_from_tbl(unsigned long rate)
>> +{
>> +	struct clk_rcg2 *l3_rcg2 = container_of(&l3_clk_src.clkr, struct clk_rcg2, clkr);
>> +	u8 max_clk = sizeof(ftbl_apss_clk_src) / sizeof(struct freq_tbl);
>> +	u8 loop;
>> +
>> +	for (loop = 0; loop < max_clk; loop++)
>> +		if (ftbl_apss_clk_src[loop].freq == rate)
>> +			return l3_rcg2->freq_tbl[loop].freq;
> 
> This looks extremely explosive if anyone makes changes to the driver..
> 
> Use an OPP table in the devicetree instead
> 
ok, already using OPPtable for cpu. To understand better, since L3 clk
is separate that needs to be scaled along with cpu, are you suggesting
to use dev_pm_opp_find_freq here for indexing ?

> And please add a newline before the return statement
> 
ok

>> +	return 0;
>> +}
>> +
>> +static int cpu_clk_notifier_fn(struct notifier_block *nb, unsigned long action,
>> +			       void *data)
>> +{
>> +	struct apss_clk *apss_ipq5424_cfg = container_of(nb, struct apss_clk, cpu_clk_notifier);
>> +	struct clk_notifier_data *cnd = (struct clk_notifier_data *)data;
>> +	struct device *dev = apss_ipq5424_cfg->dev;
>> +	unsigned long rate = 0, l3_rate;
>> +	int err = 0;
> 
> Please use 'ret'
> 
ok

>> +
>> +	dev_dbg(dev, "action:%ld old_rate:%ld new_rate:%ld\n", action,
>> +		cnd->old_rate, cnd->new_rate);
>> +
>> +	switch (action) {
>> +	case PRE_RATE_CHANGE:
>> +		if (cnd->old_rate < cnd->new_rate)
>> +			rate = cnd->new_rate;
>> +	break;
> 
> Why are the breaks indented like this?
> 
ok, will fix

>> +	case POST_RATE_CHANGE:
>> +		if (cnd->old_rate > cnd->new_rate)
>> +			rate = cnd->new_rate;
>> +	break;
>> +	};
>> +
>> +	if (!rate)
>> +		goto notif_ret;
> 
> In cases like these, just return directly instead of jumping
> 
ok

>> +
>> +	l3_rate = get_l3_clk_from_tbl(rate);
>> +	if (!l3_rate) {
>> +		dev_err(dev, "Failed to get l3 clock rate from l3_tbl\n");
>> +		return NOTIFY_BAD;
>> +	}
>> +
>> +	err = clk_set_rate(apss_ipq5424_cfg->l3_clk, l3_rate);
>> +	if (err) {
>> +		dev_err(dev, "Failed to set l3 clock rate(%ld) err(%d)\n", l3_rate, err);
>> +		return NOTIFY_BAD;
>> +	}
>> +
>> +notif_ret:
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static int apss_ipq5424_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct apss_clk *apss_ipq5424_cfg;
>> +	struct regmap *regmap;
>> +	void __iomem *base;
>> +	int ret;
>> +
>> +	apss_ipq5424_cfg = devm_kzalloc(&pdev->dev, sizeof(struct apss_clk), GFP_KERNEL);
> 
> Since there is no "config" in there, something like "ipq5424_apsscc" would be
> more fitting
> 
ok

>> +	if (IS_ERR_OR_NULL(apss_ipq5424_cfg))
>> +		return PTR_ERR(apss_ipq5424_cfg);
> 
> https://elixir.bootlin.com/linux/v6.13/source/include/linux/device.h#L326-L329
> |_
>     > elixir.bootlin.com/linux/v6.13/source/drivers/base/devres.c#L819-L820
> 
> It can never throw an errno, just check for if (!apss...)
> 
ok

>> +
>> +	base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	regmap = devm_regmap_init_mmio(dev, base, &apss_ipq5424_regmap_config);
>> +	if (!regmap)
>> +		return PTR_ERR(regmap);
> 
> devm_platform_get_and_ioremap_resource()
> 
ok

>> +
>> +	clk_alpha_pll_configure(&ipq5424_l3_pll, regmap, &l3_pll_config);
>> +
>> +	clk_alpha_pll_configure(&ipq5424_apss_pll, regmap, &apss_pll_config);
>> +
>> +	ret = qcom_cc_really_probe(dev, &apss_ipq5424_desc, regmap);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(&pdev->dev, "Registered APSS & L3 clock provider\n");
>> +
>> +	apss_ipq5424_cfg->dev = dev;
>> +	apss_ipq5424_cfg->hw = &apss_silver_clk_src.clkr.hw;
>> +	apss_ipq5424_cfg->cpu_clk_notifier.notifier_call = cpu_clk_notifier_fn;
>> +
>> +	apss_ipq5424_cfg->l3_clk = clk_hw_get_clk(&l3_core_clk.clkr.hw, "l3_clk");
>> +	if (IS_ERR(apss_ipq5424_cfg->l3_clk)) {
>> +		dev_err(&pdev->dev, "Failed to get L3 clk, %ld\n",
>> +			PTR_ERR(apss_ipq5424_cfg->l3_clk));
>> +		return PTR_ERR(apss_ipq5424_cfg->l3_clk);
>> +	}
> 
> Now that you'll use OPP, you can drop all this getting.. maybe even the
> apss_ipq5424_cfg struct could be let go

ok, is the suggestion here to use devm_pm_opp_set_config ?

>> +
>> +	ret = devm_clk_notifier_register(&pdev->dev, apss_ipq5424_cfg->hw->clk,
>> +					 &apss_ipq5424_cfg->cpu_clk_notifier);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
> 
> Just return ret instead
> 
ok

>> +}
>> +
>> +static const struct of_device_id apss_ipq5424_match_table[] = {
>> +	{ .compatible = "qcom,ipq5424-apss-clk" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, apss_ipq5424_match_table);
>> +
>> +static struct platform_driver apss_ipq5424_driver = {
>> +	.probe = apss_ipq5424_probe,
>> +	.driver = {
>> +		.name   = "apss-ipq5424-clk",
>> +		.of_match_table = apss_ipq5424_match_table,
>> +	},
>> +};
>> +
>> +module_platform_driver(apss_ipq5424_driver);
>> +
>> +MODULE_DESCRIPTION("QCOM APSS IPQ5424 CLK Driver");
>> +MODULE_LICENSE("GPL v2");
> 
> Please don't skip running 'checkpatch'.

Infact ran it with --strict as well. But thought "GPL V2" was correct
and let it. Anyways will change.

Regards,
  Sricharan

