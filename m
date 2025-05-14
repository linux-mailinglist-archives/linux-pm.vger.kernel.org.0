Return-Path: <linux-pm+bounces-27112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC85EAB610C
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 05:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789204674D1
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 03:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24126156C69;
	Wed, 14 May 2025 03:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mQFl2rLD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F621B6CF1
	for <linux-pm@vger.kernel.org>; Wed, 14 May 2025 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747191679; cv=none; b=SouvA+1IzKTPlylABfJnIvS+Zt3GDzDc3PFBj4B5uaOvVEoQLioZYnpMkwvW1vRprPXa/Yz+pH+Nbk8fykhDYzLAksUxRmOmKoPh/X/BZgwEUIe2MjFbUWjFzt/PXFfa1169U0numDHmZ4jrQogAOseZun5/jbGgSbl94CRLEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747191679; c=relaxed/simple;
	bh=q+2sQbEnkkz6ubrx/V3Keq5TtZ78G6typl9G3jGZZf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H71h2Z/3X8UJ1XYI46JXyWBqcSw50Z07cP1UgnmAbepEaEnRWnAX2nXLz1bwWmkBAFOQqKzlYsk354Zuf36y7/Tad+kmfioVjaSW3h0Yomnn8Z46a0JviNmP9h0uJH/oYPaMvLpLK9n8hX4xg86qtE1BbbFtmX1tUQ+02fjg/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mQFl2rLD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DIRebn006109;
	Wed, 14 May 2025 03:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jtLmbjfkE+5SV8op12luh0aM0bpVzDFyDslM1fh17jg=; b=mQFl2rLDppTI2EC+
	eEVydKkKzk312Swt0mVBvZVj+L6QTYAkGFB5T5nUJnE46LxPtaXRqkuMW580uR4M
	wvrKz9injYBThrhlLkcOB/9JL7BDyd5hM+6pfVgo72AYatitYmlX7sNs7dxXtnf3
	BSRDp3f30uXbS6dXpuJSaYoGUT9bmDwQ/bOrfd6ZplURnwFQZGGI+l2feKPi0+Ht
	gcnMOgPrrAZy+m6zAAyCcmaG3Y0DfLpnQC9EClXvSDozD31iLiJqBK9D9JXbTlja
	qJjStBtR04WXf47LkLpfS7bxZfeFODBb6vzoyt7OW+9xoKOuLUkmECLHWTC2oAGf
	8aDKbA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcns4v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 03:01:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54E317Sk002083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 03:01:07 GMT
Received: from [10.216.1.117] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 May
 2025 20:01:02 -0700
Message-ID: <5cb72bb7-7393-6d3f-d003-e20a21bd607f@quicinc.com>
Date: Wed, 14 May 2025 08:30:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mmc: sdhc: Add PM QoS support for mmc driver
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Madhusudhan Sana
	<quic_msana@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: <quic_cang@quicinc.com>, <quic_nguyenb@quicinc.com>,
        <quic_bhaskarv@quicinc.com>, <quic_mapa@quicinc.com>,
        <quic_narepall@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_sachgupt@quicinc.com>, <quic_sartgarg@quicinc.com>,
        Linux PM list
	<linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20241101024421.26679-1-quic_msana@quicinc.com>
 <1e47ee3e-7439-4dc4-aef6-0ad2f82ee341@intel.com>
 <CAPDyKFrku7pEPz0xNbtJetK1XhUmhgsN9Sx9Ea8=tNNhTkxa7w@mail.gmail.com>
From: Ram Prakash Gupta <quic_rampraka@quicinc.com>
In-Reply-To: <CAPDyKFrku7pEPz0xNbtJetK1XhUmhgsN9Sx9Ea8=tNNhTkxa7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EyvgPlTf5AOUxv2B4W5dwsg1dpQdmhz2
X-Proofpoint-ORIG-GUID: EyvgPlTf5AOUxv2B4W5dwsg1dpQdmhz2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAyMyBTYWx0ZWRfX/obH56WET+rg
 I/+HfZ43K5DAIG+lq4je8lRcVgH4w7WT5jwQY3tqku63Wg+bBIxZX9OQX0WbPfe+Hw3NuGyly54
 vewkrWhXGsfOI5xY8ug8I1vPSXhU7bZRmudJSbYIXBgQSCn1563Q7vvHRruySAWzc8R1GQaBM4M
 ZHN1vCq0NG6EY887Ye+NF7ykgJOr5uLQkSSuON0e6f9KAQ6F7TsD/eaObKIfSZrki6uUwFLEHRq
 U8bUJ3JS0YybvrOvPWHpEBpBg8/gOmIIJFwhgIqnpavGFV9H9YRYMejP/Tt3Bb5Tdmd419rU/DS
 CzVchs7d1XvfDvT0MFp0SyZg3glUoVsw5NEJDQiYGrFdp4uufeYIBRAc4jfiT1vwPIHrKHkiXgP
 TaO1wJcidh/WwzXGUBG6hGIgiKTTiCG5hkR0LPLpadlOC+/rjyC1ZjMCFiuozrL9yaFfZ0wH
X-Authority-Analysis: v=2.4 cv=Gp9C+l1C c=1 sm=1 tr=0 ts=68240774 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=rkOx34ob1f9j6TDfATwA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140023

Thanks a lot Adrian and Uffe for your review and comment. The Qualcomm
engineer who initiated this work, is no longer working on this and I am
taking up the responsibility to continue on this work.


