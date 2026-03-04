Return-Path: <linux-pm+bounces-43569-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB2sJgUNqGn2nQAAu9opvQ
	(envelope-from <linux-pm+bounces-43569-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 11:44:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D781FE81A
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 11:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FCF7300FC62
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4EE3A5E7C;
	Wed,  4 Mar 2026 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHdlKwiI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AqDQnfpB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6E3A5E65
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621006; cv=none; b=kORVFpQAKsT74C3qX2CnDlMvNmkUnooKuLxnq8zfS/UxMSt7mARdAnV7VINqFD68SzO6x1fn5E7YlZEtEYw/D2K2Td84wX1eH0UkWcjnuUY/t5IQmdH0SgixldDohYRBWhGejFYxS7WKzmRfu6Eff4ajYRqw08iSc7lC2ZLFQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621006; c=relaxed/simple;
	bh=g0VY1SnWACmqekRKry+p3Dbh/R88hKSsrMte/jrmuZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQBk1pGQPkNKNhk2cYx0/e8db+4RmLllVD4hLyEtrEkOTNWWdTOHtRY8+Me/LD2DH+Z89d320iAHXsWg55zNWTtN6ml2ySzjrWnnb/gpSxVArA0Sq1B4uKGSVjEWn62mVXuHEucFyJ/iOrRcN7B+deWyJxVDfalKlDhH4G893Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oHdlKwiI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AqDQnfpB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SO5g956993
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 10:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rSVxUW7sHSJ3EGoTO0uhgr92gcAUzVZPdRl59oQoUL4=; b=oHdlKwiIQh+CPkxo
	cbg5r5T0KINufGc/6sgHP7ZAc6riTDqJEfqsHsSLq9H8PDuBf5Bv8ennxVoODYTA
	RmF28651VQsM7H1G7pUZXcgjyQpIMKHZZ83E6lQe2VGLl4uDjCG9nqyKSXRv5+Np
	lJFn9jNGIebc4jqmmd8/s10t+V8OECCrRqeyIAh3yMIG1EjVv+ldiqPzIZnojbFb
	WwfzGih4HTS/08lNCERrsQMLmtCA70KsigsNeDZeAHTNz3wmsjk2adkCsNy/4UQ8
	7lTQTVQJNThJjqSnGyHJhxwlt9fxuIBzHWjVPZrjWUMM7ATgTWGdTRYI7WDYi5df
	wcstTQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp6qgah9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:43:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae42659a39so256895015ad.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 02:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772621002; x=1773225802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSVxUW7sHSJ3EGoTO0uhgr92gcAUzVZPdRl59oQoUL4=;
        b=AqDQnfpB7aKqRw9nF4cJ54Q+NT3TZIJ5XhxnbYanqiqHdUv8d7nvBTyoNT11o6ZWMY
         EAVGzpu/bBA+4rXJbIB0QxzuSKIU1PnK8kazUlOWeW606dQeen+3IOOI7af+sKwdRz1+
         bPN0jhF5EbaHPEk+FsxNBsUy7MyjhwA1qX8j9rJGLpHeNkg/Vst3DKiANqm+ReXTiEav
         ladG/aR5y1bhUugz2tKXeIxfePvjXQ8nf78oYy9l0l/avzbnKpe6+oQPffjSOoE/3G5G
         09Ww+qjdHRg9jOPzprk+nhozJaUqE8uFkELVitqCHup9lc5h2cEkscMltcxT92Vi1uyY
         8tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772621002; x=1773225802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSVxUW7sHSJ3EGoTO0uhgr92gcAUzVZPdRl59oQoUL4=;
        b=k77hglB3FI0Pruh5mez02JGu488UyK/53CsBKgReeCL8KYU8AeQc2fp/aVPGKwN8iM
         rvU4dZFOWcx5uGlXxiAbUc4UKvzlb8Dcj32+Whrl3XauM/Bx4b28wVrk/prV4uP+TSKd
         L7s6ik1IVNPLwzEbFA2H9JaWJux/RvNBc5g8B82A5n4qIDMsfrCa8Fv8d6ABMELtDwXE
         Vp08ZPCsOWiqb80MmfIyfSk2B2bnHluqw7Q2Rua9Dr9Uqe8LTZX9csdN/YgnRxigCeSF
         g9MPxpXqiQlgxnLUlA0p0+AXlu8CRax9jQ5qzR4y07oiBRPJxngE0U01lgzayQ4lylWl
         zA9A==
X-Gm-Message-State: AOJu0Yy2EWJRUTru21sIGasuuwluVH9euPC0DC2eBgF3ndwHq+5pQ6bJ
	mrpgD4sKp1XkD8RXG8N7Lz6dfCinJ9HVB7f/CVFNv4V/rl17Mv/65WOOciU+4/f2YrMIFX0R7n3
	/FETAmVkXUw+1PdSYJgUQgK9I/szIREVjD2rKrXkmr2KsnHHCr0Bwbfp7JJd+jw==
X-Gm-Gg: ATEYQzz987dS5X1ai7bAkY46AXeFMx1GMLBRipm6VWn3BiX5BE0UFYvvhrGqxcXPaYE
	EeDMHFag8N4gKSnPf7k6mpWck7x0TADvIgWqFVLsk8CkafSt6KcV3IQWlkssbR3t7gL5Y4qqZ2A
	SPlgmmXVtXI1UOoH2BWLkKYfQUxZrba7+fPliL4Cf7xMOfMGi6Dze5f94Z5gn/vzgS0UpLLl9ze
	KV/ZWXLuxSe6RtLo4mnvvJ3b2sAyiXgi58YgiIl6fWqlPmR/X7HQL2yjRkuAu8O/v1I5FPl4Rco
	AS6aij001sTN1vJ9FZJC6iwfyNUhGcD25qQ2lvzPtFAjQY5T/I4jQWPcJa3Tlefw6BFNaA3l0nn
	X2UqxtfDCiNG+I42NBJioX1pdATRNB44rpZUClWJUdu1DN/hQcOWJHuU//s2bpqnasAxYX/5gEY
	EXEjoCAXNDNoPRuYRBqA==
X-Received: by 2002:a17:902:e5cd:b0:2ae:5039:a075 with SMTP id d9443c01a7336-2ae6ab95fb7mr19412875ad.53.1772621001790;
        Wed, 04 Mar 2026 02:43:21 -0800 (PST)
X-Received: by 2002:a17:902:e5cd:b0:2ae:5039:a075 with SMTP id d9443c01a7336-2ae6ab95fb7mr19412715ad.53.1772621001353;
        Wed, 04 Mar 2026 02:43:21 -0800 (PST)
Received: from [10.133.33.194] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4ee6f257sm107497235ad.22.2026.03.04.02.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 02:43:20 -0800 (PST)
Message-ID: <706e901b-9152-4a88-b5fa-7ab611665136@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 18:43:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: Move to_device() out of CONFIG_PM_SLEEP protection
To: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260302105456.4134882-1-pengpeng.hou@isrc.iscas.ac.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260302105456.4134882-1-pengpeng.hou@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA4MiBTYWx0ZWRfX/safPkzuD3Ei
 MO73j4e/pIVmBKUymogP+bvQCm8EuDTVerJBUH80u0i9ZWesd8T6Bm5LO2OciEjpyuX4IUX0dPI
 qD9W2juDjrv5LoIWCq3+UIXoQ4QLWy1YG2zyiq2dFdYfd+X+9dtuoqI5rUTBkg0Rph8vKxzCNtb
 MynPt++GkvbjnW89clPjLLz1u7VFFPlVooUZxPiy37Vcz+V8sXkMEgs+G1zqzEaEfBPH4sKtlei
 x++qvkCl10ptGDwWjEyq9tV8z8d6DUPBftFwshGscHb9E/mzu1ahD4qlVJNfXgtzsNcuMnv6gCX
 +MoJI4zfIftt7rSIvVO68XnKCCHTjk5QAe5pui3bXhvOJXgaj/ihRqTINK7jv8Qbehp9TRLm4wA
 DyTAkds2kwnhp2lX0/OFQlDKXGr/A2h7QKCnw3wk1YjcNgntOFc696XEJKw2gu+/8iWz9FoTbBT
 qGCpc+Qaz0MWZPkVJBg==
X-Authority-Analysis: v=2.4 cv=UJ3Q3Sfy c=1 sm=1 tr=0 ts=69a80cca cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=oSJ1uSErN6jGRY7e9e0A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: aTCcyBedrbegRMpdXOczxyO6PXlsn9w-
X-Proofpoint-GUID: aTCcyBedrbegRMpdXOczxyO6PXlsn9w-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040082
X-Rspamd-Queue-Id: 03D781FE81A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-43569-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhongqiu.han@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/2/2026 6:54 PM, Pengpeng Hou wrote:
> The helper function to_device() is used to convert a list_head structure
> (specifically from dev->power.entry) back to the corresponding struct
> device. Currently, this function is only available when CONFIG_PM_SLEEP
> is enabled. However, some generic power management code may need to iterate
> through the device list even if sleep states (suspend/hibernate) are not
> supported.

Hi Pengpeng,

Thank you for the patch. However, I have some concerns about this
change:

1.Your commit message states that "some generic power management code
may need to iterate through the device list even if sleep states are not
supported." Could you please provide a concrete example of such code?

2.The to_device() function accesses dev->power.entry, which is only
present when CONFIG_PM_SLEEP is enabled:

struct dev_pm_info {
	...
#ifdef CONFIG_PM_SLEEP
	struct list_head	entry;
}

This means any code trying to use to_device() with CONFIG_PM_SLEEP=n 
would _FAIL_ to compile when actually called.


> 
> There are currently two approaches for moving the function.The first one:
> judging from the current conditions where the function is called, all calls
> are not wrapped by any macros, so it is appropriate to move the function
> definition to the global scope.The second one: if the compilation of the
> files where the function is called is controlled by CONFIG_PM, it is more
> appropriate to move the function definition into CONFIG_PM.
> 
> To ensure that the availability of the function is consistent with its
> usage scenarios and to avoid undefined reference compilation errors, the
> first approach is adopted.
> 
> Signed-off-by: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
> ---
>   drivers/base/power/power.h | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 922ed457d..0a40bb546 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -106,10 +106,6 @@ extern int pm_async_enabled;
>   /* drivers/base/power/main.c */
>   extern struct list_head dpm_list;	/* The active device list */
>   
> -static inline struct device *to_device(struct list_head *entry)
> -{
> -	return container_of(entry, struct device, power.entry);
> -}
>   
>   extern void device_pm_sleep_init(struct device *dev);
>   extern void device_pm_add(struct device *);
> @@ -162,6 +158,11 @@ static inline int pm_wakeup_source_sysfs_add(struct device *parent)
>   
>   #endif /* !CONFIG_PM_SLEEP */
>   
> +static inline struct device *to_device(struct list_head *entry)
> +{
> +	return container_of(entry, struct device, power.entry);
> +}
> +
>   static inline void device_pm_init(struct device *dev)
>   {
>   	device_pm_init_common(dev);


-- 
Thx and BRs,
Zhongqiu Han

