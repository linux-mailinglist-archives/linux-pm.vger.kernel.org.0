Return-Path: <linux-pm+bounces-35721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008BBBD70C
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B955C3AB365
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E071267B9B;
	Mon,  6 Oct 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BNMVWT1x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C12676DE
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742876; cv=none; b=CwnovdZMk70ZLMaY3cqYeacpkC+lTYNd3B9UUWrKvHND+JxZHmqn4lgtOEmcAO1OFVz7YkmcYLp1lRHNqfpyKd+MufRzOHmi4MTpnUU/TgZGTuxDmbxchwyLP5TivQ9pquQD4D2kLGsXR/bZtiahjhJanRro0WP/EwSYR8wdPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742876; c=relaxed/simple;
	bh=QU58PgIDoxyXxvtrv9nIkUTP1aP3Ji5RwiYuSuwuyDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtUAsC9BoF2/RC9LaehdHtIfxxIQiC/qP5h1ReYUe+5E4PlsEbquvIHN2dVGCFT4g5/G1jpMENkmvbHHKsE63egnm5Y4KnhqAuq5XlDrqYnop76QmpIRJKWNgTFHMXpsO6N9UMe623ZoKjzKLSWhZ2SUiJ92XXZowQtcvWfRZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BNMVWT1x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5962hBro026598
	for <linux-pm@vger.kernel.org>; Mon, 6 Oct 2025 09:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/pcwlnjS2vmra4LDe4EMuIdtHHOf5Cpr9bJvDe22TZQ=; b=BNMVWT1xSfVjrHr6
	prZKemFBfBPrpPFDPdzuWXdSw/eyvjjkfTuK4EC8BfbYyenDb0KTt4araD0L1j9t
	pTlpG5+WoZtokGsVfQ5tw2Y/mOKz59A3ZRjCfQdUI6jaXjJdcvYyoIygeobayeiO
	9181KHoE0VCsa0eljEi/nfPmUr4T5gmOAjV4p7IDEwwQVcCRyKGeQFJlOzdsajkg
	8az/qTMih45U1obx60ypgShyItRAqI3HITH/Ux8heegdywKkizP4dnk0yQa8hNOL
	ZuVeet7oenEJQJPfT3bT5E19z0cSKhefPipEG9jRw91eBAw5CBRLNCNHseODcqzv
	92N6MA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ju5xbf5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:27:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e231785cc3so20410071cf.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 02:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742873; x=1760347673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pcwlnjS2vmra4LDe4EMuIdtHHOf5Cpr9bJvDe22TZQ=;
        b=Tpy4OH4jX9Oo2TuaAUOv0BactUWjqXYqW97073mXoAmEE32apJL0NhpJuBLGz3Bm4T
         X0l91ZuWiPgc8ysyepVLCmryX92H6VYg9bunEv0bwDcy9KbZ0ftrHlAoKhIWburjmOyG
         WgSlUFplHxSAqkft7Q8KfraqYyAwwgXt1sVqNxIM1XYdaP06jo+mnCOzqEQvz7tPF2TL
         Ocwcn0YXIeNdME2eRFZ6JvUGJ6zMjUKsNNnGY5nO8RoS9e5jgnlF5aiyTIRFSvO9giR9
         1A1UIesHEib+cvFFA+//SZxa7+Y6vUa6qAJdY2KWiayGm7ecndiN5N+wMXKMxtwToxVg
         GyRw==
X-Forwarded-Encrypted: i=1; AJvYcCVfDQEiN9ob/Qb053cLEl3c5RM9kZsQCGPK9h+HgEGDEfg9Pi+1RgV+StytEQJSKwdMoRrMhn5woQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKAnHN/217uhC2+F8DDJOBsrHYsfGOjkNyugg+tNIWAPCdwuu
	oATwF5t9NVkjAC2px++pyXt9bKUnSjwtAX7WL7UFUG0iS1q3EjQhLRG6p/wW+nCBxuw2B9xlgMB
	rYldrQprP6bZsYe2KRCXBvaBI0EaySka9JTQJOddOfd8yySfw3aF8IbGDZW0EPA==
