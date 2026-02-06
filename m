Return-Path: <linux-pm+bounces-42201-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL4EKrzphWk0IQQAu9opvQ
	(envelope-from <linux-pm+bounces-42201-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 14:16:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC6FDFB8
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 14:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F0283060717
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAA3D668B;
	Fri,  6 Feb 2026 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M65YF92D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GutH41bn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D10225408
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383734; cv=none; b=muidILKWvPt+OM2S0m+xcYcix3iqWVDlptQuY94XEn2LMUSfD0FEFq81NlEe7MWzaTyWsZ5m3a5tZm8EqcibH3SC2oupKBN62crMXL/hNj56r/UC/5NF8WlwtlAwkf3b3FIjiYAVK5efLlQ7TXC1rb/J99PjlIqmuSHS6nWBV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383734; c=relaxed/simple;
	bh=OP8/OArL2cMmvjrS2BcXJQ+YVC6QxtE/6FgIyIpyXfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njfuMFGavrp1R/SLRr63rmvWuAiqsD/CktGSHiX6qPywiISjLbuEphDwqPuQeIVn3QWSRB6CJJu2kTqpKmECEmcsKN0bFLHcBGtLtBK1qQE4R2IWdhUIW8UFrN9TaLzFgjwSYIgWboOjcp56v1TtKbWeGnkE8+jo0s2mEV3q+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M65YF92D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GutH41bn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6168whMl2058377
	for <linux-pm@vger.kernel.org>; Fri, 6 Feb 2026 13:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HmNmeyWa+J7dZZyEeSg9GnKnpszfkH8n3cTwO4E6RzI=; b=M65YF92DxN324jlJ
	W7osZxwxct4DPC6cKtRVM6kQS8dSFdHbySHsE5Xn0MOQoVcmeSMdyI1oeE02vCxR
	6JmADaxuUkK/uESgT0AqQ/Zthyzagr1LJvH9yiQXMmgBThDRiB/X8BjM1bOblo/B
	ZNSgXWVwE3AqQdJM8DAIBo1jBAQGLiROvIYdCcNG64uTSJpns6hOnA9/iCa/4GTu
	svURhO7ODgvTRuw7LGhSIaTmQi4O/g+lThjWlDwCHTu88ZPCa57qXUtmI04I74IK
	8E8QVm94ZHqMh5GvbGddgtpr+gB8CNfZrpwHwBhY55PB11Hfia5FJ8jjCJ/DhxK9
	3qXOvQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4x8bkt51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 06 Feb 2026 13:15:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a76f2d7744so22423565ad.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Feb 2026 05:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770383733; x=1770988533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmNmeyWa+J7dZZyEeSg9GnKnpszfkH8n3cTwO4E6RzI=;
        b=GutH41bn89hK79mQ9R+vWJOwHsRzWVeBG8eXccqsXuryRZSjMCysTbVS3YI8r+nf9Z
         ISQJ+VnhRcWIyXh4KWDr/vvIOqn2z5YJzJFTwDKqGo3x6R7InF/P6g6M3ZiW2zEp7ydK
         S6+v8xpprfGORRsXXKudJUPqXqkIam+lE1MZwU5xt9zQZRnEEkYhsd9q8Lno3AH8BVld
         NZJyNscRBKlCL5Y9fEEhgm/9ujaBRrkuAuee6d44Xl9bTybnbxdu2trOTHHol7Cbfh7q
         fUp249arXJRJhcEV8t771RPSMNuRJiuhdsjwd8vGtBrIxe3FuRpHHY6jFejCke8Ez+F6
         mlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770383733; x=1770988533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmNmeyWa+J7dZZyEeSg9GnKnpszfkH8n3cTwO4E6RzI=;
        b=TkD+Z6v3+gk4WOtUUYpsreSVThEtg/ou/8QmK7Kd/d77CHmaMCXqnPKUU35rFUTWka
         i+6XppiJT/WZjy9i+m+yyUWtr61VvP5ip0V90ISXVPp64Ak1zZsPh6Puj5XtRTtFoBSP
         8+gSLdxuR0BFLhLCQa+az815MXMWw6ifAxd/xNPeG1YseHRx6P+4hegtRDe8seRm236F
         KohM1gbXjeuA7wWPhYmt+DzaYaFj6rxQ+iscJYKmy5CHAXmVWyCKb0bO82NNN3ohf1eq
         FfvF7gNS7ZF/o+bn+ilKXijQQFntlZnQzUCwfXuHd93ZSsE9Pr+HJUCn5bc9mFw0h/YO
         m+pQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/3oqDr13yjAc3pJJS6gQKeGRNUOv13ULI/Z4GI1gV26unjeoRFGSFCmswDzUM/bbihJPvjKYwEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8N42pMS+vR4p/1wfIEGTF88ep/pUycsaYZsNL+vUDuDq+3xTP
	6rSiXSBdXFR3lQJQPbAAmrwIYJ7Vr734lzBumaL6L3iCcnpq+o2fJu12mxgllH9/NlKw8+YvNDE
	sLIZNIMHpoKIuq4f6aRDlNuRda2SNqB9Wpzl7YjFO0b+8dW7eGPUxxlgyrdwi0fZ8w5+iBQ==
X-Gm-Gg: AZuq6aKgEKPIEvjujJAMEHt11IGtKRP9+WwdnD5yekwuGBYU2o+cUn96z9okhCaTr5q
	4sj9/+IDvQyGGW8MrIUAHw1LPc+aeNnhCQpWg0hIntxe7AJOkRM2+JVAYyMV0hjSW8Fg3n9kTfc
	UkOAKMEbfNA7/XulYpYHKiCxXXqhSFo1Mm58iJ4kMrh44aH8HA/4BgFnSuV+NhEp1BcC7ftuaSn
	fzHDMr6WQ/5MnAszdUz0m+8w+kBoZ6NzMne11WP9IbzguIRIfwIM3s/HY0I0NisuLMPUqOSTGOH
	BkYzkaYhkO1CGemgGfYCFwW5NSlxC7xBjrAoIjakIFAWh9UUu9PeQpm2mCsUXrFYLyR3FExaWoO
	VaHhEqaDB5ypsKvSdTk705MzHcfZLG+KiCjWKOHJbnQ==
X-Received: by 2002:a17:903:3d0f:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2a9519428c7mr28925185ad.48.1770383732477;
        Fri, 06 Feb 2026 05:15:32 -0800 (PST)
X-Received: by 2002:a17:903:3d0f:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2a9519428c7mr28924715ad.48.1770383731980;
        Fri, 06 Feb 2026 05:15:31 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521f8cb6sm24970545ad.79.2026.02.06.05.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 05:15:31 -0800 (PST)
Message-ID: <def530e3-3a5d-41cd-9f1a-1dc3f98747f9@oss.qualcomm.com>
Date: Fri, 6 Feb 2026 18:45:22 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
 <20260130115421.2197892-5-jishnu.prakash@oss.qualcomm.com>
 <20260131175412.0ded39d4@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260131175412.0ded39d4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GaoaXAXL c=1 sm=1 tr=0 ts=6985e975 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=i0EeH86SAAAA:8 a=yfIZU4QQ0lc7Zzv-pR8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: UXMx5MsGLD1gn8N9tjnXIUQtlTC44iox
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA5MCBTYWx0ZWRfXxY9irnwR7PMF
 Y4prj1mhgz25sOaepdKH/ExlMPmV8fHYDU1lPtQlW5OwJN7N+9MUgbF9UYiCgeqNIaRsjPOzakZ
 W02lXejtVjl8plkcE6YBDzuCPC9kzCBvF5i7jX0upVCK3dM+Fc3DZC51DtDEU7nrsWcWjl11RUG
 rUT3aKFfvV9EjmbLYppRDh3fwf8Ev5woPtV4HEd8mfWg74MJS5T8mHN3Fk5qcfSrX8JsdX64hqn
 /aMptCPPnVUzGPYQ1OEAmMY6VuFYAuC23B/a1IBs7LKuNPgKdvUa51U2e9vpI7F4DYz7qhQzHrS
 tNT+eH+ijmL/x74/6rmDgTF9lhF2TLl8ldFEpUnIuTsiPgCay8+Nt+ALkBQkgMH5ZyLppAGwWMb
 F3BpIbzie8mcem985UU+XsIDN64AArNsX7RPV/gBUAXDiu1PrwaJKx6dZXdvp7kB0NvMZ1ugjzR
 5t1QpfJa/NshP8F7WXg==
X-Proofpoint-GUID: UXMx5MsGLD1gn8N9tjnXIUQtlTC44iox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linaro.org,gmail.com,intel.com,arm.com,vger.kernel.org,chromium.org,quicinc.com];
	TAGGED_FROM(0.00)[bounces-42201-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jishnu.prakash@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 21AC6FDFB8
X-Rspamd-Action: no action

Hi Jonathan,

On 1/31/2026 11:24 PM, Jonathan Cameron wrote:
> On Fri, 30 Jan 2026 17:24:21 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Hi Jishnu.
> 
> Some minor editorial style stuff below if you are spinning again.
> Otherwise this looks good to me
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Given I expect this patch will go through the thermal tree and not IIO.

Just to confirm, would it be fine to keep your Reviewed-by tag in place
if I only make changes in this patch to address your comments, in the
next patch series?

> As mentioned in previous patch review, we've missed this cycle for IIO where
> I'd expect to spin an immutable branch for 1-3 so we can do this early
> next cycle.
> 
> Thanks,
> 
> Jonathan
> 
> 
>> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>> new file mode 100644
>> index 000000000000..882355d6606d
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
>> @@ -0,0 +1,512 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/container_of.h>
>> +#include <linux/device.h>
> 
> Similar comment to previous.  It's rare we need device.h
> and if a forwards definition of struct device is enough it
> is better to just do that.

I can do that in this file.

> 
>> +#include <linux/device/devres.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/err.h>
>> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/thermal.h>
>> +#include <linux/types.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/unaligned.h>
>> +
>> +#include "../thermal_hwmon.h"
> 
>> +
>> +static void tm_handler_work(struct work_struct *work)
>> +{
>> +	struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip,
>> +							 tm_handler_work);
>> +	int sdam_index = -1;
>> +	u8 tm_status[2] = { };
>> +	u8 buf[16] = { };
>> +
>> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
> 
> Not that important but you've been a bit inconsistent on this style
> of putting the loop iterator declaration in the for loop or not.
> You could definitely do it in a few more places.  I didn't comment on those
> because it's a style choice, but consistency is a good idea - hence I'm
> commenting here.

I'll update this everywhere in both driver files and also address your
other comments in the next patch series.

Thanks,
Jishnu

> 
>> +		struct adc_tm5_gen3_channel_props *chan_prop = &adc_tm5->chan_props[i];


