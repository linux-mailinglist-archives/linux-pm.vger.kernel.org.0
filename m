Return-Path: <linux-pm+bounces-38146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AB1C67059
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 03:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 652C7355EF0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 02:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECF63203B0;
	Tue, 18 Nov 2025 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KYdijhW9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Er+sKGhz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3F1F8691
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432987; cv=none; b=FAxchV8onKHeKY+6yZKvh1jTuKIPhWkc5uaPYbd+Qyrvroo9kK1Y/jCpcUWgtRs7of5YvKBQ+C+Ks3LxqYxhAp32SFFcwKV9LKS0kA9l6JnusXemSy9jHEkYJlF1jj1T3TSwQO8timqAblUIbr11zR/fG86YcK2vEiGUo9wzXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432987; c=relaxed/simple;
	bh=2KOfma0sITPO/4dH2G9QHJ4relhWBo110kMOcda7Thk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AqOdidCeOPcHU/ZKnBeiVouA0oeyPuc9kOQz8aKfDvVKvVA3DZdhOs7A65HSxxUKLH0vt4Fe9h1E7Wo5fvaUCLj/xQhKelRV+9c2EDgBZStrp4guA8LZ0BCJyxziNmDzRtpskDiZymJtypqITk1tL/Ig/tH7EAj3ppXfD9XO7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KYdijhW9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Er+sKGhz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHKBk1w623728
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 02:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xDqii3elKukNgR40+RTb2lx/n+vGBSNGvcekTp398fU=; b=KYdijhW9h0aGpVmd
	xAbg1APihmWlAuWKP2GrwJbGpFVIZeMYnFL0pk/BL5m69GOQcaovfVV79J94VBr7
	ZCB/DamiCnmXXxXL1pevn04VVF1crVNJkLnFWgwlRrqfhCxbA7rd6mvpqDQlgFtJ
	Uu4zaQAAUW6rOfuf1/f4blgXtftOR3GKnmSpTZNkk+T3K7dBP6yWyq+PqHHFXH/T
	bVlDpwlBDfQjOLM7qGTx3LrSqx0sUzozY70EeKEM0pRHaWMvx1lCfGcuSbsZRSI4
	knJTs1xQ798vMY5ynz2EGwbvOa4Jh9N07tElB93NHZ7tfCsa0s489NXSaJMgzdWt
	OPmTtw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agahf8t5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 02:29:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b89ee2c1a4so7148540b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 18:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763432985; x=1764037785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDqii3elKukNgR40+RTb2lx/n+vGBSNGvcekTp398fU=;
        b=Er+sKGhz6/TlF73uASVCngfC4nurdPVYT7qtXcHQC+sKGk4AaYU0pYu18xUdekeL0x
         qitUWTUXQ7K8x9fop/4IH9HdruZvIQUSo6jODlDolDRaPIMZSFJZqN6Gz0EG9WHHHck3
         yMjcl+5k0UBUzGePfuB726RfmJdPJp1asIEuTP9LIrqpgR2PkV33vlZh8WeyPMBvUsXE
         yMXdUcxiwHJKJXiXCybNq5NIa2I9OVzBGcijfkVTFrQyNfRTcdFEPrdU9nAZDljR2dQS
         y3hxSUiGpADvSdJk5yvWgXc293fsY0ncd2DamECJbvsihTdQ3OODcmyny1afTenSa1BU
         4s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763432985; x=1764037785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDqii3elKukNgR40+RTb2lx/n+vGBSNGvcekTp398fU=;
        b=sXY+xqy91orsLt+I3Cc1DpwY1ULgVRCPgkeBlYuMCGdxKXGa6HNwsTzk97Kyw1jGU9
         WVDRv5KfChCcJXx9iKaG0ewDCRrYYO/XWNHFL2n3a1Kw4q9+oDki/oyPItchgF8ug8UJ
         5ui0DGEIpmXucV23OyKkkDBu94pV5sFe1a5GgLU+CA7OjtpoaJucZ/3Yz/cvIL6GR/xQ
         kV8+FW1syV4UUDA1KAeX3NBi2IgeSOvJFbRuPEZ5cPITQA5qG/XeQZvHsd1DJCuWtpxz
         z4uymaAp4GBtzQJX+nIPAAj5NUgHLWB/scVwcxBfG7mBLtRsAyUA/iBSC6vEGnM4hms1
         uwjg==
X-Forwarded-Encrypted: i=1; AJvYcCV8oFBHz3+wfqdF3tt4hVGbyl44U5n4fDzw98vlwQUImWK1cVXDiR4aei+PTrPUn7rtlXbZSoI4sQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40AErLrh+cnWjUzIqwRQl+lttLfTEsX0s2utJFB++xGuVmgLl
	MGNM+3XMH+vwvBNgkJZ+llyrCTYXXp8Cj+ipJwe2ALU0PrxtWMninmtvVV2nOx1BjwlciQsfyvG
	Qv5420Lq3tDQtlEqR3YdrEqfzB7jN52RohVaq4nnRUX4vn0qGRjzftI0K5GVVkw==
X-Gm-Gg: ASbGnct36Ls1PeiVZjahOeB5Ae650rdEYxHKdPzo9J3BxHSp9YSKfojmcsw7enXYfDS
	pqsOkhaxj32D0OLh3ThlQtI+Qkw2BdKTdgOotBsx7kX8vziEqOAPjbv8HHc56U328U5sFHv9c54
	0GWBAQRulcQFYjYVM99UZdS5BHLIQixmXSDOLa5JEImU6/9NEt6U4yj2LCTunPQ0ld34StOup1R
	EXObQTa3VB4KvCcBhHO8lOn1mP5FH+ySu3I0YUambzYM+6ZkDp6A4b7uonY+AW0yPOSscU1zUwe
	mTXzbvHs3DoljpKRWDlSNdrAvC/zYmfOQpop7DHt6MiKp7P1NNMkGzf2KVoIL39Vevv6jbCudSb
	8pZfYkiRu0uAN8+J1oWykF30mm5J0WEfMm5YYy2VI1pjls8QpXHWbn4nNCfuGGAVUyXxDj/5znt
	UXfig=
