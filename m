Return-Path: <linux-pm+bounces-29561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F72AE98BA
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53747B3495
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8A2676CD;
	Thu, 26 Jun 2025 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="McKZ+jvg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217C25BF08
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927381; cv=none; b=fp0tNyrXi/w0zsM3oUxb3JlD2hRxxixn2+hySfj05BOjc3TvCRDoMeSXmbogAwJRgLIgQ+cQactwdUbJi6m9OCmku6HarCbL9jk/Thu3O+Z7kaEg1rMZsGh8lj4CdSaOgH+HcUn1CdOXboiiEGrNMFe9Wfd1uiB4gG3EQSRdaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927381; c=relaxed/simple;
	bh=ligktBwIKrjL1k2FxuZqWrhVOWA3ZtJh6/sODsypgKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUMOMuX7ioT0W5tdmSbzlHeiL3djHwng0cbDxCQh8/WA2cY59BOiPaLAvoSSp0E7DPqMrXmSuBA5IoCHM5SuYSIzNZIWg12HpVLLOwRQDlu7xa9Y2cqaq6LyYkAlxO8OBqLb14wuENZtki+JL37+ajPUE5baM/N0C7eAkvCotlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=McKZ+jvg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q0Drb6002564
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 08:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ujJ3hdrZdrWTs1QinajLpV8B1IFekcuKFA40yvSASwk=; b=McKZ+jvggb8UAIJr
	uwzGm7b1LdrMuN8TDjEhy1Q8l0xKd7fbHC7l2lezkK0x8T7udPS83QIWYSl8RYsc
	9teaZgCJCxZnlDmlRTFAJYNgbU5+dRNuyP0lxpoQ0bREm7oJx0s7Qo5c1Dh0xTfh
	khtLSWCg084Z78b8uYMkhuNs045Kl4kbDhaAJto06yMfLglQAGAjDoWkWf4O0J17
	MryR+pdms4HlXk2aRo49R7NAtVolpnfmun7p4KY0vkffJMI4FjDCMg6b9+MGogWQ
	X2cW5rRiR3iF2JAco354gUDKpIhkXK6TW0vHGmP37fiwi+zjGda4oItgaQRCNJtW
	SVeO9A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmvbqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 08:42:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d3ea727700so10758185a.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 01:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927378; x=1751532178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujJ3hdrZdrWTs1QinajLpV8B1IFekcuKFA40yvSASwk=;
        b=xLDoVXhMQkqSOiasOCZGEM5QBRS6z8x00fHVuncPZxoB25INyaxuMhE1AldH0Cuh+o
         qNvVD/aMR65frtLyWutDKju4sKw4hkGA81MrSxPtAmOnrHRnBjjT9qDV4PZQauM/xEKG
         j8YPip484FS+gtDrDqSO6Sc0i7IjdEtvQzaBN3U3s+vD5c1y4MPZtdZZIQ97s52NXNcE
         UIzAasu05o8B5t2IPIMo2RLpGdFee/kIHBbl8L5IVSNn5eKuCTfJMkcJLWyydg8J1m9W
         iPX9dwfG/aaSwoT+qhzd5nBpkUQZ8+Js7S2Kh8FE5n/z6TTDTmeGjUFdoSzRWsCrtdSp
         CGoA==
X-Forwarded-Encrypted: i=1; AJvYcCX+JAEocZeNcH+fVLpzkhf0b98jJHncqgrSLecYw9sPWGOTyViR96wFRFL9MsgQ1Csgj5jSoW45qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjQTNC4K8qxm5G+lCr+eFM6bn50Ll1kCxrk/t/O2LHbhJwLyNs
	8K7DJtEYtHzkX75r7TDuuPFtCwEOA+2gIIBADDFmSpTgjJFkUy3yIL3njOfu4Sjp7N9kUN8MahP
	jnjTeIKWDyexeL5F4NIbh0wvHpF9NToaaJp9RIh0r2Tnbsa3joFpL5/A+710OKQ==
X-Gm-Gg: ASbGncvMuXNWLDrtFbCX1J06ZSOmCoLxnc6CqoJULiftNAlOwPbQnaKkLFUNy0bEZVF
	hpciun81P19cdGshFgNdKj27OFoE14kzklQiyzFpY4unolww8XWhaxT3UFuq8qLKg8XQrK1a0Az
	ZS7aW4O2XYr4tQUbeten35o7lVXqqeCufFKbUNmssg+2WDUcOELGk+7MRM30gyQhW5rLHgeBm/n
	eQpVzGiY9BrXnge6TKsi4ogyO39Y9CFq8TLBtGRyhitJ8R4nkB9yLgC5xGDy6HwYNYtI633Jxl1
	rXhSQRX+cZSo8Vyu0AkF7in/JAhL2zgL/r8OW/S2c/FvqqO1NhBuzTLVKaW17tItrtEWpFMC+H/
	kXBs=
