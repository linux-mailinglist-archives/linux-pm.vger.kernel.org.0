Return-Path: <linux-pm+bounces-11991-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C785C94BBBE
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 12:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B9C281A66
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C25918A950;
	Thu,  8 Aug 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LtOUdPAh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C213A257;
	Thu,  8 Aug 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114572; cv=none; b=VIKdZQIHEI9Ov3mkzUFIH+P/RBngDETUDYNHRwX3HZXqxQ+WLxI6pN2jG5jne13RKlM7BnPVKOh2k0qUKKu50CiOKDIxMXG1v2w36XDDVifhwjLlJFGCG0BTAD8olRFKJRnaXqTUHYyhzVpnHcCR0Q1L7jwESOAyuDUmxLoa77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114572; c=relaxed/simple;
	bh=TeKQmd5lTHdo9nK0gbzefeQgA5HbBNzXFovVrBMQFmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hoRFDa1nAZhZVDRKBces1ft/LlKrSnyp72NI1kvBhXONjVo0HfbPjCFyx0k1k/PQ7CPBVRH60IoTWgtcoqbSOMLJ3iRIICDE+xGxx5dMjSFjxB10MwW+iCLFzW4MIQS2LPeuC/61SNKEBhuk3rWi6eWCFg8cEQGwiPb/ROPNWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LtOUdPAh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4780nbcU020984;
	Thu, 8 Aug 2024 10:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i3JQwwIVB+7xMCg3ydKuLW2vtns05Zod+nZsJTFL65M=; b=LtOUdPAhCjtzfLn1
	haaKSJG1yG9xy5CjYOEhjqDxLRCjwBC2fqn4HnMlEFuSPiUKBuw0TUiuNR86zdup
	2M+rdaDu5hu4OPwcdBLNDQFit7jxwctF+iCokf3lYSDaoFErdlu7a8ixF9gciPSH
	DGo81oefKOTmyPZE4MRg0OLCWfpTliL39pIWY9XpAZvtUVD572eGXXlYaUpSn0pN
	dmblwtWbq2wX+mdhjoGERTwVd9y8oSOQx1ISMhM6vgttTo3jXw51sPM2w9Ri7+Vo
	IX/UaiVBqSnKs9lDc0BV4mBZi3rh7aKsyQdMVAMt5qBet16y07Icr/g0D/221V05
	K4C5vw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40v79jb570-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 10:55:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 478AtuhR026103
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Aug 2024 10:55:56 GMT
Received: from [10.204.101.50] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 8 Aug 2024
 03:55:51 -0700
Message-ID: <36de7f9c-701f-6650-468b-bf07453e2e21@quicinc.com>
Date: Thu, 8 Aug 2024 16:25:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] PM: domains: add device managed version of
 dev_pm_domain_attach|detach_list()
Content-Language: en-US
To: Dhruva Gole <d-gole@ti.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "Len
 Brown" <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio"
	<konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf
 Hansson <ulf.hansson@linaro.org>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com>
 <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
 <20240808104130.3lehlvkcprag2md6@lcpd911>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20240808104130.3lehlvkcprag2md6@lcpd911>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V80uN_qPRXJWl7nKg850ChAMZfcTJgEG
X-Proofpoint-ORIG-GUID: V80uN_qPRXJWl7nKg850ChAMZfcTJgEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408080078



On 8/8/2024 4:11 PM, Dhruva Gole wrote:
> On Aug 07, 2024 at 12:45:46 +0530, Dikshita Agarwal wrote:
>> Add the devres-enabled version of dev_pm_domain_attach|detach_list.
>> If client drivers use devm_pm_domain_attach_list() to attach the
>> PM domains, devm_pm_domain_detach_list() will be invoked implicitly
>> during remove phase.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
>>  drivers/base/power/common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   | 13 +++++++++++++
>>  2 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
>> index 327d168..729d6c2 100644
>> --- a/drivers/base/power/common.c
>> +++ b/drivers/base/power/common.c
>> @@ -277,6 +277,50 @@ int dev_pm_domain_attach_list(struct device *dev,
>>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
>>  
>>  /**
>> + * devm_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
>> + * @_list: The list of PM domains to detach.
>> + *
>> + * This function reverse the actions from devm_pm_domain_attach_list().
>> + * it will be invoked during the remove phase from drivers implicitly if driver
>> + * uses devm_pm_domain_attach_list() to attach the PM domains.
>> + */
>> +void devm_pm_domain_detach_list(void *_list)
>> +{
>> +	struct dev_pm_domain_list *list = _list;
>> +
>> +	dev_pm_domain_detach_list(list);
>> +}
>> +EXPORT_SYMBOL_GPL(devm_pm_domain_detach_list);
>> +
>> +/**
>> + * devm_pm_domain_attach_list - devres-enabled version of dev_pm_domain_attach_list
>> + * @dev: The device used to lookup the PM domains for.
>> + * @data: The data used for attaching to the PM domains.
>> + * @list: An out-parameter with an allocated list of attached PM domains.
>> + *
>> + * NOTE: this will also handle calling devm_pm_domain_detach_list() for
>> + * you during remove phase.
>> + *
>> + * Returns the number of attached PM domains or a negative error code in case of
>> + * a failure.
>> + */
>> +int devm_pm_domain_attach_list(struct device *dev,
>> +			       const struct dev_pm_domain_attach_data *data,
>> +			       struct dev_pm_domain_list **list)
>> +{
>> +	int ret, num_pds = 0;
> 
> Do we require this =0? In the very next line you're initing this anyway.
> 
That's correct, will fix this. Thanks.
>> +
>> +	num_pds = dev_pm_domain_attach_list(dev, data, list);
>> +
>> +	ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, *list);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return num_pds;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_pm_domain_attach_list);
>> +
>> +/**
>>   * dev_pm_domain_detach - Detach a device from its PM domain.
>>   * @dev: Device to detach.
>>   * @power_off: Used to indicate whether we should power off the device.
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 772d328..efd517017 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -450,8 +450,12 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
>>  int dev_pm_domain_attach_list(struct device *dev,
>>  			      const struct dev_pm_domain_attach_data *data,
>>  			      struct dev_pm_domain_list **list);
>> +int devm_pm_domain_attach_list(struct device *dev,
>> +			       const struct dev_pm_domain_attach_data *data,
>> +			       struct dev_pm_domain_list **list);
>>  void dev_pm_domain_detach(struct device *dev, bool power_off);
>>  void dev_pm_domain_detach_list(struct dev_pm_domain_list *list);
>> +void devm_pm_domain_detach_list(void *list);
> 
> Why not just call it dev_pm_domain_list *list? Why make it void? I am a
> bit confused.
> 
This comment is not clear to me, could you pls elaborate?
This is just a stub API like others in this file for !CONFIG_PM case.

Thanks,
Dikshita
> 

