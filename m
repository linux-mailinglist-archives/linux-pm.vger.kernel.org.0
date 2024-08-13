Return-Path: <linux-pm+bounces-12147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3E29504DB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501B81C21E5E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 12:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C5199392;
	Tue, 13 Aug 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VIWR6hhf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BD19925A;
	Tue, 13 Aug 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551849; cv=none; b=XFn30efYp7hdcPaooNNZ9UMIScznl6HVMjr/OqVwtt13goAGvgu4SWnuLekgnqMeOm9TmlMQb15aPBoOWiRC83ThLrdWaZXcPFfUVqzkfcBxjkOUcjHXjY8m4YKr4ItjrJWrj43/Vr9yII2qtl8D/ewGmkSg9udjNw/Y0HPUZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551849; c=relaxed/simple;
	bh=1ZDxptwVrneNxu4p5SwrDiUdmUGr3CxbvQsLYPw5+Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G+e72f6H5pG3FJNXwisXX6OLiQoLuaGQh5yGJstSQVJ/oAlUjYRKeuYou6fH2w9VcpjSfWVWZM634DFdDTY6OS7T9KWxiiQXafrxwgXgVy+F49RHZHWZUv28riLA51JJ836jpsHLdIOoKrBt3XG+g0JdHRc6lyGooF8bVs6SuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VIWR6hhf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DCC9Wq008197;
	Tue, 13 Aug 2024 12:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hZj+vhJGdhHYsx/eUIiC0gHPR7bA9/LNX09lcGIyuvU=; b=VIWR6hhf6O4PnSLG
	tySLUgG1PimLKg58LpMtdQEJv1icH8wui6Hrufykd2sqzJjsFeI/8KBhpS3x9CMZ
	QX8IMmugRI29ode0FG7229HW+g5CG6K4KNwpkbBXDZXwxo8thOMtNWUqS1tqbQuK
	7eOP6/0if3GDqX0QKiNagg9Mjxbyu9+cgby9rSHnU0HZfPN4Q7h9B4Ow0GV2f3Q3
	wIUZSnDt8vL9vM2Dig/cyZgsGJiC/CGiKguUi1trioIS+hCZQUroIuqUyUBLGrxk
	O3vnnVLaWVDOTqUv52QGeARtd9w14HRseSXYOfaYQEEatBU7fWI5cf83Sjk5WGcu
	G/42xg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x15e7p8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 12:23:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DCNwSK031917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 12:23:58 GMT
Received: from [10.216.47.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 05:23:53 -0700
Message-ID: <efb17431-82a6-bcc9-cade-896d0dca958e@quicinc.com>
Date: Tue, 13 Aug 2024 17:53:50 +0530
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
To: Ulf Hansson <ulf.hansson@linaro.org>
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
        Bryan
 O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com>
 <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
 <CAPDyKFpUMmveKQ2Pi33VwcvG9tsMQHEcAg88icf7v9mzzm+k4Q@mail.gmail.com>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <CAPDyKFpUMmveKQ2Pi33VwcvG9tsMQHEcAg88icf7v9mzzm+k4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aiNbY4KiByPubnaFkBrASBjcMuFkfl35
X-Proofpoint-ORIG-GUID: aiNbY4KiByPubnaFkBrASBjcMuFkfl35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_04,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130089



On 8/13/2024 4:22 PM, Ulf Hansson wrote:
> On Wed, 7 Aug 2024 at 09:16, Dikshita Agarwal <quic_dikshita@quicinc.com> wrote:
>>
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
>> +       struct dev_pm_domain_list *list = _list;
>> +
>> +       dev_pm_domain_detach_list(list);
>> +}
>> +EXPORT_SYMBOL_GPL(devm_pm_domain_detach_list);
> 
> I think this function should be internal and hence made static -
> unless there is a good reason to export it?
Yeah, it should be static and no need of exporting it.
Will make the changes.
> 
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
>> +                              const struct dev_pm_domain_attach_data *data,
>> +                              struct dev_pm_domain_list **list)
>> +{
>> +       int ret, num_pds = 0;
> 
> There is no need to initialize num_pds to 0 here, as the below calls
> take care of it.
> 
Right, will be fixed in next revision.
>> +
>> +       num_pds = dev_pm_domain_attach_list(dev, data, list);
>> +
> 
> We should add a check if num_pds is zero here, as in that case there
> is no reason to add a devres callback for it.
> 
Sure, will add the below check.
if (!num_pds)
    return 0;

Thanks,
Dikshita
>> +       ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, *list);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return num_pds;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_pm_domain_attach_list);
> 
> [...]
> 
> Kind regards
> Uffe

