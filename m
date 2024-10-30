Return-Path: <linux-pm+bounces-16724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B329B635C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 13:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954421C20CCC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005A51E8851;
	Wed, 30 Oct 2024 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hptq/L4l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7921E47AC;
	Wed, 30 Oct 2024 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292669; cv=none; b=qmMC6Mo8HWQOs538aCZsXJxlest6S5sLxGQLty8hB3dhTdBVTD7WXUO9CfvQRJOarvhtlAgBw006/C+nk53ItbybXq8ZsQrnibzew1g06+EoGF30sK6/fzkyCgyXjicTG1hHOknEbjEOXBOj4UobLOW55MWjCoR20eDAGQHd990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292669; c=relaxed/simple;
	bh=t0izBSuJJDUdOBaC7dWb05wbehQm0Y3vnx74I97Rtok=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UcJdsS9ru8UctS9V59aK4a/IIZcsR74m3Ihjtq+NtC1BMoTnOmbfk5VfB1GCw9fn/uLlSqkU9eRIq1YgsflPhUuyUt+DwxC4pGT7oyYmb2vRR20i28D7cLUdn0YaPHr7m1i5FusGvCNAWp0I6ZcxNBr/THW9xVCQ+CLTLThUrYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hptq/L4l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UBDT9L008803;
	Wed, 30 Oct 2024 12:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LxOfEoxJrpdJfWhALuCidnuHpCbc4UMX4i9V24oLUBI=; b=hptq/L4lQ4yD3X0f
	fjnbcamXtEISJU2eQX6JofH3dbOw59mYGwVslMzQfu34CDWQsT4o6WD8RKSsGhJq
	4+/0M1sDVlFlwyZU67jTjeV1zBo2kCxN5cMiEhTpQcwCHiCHkOmoDUWH3k7Hy9XK
	w/ft9GJCiuC5gN5TQhhHkpwvF3H2caLBoBtZf3HzIrqfPagK/1OEplG2CUGtITBz
	HTDnYmZQ2EUQJuvvd4I6owK2TgCPDnhngpMyXkVEFhmu+uxof4xM//MkH4+lfYwi
	TZmxHG19bqaBTF4O8+jDa4/6E/uMtEE9ZtelbNw5Y2wxbhBJ0saeoAmiIaU0xXwq
	WcORWA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42jxa8bu6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:50:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UCorHS005813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 12:50:53 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 30 Oct
 2024 05:50:46 -0700
Message-ID: <58932d61-0aab-7738-97a1-2eda3bcda0ec@quicinc.com>
Date: Wed, 30 Oct 2024 18:20:43 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 3/4] pmdomain: core: Fix debugfs node creation failure
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <jassisinghbrar@gmail.com>, <dmitry.baryshkov@linaro.org>,
        <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <johan@kernel.org>,
        <konradybcio@kernel.org>, <linux-pm@vger.kernel.org>,
        <tstrudel@google.com>, <rafael@kernel.org>,
        Johan Hovold
	<johan+linaro@kernel.org>
References: <20241023102148.1698910-1-quic_sibis@quicinc.com>
 <20241023102148.1698910-4-quic_sibis@quicinc.com>
 <CAPDyKFrVopgySevDVZtkZdHBBxiiVNh73VOXLqaHfXs9MyiZ+w@mail.gmail.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <CAPDyKFrVopgySevDVZtkZdHBBxiiVNh73VOXLqaHfXs9MyiZ+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VvKhigREobC6oWICJY78p9ho5q6T5YYT
X-Proofpoint-ORIG-GUID: VvKhigREobC6oWICJY78p9ho5q6T5YYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300101



