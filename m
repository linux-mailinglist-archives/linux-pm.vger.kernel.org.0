Return-Path: <linux-pm+bounces-8465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC848D6115
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 13:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF9B23C7F
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC01581EB;
	Fri, 31 May 2024 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g93vQSf9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74215748F;
	Fri, 31 May 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156646; cv=none; b=fAg6LQj+TUVkBRS1gz8FyOKTWsii7bh3vwU1xFi9RuBP2zBhmFHfIOF1iTHF3CYjX+Zb2LQiXR8VZsXSCqlQaQ7arsRar6FDNJ6FFrjg+BEGxSEMP7WJD7ycOFPpuRP3rLwJ23/zALRL0hyzwKUt+5QW/FyWZEnw3uATSMuc0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156646; c=relaxed/simple;
	bh=jK6YYEy/7Igoejw2c2fzU6CRCWo7OrhStRnGrEA4778=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YpEWbaZA5gAAHJ+JsLfNAAfd2TXb8BBhzVMwV4deM+ElvaIio4eUmFq/1y2JttP6S4BoCO7/neq/g4X22IWKI14fXBO2yVtrP9i4AQvEpC5ZHigX29pJM8aT/78R+BTqxEIJZDqLpYv6iTwk+//AWKiGW0C7GP8WlBQ674aRclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g93vQSf9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V8lHAr006252;
	Fri, 31 May 2024 11:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QLXCf+uuiqWX0T+eAEfBRmO10Kpgb3O9apvffaCdJmA=; b=g93vQSf9dgKTHatG
	Am/8jpuemv3UW6BDgRKTST76WOniM8PKa3t1AgfRk0Xdc++DThS/2XEGkI0xIvZQ
	U+mrbpRfA7MUasPTZwePgCKfsJ5q7DlWSU29P+75RVwkrJmRjKPi8hrWc49OIKsN
	2UB1b05HbTpCraKFhDk2S88QxwaLBJ1vpDiHteIn2gPITKbEaI80qDo9A0vQrJmK
	KmeJ5vEppgX3Gcrr+eL/9ReWG6cQ8ceNQzD15uZhcU+o0T3pVB9ZjV53k/kfaBlO
	q6NYTFGsXFq5bvX4Dxs/ZiVthmDMK2Fw0Y2EaaT5jW44cu/4teoEbAQNNd7F4e93
	XbyXQA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2hembv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 11:57:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VBvA7b010803
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 11:57:10 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 04:56:55 -0700
Message-ID: <1df48a42-3b4e-4eb4-971b-cd4be001ba27@quicinc.com>
Date: Fri, 31 May 2024 17:26:52 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode on V6
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia
	<quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Ulf
 Hansson" <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown
	<len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Andy
 Gross" <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-6-quic_jkona@quicinc.com>
 <5c78ad52-524b-4ad7-b149-0e7252abc2ee@linaro.org>
 <b96ef82c-4033-43e0-9c1e-347ffb500751@quicinc.com>
 <a522f25f-bb38-4ae1-8f13-8e56934e5ef5@linaro.org>
 <dbd1b86c-7b5f-4b92-ab1f-fecfe1486cfc@quicinc.com>
 <621dbaaa-6b86-45b5-988e-a6d9c39b13d7@linaro.org>
 <d36c1163-a3f0-4034-a430-91986e5bbce8@linaro.org>
 <ef194e5c-f136-4dba-bfe0-2c6439892e34@linaro.org>
 <d2e55523-f8fd-4cbe-909c-57de241107e8@linaro.org>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <d2e55523-f8fd-4cbe-909c-57de241107e8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BLsjDIiK3CsLckqGqMKAgMBG7h5L6Pat
X-Proofpoint-ORIG-GUID: BLsjDIiK3CsLckqGqMKAgMBG7h5L6Pat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=921 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310088



On 5/10/2024 6:31 PM, Bryan O'Donoghue wrote:
> On 01/05/2024 10:14, Bryan O'Donoghue wrote:
>> On 30/04/2024 21:01, Konrad Dybcio wrote:
>>> On 24.04.2024 11:50 AM, Bryan O'Donoghue wrote:
>>>> On 24/04/2024 10:45, Jagadeesh Kona wrote:
>>>>>
>>>>> Thanks Bryan for testing this series. Can you please confirm if 
>>>>> this issue is observed in every run or only seen during the first 
>>>>> run? Also please let me know on which platform this issue is observed?
>>>>>
>>>>> Thanks,
>>>>> Jagadeesh
>>>>
>>>> rb5/sm8250
>>>>
>>>> My observation was on a previous _boot_ the stuttering was worse. 
>>>> There is in the video capture three times that I count where the 
>>>> video halts briefly, I guess we need to vote or set an OPP so the 
>>>> firmware knows not to power-collapse quite so aggressively.
>>>
>>> We seem to be having some qualcomm-wide variance on perf/pwr usage on 
>>> some
>>> odd boots.. Any chance you could try like 5 times and see if it was a 
>>> fluke?
>>>
>>> Konrad
>>
>> Sure.
>>
>> The first time I tried it, it was much worse.
>>
>> The second time, captured in the video is only noticeable because I 
>> was *looking* for this specific error i.e. I don't think I would have 
>> noticed the error on the second run, had I not seen the first run.
>>
>> I'll find some time to do 5x with and 5x without.
>>
>> ---
>> bod
> 
> ping bod please remember to do this thanks
> 

Hi Bryan, Could you please let me know if you got a chance to check the 
above? Thank you!

Thanks,
Jagadeesh

