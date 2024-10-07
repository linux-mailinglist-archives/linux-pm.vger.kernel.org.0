Return-Path: <linux-pm+bounces-15261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E312992CCB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E501F23B0B
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 13:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9461D359F;
	Mon,  7 Oct 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rk7PlXyt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC921D2B35
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306852; cv=none; b=nNGlyxLirwk6SpDakwDoqN2w8CSAQZB3gqewierP84rhky1vMByHc8OryeoARH37J6P8GhHQYYnQwxcdgQ12v7dLO+vuu4IDedqY2A+NS5wxmwQHaiNmmyDK3TdlJr0wpSuH9/C4enDKQ68FLT6XOl9synZd5XpKojKZg+ROMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306852; c=relaxed/simple;
	bh=aoZ6Ab2vT/zv5gBysjB0k30FjuEJ24iQqrKlS0K2iTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJxa8bLBl6cUYUkWI8+3fitUqi54CAFDd3WEtBhwnknJc0gG7gcrgMWovgKGsWeu8MPTaPPAApk+T4Yp5m2wEGxLQopT9VAcRfq7zRx2MtGbb7GQ6p1xtGdad6364bxuIU6Oh8WjLzwgtP8EKlE4NmbWqZD3zJ8lxJzRHhl+oqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rk7PlXyt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4974T7wK019241
	for <linux-pm@vger.kernel.org>; Mon, 7 Oct 2024 13:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lagPHIZttZDMUwYWdXVzJKUqDahMn43dORef7ZZpNvk=; b=Rk7PlXytr1YHYGI2
	foDnifwZQTqFUtnW+s3xpBvEczDraD02voigsUqk3CUbu2qBxoq3B8La7Zvwh8sp
	cYb4AzRYYPWY2gmbBKAid1ycLTzf36fFt2Y1Ik74L6X6TyWiMNyZ8rWzieRU4UV8
	ab2wn6VDw3nsloKKcHBc+LyfHDDEw14+dzGyvq0gVQdsOtTlx+AiOhCeX11zouIG
	SlPsAPugVkMCnXTDrKb9P4SeeG8E0ALvnGAMDp5PwaCTl37ltSgKkdehXvSsw9L+
	zMFkflejufD9edOD5YmpGoC5qWeArbhNBbNYvsFkznGwprXMFyyBsIwYaqmsEyrU
	43MFHg==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xsn48js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2024 13:14:09 +0000 (GMT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c884af74b5so467551a12.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2024 06:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306848; x=1728911648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lagPHIZttZDMUwYWdXVzJKUqDahMn43dORef7ZZpNvk=;
        b=GLhHoxWsbMGj+k1/dj1lyesURbcBGV+Qb98KxIAxLJJ43sHq+rQMWuyEjw0AwbbR7V
         23aNJ6tvhqCOvQear1an3XQ4+ULWRWE3YGXGrNqnuhxuKoS3DHoa1bOpQqO8ImuHtJkx
         EuZ5xpj0k1Ome5D8RKFa9L+SroqJjYc+C1/XIIY/azOwn6b2BIq3i7P9MI5IcIJhC9P/
         53t4TUziReZzLfEqphSjQyucomwblcsnsvl4YsaWZzAyWiBHaGU+lqgajHRDJ8MW3kNH
         L9+1bEH6AtYDshS3gD5suEcV6iUIJKUve9exi5n4z6iz0SYYLK7IBxKAi1NlChw16hFt
         DqFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfOmxADBeTCuv3gRh3lgBwC6NMqUiTpqBzg4CbdOvZaHfW+hzK/E8t7Cgb/YHwRa8iQwgFUr21qQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DslhzOpuIWiK7ZWH2nrX66TdgCb61yjQmudyNSVfKE+uJRQ4
	LumsvQHnOyI08rJ77E3awY4JeitASVVpWmth3kRD3LARJkJ5s3CGS1P0SEPuw0kacHPKxvdBXz4
	6FfPtO8tmvzOeKBvOh6f0SyUNLAOJw1o/r8i0y2OwGKG/IoTcPOxThKdlzg==
X-Received: by 2002:a17:907:928c:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a991bd427e1mr582895966b.8.1728306847961;
        Mon, 07 Oct 2024 06:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG99yzel8woEN3MfN94DmcG3qCsQPgg06GOvsb7ccyx/jB9qBtMungcx0dHjaKg7+ABpfb/Qg==
X-Received: by 2002:a17:907:928c:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a991bd427e1mr582892166b.8.1728306847312;
        Mon, 07 Oct 2024 06:14:07 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99420bcc1esm287761166b.199.2024.10.07.06.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 06:14:07 -0700 (PDT)
Message-ID: <d1f12236-220a-43de-a69a-12831bc8a691@oss.qualcomm.com>
Date: Mon, 7 Oct 2024 15:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] mailbox: qcom-cpucp: Mark the irq with
 IRQF_NO_SUSPEND flag
To: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, ulf.hansson@linaro.org,
        jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        johan@kernel.org, konradybcio@kernel.org, linux-pm@vger.kernel.org,
        tstrudel@google.com, rafael@kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <20241007060642.1978049-5-quic_sibis@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241007060642.1978049-5-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yo4pDS1ZCp2J39dXIS0CyhXff8jJKMHI
X-Proofpoint-GUID: yo4pDS1ZCp2J39dXIS0CyhXff8jJKMHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410070093

On 7.10.2024 8:06 AM, Sibi Sankar wrote:
> The qcom-cpucp mailbox irq is expected to function during suspend-resume
> cycle particularly when the scmi cpufreq driver can query the current
> frequency using the get_level message after the cpus are brought up during
> resume. Hence mark the irq with IRQF_NO_SUSPEND flag to fix the do_xfer
> failures we see during resume.
> 
> Err Logs:
> arm-scmi firmware:scmi: timed out in resp(caller:do_xfer+0x164/0x568)
> cpufreq: cpufreq_online: ->get() failed
> 
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZtgFj1y5ggipgEOS@hovoldconsulting.com/
> Fixes: 0e2a9a03106c ("mailbox: Add support for QTI CPUCP mailbox controller")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