On 11/12/2024 8:38 PM, Ulf Hansson wrote:
> On Fri, 8 Nov 2024 at 15:43, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 1/11/24 04:44, Madhusudhan Sana wrote:
>>> Register mmc driver to CPU latency PM QoS framework to improve
>>> mmc device io performance.
>> Not sure host controller drivers should really be manipulating
>> cpu_latency_qos in order to squeeze a bit more I/O performance.
> I fully agree, this type of boosting doesn't belong in a low level
> storage driver, as it is simply not capable of understanding the
> use-case. Note that the cpu_latency_qos can also be managed from
> user-space.
>
> Moreover, I guess there are use cases where it would make sense to
> have some in-kernel governor to boost too for some conditions. But as
> far as I can tell, we don't have a common way to do this, but rather
> platform specific hacks via devfreq drivers for example.
>
> Kind regards
> Uffe

Hi Uffe/Adrian,

In my opinion, many use case owners might not opt to control qos and
may not use qos to gain better performance, and similar work was done
in other driver eg.
https://patchwork.kernel.org/project/linux-mediatek/patch/20231219123706.6463-2-quic_mnaresh@quicinc.com/

Earlier this was done in Qualcomm specific file but later community
suggested to make it into core driver, so that it applies for everyone.
Having this thought in mind, here also this was made it into core driver.
If this still doesn't fit here in mmc context, would like to refactor and
move into Qualcomm specific file sdhci-msm.c please share your opinion.

Thanks,
Ram

>
>>> Signed-off-by: Madhusudhan Sana <quic_msana@quicinc.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 47 ++++++++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci.h |  4 ++++
>>>  2 files changed, 51 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index f4a7733a8ad2..ffcc9544a3df 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -359,6 +359,46 @@ static void sdhci_config_dma(struct sdhci_host *host)
>>>       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>>  }
>>>
>>> +/*
>>> + * sdhci_pm_qos_init - initialize PM QoS request
>>> + */
>>> +void sdhci_pm_qos_init(struct sdhci_host *host)
>>> +{
>>> +     if (host->pm_qos_enable)
>>> +             return;
>>> +
>>> +     cpu_latency_qos_add_request(&host->pm_qos_req, PM_QOS_DEFAULT_VALUE);
>>> +
>>> +     if (cpu_latency_qos_request_active(&host->pm_qos_req))
>>> +             host->pm_qos_enable = true;
>>> +}
>>> +
>>> +/*
>>> + * sdhci_pm_qos_exit - remove request from PM QoS
>>> + */
>>> +void sdhci_pm_qos_exit(struct sdhci_host *host)
>>> +{
>>> +     if (!host->pm_qos_enable)
>>> +             return;
>>> +
>>> +     cpu_latency_qos_remove_request(&host->pm_qos_req);
>>> +     host->pm_qos_enable = false;
>>> +}
>>> +
>>> +/*
>>> + * sdhci_pm_qos_update - update PM QoS request
>>> + * @on - True, vote for perf PM QoS mode
>>> + *     - False, vote for power save mode.
>>> + */
>>> +static void sdhci_pm_qos_update(struct sdhci_host *host, bool on)
>>> +{
>>> +     if (!host->pm_qos_enable)
>>> +             return;
>>> +
>>> +     cpu_latency_qos_update_request(&host->pm_qos_req, on ?
>>> +                                             0 : PM_QOS_DEFAULT_VALUE);
>>> +}
>>> +
>>>  static void sdhci_init(struct sdhci_host *host, int soft)
>>>  {
>>>       struct mmc_host *mmc = host->mmc;
>>> @@ -384,6 +424,9 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>>>               host->reinit_uhs = true;
>>>               mmc->ops->set_ios(mmc, &mmc->ios);
>>>       }
>>> +
>>> +     sdhci_pm_qos_init(host);
>>> +     sdhci_pm_qos_update(host, true);
>>>  }
>>>
>>>  static void sdhci_reinit(struct sdhci_host *host)
>>> @@ -2072,6 +2115,7 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>>
>>>       clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>>>       sdhci_enable_clk(host, clk);
>>> +     sdhci_pm_qos_update(host, true);
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_set_clock);
>>>
>>> @@ -3811,6 +3855,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
>>>               sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
>>>               free_irq(host->irq, host);
>>>       }
>>> +     sdhci_pm_qos_update(host, false);
>>>
>>>       return 0;
>>>  }
>>> @@ -3873,6 +3918,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>>>       spin_lock_irqsave(&host->lock, flags);
>>>       host->runtime_suspended = true;
>>>       spin_unlock_irqrestore(&host->lock, flags);
>>> +     sdhci_pm_qos_update(host, false);
>>>
>>>       return 0;
>>>  }
>>> @@ -4987,6 +5033,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>>>       if (host->use_external_dma)
>>>               sdhci_external_dma_release(host);
>>>
>>> +     sdhci_pm_qos_exit(host);
>>>       host->adma_table = NULL;
>>>       host->align_buffer = NULL;
>>>  }
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index cd0e35a80542..685036ed888b 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/io.h>
>>>  #include <linux/leds.h>
>>>  #include <linux/interrupt.h>
>>> +#include <linux/devfreq.h>
>>>
>>>  #include <linux/mmc/host.h>
>>>
>>> @@ -675,6 +676,9 @@ struct sdhci_host {
>>>
>>>       u64                     data_timeout;
>>>
>>> +     struct pm_qos_request pm_qos_req;       /* PM QoS request handle */
>>> +     bool pm_qos_enable;                     /* flag to check PM QoS is enable */
>>> +
>>>       unsigned long private[] ____cacheline_aligned;
>>>  };
>>>

