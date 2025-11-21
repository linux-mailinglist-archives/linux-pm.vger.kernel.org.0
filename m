Return-Path: <linux-pm+bounces-38378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CB2C7A552
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 15:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3834C3D9
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E4D29B796;
	Fri, 21 Nov 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Io0bpT/E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jLod4hO0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9F7291C19
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736638; cv=none; b=e1gfkLfzJLD3NLyN/gDbs7F1/Fx18E3nz8hYztP99QQteQ+ncUrKOkE7BjwK+C3wFVlxExBlFHpY3W7gXQxIf42rMCoC1+l4oJfHHgOumyJZLADO2ZH9F4XQSH80HGF1dLoBwgo8AfikFW1ndVHj39GQRi/Gim2NMOTrOHJcWD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736638; c=relaxed/simple;
	bh=fTzxInQXL1PW/7RxVGDfFpO8Lq1pdHKtjsjlU6dwGtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hc5asTC/MqWwKm8ST+D7LTFwZ9//xPPqWYJgdw8/iHmIpTKYDdrB8moynb400smjdgFFdNtSZf51mTuP3nuKTum4PfjgNsfqmO1xQ8GcjDP4rITvPbW5up8XfT1Lc4wjf43NG5KGR1eSflFW9mP/9Pi/suieZRaKT/89bT035k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Io0bpT/E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jLod4hO0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ALD6RBd1637676
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 14:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y4yMm5gRaB703rYohlWyjuL3DkCaUbLUnDXibYrUjg0=; b=Io0bpT/EpkpXSFLs
	D91WsCR6qVXIp/UbEh+epgzpRqth9vIzKDpVF4kI+bw1DeoY0rzGBSd9wltA1VfO
	O8OLJFFD6DiQHsaBDr3tlaMvNtvrjSGV+N4gD8bHLg1WfMZvseQkHFFO2hU3jD4y
	WOhU0hdEkQs07PdQj7NfpnJU/XZANUq6oW70ofjyNY9tfaq0GtswfqtQGrv6tuGO
	KPWUNqwhnbmn5b9qNQ0ycvRd33eNdoiv7HRK7MdcAxP0GCnkwXOD/EIvkim1eLzd
	93arcj2qwfEkGcsjHDpBChKRHLR4+P388Q635cOe/f+nEhbu2lnxb3TfgIaDy6rz
	iO3h0Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajagau043-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 14:50:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee23b6b6fdso6918651cf.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 06:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763736635; x=1764341435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4yMm5gRaB703rYohlWyjuL3DkCaUbLUnDXibYrUjg0=;
        b=jLod4hO0Ti8EUIc6Ta9odSt6HaZQL/SFnNbXc2cNFM+kFIq9bcuO3QmAvqEYPNoJtV
         vkKdnzMG4fqhTjaHbVSV70YCr4B7yuya/JGNt4gSvg1bhx9EKUi98J2QMl73GIg6l+LK
         OzJu8E40Vf1BXyt0QypM8gsLmrNmpWu5vldNPdDMvohNVmJdcW/b/kxwmvVeJaXNBdEQ
         qOkTqdQ5Zg/7spy77D/a+cqp2xWP3VrWI2t/7uk3C282uTGyAu6f2ckPyqNxhnAihVBy
         9rBzIIH8kW8DA5OM5T7h0KLLaqkFeJrFQGO8tUnydOcqs7bzypItJZftLEwch2X/oOma
         sKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736635; x=1764341435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4yMm5gRaB703rYohlWyjuL3DkCaUbLUnDXibYrUjg0=;
        b=NvhB4REfjpuwi9ZOi13rPMpDuvm0SEAeLmtUIb2Bj6ii5PD8rWahrtqw94lEgz6kwU
         q7A5pu3ITV7UOwDn8sbF2Z9JfTtKlW2aOqhVs2r/BEld/VJy0zW/CI6f4VnvRB+zquDs
         hmPUnI47rhqao/SkJKB3kext7daTDUN8tcEJ1m2fQs6CTXE3vHMDkS6K9M0CwqlaUVEC
         FaX5SbWVHxC8ZJPsII2Ru4Cub0kmlQbNUHOT+/V6tHbvThOtJRBOp4PXmuOBYMAowpBO
         YiWj1LHy+ihUqLONqFAsOhUImyH24X0rnI26ej69qE+ffsWPzVmCqtARRAOuu3XKR/l8
         SITg==
X-Forwarded-Encrypted: i=1; AJvYcCVkmr3j1T3mzNuF4IpooT0f1YuKUhsT7eCYM44KbCvg0qYEvMVQ2T8d7TTAN2UGXvk4ALP1ST79ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCf+oz6OpJOZQh1BaDSg84y2mQf7kDV4P7iNfP9tqo+pl495Na
	OWy8FfwQvc+mog0FXHJO1R+3zySECuuMw7kprVXWZe27JXc+aTeNXISuWpBTue1xZnx0ViLCEf+
	Ocea+JD1ifgy1Xuc90OAnqShToDwsPfaiV9uXN0WBz91hA5N8EJFRWFgv/oWweQ==
