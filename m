Return-Path: <linux-pm+bounces-35832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FDBBC75AA
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 06:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBED63B59EA
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 04:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB5324418E;
	Thu,  9 Oct 2025 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XHZFYLgZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21C23D7F5
	for <linux-pm@vger.kernel.org>; Thu,  9 Oct 2025 04:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759983387; cv=none; b=ciL3Q6S8tkQFEX+AbxE2l46ix7OtmmsuIEQ4G8m8tJaEppdpdQnoFQ7/r2iw222bVTDxWyDVcGDu/xcONypG/Lhx4j1OEK0uCJiyOXSack2vJPmTL7QW8HQIB82Jsl2fwyomrZvTuTHOTcozl8NHxnDoXWI+AcyuIEJH+8E4tuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759983387; c=relaxed/simple;
	bh=u7Lz+ubu4/1tXnCu0JIWk++I/7M7DTEbDaUucDlh2Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5u0JwpnCxdTP0ivG+W4xPilupoJYEIjzRzxlW6/X6jrcrPuM+UX5mPn2SuJfEyye1UN5Uvp5ewqbCihA8uTFybzrm2QYxePyDbsCQsJGULPIQFhbs702okKBOI/c+YE+mDF51B3MZks31koLx/Sb5t69UlhNac7OsbhvcHfgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XHZFYLgZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5OP6008831
	for <linux-pm@vger.kernel.org>; Thu, 9 Oct 2025 04:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z/wdRyhztOnxEiG33RJa6Kf0OnFSv+4r6++4AXqf4jY=; b=XHZFYLgZg2Ow6PRS
	JUclyU+TF0z+pY12ZqtzQNQ8VrlNuUg4Xhs2eCmPHAsMuCEbCoWLl6Ys5FMv8+E8
	89gfBpvct8WYZs9kbHFEk6okh2RczPluDauSmMVRl+lkdVU96NV+QtPgzwPUWJQm
	h6zb3/e4EaXHY0MBqFk9RCBk8n/AJAm5HY9N7x2IE8aDV9a4jkhwtqTyXNjLHRaC
	t0b0eyL2VXf5Fr5Q1DHjvqo+HSD0rwxgop4rzn/M3rRAe9+rD5erQYhu6h0y+N+r
	oyPAcpW4+DhSvZFelpYG8LFvhxtKhQzLFhLqm0ZFGIv9n5wijiJW9KMVTFbQUaeS
	SGgAHw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4n9e3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 04:16:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54aa407bc7so164864a12.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2025 21:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759983384; x=1760588184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/wdRyhztOnxEiG33RJa6Kf0OnFSv+4r6++4AXqf4jY=;
        b=LfAIlwscOA0KQvQ9EmVJC4Iz2dw5UIDnYaS4XcQ+dRLbv1dR3g4Q3RYCBypiPfy5YJ
         WdlXrD0n9bBh4W7JPPbwVRFECO2aTMUSrhhWj6Neu91t79DRUahwc6MUtf4UqHcj7e5B
         Enu7udYuuXGaOeOnPDDHMI4szEQuTh0z4T5Jylf1ysjrTIzvyvTNgcRmaFZLdrE24Y8z
         rmAKi0xD2ja4o3Nw6bAr21NCAdyCs7CZibdYG3/m+0p85kfIu3JVzhAGtQ39G6ujZU3I
         umxT89Sj3WGTS3QV3beI0n9MD0b91iGGNgZn+L0jT6wprKE8ovwF3yr48h+s7sNCDHPh
         k2IA==
X-Forwarded-Encrypted: i=1; AJvYcCXozWconmpy+yZlfYlxJiiJGjoz4UV+yicX6pHXX2+gca0Gkf2DLNT+FU4hMd9Jx+fPD9OeERdDpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMR1oYndsAxRS4zMHgElT88OJmRvA6t7xhOKZqyygH2JyzRXt
	TN02LP5FIT5ngMy4B0CTA7FeeGyPQGZwUAoQFsLED3HDES8rI66BhUcmjqO8TGaFitPDI036d7M
	/qxnm8g6n2RhEYjWgyvjYsaIJvQx04gbGoubhPR2d2HvDvifYPa5iNTacasw/IA==
