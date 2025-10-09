Return-Path: <linux-pm+bounces-35831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B56BC759C
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 06:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B73189FE6C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 04:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A334B244186;
	Thu,  9 Oct 2025 04:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kWW3pZxi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011EC238175
	for <linux-pm@vger.kernel.org>; Thu,  9 Oct 2025 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759983301; cv=none; b=HD1sIkexSUF4j6AErOC0qWSlkQfrerX6ILvsRJ2bob1+2m7PW4F1e2119V/O3tI/yMwf6wkBV8IOtDAFsMu3H45HAdVMELgaSsAEzOHrw33oXtTuDopJChtBYWL33zYXMgt0sxlDkT0NpzHDTSkzrLcab3xst3X9gCUYkmuXyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759983301; c=relaxed/simple;
	bh=oe7VuLNsgGCgL70KMCtbXqjMfR3AriFiWIM7bP1/9eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph8XVeV/o4VsE12IwYLdOsRfx8sLO9syLiRJInudmtWwNsVLc0NxXottVwI6WP39hdW++YUImyHUe/Eq+qmDzOZ05P+KY82SXQ2ZGxfueELni4Qsq9K4Wf2KQTR7RhgZFCJO/iiVTMaTDcb1eTbg2SaDZVDemEUw/yOJbELMXK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kWW3pZxi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5G3H001377
	for <linux-pm@vger.kernel.org>; Thu, 9 Oct 2025 04:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/js+3taDhrejgB7UpAvscxRkqjCCg2tof4BrdDtD+8U=; b=kWW3pZxibhYsonos
	xFC0Upj6XzEn7h5r4ubL8lgzYXy+Q0HtPkjbzsqXRM18PRMGM9cyKHwjDEX5qYPF
	ZY/Wk1YVir1y0qjNR0J8silgm524wvvCaPrdA7oPaZakeKmDjFwD1z8tcfEDnThV
	5QznhUwAmIjzmOZX+M+Nxokx/dnz/dFtADSLWaq26b8eJWvs0LlxjFrqchiU34G3
	ItF5lxyUg9dRPsSDfRq3XEKOPUIg4qGP+O8Cqz0nRPK1CV//hcjxz/ObvGFose9E
	p9Vk6gT5CEWB81YKxm00drPgcowOoU0hrMVX0jKOiToYs9PRLDp5MrUpQBJAJQ1I
	D4TI7g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ksebc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 04:14:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2698ede62c2so1608735ad.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2025 21:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759983298; x=1760588098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/js+3taDhrejgB7UpAvscxRkqjCCg2tof4BrdDtD+8U=;
        b=fdQ1IYvu8KHAmMdgOkSEYDjP+K15vueHip8o1W/exA93G2BDPJKjEHQYuLifbKLMPH
         x3AmzJFSAJhriWWvjTMqlO1HkLg7UTMdbdfzK+1Q1zOehelw3xDCyquvJvh21FBgVSiR
         tCgeI7X++Ep0dSUiMX6Zc1bWG3o6LkrlRbtKxTgdx3to+1xfLme+yqcRjwMf1tdykIxQ
         cJZPVqjOjLNNsP4RR8DoNFBYMvqT2TBrgYYGMOrnnBJgCFx3g8M7dCMhhs7mDWiBhqfr
         3hfP7L2fb32Mh5r8TvcspjyQSiTD0/lPdJn7QuWmqhS93TLN/4LFnF4y07xDGHugz1B4
         MWLw==
X-Forwarded-Encrypted: i=1; AJvYcCXeKoTBwZ8cFGB6d1FKQ07Cz8b/PgDlqEjd2Bpqas14ZoedqoKEcebsFIcRjbxbxPi7kfn0d/wPIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUHN+cU0z4/yEElxuOJ6Cf1847+IO7nRfSCgG1+TM1MHFV7W+
	9BuiD+Bm95QAgyZ0R4g7qVjTYYBfHIP3yGLstyZLt37X77Ty1YdVvxnWzMoIgg/wg+mAGF0m2DW
	GxWos5udzHDLInRJBmmCS2D4m6WbXxr3bQJr2n00/KhP8Lcn6MW8MlKV4fGVFVA==
X-Gm-Gg: ASbGncte9Kp7YF7Q5YkNIywozwaZ3i2S3opBhIdjG3hhu1vKvwIxzxa0YoasCpeGsn0
	onrNG7eMwueZ5WBeAhnsPvRoKmuxg244yPe8/+75Y1PQ7mqfE229W1nYYk+p9WKFM7JTD3cq5X+
	JVDAvfH5RRiKyyFifjOKbztrGhyBOCWdZZrFY9XtsHxjHEPxaPeEPwJSecGIAZeytIFYkKZUMp1
	lstM4HJ3iQqF3T94ut1vsWf4SqPaqaqI5GWynuw86YhOvfGvjfaJAKLZt8iDlBsrw+NLcvm8/2Q
	qcxeAnOjXA/o3mZokApPp/eaFhenx0YypaVBvi0B2STjdlleZNamduafh6ZYZ9OArevmH+BkhUy
	hzcwLurHCA80IU9AUu7BznLceZWUWRpoVgtihpp8nZw==