X-Gm-Gg: ASbGncvpN657SYuLmcvv/2Dg7SGZdcP5AGkZlWNNbmghFNXXPYXFydZfMbcreeaHtUX
	ABJi68kmYCJ/qZTNVz8B3qhx37s3sCP6uYcrsxV+OF+Bgyo33P6vE83e9pt76Kzw/PvrSCP/wQF
	hidjYfTkOUbVro7EISfUdKzxcddrbwKeW2G+0mzodhBNuwKxezJUZ/e8d8aVldf9tl6cSRJ5v2y
	2Nb9xavCsG4VHUDCuHTNlp7zsCS2BFh1m08bTIWO5biPZAniYdPz0UNaDEoDwP+bb6oKeVZUTyc
	j9brCEe95CKn8nR8J6DwVfK+lr3hAmepy1RAphhboCFteo+y+r546XhgOMvax5Ju5NVpf8darx7
	coY6H3S+7Wo0IFc1qiGNeA3gVrhF0yqTrVkC/nn52XYavYutJoSR8H/ZDUIfBcdpIhrU=
X-Received: by 2002:a05:622a:151:b0:4ee:1924:c6fc with SMTP id d75a77b69052e-4ee5883a43cmr25444491cf.1.1763736635244;
        Fri, 21 Nov 2025 06:50:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxj2AABKQQlV7xQ2ap9JjI3812ONi/dGdeAeCium8JGunYEAvRHgpsHbcoAjOYZET5U86ETA==
X-Received: by 2002:a05:622a:151:b0:4ee:1924:c6fc with SMTP id d75a77b69052e-4ee5883a43cmr25444141cf.1.1763736634749;
        Fri, 21 Nov 2025 06:50:34 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b5a46sm4708560a12.8.2025.11.21.06.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 06:50:34 -0800 (PST)
Message-ID: <3abea679-fc83-4157-9d2d-587354b85c68@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 15:50:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: warn and fixup on sanity check instead of
 rejecting the driver
To: Val Packett <val@packett.cool>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251121010756.6687-1-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251121010756.6687-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ce8FJbrl c=1 sm=1 tr=0 ts=69207c3c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2g0XylBXbUAb_SZQJ8YA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDEwOSBTYWx0ZWRfX8mY4SQXywVYd
 1BCAcF0wXt2jdcsLkKqYlZTaxWJp074GJ7hppHeKoTnQGayOYniz246bSBB2/sOSvvoC8WMIIz4
 3ps/r6GsOQj6MaotfPsQSZyk2kGIGH7GbRX9xSIhFzF/T0ONIvmM7FSIRa3hyxFHsBVjFSLVxk+
 KS+CQZ82ijJtzndSCypKf/nyYNjS/Dcx8flzmQjJNCQGj2yWKgJm1CWxtnQQ72KvRrB1ior4O+x
 07mt06g0/iuNOgwzwTl00ccsW8Ppl1kVEyBgpGne3Xihl0ISep4/r0YNbrXcR9/kcM318bafhaU
 gjq6vWw5FpQjNYebQ/AuhTjqylPmBClElMz4ubnBMZk5R3j/6dhumdkSg0N6WpKLT2FJgoQcoWR
 UZSTtARWslP8B7j77NQO85kh1v5WGw==
X-Proofpoint-ORIG-GUID: BxRqIaoutCosElKmvSXESVKenZgQGyfK
X-Proofpoint-GUID: BxRqIaoutCosElKmvSXESVKenZgQGyfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210109

On 11/21/25 2:06 AM, Val Packett wrote:
> On Device Tree platforms, the latency and target residency values come
> directly from device trees, which are numerous and weren't all written
> with cpuidle invariants in mind. For example, qcom/hamoa.dtsi currently
> trips this check: exit latency 680000 > residency 600000.
> 
> Instead of harshly rejecting the entire cpuidle driver with a mysterious
> error message, print a warning and set the target residency value to be
> equal to the exit latency.
> 
> Fixes: 76934e495cdc ("cpuidle: Add sanity check for exit latency and target residency")
> Signed-off-by: Val Packett <val@packett.cool>
> ---

FWIW this is caused by:

--- hamoa.dtsi
cluster_c4: cpu-sleep-0 {
	compatible = "arm,idle-state";
	idle-state-name = "ret";
	arm,psci-suspend-param = <0x00000004>;
	entry-latency-us = <180>;
	exit-latency-us = <500>;
	min-residency-us = <600>;
};

which notably lacks 'wakeup-latency-us', which triggers this code path:

/*
 * If wakeup-latency-us is missing, default to entry+exit
 * latencies as defined in idle states bindings
 */
idle_state->exit_latency = entry_latency + exit_latency;

which fails this sanity check because 500+180=680 > 600

(which would have been good to note somewhere)


+Maulik can we fix up the numbers somehow?

Konrad

