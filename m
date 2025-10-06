Return-Path: <linux-pm+bounces-35722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23705BBD724
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1771894128
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8F217C21E;
	Mon,  6 Oct 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FtI2+KdI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD9168BD
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743059; cv=none; b=rGfADtq7RYhxsCYtR5ZpPr+aPjuJbDAURLkmH/IWmnTtATffQqNOoWfs7AF1HVry6/GfpXHS1tCZqOAaWCxTqaFKTIesIvvojqbFbdjFynpOucGrWDagdtUxl1ojUEYiqbovmIqzYKAfHFdR02sjqD3kzbasAEiy6VEqpwOMUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743059; c=relaxed/simple;
	bh=leaPRdjhUAhu65EKAwyIHOe5Bt9yDIhBkariT72x9hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4FA4x4QNxgzgEaxfqh4BZQizpCmXIC4MlAgH2pTOpJom4ONEDthurb1a8ocuXdvLAML25rF13oRUQZgY3Mp7yPipKXZHlvigiJsucBXO3RVIrmXCiBmZPONQ7XOj+hgPEydTF3PzAGF4kVL7bfz51VC6Pg2fFc2+P1pBQ6mSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FtI2+KdI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595Nrl9f008637
	for <linux-pm@vger.kernel.org>; Mon, 6 Oct 2025 09:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vops52gUYvZ3NLTbdfUXQSMexbJtRLHsZnvJ7nngDMo=; b=FtI2+KdIXV07hdY4
	laJIJAarmK+hNExe9mi4lzgX+cXYQ04PSC4NXTEkyBjBALpo8h+B2Rh8hleKTZ/6
	PegV9Tqbq3bEp9UUNHfhHUjnZOcRWIrclthWn8LjIUlvQKzNMvuBebPIeqeoKeDj
	PuOtS31KiwfW1BFEwgq6xEM0LK11c1HIAWNas/2oWvkopE4PFkAuX/kIEk8pgKpT
	kE7170gd+B8MA5WsVOXcOG5b2zxzfE6Aiwrt2xcotbDA4wsfjMErbqM/6zfUCPv5
	HMIYeiehPpm/J/UeSkBChO2y2gnQshIBdV8kBC8MtQtqDowCdLFu/JCmrfoeGDyt
	H4sUhA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7k9hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:30:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-795ac54d6f8so10015776d6.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 02:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759743056; x=1760347856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vops52gUYvZ3NLTbdfUXQSMexbJtRLHsZnvJ7nngDMo=;
        b=OZrgTcCZOjzBVmX2TsY0EKbaH9ll6+MS64H+HvU6dau2LhbCrkV1X2pvXg2w0hUlgY
         wDqIJPU+qxtm94wmi7Jn3xhjh8V/N8244RrBSqu8cMBMK0QLW6u8LUJugXpH914V66p5
         W/9I/HXB+eO+VGFsIdAAcoJEDnu2l9HlRY1HHajgnQ+lDnnwHts4R4oG+LAB0xoQEKPZ
         ovFDNwcgLcZnLcovVmxc93qxfoPFccXTz6+ubQKtvipT9m9UioRWckPdXs5iWt19NbFK
         rlhtl1S8KWl0h87rcO2BQoY11YyzWa+yuMZ+vSNwW6WmKk9yMnuvLLakazxtHxFSL6iv
         cKew==
X-Forwarded-Encrypted: i=1; AJvYcCUjIAjxpdrh4wSvd6E1E0OYSD73ZtJNNeMQ5NeTxKef+fOR6Tp7mAjYpfJttqNEs1J1wp5PbjRiSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7S7QMhlFpg9qfWskgKA8UjXH/TNs0UqYUIXnFuAU5ULpvsYDM
	LA1RQ1T/YEhqZk/awAVWdYWI9OoSOpU4arv929bkZMPSY/0/iKRb24/O7D+eEuipsTQrAnNFNBy
	Hi3ZUBaf4AH6Bd+E5SGHeLrMIAnQwA79qppHLhJ/1vGguIX98RGAL62mNDjy6Qw==