X-Gm-Gg: ASbGnctO7TnRd/KyWEk36raed13LYQ6ZtqIFzQyeTUUlPd19VqE5bpHLHsHrIUkR46v
	3pkvGRkWCulomhpuSg0yuAUYzAoe9H+L1BeRvGY99dXwVS8hyhdR8x/Ud0kQW6jbWw7j5EzF1ui
	FsKxy2+fnwEfLdR7fXB81qyR1FijKg6OdCr8IHiqMFsDKYBS3p2PwzCciHSUuqtAat9QDJLohzh
	xd8XCQB29r7CWxCLac3CdEO7h32nhn2ZflaSBg4E+1JWch7S4somwf/Rozzwrm/A0097j/ldIu7
	jEmxfoPNuvd1PynAIUPKZhHfcC9kGM0gi7Zrx+Ux2TPGso/Mu3cl1jFxh5Lt1bb0bEVuOCQkkEX
	DrBjnmkHe5XI5mH66s9ooWJg6GmDu+nMozoghbGTIhA==
X-Received: by 2002:a05:6300:619c:b0:2bc:1f29:1232 with SMTP id adf61e73a8af0-32da84deb91mr4229026637.7.1759983384467;
        Wed, 08 Oct 2025 21:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfQd96vAGN51vtHjr82AtIlkinA4yVsIrZBAw+ojodJrmawHih66RQcFW7/2SrnnG0euQhHA==
X-Received: by 2002:a05:6300:619c:b0:2bc:1f29:1232 with SMTP id adf61e73a8af0-32da84deb91mr4229010637.7.1759983383989;
        Wed, 08 Oct 2025 21:16:23 -0700 (PDT)
Received: from [10.240.201.55] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794dbc5a6c5sm1359671b3a.54.2025.10.08.21.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 21:16:23 -0700 (PDT)
Message-ID: <090c08f4-b1e8-4af4-b665-7894a1443ebe@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 09:46:17 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 03/14] power: reset: reboot-mode: Add support for 64
 bit magic
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>, umang.chheda@oss.qualcomm.com
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
 <20250922-arm-psci-system_reset2-vendor-reboots-v15-3-7ce3a08878f1@oss.qualcomm.com>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-3-7ce3a08878f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e73719 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=xyQZWzCWjP-v2z6xiYIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: I7ALX_Fe5F2A5_QkurB21I1OeRMhxMSB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX3yhkQtutrTXs
 W/nu6GOM+JZsgtEDAnF4lawNxoYHMA20y1ZYiNY830tO/IZIZtjI1eitdj1ijsFma552+ZlUDYj
 wEDHtXasOkY2abhVJnCuIemdrmBJ4l/yPa9IZU3LGMiklD0qxBa5qnwbMzKz+kdVAnHnWc23+pp
 tVZSZdKMR+7D52VjUR30nfPS/MCM7tR1Jk3q85k4Ib0f5cD6uuACaP+RybgZWpalBKHJ3Jf8p4z
 Ecp50KuL2TmaPG9HMYVOnP3kM132Enz/Y6j1t4uxP22MrnuigAt+Og2cDhRvJUKq/u/iP9QwYxk
 ldjE8E2NS058yrXfDV0aJ9MywAE7ya688DucOcaehbGYDKkZAwyQnWRKW7LGZx40SH/BueQOdLS
 k0NztxhPKIYXif0yxI5/e7OUDuZjsA==
X-Proofpoint-GUID: I7ALX_Fe5F2A5_QkurB21I1OeRMhxMSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 9/22/2025 7:10 PM, Shivendra Pratap wrote:
> Current reboot-mode supports a single 32-bit argument for any
> supported mode. Some reboot-mode based drivers may require
> passing two independent 32-bit arguments during a reboot
> sequence, for uses-cases, where a mode requires an additional
> argument. Such drivers may not be able to use the reboot-mode
> driver. For example, ARM PSCI vendor-specific resets, need two
> arguments for its operation – reset_type and cookie, to complete
> the reset operation. If a driver wants to implement this
> firmware-based reset, it cannot use reboot-mode framework.
> 
> Introduce 64-bit magic values in reboot-mode driver to
> accommodate dual 32-bit arguments when specified via device tree.
> In cases, where no second argument is passed from device tree,
> keep the upper 32-bit of magic un-changed(0) to maintain backward
> compatibility.
> 
> Update the current drivers using reboot-mode for a 64-bit magic
> value.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/nvmem-reboot-mode.c  | 13 +++++++++----
>  drivers/power/reset/qcom-pon.c           | 11 ++++++++---
>  drivers/power/reset/reboot-mode.c        | 19 +++++++++++++------
>  drivers/power/reset/syscon-reboot-mode.c | 11 ++++++++---
>  include/linux/reboot-mode.h              |  3 ++-
>  5 files changed, 40 insertions(+), 17 deletions(-)
> 

Reviewed-by: Umang Chheda <umang.chheda@oss.qualcomm.com>

Thanks,
Umang

