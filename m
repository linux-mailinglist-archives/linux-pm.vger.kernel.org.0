Return-Path: <linux-pm+bounces-40224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3DDCF5322
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 19:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEA7A300968D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6796C322B9C;
	Mon,  5 Jan 2026 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BWdNe6sk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W4B+P2ji"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145232570D
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637012; cv=none; b=OmJ6R7Jhkbmvymj2T9m//LpIGzvHmd+YJJHgonPQ+yHo/NTRwZbdiyxJ8Uy0oT8pZUIC9QfwqlYcxye20Hjmp2+y6zQUMS7XPlpKqQy28bnQjQFjIPV2onqNYC0NZUH8pXonJFd69ze5bluX9XGGAxUEA/j2N1LbiWypF1BLsBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637012; c=relaxed/simple;
	bh=9d4AsoILpOYhFOv7ydnu456xsSCdCM+PZdVzhXYes7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0r5Ug/mKR6TpuxjqXwjnFPyHieSa96zrVgW/Qal5arynl5xxLRY639ANkUTwFAIfTvO2yRsEJfIlAa39m45AFpnLjNqWbOKcJ3BjLb6hgLyEQk/xHX9fS7iTajvUEcm8BbwCPDQ639rdcIxLVXQguVFsiVIH+ot3BkispDfqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BWdNe6sk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W4B+P2ji; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605FKb6M1751495
	for <linux-pm@vger.kernel.org>; Mon, 5 Jan 2026 18:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w52BulNVFU+lzS+SO0meiPZlKCDrq/1WBOqtA2zReK4=; b=BWdNe6skBfbyahVh
	obkgpomt/z1pLwhVWwvvB3MRj/Jn0oMGSu2oXUDlTmNAaqy3RnfN87nbCiApuRkz
	MJrZ5hLEiQQHGxlp/+oi2/2pcNMGIAgo+UbVXNFDEadhMeHPaNU0KWZ72EISaA7/
	lXCDLwbkBzZzBnv2dLib5m4hQ/XEGXANQuQYKSYtr4+YkrynquB/EXfLmP/NmWCD
	iWfirE/yNHwK36DtiG1EbJUpsyzQkgpOT8/N+6Tv33M6XXhs4R+Nkh/wCYBm44Xs
	mBj2RKvk2NYfNvBWXWFtTCrG/R/zOkUMJEvcnD5vk3/HqXWf4NrOUiftU6rCt88r
	x6yovQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv00h06-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 18:16:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so299490b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 10:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767637009; x=1768241809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w52BulNVFU+lzS+SO0meiPZlKCDrq/1WBOqtA2zReK4=;
        b=W4B+P2jiReKtwQ0i0f3A/2vw242v+X0I0/FfI363JrzpS6C3/8/viEhYQ00KQr9H9o
         +hjNXpIKTivB++eR503X77tMcpZRyWzmqv5m0OqQ9juPfGKJnY9IkaxdVfcNHYMs78x/
         HKHaNukMLrJNnMWLvNaLScVSkzWUa7VX6D92jRkn04MccC/vBfmnj4/71EZVpDUyQ4XQ
         UI3gCf8Ox9pHFi8xBjsXMw+vHTOHZgReJUZMkkPUVTc/GchFHerMkMe0f+tOQUpnps8P
         X7uAVqFIispnGv/I1fGkxxBybmuCTnSWrMip7hYISD28Zn0jOKXsqxBK9lAB94jEguOa
         uemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767637009; x=1768241809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w52BulNVFU+lzS+SO0meiPZlKCDrq/1WBOqtA2zReK4=;
        b=uOjXLc9ui87TNtavB++7Wm2nt1VmQgnOZajXKEWMGcF3khCDlc7al1F9x3wTXicgGJ
         cHlxiVCppQBGynaXyf6mPUnSfTbsmsqZstYmLnDEHdlFz2eRDhIaUyAw1olGXmwAD0vV
         xdZAOqH+QGwB4JnEBiMy/w+wZGZAfPDGCFqRZwDFpBfzhGQWraF5Xez26O+TsCxGNXib
         cOA4KlbjNzVYo874VOF+DqZ4IgvMEPm5nNApNklMmq/v8bdrnUfsJADmEkqLvYwLvw9d
         exZ2ixSMyaahUJL3juHd6T0iQ6PXpB+rcoDuYMykzd0yoNVmeG0VRad0hVnk1wpfNm0K
         Ryuw==
X-Forwarded-Encrypted: i=1; AJvYcCXPAHtbq0LRIW7u0nhLdTAU96o8oekHX2wIhdiNM/U4eAonxDN04MIXNUg9kOiU/sExV6idJd2AXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4YmUq2O//AnY5DUkyM+9jJH6eq2NmOWYesAlUj/sjce4HVylL
	nEKhuRrwe4qRSO+/RzSxdDenSWm326Q6J4ltVtG5FbSM09GO5moBDypbBAWH/tWbcRAOfR3Ud9d
	mHnbNoM3ix395mK3y30cB5zMk27y8fw6qVc2isyiRXwqvR8Rrp2AJu7c4juY37w==