X-Received: by 2002:a17:902:d491:b0:253:a668:b638 with SMTP id d9443c01a7336-290273c598bmr46026545ad.2.1759983298274;
        Wed, 08 Oct 2025 21:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUYcLZvr1TDduUWf5IW+YzwXsZMsBV8TnFvLqPUsLDWvggUY7/sMA/hO5Cu4Ze/JJFPYsNLA==
X-Received: by 2002:a17:902:d491:b0:253:a668:b638 with SMTP id d9443c01a7336-290273c598bmr46026265ad.2.1759983297782;
        Wed, 08 Oct 2025 21:14:57 -0700 (PDT)
Received: from [10.240.201.55] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e20f8csm13510955ad.49.2025.10.08.21.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 21:14:57 -0700 (PDT)
Message-ID: <9ba7562f-bf6a-4759-b4a3-aaa80c45e247@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 09:44:51 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 07/14] firmware: psci: Implement vendor-specific
 resets as reboot-mode
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
        Srinivas Kandagatla <srini@kernel.org>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
 <20250922-arm-psci-system_reset2-vendor-reboots-v15-7-7ce3a08878f1@oss.qualcomm.com>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-7-7ce3a08878f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1lT6+3L3UxIt
 75Lwzb14E0mrLM++3V6JPJkdv9tz7lujhLwsBO7LORN6civKqzOusB68VVePnuVUHzphxaRc2Li
 iBfh29UI18iDRA595J7qMbKhtdGOAtM0XlFP7FbA74EDZ4aYj2lWIMTPswI83zHeEA+G3v/VMly
 JBKvbNie+lL0NJoqVStd7zLGo7RGwc0N7J4uDcT2jYggjwNKqx1r3Rf7DUQZNqlfiJzQ/ruA69x
 G6YivZPgRCFqzLNRgjR+eaDbVvU9hcqtuKMQ/M5yCMSUdNLUOaaqvLa2vTDhf/Et4VEzP8TqdAl
 +G0yQ5OK0K8XCQ4gERHLdqecpXzL/bcErD1NBwrpJilhwcPyNJ6Iu5spAQQDvRovz3jVC7xrMK1
 BX82NHMsKhZBEej59nlnHPEHhzqkvA==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e736c3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=yVxwAGkkkSKiqd9de7UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: sJYOhQ39nr85t3Xjkj7avm-zbi7Nca8o
X-Proofpoint-ORIG-GUID: sJYOhQ39nr85t3Xjkj7avm-zbi7Nca8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121


On 9/22/2025 7:10 PM, Shivendra Pratap wrote:
> SoC vendors have different types of resets which are controlled
> through various hardware registers. For instance, Qualcomm SoC
> may have a requirement that reboot with “bootloader” command
> should reboot the device to bootloader flashing mode and reboot
> with “edl” should reboot the device into Emergency flashing mode.
> Setting up such reboots on Qualcomm devices can be inconsistent
> across SoC platforms and may require setting different HW
> registers, where some of these registers may not be accessible to
> HLOS. These knobs evolve over product generations and require
> more drivers. PSCI spec defines, SYSTEM_RESET2, vendor-specific
> reset which can help align this requirement. Add support for PSCI
> SYSTEM_RESET2, vendor-specific resets and align the implementation
> to allow user-space initiated reboots to trigger these resets.
> 
> Implement the PSCI vendor-specific resets by registering to the
> reboot-mode framework. As psci init is done at early kernel init,
> reboot-mode registration cannot be done at the time of psci init.
> This is because reboot-mode creates a “reboot-mode” class for
> exposing sysfs, which can fail at early kernel init. To overcome
> this, introduce a late_initcall to register PSCI vendor-specific
> resets as reboot modes. Implement a reboot-mode write function
> that sets reset_type and cookie values during the reboot notifier
> callback.  Introduce a firmware-based call for SYSTEM_RESET2
> vendor-specific reset in the psci_sys_reset path, using
> reset_type and cookie if supported by secure firmware. Register a
> panic notifier and clear vendor_reset valid status during panic.
> This is needed for any kernel panic that occurs post
> reboot_notifiers.
> 
> By using the above implementation, userspace will be able to issue
> such resets using the reboot() system call with the "*arg"
> parameter as a string based command. The commands can be defined
> in PSCI device tree node under “reboot-mode” and are based on the
> reboot-mode based commands.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/firmware/psci/Kconfig |  2 +
>  drivers/firmware/psci/psci.c  | 89 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 90 insertions(+), 1 deletion(-)
> 

Reviewed-by: Umang Chheda <umang.chheda@oss.qualcomm.com>

Thanks,
Umang

