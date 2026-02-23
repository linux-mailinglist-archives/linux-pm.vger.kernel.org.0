Return-Path: <linux-pm+bounces-43033-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Bn9FtdFnGk7CgQAu9opvQ
	(envelope-from <linux-pm+bounces-43033-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:19:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45059176078
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F3113026AAA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA65365A10;
	Mon, 23 Feb 2026 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BS4Kplx3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hGu0SkkB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8AE364E99
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849173; cv=none; b=tbrVuOxdziS6GN/CGEaVZ7RK9WPxRpeVgbb83iWsTiJOFdn6jV0pzmRFEyu5A0Fy9RgfxQC10haKD4Qb4n10EqAClWpWScGX1vjcr+Xmlw3LSiVOwahmskJgi0vltdPwpN+JcLgj/5FpP6Q7zOAkRsbDxHoyA0vsyXYErhLmdfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849173; c=relaxed/simple;
	bh=H9tBpH3FJ8NHINo0k6gxJuREDCEnVNm57V43aQX5k/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQez6SKlJOCuTCxbjqGrf/rAZsALP+4fiHCiDLRCf9h/KwufhWWPvsPt7+FwlvqWeqTDfc+1h77mFHVksyVnPOZvC17lXtwKi3bnpbEJjpFoNaoWk7CFZ9XeDCqcKMeYvzmugTPP+/SWBcAvd/8XeuTTUWEt6BD8PrxZZOpiq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BS4Kplx3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hGu0SkkB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N85gS4624267
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Et4rmFw5DqcAxFldXWsgH23NJXURgSeQXkLXYWOqGk=; b=BS4Kplx3EbeQ9V6m
	OrVqeOT8W+6+fwfbK4UCcZ5H0RuNlMxDJPtzLoJ6c/OXduS5Vc812BlSZvM45ArP
	cL7d7/xjg2hzn7Uxzi7R+c0cu5Ce9YeaQsEcVYHIXF4C6uwbQqLdkdk7ZTIrQTwI
	VYsbHSK70Dc5CjEjOO6Ypg2w45rYkRPGUEF+p4ULg6CishGvrJ55wnURRHQhektI
	ykHAlHI1gCSnV1qkL9ZR6ienC65ACZnbKT96YxXvPD3GZy/XFbvc5k355rpfKH5O
	BU8tsgx7osGmRH6BnZRMSX6SS8dPBmEhI4iWMicDjq89Njc7Hiq5B+Mb3f9QR1pK
	+RPpVQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5u9vp3e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:19:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aaf2ce5d81so58528705ad.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 04:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771849169; x=1772453969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Et4rmFw5DqcAxFldXWsgH23NJXURgSeQXkLXYWOqGk=;
        b=hGu0SkkBHLPNggvQGvOw+7UVxx/AivcBLucfYOLwmmoprJBNoa7ou0HdM7xvSabzCO
         fKY5+oHdeyPtV4TBAHphMrvbhLeP4l9/jS/vQ+yq21baLIxIFpsTbQoswgGP9hMrO+yH
         RIqSASo8nHzbbwHppv3CFfGUklhkpU1e22SlK7U5Y+hWQ49NgZoblw1/ngKm8A9kDnig
         L4Vbl1ULYGbv4c5m9OGydtmAPzLpFCfEiyaP7i/eTCbDc2JQPCIkKxOYNxlDdle8Z1qO
         ZZrlptQwGJuTm4d4oo9RWOCswRnbKm70z98fFLenoKHjCIfM7JfnRSFGC/MyBKuo0W9F
         b0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849169; x=1772453969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Et4rmFw5DqcAxFldXWsgH23NJXURgSeQXkLXYWOqGk=;
        b=CrQx4a0V1593PKkFRZwmN1GSs3eYwDRukz0qJaAQTNEDSVHO7aF8MhT9BaB18l0hXP
         lWIDzABeyPIdPEvjxzTLSKndRTdEgg6mXtPMeRP0yB30VFi5M2sxLc/gUxQ5NEHC6coY
         jw0Rq7/9hpbz5alr/F8paWZYB+Y5sS+2gOYbr1s/DKLTFIcEMvjDglUcRUfaIoN0CVhL
         FRdbUIXhTm11oSoRzmbNU4OSEpVXesodfzMa4CK2hxgU/oA8fhY93A1QlGn5Jk2m2YaW
         4x4wuBU3pkmUgcFbhqn8K1EJ/07KBgJOJN/9qVsHUfyl9kb7mEQht0j4pO1BhQMH3YLi
         rMgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMz2nB6sQloajDEWeqPVCE5M/TgDEbNgA3OvQEBPM2fTyXm3A718WDZn5iCSAefVaj0hWzkzEvRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZLZzCnA9XmJkMhSR8We+/Kjf/C8ZwICPwbnrzoOkRl83+u5j
	pzk/Yws4y9s5I8udGKy03kWvgG6OyvPIH2v4DH/PoG8GMilwCEhcy7dLnpgkUVfHMLjksb6h75o
	/K/LvRJTDbTUVXSt+Tw5nHi0Z0B6L5+m6gPe05nVKEfVb/ZQd6RbrHjtJjakPQQ==
X-Gm-Gg: ATEYQzyQQTDAs9APQJpkS74nskNGs/dlimoqI6iUWARCR0fQeIoFncsNBecXMZ2JV3G
	IioJay+Qo8nKIIkXWqZIOgGyscCE20UvmcVcU1qUaLX1E9hqj/z8L5QNs3p6tTXzbwwjEdEaFD1
	4g+TpJZ2fi8IZn1S2CIjlA+sUvwMa8FS+dNB88lr70HuHqo3QKpVpsiQryrzYqvCoVymgsY3IGL
	oWWkR0Myaq1ZHltbIseJeaQIEN35Dad6KjRKy9Y4gPHK8Zm8UGukCQW4xCP/qBbva+Fh6osNGyc
	Nj0eC04OHt08aedZqy5iFMLLM9G5tq0zn5+gQAhNFqH4H3ZAZSo2dJkEVwUbjYRmknWIr3EcltC
	c/Z/p94wVJWCXNfcA8Gkp0wbtQfSG518HKfDplvEWCZzs7LF0Wfe7xQ==
X-Received: by 2002:a17:903:2451:b0:2a9:5b48:2b57 with SMTP id d9443c01a7336-2ad7454a6bdmr76541385ad.45.1771849168735;
        Mon, 23 Feb 2026 04:19:28 -0800 (PST)
X-Received: by 2002:a17:903:2451:b0:2a9:5b48:2b57 with SMTP id d9443c01a7336-2ad7454a6bdmr76540885ad.45.1771849168127;
        Mon, 23 Feb 2026 04:19:28 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75035487sm74021225ad.74.2026.02.23.04.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 04:19:27 -0800 (PST)
Message-ID: <70b77d54-a6ab-426e-a7e1-3e011adad6d4@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 17:49:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
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
 <20260130115421.2197892-4-jishnu.prakash@oss.qualcomm.com>
 <20260131173941.68b8116d@jic23-huawei>
 <6012ad64-3a10-4f05-9f37-f2d0c36df582@oss.qualcomm.com>
 <20260207165638.0ed27302@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260207165638.0ed27302@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwNCBTYWx0ZWRfX9ES1DoZYQJhB
 loDrFer8CUDPISmeG37hALxWdzWAlomfdrXogKvc3T09+hZ95OLXaWOPcKd7zRumLioD483SJfl
 gWz4HnOTaguQmzn1UD2KWzf1teibl13wPvwK7sTlU7wx1R8KXyF8CQHYqLbooEJkvyLBKXymm3p
 HY+jau2299BwCVHnPjApmGwtBSdP84SPcoxC+6KwdDyOnBQWzrMFuKZjhtOSvUAwET1/xZWSzX7
 ZKmGYB1/oAFEtco1nwVmmhSRK+6N/P3O6z+L5r8/0T0UnDgAojkZLCUo/SQAq9nu13BoiVZFUA2
 flFbbKga756S/Bn8XAQHJhs04XrekTlOQCrdqRANTf/MbsGqaF7+SIH95vNKhPksapGdp9QE1XL
 Ez9NGp6SbdRta5RimskEk/PS6DnCB2ddzamPpwwSq05uzASzvcpCY/J/IwHqourRJtJIqVBzT9K
 YLKz9ZuggXleEJI5qZQ==
X-Proofpoint-GUID: PtdsUe6jRkwvTyquLnMZYGfj5lkvPc1S
X-Proofpoint-ORIG-GUID: PtdsUe6jRkwvTyquLnMZYGfj5lkvPc1S
X-Authority-Analysis: v=2.4 cv=RpDI7SmK c=1 sm=1 tr=0 ts=699c45d1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PFIV_uwPMKvENUFLfcIA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linaro.org,gmail.com,intel.com,arm.com,vger.kernel.org,chromium.org,quicinc.com];
	TAGGED_FROM(0.00)[bounces-43033-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jishnu.prakash@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 45059176078
X-Rspamd-Action: no action

Hi Jonathan,

On 2/7/2026 10:26 PM, Jonathan Cameron wrote:
> On Fri, 6 Feb 2026 18:45:02 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 1/31/2026 11:09 PM, Jonathan Cameron wrote:
>>> On Fri, 30 Jan 2026 17:24:20 +0530
>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>   
>>>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>>>> with all SW communication to ADC going through PMK8550 which
>>>> communicates with other PMICs through PBS.
>>>>
>>>> One major difference is that the register interface used here is that
>>>> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
>>>> There may be more than one SDAM used for ADC5 Gen3 and each has eight
>>>> channels, which may be used for either immediate reads (same functionality
>>>> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
>>>> (same as ADC_TM functionality).
>>>>
>>>> By convention, we reserve the first channel of the first SDAM for all
>>>> immediate reads and use the remaining channels across all SDAMs for
>>>> ADC_TM monitoring functionality.
>>>>
>>>> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
>>>> ADC_TM is implemented as an auxiliary thermal driver under this ADC
>>>> driver.
>>>>
>>>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>  
>>> Hi Jishnu
>>>
>>> Whilst there are a couple of comments below, I think this is ready to go.
>>> Unfortunately this is just a few days too late to merge for this coming
>>> cycle as I need to send the IIO pull request today or tomorrow (due to going
>>> through char-misc) so this would get no soak time in next.
>>>
>>> Also, I'm not sure how we actually want to merge this given close coupling with
>>> the thermal driver.  Perhaps best bet is I do an immutable branch of next rc1
>>> once available that we pull into both trees. That would have the first 3 patches
>>> on it. 
>>>
>>> Jonathan
>>>   
>>>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>>>> new file mode 100644
>>>> index 000000000000..f8168a14b907
>>>> --- /dev/null
>>>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c

....

>>
>> Also, is it alright if I push the next series to address
>> your comments immediately? Would you be able to include patches 1-3
>> in the immutable branch you mentioned, once it's available?
> It's fine to post a v11.  I'll only be building that immutable tree
> after 7.0-rc1 is out (or 6.20-rc1 depending on Linus' decision on naming
> for the cycle that is about to start)
> 

It looks like kernel 7.0-rc1 is out now and I had posted v11 here earlier:
https://lore.kernel.org/all/20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com/,

so can you please check this latest series and pick patches 1-3 if there
are no issues?

Thanks,
Jishnu

> Thanks,
> 
> Jonathan