X-Gm-Gg: AY/fxX5H4tpOGYEBqIX+z+8Jo+EeVHedsNSj/lKKv+elsI8uyoqtO3kLITQ+kayTDiY
	aLCIq9C6yYCwWNELSVypOXDJq+4oM2B2nPTV7dYIigRaAkLy+LMQ0EQx02o4GuMxH2D9fj+PjXh
	TJWssZi5JVRKFgVtBu1tXAXjFXGimF4gI8xrN6lSjmZw2aXqcGozuSTu0axRglrR0V45aGG5my2
	KkB+2SjVA835/hxdpvBOLZigohn3N2JKfMqP4JGVvAdgdQBb/Yz6eSEczKncM6imLYmGg/BkrOW
	E1pjKKDPjYXSDfjQez+C6Qid156sCuMwHtEXNo9XcoHH4xq4vJwKSBySQvWPBo91eq94ohS+j89
	eEQjDuQNrYHEQPqSY0ulrW+z67RhDRbhPR2yMSy0bEn/cBiiHGKrPBsmZW2utt6LL+LEYD0RoJv
	qeIGDr
X-Received: by 2002:a05:6a00:3393:b0:7b8:7f5d:95aa with SMTP id d2e1a72fcca58-8188173183emr471281b3a.27.1767637009458;
        Mon, 05 Jan 2026 10:16:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMHu4SsqjEOd4T8C1y20KfwPG3UOOyJPNbJiN3J0S5bcm7ss6s6QX48g3Cn1Hda5n/4PFdlg==
X-Received: by 2002:a05:6a00:3393:b0:7b8:7f5d:95aa with SMTP id d2e1a72fcca58-8188173183emr471265b3a.27.1767637008973;
        Mon, 05 Jan 2026 10:16:48 -0800 (PST)
Received: from ?IPV6:2405:201:c408:b07b:6589:c739:d9cc:4910? ([2405:201:c408:b07b:6589:c739:d9cc:4910])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8187a42cfabsm385102b3a.62.2026.01.05.10.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 10:16:48 -0800 (PST)
Message-ID: <acbb37a1-3189-4d4e-5c05-55b13cd40a7f@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 23:46:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v19 01/10] power: reset: reboot-mode: Remove devres based
 allocations
Content-Language: en-US
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
 <20251228-arm-psci-system_reset2-vendor-reboots-v19-1-ebb956053098@oss.qualcomm.com>
 <CAMRc=McEB+yVYxropzsqLExZCU5Pd_iy_=5N3pTxu28-ZX=7_w@mail.gmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=McEB+yVYxropzsqLExZCU5Pd_iy_=5N3pTxu28-ZX=7_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695c0012 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VO0Mc1whj1O5pWEdU38A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 5lTf0dwGcV5U4rBmWSO3iNmKYQ39xYPv
X-Proofpoint-ORIG-GUID: 5lTf0dwGcV5U4rBmWSO3iNmKYQ39xYPv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE1OSBTYWx0ZWRfX/Z1MVf7RIL0+
 pVoiAkkndCaU/rIXam6TdMqXT+yZzCWU2Zcv9TnW53T0b28OdPCTjrY5APhwG3cj4x3y5dLm2mI
 GiObEuY8DDg4psI84WnCWOKN5LK13A7czR/CcP4VG1AdeNVameTir4qhjHU/Kq+jNE7T90KdTo5
 1M3+ouztaf1WKvC76me0tvbXGjxZ/BaWOeLECXuIyoTuW6x5P4XkQZ4eSVorF+iVdydeoEed9gN
 ZLl7GvtEEIpL2tXTTGrieYUA8ECsdSC8trlLZzoXc79WsZ41qqscqY37Wesmfa/S+dqs7Z5ep9b
 j3LTSH/mr3R1Uvt3kmKdMtoB/rkl/eiAiFHBtODp6lVW5OrNi+u+o/gC7UYtRAnBUAo+Ot+Pw1S
 pjxAzTe/IJ4AR6CrnCBWj6CO7MWeRCrwJv13mCgT9gY+T04UJQiSKWlpPlKTLcFHVlkky3oxQCS
 Pm6Pr1K1IILRB5m2x6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050159



On 1/2/2026 3:35 PM, Bartosz Golaszewski wrote:
> On Sun, Dec 28, 2025 at 6:20 PM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:

[snip]

> 
>> +                       pr_err("reboot mode %s without magic number\n", prop->name);
> 
> If this is an error, shouldn't we bail out?
> 
>> +                       continue;

This is not an error as per original design of reboot-mode framework.
The code as of now says, if the reboot-mode node has an entry without
proper magic value, ignore it, and, process the next.

thanks,
Shivendra