X-Gm-Gg: ASbGnct0YTg0ptn2SCVNLRjDbd7apfz2aPt9oBalhmSbntCqKI+0Sg+6ms8tZ1sELhy
	ub/dv5H9lOmB+DYJtpHtjBq0DEbPpxk09LNM6G9QEJXD3VQwIvMYmCnpClQCFfvncfSt5R6+XIp
	fF7V8EjgmLPCR3ldPaEs4LFwmHWmdAj4HdWN3YBn7upJIru0gp5FhO7x+RJgcDQvnQ9fLgbbMql
	cAkUwQEbON/VkQ23JHRu3xeEEK5DLb3UkeOp9VzTZtcDtYH3MF5kB3QHh/meV90i464/dUedT/b
	pyiernf+rB8MbUAXTUCC0zQQLrERNkTPgKmnFVQ+IFX5MyGJEArcXTkBnP5OAxkGZ7r9oXIPGI6
	EpCBz6UnZYJ+Ulrd+NriUq/N1fbg=
X-Received: by 2002:ac8:5f91:0:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4e576955b55mr107433241cf.0.1759742872939;
        Mon, 06 Oct 2025 02:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk+OyISCU/gYVLyFTdyZBlaX8VxXHWghQ/t1CCKjFjUKk15AZPAUHnnfYB9omxMiCPUC3/Ww==
X-Received: by 2002:ac8:5f91:0:b0:4b5:eaee:1c04 with SMTP id d75a77b69052e-4e576955b55mr107433051cf.0.1759742872419;
        Mon, 06 Oct 2025 02:27:52 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4f1d1sm1089257366b.71.2025.10.06.02.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:27:51 -0700 (PDT)
Message-ID: <4a442f02-405d-4a88-bca9-92233e602653@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 11:27:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8996: add interconnect paths to
 USB2 controller
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana
 <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
 <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FooIPmrq c=1 sm=1 tr=0 ts=68e38b99 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=81On53fQ4K8t90Y-VgIA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: e28jzAOO7J0X5QKIB3zeYrt5oO3j7_xo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX0I9w+BUnRMWx
 rEgN7XM+/2YUhtT6WsvP3UqLN7IeH3nK2+QfEc/Yc0Tj2H5EuHzNS3Th1Z2Agu9iDgmxPx3ykxq
 M3hrdWzbbkLAalSBMJlz8fWRSYmjmS9Wtpdjv2hb5KmnUBZLkLv62VXcOVRWBP2VNUC8CpaGG9L
 TudWz8jvxlnNjw1SMFCtKFm8dFF/ESSIZIJPMQ/Xaj9sf8ljyC3Vs7zxg4eoC28m5W/8SF3aBER
 K2aA1FupOqmTQXcK+8Oz7BogYrV9C4IAd6QpoMkbr5H61fcLlOyN2b/tIRkfhXHnYjJ8YWgQLVy
 Po9zumh8yR1w7tJmbX8xGinXdEk8nDqQ6lBULwGIfxUSiSGA0qlr8oQDXcMDh5ObJ+/XfBsI9oF
 YBFbn975h0slYaWahIhKAEZIofD7SQ==
X-Proofpoint-GUID: e28jzAOO7J0X5QKIB3zeYrt5oO3j7_xo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On 10/2/25 10:53 AM, Dmitry Baryshkov wrote:
> Add the missing interconnects to the USB2 host. The Fixes tag points to
> the commit which broke probing of the USB host on that platform.
> 
> Fixes: 130733a10079 ("interconnect: qcom: msm8996: Promote to core_initcall")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> ---
> Note: without the previous patch applying this one can result in the
> kernel stuck at booting because of the EPROBE_DEFER loop. I suggest
> applying them through the same tree in order to make sure that the tree
> is not broken (or using an immutable tag for the icc commit).
> ---

with that ^

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