X-Received: by 2002:a05:6a00:1744:b0:7b8:6e0d:6566 with SMTP id d2e1a72fcca58-7ba3be8c60fmr13776020b3a.15.1763432984574;
        Mon, 17 Nov 2025 18:29:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHARX4H4UC1Tv8HJiSAkEHFZwwaJOg+neMIkMp2N3vFNfTFZNFkcsb5OXabfS1mRLsiOx+BBA==
X-Received: by 2002:a05:6a00:1744:b0:7b8:6e0d:6566 with SMTP id d2e1a72fcca58-7ba3be8c60fmr13775991b3a.15.1763432984068;
        Mon, 17 Nov 2025 18:29:44 -0800 (PST)
Received: from [10.133.33.128] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927c22b1bsm14420563b3a.66.2025.11.17.18.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 18:29:43 -0800 (PST)
Message-ID: <d92cb96b-b398-45c1-964c-0ab551ca135f@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 10:29:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] power: supply: qcom_battmgr: improve charge control
 threshold handling
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Val Packett <val@packett.cool>, Sebastian Reichel <sre@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251012233333.19144-2-val@packett.cool>
 <faa9d74d-63d3-4569-ab36-5e0ee0241794@oss.qualcomm.com>
 <02db51aa-6e19-411f-875f-718b8215c373@oss.qualcomm.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <02db51aa-6e19-411f-875f-718b8215c373@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDAxOCBTYWx0ZWRfXxBX6GGS8X5ng
 fEcShwk5hO7VL3qtuv0HnWx+ustQdnMANmWKMzkDTKccMcvjdGvg9/jCyvp0nYHaBHJxOvADCfy
 lwSWu93xvph8CVmjJCDKbSM6igQVG40pE1pG3eeLWu1FK4t+xwNJluAjvD2KzoHosDdYXJ883y8
 AxZRSlqDwFzFoFdZ3fNC9On4/XVQPt8ytEr+HoIsKGxiEMnSpc+Iq5LdVQbQTOlM+0Hqg+XdE1s
 eM4oTzF16w+juP4K6Tyo3lipQGoH5pFhS24HpLRANPSmMOgQGeLRrCQvevQ3ui8DvVszAbo0I5r
 9hMAEtUgIQnBd0CmCWPQJja8QZCCUGJAjPpfgXZnToEoCKEZmJRBlniQyCap8bNY9ohKdHor41L
 VE59GdZb60ev9VUouxiWPdXZ3NUx8Q==
X-Authority-Analysis: v=2.4 cv=RpTI7SmK c=1 sm=1 tr=0 ts=691bda19 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=efJFygxvcKwCkfyfGs0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: qBNzAk8zYcL7kr391qLy_8Kx0mj1xEin
X-Proofpoint-GUID: qBNzAk8zYcL7kr391qLy_8Kx0mj1xEin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180018


On 11/17/2025 8:45 PM, Konrad Dybcio wrote:
> On 11/17/25 6:12 AM, Fenglin Wu wrote:
>> On 10/13/2025 7:32 AM, Val Packett wrote:
>>> Currently, upowerd is unable to turn off the battery preservation mode[1]
>>> on Qualcomm laptops, because it does that by setting the start threshold to
>>> zero and the driver returns an error:
>>>
>>> pmic_glink.power-supply.0: charge control start threshold exceed range: [50 - 95]
>>>
>>> Kernel documentation says the end threshold must be clamped[2] but does
>>> not say anything about the start threshold.
>>>
>>> In this proposal I've special-cased start==0 to actually disable the
>>> functionality via the enable bit, and otherwise made both start and
>>> end thresholds be clamped to the acceptable range. Hopefully that's
>>> fine?
>> It is fine to clamping the threshold to the acceptable range. Thank you for making the changes.
>>> Or should the [1 - 49] range for start actually be rejected?
>> The minimum charging start threshold was set to 50 to improve user experience. If the threshold is too low and the system keeps drawing power from the battery frequently due to a large system load and a weak charger, the laptop will only begin charging when the battery level falls below that threshold. If the user disconnects the charger at that time, then the device would be only having a battery below 50%. Setting the threshold at 50 ensures the battery always stays above 50%.
> So can we set it lower?
>
> Such decisions are best deferred to userspace and/or the user, which can
> limit what the kernel exposes as necessary/deemed useful
>
> Konrad

Yes, it can be set to a lower value.

However, I am still having concerns that the inappropriate start and end 
threshold settings would cause a very bad user experience if they are 
misused, since these thresholds are stored in nvmem and they won't be 
reset until battery is unplugged or completely drained. For example, if 
someone intentionally sets the start threshold to 1 and end threshold to 
6, and if the laptop was shutdown with a battery SoC less than the end 
threshold, I am not sure if <6% percent battery level would be good 
enough to boot up the laptop successfully, if it is not, then the laptop 
may not have chance to charge up until you hot plug the battery.

Also, from battery management firmware point of view, the charge control 
feature was mainly designed for battery health management, to slow the 
aging of Li-ion battery by preventing it from being frequently charged 
to full state. Having a too low minimum start threshold setting won't 
help anything on that.

Thanks

Fenglin


