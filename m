Return-Path: <linux-pm+bounces-39900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2121ACDA6E5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 20:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4CF0300E031
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FE334C137;
	Tue, 23 Dec 2025 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XvQqS6Dc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LzbqHjvF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E0346AD5
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766519720; cv=none; b=lHo0wmVxAdJLimPDMGT8+uyYUdf0UnQPAPDocF1qawdGzocfsa2vMdqZ6OWY4It0HUiXI0EqqqQl7nTEX87Pyiiombhf8vuWFgBaiu5cOGp8bBKHageSsjVtE3btriGYgmHxpsccIm5iemW+BjK/obxEWyWdp7Afk39FKVyQrxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766519720; c=relaxed/simple;
	bh=JeHtUOzF6q/IAIMn52nRpNimmQWWVnXvup3DxfBJg60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtzPewHskWRwSiZtbsnRMryxAhgC8OTLoK3+CLEpV5jO/z3DNlQavYiJMcQ5dN6tjjmfMb816427hByqsunv2blzl6JzpnrN+YCwTNl9RI9DTbUdFQeC8a3JL3/esj8s0Ir/aPLkFU6tpmS/iorQIxVNmdhCrUU5qVdyIPZ5Tfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XvQqS6Dc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LzbqHjvF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNHwUXD1245478
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 19:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+5BStTVKjVSt3rj+EAQ8x7sv
	1areOLZbU4gP/y3s9RY=; b=XvQqS6DcJadicDp6PjCqvfHdxaGbi/zdbR/XLKdV
	g9DwJpw07Mh56S2rqPpKQm3tCFn9ZaEO5m8N/lZ0unpNo0OGWtII7B4kLgPfo1JI
	FkEBH/sTqSj2q3B0w3biADdYKnqt/FGHwHUtXI+q7/B50m1vun9Mv/Iu75bWoarW
	BQp7IIIrUgnlS+FYFZoGfVFJ1VAe5GMJ/9IpdqQKOsYQanJmUa0mTiFBnipGkh+K
	F2/0KiNX36cDAVMkmnHYqsFj05IREPUu+4/c8vxxQ7EjMZYob5cyUK3+x4S2O48+
	aQnRwyl4I338dSgi0lHPH06B1qS27XwCT/ys5aZoAIXTew==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7u9cs94r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 19:55:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed7591799eso128454351cf.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 11:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766519718; x=1767124518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5BStTVKjVSt3rj+EAQ8x7sv1areOLZbU4gP/y3s9RY=;
        b=LzbqHjvFzMZc7b85ToZg5DDj/m9URRMcEKv+z21vr5RXFgzXYoKcs9NNFFJajvzRLl
         8LjHyVNVmNN2oEeoZeZw8tEUcNMTlRAWIJ4qQVm8p1muLwuJwqCKM1CBDujGZYbotcBl
         uvszhUg5hgWL0MYxx8yuDFVqM44qeGGtBH2naskoclS0xVqHh30t8NOATAI1zicdH4oN
         ogpyN0dndRZpl8WLiuleyA2qe81+jhncc93LMmKR5Fw7I1EKSDrZFXU6MoSnEhBRplyE
         x5+FWS/VXUw6ads0Pd9tQCxzX0d8XHAH6uO10xyyQetB1UZfSXhW4l+vtQDFzjFSisWQ
         UfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766519718; x=1767124518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5BStTVKjVSt3rj+EAQ8x7sv1areOLZbU4gP/y3s9RY=;
        b=h+6Q4fdMwx9YN6COSRnYaTzPi4hWbiwR5GNlrwBCA3+uvVW19ygdQLe3EP4Hez4qy+
         tbza4VYdK5/iaualFCuJcbvLLj02T123camkFgeOcWXTNPfDwJlVjBTG/cNDL7sp3CeG
         LRaTEbsMJsiAfZ0jvAIXKDIdAac1TUI0VrLjy5d/i2ouQ3p4IjD93tCn3y5aYoGqv+bd
         MTkdzKjNMcrbo0FhOL6flyXwoWGlRa4CvFXbhJIrC8grf02G+Mow9WAsNmuSnhTy5i6o
         kX7cygDwWv03rBrFkEZL431vTQiWhQKOKsIhCaa83AfIL3Wta5rlHdIY8BgDVmCkjBSU
         3o8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSSwDcuMo/+bDiivXEu0ndEQamM3z4Ngt140wnA1dGMQM1H4ErwAsAetaKdbNH1QGAjMbAaMie0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKUcJ84sjQeqykXqcoqkD2KudVkh2DdYvfRpqEngxgloHEJUH
	ZiSpL4gpEmLBfoAQkZ3McSIQ6h9Nz77IsY2eo1vAfAn0qoNHQ9CeppaZZnWOyfEH/ITAev4TROT
	gdEewCeUg0C0JaRF56Qh47pINApqcJU861dhRlV4eazlgJCRlJ9yelmbDK9x+Tw==