On 10/28/24 18:58, Ulf Hansson wrote:
> On Wed, 23 Oct 2024 at 12:22, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>>
>> The domain attributes returned by the perf protocol can end up
>> reporting identical names across domains, resulting in debugfs
>> node creation failure. Fix this failure by ensuring that pm domains
>> get a unique name using ida in pm_genpd_init.
>>
>> Logs: [X1E reports 'NCC' for all its scmi perf domains]
>> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
>> debugfs: Directory 'NCC' with parent 'pm_genpd' already present!
>>
>> Reported-by: Johan Hovold <johan+linaro@kernel.org>
>> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
>> Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
>> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v3:
>> * Update device names only when a name collision occurs [Dmitry/Ulf]
>> * Drop Johan's T-b from "fix debugfs node creation failure"
>>
>>   drivers/pmdomain/core.c   | 65 ++++++++++++++++++++++++++++++---------
>>   include/linux/pm_domain.h |  1 +
>>   2 files changed, 51 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> index 76490f0bf1e2..756ed0975788 100644
>> --- a/drivers/pmdomain/core.c
>> +++ b/drivers/pmdomain/core.c
>> @@ -7,6 +7,7 @@
>>   #define pr_fmt(fmt) "PM: " fmt
>>
>>   #include <linux/delay.h>
>> +#include <linux/idr.h>
>>   #include <linux/kernel.h>
>>   #include <linux/io.h>
>>   #include <linux/platform_device.h>
>> @@ -23,6 +24,9 @@
>>   #include <linux/cpu.h>
>>   #include <linux/debugfs.h>
>>
>> +/* Provides a unique ID for each genpd device */
>> +static DEFINE_IDA(genpd_ida);
>> +
>>   #define GENPD_RETRY_MAX_MS     250             /* Approximate */
>>
>>   #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)         \
>> @@ -189,7 +193,7 @@ static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
>>
>>          if (ret)
>>                  dev_warn_once(dev, "PM domain %s will not be powered off\n",
>> -                               genpd->name);
>> +                             dev_name(&genpd->dev));
>>
>>          return ret;
>>   }
>> @@ -274,7 +278,7 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
>>          if (!genpd_debugfs_dir)
>>                  return;
>>
>> -       debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
>> +       debugfs_lookup_and_remove(dev_name(&genpd->dev), genpd_debugfs_dir);
>>   }
>>
>>   static void genpd_update_accounting(struct generic_pm_domain *genpd)
>> @@ -731,7 +735,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>>          genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
>>          genpd->gd->max_off_time_changed = true;
>>          pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
>> -                genpd->name, "on", elapsed_ns);
>> +                dev_name(&genpd->dev), "on", elapsed_ns);
>>
>>   out:
>>          raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON, NULL);
>> @@ -782,7 +786,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>>          genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
>>          genpd->gd->max_off_time_changed = true;
>>          pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
>> -                genpd->name, "off", elapsed_ns);
>> +                dev_name(&genpd->dev), "off", elapsed_ns);
>>
>>   out:
>>          raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF,
>> @@ -1941,7 +1945,7 @@ int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb)
>>
>>          if (ret) {
>>                  dev_warn(dev, "failed to add notifier for PM domain %s\n",
>> -                        genpd->name);
>> +                        dev_name(&genpd->dev));
>>                  return ret;
>>          }
>>
>> @@ -1988,7 +1992,7 @@ int dev_pm_genpd_remove_notifier(struct device *dev)
>>
>>          if (ret) {
>>                  dev_warn(dev, "failed to remove notifier for PM domain %s\n",
>> -                        genpd->name);
>> +                        dev_name(&genpd->dev));
>>                  return ret;
>>          }
>>
>> @@ -2014,7 +2018,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>>           */
>>          if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
>>                  WARN(1, "Parent %s of subdomain %s must be IRQ safe\n",
>> -                               genpd->name, subdomain->name);
>> +                    dev_name(&genpd->dev), subdomain->name);
>>                  return -EINVAL;
>>          }
>>
>> @@ -2089,7 +2093,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>>
>>          if (!list_empty(&subdomain->parent_links) || subdomain->device_count) {
>>                  pr_warn("%s: unable to remove subdomain %s\n",
>> -                       genpd->name, subdomain->name);
>> +                       dev_name(&genpd->dev), subdomain->name);
>>                  ret = -EBUSY;
>>                  goto out;
>>          }
>> @@ -2199,6 +2203,23 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
>>          }
>>   }
>>
>> +static bool genpd_name_present(const char *name)
>> +{
>> +       bool ret = false;
>> +       const struct generic_pm_domain *gpd;
>> +
>> +       mutex_lock(&gpd_list_lock);
>> +       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
>> +               if (!strcmp(dev_name(&gpd->dev), name)) {
>> +                       ret = true;
>> +                       break;
>> +               }
>> +       }
>> +       mutex_unlock(&gpd_list_lock);
>> +
>> +       return ret;
>> +}
>> +
>>   /**
>>    * pm_genpd_init - Initialize a generic I/O PM domain object.
>>    * @genpd: PM domain object to initialize.
>> @@ -2226,6 +2247,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>>          genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
>>          genpd->device_count = 0;
>>          genpd->provider = NULL;
>> +       genpd->device_id = -ENXIO;
>>          genpd->has_provider = false;
>>          genpd->accounting_time = ktime_get_mono_fast_ns();
>>          genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
>> @@ -2266,7 +2288,18 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>>                  return ret;
>>
>>          device_initialize(&genpd->dev);
>> -       dev_set_name(&genpd->dev, "%s", genpd->name);
>> +
>> +       if (!genpd_name_present(genpd->name)) {
>> +               dev_set_name(&genpd->dev, "%s", genpd->name);
>> +       } else {
>> +               ret = ida_alloc(&genpd_ida, GFP_KERNEL);
>> +               if (ret < 0) {
>> +                       put_device(&genpd->dev);
>> +                       return ret;
>> +               }
>> +               genpd->device_id = ret;
>> +               dev_set_name(&genpd->dev, "%s_%u", genpd->name, genpd->device_id);
>> +       }
> 
> If we can't assume that the genpd->name is unique, I think we need to
> hold the gpd_list_lock over this entire new section, until we have
> added the new genpd in the gpd_list. I am not sure we really want this
> as it could hurt (theoretically at least) boot/probing on systems
> where a lot of genpds are being used.
> 
> That said, I would suggest we go for Dmitry's suggestion to make this
> genpd provider specific. Let's add a new genpd flag that genpd
> providers can set, if they need an ida to be tagged on to their
> device-name. Then we should set that flag for SCMI perf/power domains.

lol, will do ^^ in the next re-spin.

-Sibi

> 
> [...]
> 
> Kind regards
> Uffe

