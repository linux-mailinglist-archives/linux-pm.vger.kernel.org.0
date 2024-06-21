Return-Path: <linux-pm+bounces-9751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF939912157
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 11:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BDA28A6B7
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 09:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D416F84C;
	Fri, 21 Jun 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EHIAoa68"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A516E87B;
	Fri, 21 Jun 2024 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963756; cv=none; b=TkXjwfDnIH7Wl1ph5zTMOzfWUhhEeqtgTaKb8x1B+rZwILdrc9Rpv9Pv0WM6JKsGGRuUXbx72wSqaFkzYXeNTTWRFnMmtYXMXQn+2LUPcYdF9ee88f7c36lvGeNwldeiwluaL6QwYS4C9ICm/LogunNqL5u07VRtOjnHTARik9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963756; c=relaxed/simple;
	bh=2uvIOYm/6Txt3aNQXCJHHxUsOvqbKc3bO0kcqt5t4o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dQ9E/SoiRcW5i0q0Ljn4lkMtAdZ0MKJm3qw5dAomH5Ajbvn/CUtUtCvsdB/MoHtc1Czv2qOFI8zQzxgwojjPV55rfrP7sZ5hARFMlxph0gUE6i+3knVPtt8ak75WYnv+F0WrMfDemXXFI69Gbl2BnmquXYc0M6InSi0leAfZZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EHIAoa68; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L9oWQO006674;
	Fri, 21 Jun 2024 09:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C7r0iU1QgDXiHzLeAODaeM49VGbxfg8Jjfz3e4wQM0g=; b=EHIAoa68lEPLqNCN
	62sdCoH09X+OrSriYqZvh66c8566fiYsymgi5imHRKbs0Np+70f9GK/DLYrOqGgK
	xCCaGszrShk+WPGRXAL5/5gzuZssVzER4yAsipQeItPQvNRQz+frp2yLBqapfutx
	czFtCjo+sDfISAoRR69SPU1lr4tmS1xEMJLzbssJj/0boTPI5MLESfFZvTJH94aZ
	dHT9jkJwbJjW/c49yKpbuqaco2UyeIcxXJy5OhNcv4EvcWLss2pcbPiSmuDxHpCT
	nGW/dk4UkOV3BWBwMyiGieFU1wiffqkNQIWNT6Yz0La0oWz22tTQgCZ8Pya7KWv+
	rT/lgA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrkkj8p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 09:55:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45L9tgRM002205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 09:55:42 GMT
Received: from [10.217.216.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Jun
 2024 02:55:34 -0700
Message-ID: <7c0ca78a-51ea-4421-af95-46f91d1fdbb9@quicinc.com>
Date: Fri, 21 Jun 2024 15:24:21 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/5] clk: qcom: gdsc: Add set and get hwmode callbacks
 to switch GDSC mode
To: Caleb Connolly <caleb.connolly@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy
 Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240619141413.7983-1-quic_jkona@quicinc.com>
 <20240619141413.7983-4-quic_jkona@quicinc.com>
 <18c0b683-97c8-4d53-9852-840a21c11d9a@linaro.org>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <18c0b683-97c8-4d53-9852-840a21c11d9a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lVY92_RC4gy1AddugClrJViwzS1DjiS4
X-Proofpoint-ORIG-GUID: lVY92_RC4gy1AddugClrJViwzS1DjiS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210073



On 6/20/2024 3:40 AM, Caleb Connolly wrote:
> Hi Jagadeesh,
> 
> Sorry, some grammar nitpicks.
> 
> On 19/06/2024 16:14, Jagadeesh Kona wrote:
>> Some GDSC client drivers require the GDSC mode to be switched dynamically
>> to HW mode at runtime to gain the power benefits. Typically such client
>> drivers require the GDSC to be brought up in SW mode initially to enable
>> the required dependent clocks and configure the hardware to proper state.
>> Once initial hardware set up is done, they switch the GDSC to HW mode to
>> save power. At the end of usecase, they switch the GDSC back to SW mode
>> and disable the GDSC.
>>
>> Introduce HW_CTRL_TRIGGER flag to register the set_hwmode_dev and
>> get_hwmode_dev callbacks for GDSC's whose respective client drivers
>> require the GDSC mode to be switched dynamically at runtime using
>> dev_pm_genpd_set_hwmode() API.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/clk/qcom/gdsc.c | 42 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/gdsc.h |  1 +
>>   2 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index df9618ab7eea..6acc7af82255 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -363,6 +363,44 @@ static int gdsc_disable(struct generic_pm_domain 
>> *domain)
>>       return 0;
>>   }
>> +static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct 
>> device *dev, bool mode)
>> +{
>> +    struct gdsc *sc = domain_to_gdsc(domain);
>> +    int ret;
>> +
>> +    ret = gdsc_hwctrl(sc, mode);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /*
>> +     * Wait for the GDSC to go through a power down and
>> +     * up cycle. In case SW/FW end up polling status
>> +     * bits for the gdsc before the power cycle is completed
>> +     * it might read the status wrongly.
> 
> If we poll the status register before the power cycle is finished we 
> might read incorrect values.

Thanks Caleb for your review. Sure, will take care of these comments in
next series.

Thanks,
Jagadeesh

>> +     */
>> +    udelay(1);
>> +
>> +    /*
>> +     * When GDSC is switched to HW mode, HW can disable the GDSC.
> The GDSC
>> +     * When GDSC is switched back to SW mode, the GDSC will be enabled
> The GDSC
>> +     * again, hence need to poll for GDSC to complete the power 
>> uphence we need to poll
> 
> Kind regards,
>> +     */
>> +    if (!mode)
>> +        return gdsc_poll_status(sc, GDSC_ON);
>> +
>> +    return 0;
>> +}
>> +
>> +static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct 
>> device *dev)
>> +{
>> +    struct gdsc *sc = domain_to_gdsc(domain);
>> +    u32 val;
>> +
>> +    regmap_read(sc->regmap, sc->gdscr, &val);
>> +
>> +    return !!(val & HW_CONTROL_MASK);
>> +}
>> +
>>   static int gdsc_init(struct gdsc *sc)
>>   {
>>       u32 mask, val;
>> @@ -451,6 +489,10 @@ static int gdsc_init(struct gdsc *sc)
>>           sc->pd.power_off = gdsc_disable;
>>       if (!sc->pd.power_on)
>>           sc->pd.power_on = gdsc_enable;
>> +    if (sc->flags & HW_CTRL_TRIGGER) {
>> +        sc->pd.set_hwmode_dev = gdsc_set_hwmode;
>> +        sc->pd.get_hwmode_dev = gdsc_get_hwmode;
>> +    }
>>       ret = pm_genpd_init(&sc->pd, NULL, !on);
>>       if (ret)
>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>> index 803512688336..1e2779b823d1 100644
>> --- a/drivers/clk/qcom/gdsc.h
>> +++ b/drivers/clk/qcom/gdsc.h
>> @@ -67,6 +67,7 @@ struct gdsc {
>>   #define ALWAYS_ON    BIT(6)
>>   #define RETAIN_FF_ENABLE    BIT(7)
>>   #define NO_RET_PERIPH    BIT(8)
>> +#define HW_CTRL_TRIGGER    BIT(9)
>>       struct reset_controller_dev    *rcdev;
>>       unsigned int            *resets;
>>       unsigned int            reset_count;
> 