X-Gm-Gg: AY/fxX5iREWWXIbthccsZ1VUqih20sq6H35KIXkW4nttdKMdLYhUxxNPhR5vAXLS4vn
	BUIy7bVsSGvjJAkXIKRJIRc7r6a+VVtdXoKrzhUL9k6eusHPq/z94l/jA1EOjEBul7wrAKQgZGF
	AwiStbvq43QJGfhC95RHe8k1suA2o1vPWIXg9edwGmbF0PzAYfUGSdZB11mVF2rxIXsTj+l2bnW
	xZ6zWA22kjLswTb+1d9dbp55zEQ1yiXZiBnNTHdmaXe8us4u6h5Vk/3YYu6Di8zMIHfI87zsSec
	Hdhud9FhrBpTcoZR4IMODFVmjakxShbVyHgb7jIkh5cYJCOqyuGeojBepb4yHx6oosS/yzPRoah
	kLwHvj+LXMR99VnpFHCXznk4cyDJgHp5lWhJ12Az4OdtZ5q90Wu8d3hyHKrbcGgHa4cMhDghjPs
	zYdu6xiFhLOkBQ6ZHIC6P4vII=
X-Received: by 2002:a05:622a:4243:b0:4ef:bed6:5358 with SMTP id d75a77b69052e-4f4abd1c647mr227535291cf.21.1766519717615;
        Tue, 23 Dec 2025 11:55:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyl53CTvCy3DtDwqsEpaclioPGQPPivQcHmL7nD6zQOqdsOLZVeuyyrrHY4JSSia3f121UAA==
X-Received: by 2002:a05:622a:4243:b0:4ef:bed6:5358 with SMTP id d75a77b69052e-4f4abd1c647mr227535001cf.21.1766519717172;
        Tue, 23 Dec 2025 11:55:17 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812262b2cdsm38445331fa.25.2025.12.23.11.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 11:55:16 -0800 (PST)
Date: Tue, 23 Dec 2025 21:55:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on qcs8300
Message-ID: <n7ucdvjlvst23zbbcwenp7umhn4wgsznqp23scpknwqnd6tcep@i6lhp7va325w>
References: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
 <20251128150106.13849-2-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128150106.13849-2-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-GUID: uhUzl93hXNpbuR3kozoIHlMSKkXKczVE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE2NiBTYWx0ZWRfX1vKvb+d5sQ5M
 pRhy6pmx5k9g1dW6dog52JLnEdU0jCY0js5Cn+Mtxjev+ghN5EOpAKN9544q+nwPT7fB58mU4wt
 lKLfOUaFTN8DGnJi34K2lKgTYeTuzHOAdxnaOdRxoaNulV28H/WcyhEfGny/HVV6Lq5pL5ybHby
 aIO6M6TbbhMhfg6YN3ZrelnPf3Owfs83mm3Fa4kjZxa/biOMjHGKu9rkix0xmHX37cz8rnG6lSU
 ZARoq+GiUK2q3zNyPZBMS1JdVnoCxWn0Co6CtUVZzGJ6bHkefLvW3kt5oT75DCDI8scdQr5Chhz
 tqfFXPbuKFc9uXTsnd1wjlGJXiWhBtverD9xGlPWp3+Miz5xGv2sk0HKLb7/ae2TjtKsuQ7O2ja
 VrM5Mqk3KpPlZ+keaYv+91IuQSV7/5lAtXw6Cw5Bs2+O2A097IJWHXwNh4pUlUKjFb23n8eQExv
 39NyERqe2kzoePW1LrQ==
X-Authority-Analysis: v=2.4 cv=HsN72kTS c=1 sm=1 tr=0 ts=694af3a6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=dhCFs6qcdUbYmOXzIwcA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: uhUzl93hXNpbuR3kozoIHlMSKkXKczVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230166

On Fri, Nov 28, 2025 at 08:31:04PM +0530, Odelu Kukatla wrote:
> Add 'clocks' property to enable QoS configuration. This property
> enables the necessary clocks for QoS configuration.
> 
> QoS configuration is essential for ensuring that latency sensitive
> components such as CPUs and multimedia engines receive prioritized
> access to memory and interconnect resources. This helps to manage
> bandwidth and latency across subsystems, improving system responsiveness
> and performance in concurrent workloads.
> 
> Both 'reg' and 'clocks' properties are optional. If either is missing,
> QoS configuration will be skipped. This behavior is controlled by the
> 'qos_requires_clocks' flag in the driver, which ensures that QoS
> configuration is bypassed when required clocks are not defined.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  .../interconnect/qcom,qcs8300-rpmh.yaml       | 53 ++++++++++++++++---
>  1 file changed, 47 insertions(+), 6 deletions(-)

As a generic feedback for Qualcomm interconnect drivers (please pass it
through the team):

Please ensure that QoS-related clocks are defined in the first driver
submission. DT bindings should describe the hardware and it's not that
the hardware has changed between the time the first patches were
submitted and this patchset.

I see a typical pattern that QoS support is being submitted several
months later. Why is it so? Why can't QoS be a part of the _same_
patchset?

-- 
With best wishes
Dmitry