X-Gm-Gg: ASbGncupPk1QhKr1a0wgGCj4/ZZaaUFARO/+xbKRhp7nN4Ob1XTCTnebDkPUt6ffcrL
	Li6bkSIISyl/6yePTym1ulfTUSTAznwFSZaaE7huzF6ED1TTbxURKT6b5tvi1S5+2toMDeTJwzU
	WPIaRvLUWYKvnIIKW4q0ToCE9w+eyhKrM3UZYJxwE+Q4E/OOeVTZH9QLm309leG91lWzb4HKpQ1
	4y81/mm/NgWXA70BSuYv/lCGc+Dy2jSxOdf4/reX542jM1L3PiMTaL9Z8+L3jIv0QXPeDfIxcQT
	n3HLoikZ/eB6QINdB5890S15ybmrdp07HHoswzuyQuIMYi4JRSFQZtRj/w0IB8ReAt4sfE0x+Ec
	FXBBFLvmv+KlWOqsWhyNtZC9YDpg=
X-Received: by 2002:a05:6214:f23:b0:80a:9ebc:33f9 with SMTP id 6a1803df08f44-879dc89535cmr103756806d6.6.1759743055694;
        Mon, 06 Oct 2025 02:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBKGVvuT/dS5+zF4JwZxmMHMvCe6TF1FwUlsq3NgesrwmiFqhiDCKZ77vUMID+5OE3Uvgp/g==
X-Received: by 2002:a05:6214:f23:b0:80a:9ebc:33f9 with SMTP id 6a1803df08f44-879dc89535cmr103756506d6.6.1759743055006;
        Mon, 06 Oct 2025 02:30:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637880ffa4dsm9810213a12.29.2025.10.06.02.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:30:54 -0700 (PDT)
Message-ID: <7ef8ba74-4e9e-4b19-998e-40917d997ca8@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 11:30:52 +0200
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfX/tqT46hNEmBM
 VtNl6GpA4BVWWWavCh7fgoeO/N8qPhkIsShGSr1nISpgo3yvjySUI52rvOB7pFz/hARokBPXdbu
 eteIEj86cjY6bsAdoeKYPh0SgqYySmeKD5ZAaN/tUKf6OKv6lEM3alpgGBZ4+AJE9LTLl3Hf4ck
 5+1du1ue2ixnoGdwjA9dI99VkKyQIH0rLAPM5W0nifmx1tFVDvZ8n6kvAXewB2uuGIIaU0nyBhI
 L7z5Qmiy6ZsYMKBetlkrqb2v0zQKKtghob8HYAw4iF0NYP7iDJlkJTp8oIslbpk9at8fhjoSUmW
 rbiDQa2CRr8tN0wFSB0wquN5KIjzC0RJxNpYIrT/N96dTkdggQKLK2o8ICZPGm+8Z4116tWKwpi
 gE802AENaIQPoeBWuKMFMpheyRmTFg==
X-Proofpoint-ORIG-GUID: UlfN5B_D889MNihPaTsGJf7oz9ctHv1w
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e38c51 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=T_NsP1zJ15PqFYLLzu8A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: UlfN5B_D889MNihPaTsGJf7oz9ctHv1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037

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

There seems to be syntax for this, at least for stable patches
(which we should probably either use or add +noautosel):

* Specify any additional patch prerequisites for cherry picking::

    xCxc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
    xCxc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
    xCxc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
    xCxc: <stable@vger.kernel.org> # 3.3.x
    xSxixgxxnxexd-oxfxf-xbxy: Ingo Molnar <mingo@elte.hu>

(deliberatelly added a bunch of 'x'-es to not interrupt the maintainers'
b4 workflow)

(via https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst)

Konrad

