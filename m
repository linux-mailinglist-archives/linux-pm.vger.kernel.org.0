Return-Path: <linux-pm+bounces-41334-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAlMMtyGcmnAlwAAu9opvQ
	(envelope-from <linux-pm+bounces-41334-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 21:21:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 290DF6D61E
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 21:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C7C7300A8EF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C015B392838;
	Thu, 22 Jan 2026 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K+7DCInc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Guqi5eAr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9283358AF
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113305; cv=none; b=A8r1F3YmGkt0vJ1wgN24wvYV8K0IhHeKVczQstfRCcQkbGvAhWW7n5flF7g0lSg9Lgmr8n59mEY+QhKfdWBcH3tOnO73KuUA1mkd+WvS4buyTEIyab9Hf6G/hot2SN/+bWXssMHSGZafrmyhM+Dj1/E5IDVtcdWXZyeOf5kEnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113305; c=relaxed/simple;
	bh=6eQVqhuoXXcU62rBiKj/oxf6YStUOFW+3uka7j2kpho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGn4mq0C9m/ZJftzWO1UoCVmdUpEJMeaRntgpwSoKUOWYh9brTNcn2oGOr1kJ3LNvcONAPFeQFiDdue2gPP4QZy2lIb0P6dHoeiJrYWJshHUCQ0AGZNkLgGOCcmtX6OTfeJL+5d1o4I75yrzfr5+I2cJJNOZ4fdibUzTKET+kwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K+7DCInc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Guqi5eAr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MK86hU2442147
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 20:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A0xgwOP1fO+5esZ1TuMNorLfQ2cp/Q6fJPHh5n3c+i0=; b=K+7DCIncPg/B3lUl
	5nP7GUegv+xE3a56YLz8/ED5N5vlypTtQFcVMDREEQxI9KvREiaSnfhkcpftRlm6
	tpu/s3pAILUuNSEWGbEvdXrHP6BCpksJSjY5dsMV1FczJF3w+YbONOOocB4L7Z90
	1AVF24myMgVw3wcDihkI8WQK8Pdnw1JqmYy4wH9RfKeFXbjumBeeo1DsTcKSCFpa
	YX4jJ46jr+HWssZp8WmSW0rQUnbJQa3gKY2DjvAfpPH57N9xL0NHTjmb04qlazZs
	stUZmtHk1UnrFDCEdpQlUg9LJlhQq6JT6SJSu7QdoqGWSxzVpNqzBz8GMq6yEC92
	dQ/Hfw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buf1bjp40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 20:21:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c536c9d2f7so39039485a.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 12:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769113303; x=1769718103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0xgwOP1fO+5esZ1TuMNorLfQ2cp/Q6fJPHh5n3c+i0=;
        b=Guqi5eAre7N35pg9ki77+2TAHGdlJMge1BSPp/T9//b/dR5hr2vOSK6EbitJP5PehH
         vtm9v3W9PgmZBfv+OVzqo4AKA/nsWrKnfkQp1km+Tv2H9iIcLrPuX1IUkCqJjM8tIPj2
         8vJQW8WcaBI64BwOrK/AAhxIH/V9uHJvwPxzoTWLjI1VKLKQGKioko0sblPOJHw4PMUl
         Lq+3zcEK1VtdM9M5v+KghkC99qbunCXVu+hVLw/Agb4uaPEnllmdHzxvSPDgS7V1TRdK
         Dix5gvmGLA+ThA4HWTvFHIHZIYjWv/jxgOuqtCgDas19guqwFFiyeii/Ao3C+BIxU8Jt
         U8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769113303; x=1769718103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0xgwOP1fO+5esZ1TuMNorLfQ2cp/Q6fJPHh5n3c+i0=;
        b=QnlmDjVMu/7KGZD0uQ+lldYsBiCvjiGWNpp1g8XJYZWczI7k4ccz0Luzn5jImkS09B
         n7BpQjQ6AyimDl2rrm/yBXs1+L/EoEKjsNLU9FBLEeGnUCnUpy+HJV88vVX9ebhjPX4W
         n9oL0OlABfKFauVwC/cBErX4edk+wEAq9VnyPr4sW50EMM1x0yTLPu6ZnUKH5giWm+s6
         OVJCwr9EPyA27SrwZyNdXC8h9yL3tPIJ/a/Xuo14Vww8CECaP0cSbsxg3oI4AEC1ZytF
         IIAFHA2QNTbZbETVJddEYDIVFRFCOGIAiyOmx0AHIxTy8OQrtBzea4vEZ9vCLzCm1jv9
         ichQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC3uvP+p784WTCiEhBmqGc9DU3jBgoT+AJmiX6/17N9O1XeSBVhCDDzuiaIoUqAVs/rZUiFdpdqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RPDVGnqDncJ3QDj4LB/1d+aLrlGm7lQLSzBqGi+/rHByKIrR
	QlFwq0mj81M8thM1jVmRHx08/TvN+OL0XMQ6LP6EMmpoJGfmtQgz5YdZd7Ri8iyvhLdywbZ9ad6
	x6GQ6Vyze0J6TeqXNzdgkdmzGHp6R5lCzgzyqL/Tx70241NkbCQBS9NIj/kvQQg==
X-Gm-Gg: AZuq6aL61Hh+7kPNrRdgYv0sL2SSk2iFAOErMkFYjRuQEBE+miYgvBD1H57wOpolr2i
	4EWvE5EfkdmXsKFTnqtwpGH95X8VfW4v2rFkGRjKa2wwXM6RZW87C+FK9TaB9WSmlsCxMCaV0vP
	MmsyECOi/5IURc9F95TStq2nA2nmE2Z25jIY5lEHHnGPVYaqZHfGXSV63b8lCsEkHTXNHnRWMnc
	coamHxdAscjadSYeZQJKpdlJqgrAcEvjPKRjy9jlT1CQhOxSTs82TuIpreyu+Ibvttd+IhzI3va
	7v0YebKGAmzPO0G/dbh4Avv0m9y1TMcq4TmGWZNH83g8IssPRTGmPZjn23TCJU4b3ChKUW0STy8
	s8obS+Z48uAB2z564KzRkZPsbDRU5Oy942F0D3RrL33BNsW34W9Hk5XnChEKJaZzERb4=
X-Received: by 2002:a05:620a:1908:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8c6e2d803e7mr79206485a.1.1769113302695;
        Thu, 22 Jan 2026 12:21:42 -0800 (PST)
X-Received: by 2002:a05:620a:1908:b0:89f:5a1b:1ec9 with SMTP id af79cd13be357-8c6e2d803e7mr79203785a.1.1769113302202;
        Thu, 22 Jan 2026 12:21:42 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b92b66dsm175565a12.20.2026.01.22.12.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 12:21:40 -0800 (PST)
Message-ID: <5d1c7066-33a8-4347-a15d-c600bf847dc8@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 21:21:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: qcom: rpmpd: fix off-by-one error in clamping
 to the highest state
To: Gabor Juhos <j4g8y7@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260122-qcom-rpmpd-clamp-fix-v1-1-7b6a67975a69@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260122-qcom-rpmpd-clamp-fix-v1-1-7b6a67975a69@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hL9LgqouQHLu3NcX2EZZQRia_Soixedp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE1NiBTYWx0ZWRfX+sWRbo8zprir
 5Syv4bFIegVJgGJrPC5+GvGUxJKER48S/dsxtYXfPuTWhakcPnyjMXUUCjqsiFFEXFp4prgL0kq
 9NHJ5oKzVCZgZuc1ZWhCLr9nijMSNBT8kSIOc1PvOJTSWHzVIwr5Mj/dK1NMUD0tE8O+Nt68R6h
 05y1ZbgKLATaqWsazBVpDEm7YYFcv947GgftYEFwyohigssurwp7H90CrMzjPv8x5+B/nQpWJoj
 xEpjykxiHqFwThmaP4dznzVwqoEzkEyiV/CGQuwU9VOYvqFEAGsSeQuvL/GYKsc336Wkxn0mW+b
 2CbeqLEVFOOvaMP8uArr0Ui4hEfGHUZmgvzF0FODlf4ixBpNu+6kZ1ZQLvOwMZCZVzaZGV1PAvy
 Cbsh+HpoZaOMLx3TJKe8ky99P06LUlguVlWB+kUxyG5lamCQZ2LFhu6itXw2WBFdrVRMZkETKxZ
 7aB4KhL6UfJ2EBlAQgw==
X-Authority-Analysis: v=2.4 cv=G+0R0tk5 c=1 sm=1 tr=0 ts=697286d7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=lxoN7_sM4p6pl6PJJbgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: hL9LgqouQHLu3NcX2EZZQRia_Soixedp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-41334-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,linaro.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 290DF6D61E
X-Rspamd-Action: no action

On 1/22/26 6:20 PM, Gabor Juhos wrote:
> As it is indicated by the comment, the rpmpd_aggregate_corner() function
> tries to clamp the state to the highest corner/level supported by the
> given power domain, however the calculation of the highest state contains
> an off-by-one error.
> 
> The 'max_state' member of the 'rpmpd' structure indicates the highest
> corner/level, and as such it does not needs to be decremented.
> 
> Change the code to use the 'max_state' value directly to avoid the error.
> 
> Fixes: 98c8b3efacae ("soc: qcom: rpmpd: Add sync_state")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/pmdomain/qcom/rpmpd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
> index f8580ec0f73785544aeb6f686438f39b477d134d..98ab4f9ea9bff431614739f37cd32b7b3bb407e4 100644
> --- a/drivers/pmdomain/qcom/rpmpd.c
> +++ b/drivers/pmdomain/qcom/rpmpd.c
> @@ -1001,7 +1001,7 @@ static int rpmpd_aggregate_corner(struct rpmpd *pd)
>  
>  	/* Clamp to the highest corner/level if sync_state isn't done yet */
>  	if (!pd->state_synced)
> -		this_active_corner = this_sleep_corner = pd->max_state - 1;
> +		this_active_corner = this_sleep_corner = pd->max_state;

Great catch, I copypastad it from the rpm_h_pd driver where a
similar variable represents level _count_

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