X-Received: by 2002:a05:620a:28c6:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7d4295ce2ecmr287083185a.0.1750927377997;
        Thu, 26 Jun 2025 01:42:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaVjmoZaaH2FxAtCQ7+d0FZNW6yvYljbo9W4gCwn6F86xona1VfGrD8NQY4qhsOHOFM2vMlQ==
X-Received: by 2002:a05:620a:28c6:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7d4295ce2ecmr287081985a.0.1750927377562;
        Thu, 26 Jun 2025 01:42:57 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a7b0565bsm456823666b.165.2025.06.26.01.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:42:57 -0700 (PDT)
Message-ID: <9d619e6f-9ee1-4161-a60c-4d17d685a2cb@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 10:42:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: sequencing: qcom-wcn: Fix bluetooth-wifi copypasta
 for WCN6855
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-topic-wcn6855_pwrseq-v1-1-cfb96d599ff8@oss.qualcomm.com>
 <CAMRc=MeUU842TVDsPNn_Wcy8KtCQ_nz0qYt+muQJEn87g0kS+g@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMRc=MeUU842TVDsPNn_Wcy8KtCQ_nz0qYt+muQJEn87g0kS+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mJsOvcuVgjzbLS2QW63qJqxl1zMMZFOk
X-Proofpoint-ORIG-GUID: mJsOvcuVgjzbLS2QW63qJqxl1zMMZFOk
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685d0813 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=imviz4xovgbBuZMsnOIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA3MSBTYWx0ZWRfX9Icd4PKRqPUh
 sztQBLlQnfa5RE1q+lX83oiVCYj1jE7B/+nb6mDVKHjwwnIdIY0UoPCdBnUR3tV1kfSBDYE0yYJ
 I4bF6+kJ7iMWWAO9v06MsLGUEB6DY1NUzE80br95Wba5j0Kn9Gor2wsOOPGKF+MoqZDHarU6ZAS
 7AnI32RC4jUpwnulff5mh35AQ1bw+5svaIR/cdmtn459S7knDCvUdkbgcF+eqN7xqAkFleuEeX/
 DIDNcP3yQz2QsssEgCrNQwyQWGtjIHIggaQoXSMLBjfcLqtnTbeLlqoX4+W6bgx1Qj9ZOGkEz3q
 Fkqb+Y57QmPfFmeOriqpwvgXbjcHV01CpUtc3b9flyVFLTnIaCIJQiTILy3pG2Bd6+Iqb2ZLLV7
 Kdh+mcxkflexK84DlU8/YRgRGlhnm03QdA1ASTELahiAZ5FZQ1WskdT7trve0NBUL7hQ3S5T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260071

On 6/25/25 9:14 PM, Bartosz Golaszewski wrote:
> On Wed, Jun 25, 2025 at 5:55 PM Konrad Dybcio <konradybcio@kernel.org> wrote:
>>
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Prevent a name conflict (which is surprisingly not caught by the
>> framework).
>>
>> Fixes: bd4c8bafcf50 ("power: sequencing: qcom-wcn: improve support for wcn6855")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> ---
>>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
>> index e8f5030f2639a69254ad5efe0a313d2f3d10fa1d..7d8d6b3407495c28a780d5bb0668b2b35837b48a 100644
>> --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
>> +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
>> @@ -155,7 +155,7 @@ static const struct pwrseq_unit_data pwrseq_qcom_wcn_bt_unit_data = {
>>  };
>>
>>  static const struct pwrseq_unit_data pwrseq_qcom_wcn6855_bt_unit_data = {
>> -       .name = "wlan-enable",
>> +       .name = "bluetooth-enable",
>>         .deps = pwrseq_qcom_wcn6855_unit_deps,
>>         .enable = pwrseq_qcom_wcn_bt_enable,
>>         .disable = pwrseq_qcom_wcn_bt_disable,
>>
>> ---
> 
> Thanks for the catch. Unlike target names, the unit names are mostly
> for human convenience. That's why it didn't really break anything. If
> you have no objections, I will queue it for v6.17 as I have already a
> bunch of changes queued up and there's no point bothering Torvalds
> with a one-liner that's not urgent.

No worries

Konrad

