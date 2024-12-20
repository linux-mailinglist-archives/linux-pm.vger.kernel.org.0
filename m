Return-Path: <linux-pm+bounces-19581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38299F952A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 16:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B55B18852AD
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D708218EA1;
	Fri, 20 Dec 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWkrGgGe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF180218AC9
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707729; cv=none; b=nNUhMkPibttBYPdSjLzAyw0fHjfNgzDikwmqC4Am+JuT/6NZIBzZejIww73g9dLUTxRoEJVyiYdGIYmAX1Dm3OVp+uLaTYn5BX8E3dH+nbLS0x3G2JNcWindK4m5k2Ljirn9aH8+yCNZJqi8kbvDBRhDB0vW2GCuLzh0YK96Ph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707729; c=relaxed/simple;
	bh=kg49+uaoHpj7D++o6jRL1ADBtrJA1aWRF63Yb9kp8ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qy/SD/ykdcDSfiaJQov5Bm4e/LgWP72W6D3Z4iiSU6IfgdJsS7g/R7f1jNQIrEQNiZ+RlFJr+6tnLD5riJtL1lY9uD0oCG9FhHPjvW92YxjJFPq2RRvdmp78Aal9h6p/OL2OTs0VJ4D6PDmBi0CoT5YmM/ftxm4fUaylqTsOdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWkrGgGe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKDHXBP017499
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 15:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9pdRk1FNEwE15r/NRpb5txdFYJ22rYoCmR29SeDLD9E=; b=CWkrGgGegK3PkMiY
	21XQ7nuYVRZdULWoQulYqqX8aAHE8jbyNEdEg73YmDZVSxvnURpB4D4bUA+m/kTB
	LO1CY95KY8IVvkA7UHxeL2jUR6ya8zlQljpYX2cWDemMtBTBxIwyQT/J9CgWKBPW
	9sUxYrb6RRpvNNOJWaxLc18BXplb1tD5Rb/YtnO2odLR1Hg4INSoaaBIxhhHsKuV
	/o5/i66CKjOmTe92spTR3caiejJbu24r8RB+RllT4HwZgBQbPp2iYU0wkl5Csv5z
	tCBy0CRXjZdO9bhgYqFHuT2Unuu0R/Lo0AnPZ0heF2W92bgaIriX8GZz9nI059b9
	qGsaIA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n9b9g977-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 15:15:26 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8f15481bbso5736356d6.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 07:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707725; x=1735312525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pdRk1FNEwE15r/NRpb5txdFYJ22rYoCmR29SeDLD9E=;
        b=M3IonlDD0u8F18rf4tAuDHdRV4aAxMvTvhJpC1XK0NgLpPv6yvNvA4jgAjTCFC8ssD
         aSQhW4OFyK5C8XaHclozdLlF2ydb3M6tyWAlEkR5C/NUxlIFeAAbCDpzMtGLrbOz2VNc
         3MnlWJqLKMzNg0Zm1O8ho4bO6f2hDFzmjXfDN6qxjNB4GnAWzyv/ShO2NeAt5RTUX90w
         UHr+p7D7LT1BSmyg+ECsAKfm6C0AbGZh/0gb07HAr/sEx+0Um9/b6s5GvI538LIk/BnC
         9WxMvhnrKZLsnssJXdYbCgikkngfFpHo1/VEvVQy54Rot+yqMGuz0r2dnbeY/uPSNEc7
         cvtw==
X-Forwarded-Encrypted: i=1; AJvYcCXbd3qpNwRzGQy+LDv3yLpwLFrlz3LGx3x6BQ9TthyHsiEEUAZj6kbeoWGc+27917cAvkIfdC/0kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkv91/q+j88LlYNZiM3q6xRYy7wY8OJ/acPa9MnY6OEBga2xP
	nrvshcPL+IJss4TW4MpF/3BrUwtDstPFBb7Mw+HO57E2B0R9465PIknIDEk016Q2DJpqfX0vKjj
	wOoi+1aqKAG2vyUGA9ewRm88k7VqzYWUrDNLoaAZTyHUGiC1QSY+1Jh/b/A==
X-Gm-Gg: ASbGnctynBDZm9/nxatg4lJRa3bPpWE/PcV1/8HBeVcZ3Gb8EiX3aVBN40HyJFg8La3
	fCDQ9lCDXmKrjleEezXJWrdOgYw7LEDL7a9cH84yfWN0SclOuvQz8FQtqN4N0UycapxoFnSQA2D
	k/TYnJ573jxefpAvjib5zWF/udO0qEHTUOsrYoPuXwKDl0KugqfyQ9P2XpI/ABbxIZez+Smrqkf
	HdOcL/xwQYFhETjaXt77MWzxi8NDQ523v7Hk+kshs3TDPjiliKGaFQ8y6jKDlxCmpNpaSiVlEn0
	UX1roSEnDvX2y8Bcd71aGr1ON75UNmzXQPA=
X-Received: by 2002:a05:620a:2454:b0:7b6:c8a4:ba09 with SMTP id af79cd13be357-7b9ba7be496mr170655485a.9.1734707725202;
        Fri, 20 Dec 2024 07:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD5koPpJL0wKEso3nr+u+1J+IrI3s+lO5cyWCeEsrPYRbTAkLqKhgQ19j1vhTaqjkKzFcUzQ==
X-Received: by 2002:a05:620a:2454:b0:7b6:c8a4:ba09 with SMTP id af79cd13be357-7b9ba7be496mr170652685a.9.1734707724779;
        Fri, 20 Dec 2024 07:15:24 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a741sm1818444a12.12.2024.12.20.07.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 07:15:24 -0800 (PST)
Message-ID: <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 16:15:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the
 user
To: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki"
 <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org
References: <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oY6ipAgO7sAPxZndE5YIMS7SB1Jb5zUC
X-Proofpoint-GUID: oY6ipAgO7sAPxZndE5YIMS7SB1Jb5zUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200124

On 16.12.2024 5:42 PM, Rafael J. Wysocki wrote:
> On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
>>> We need a PM core API that tells the device drivers when it is safe to powerdown
>>> the devices. The usecase here is with PCIe based NVMe devices but the problem is
>>> applicable to other devices as well.
>>
>> Maybe I'm misunderstanding things, but I think the important part is
>> to indicate when a suspend actually MUST put the device into D3.  Because
>> doing that should always be safe, but not always optimal.
> 
> I'm not aware of any cases when a device must be put into D3cold
> (which I think is what you mean) during system-wide suspend.
> 
> Suspend-to-idle on x86 doesn't require this, at least not for
> correctness.  I don't think any platforms using DT require it either.

That would be correct.

The Qualcomm platform (or class of platforms) we're looking at with this
specific issue requires PCIe (implying NVMe) shutdown for S2RAM.

The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
state by Linux as of today, and I'm trying really hard to convince some
folks to let me describe it correctly, with little success so far..

That is the real underlying issue and once/if it's solved, this patch
will not be necessary.

> In theory, ACPI S3 or hibernation may request that, but I've never
> seen it happen in practice.
> 
> Suspend-to-idle on x86 may want devices to end up in specific power
> states in order to be able to switch the entire platform into a deep
> energy-saving mode, but that's never been D3cold so far.

In our case the plug is only pulled in S2RAM, otherwise the best we can
do is just turn off the devices individually to decrease the overall
power draw

(simplifying some small edge cases here, but that's mostly the story)

Konrad

