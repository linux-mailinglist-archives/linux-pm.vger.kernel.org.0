Return-Path: <linux-pm+bounces-31745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC60BB17F71
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 11:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1E87A4BC9
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77CF22CBD8;
	Fri,  1 Aug 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HlpmpxAX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1482A78F58
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040943; cv=none; b=hnIkxuZQ8REAe4p2NoHrvnq7CHd3TaaWZg1NU4JKfjRNuijRS4n0HAyIQbYKrVvyUbVtUxoiy/3C27uGL83yb0aOqNcClSCKsIpFKbSK4i93difpunvsBhoByH9O0rWbjp/AQdjSDHjfgh/+MbFN7uVOtVDjuYeHSdTCPb8SA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040943; c=relaxed/simple;
	bh=RereaYefPMJ+AN1G/WR2ZPJ7Q/9VsGyrmIOo6U3bInI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQ6Fr5t0rjhL+Z6KcARYyr9zpAH4/CUN3bC+3fG6A6Yi29aOwWOOQplf56TX/GgSt8MUMd2gvIUtlm7vDQ458ujXN7i6iYEEDFQRKvQ0yQ84prIZg2Pix++Jg52GWzWOXrPFNzjbfQ3PDXi+vEpucL3FoxQ+zjdm3dU6VDq2yvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HlpmpxAX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719EhAw002538
	for <linux-pm@vger.kernel.org>; Fri, 1 Aug 2025 09:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FTE8Tu8b1amkpQAae9PG0gDF8STmsmRt79+CR3F5UKg=; b=HlpmpxAXKwE/hM1u
	Vvr45SBbJSsOe208L9fPmhGEtdQ7zzm59J2Sp07WRhzO7rBeZaXdlrIwqqYH+6nn
	7a5yeh6hOwgvw1qKBjhmTekG2uiDf9OrPOetBdNKvf2aD5X31PAR031EJXZ0ftte
	RiHFgnWyPtj6oI0O0dA6yOLjurfsNDi3LOe4jvlHCjpbLkit+g29lMYwNoEyNZXK
	JxPPajHIsUlwQCMSX0jrcQBeYKhG4BUrfNO/UATglbrCWS3fYvM6/SrPhUahdauM
	Mno8z7oA/gKNWhCB1NsYffFz4V/47S2lWdD69jVy4nlMbhIrJMCgjQXRuJGCMWPx
	4l/vfQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbmb3mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 09:35:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23824a9bc29so13864435ad.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 02:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754040939; x=1754645739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTE8Tu8b1amkpQAae9PG0gDF8STmsmRt79+CR3F5UKg=;
        b=a84QbwkE3NjNwNDPz84fXpXU88VdEdMeailpOFAV77bVPDm/XSwHhRGvMVD6U4mzj9
         A+5NZlvszUhrcomNtZaHRSXm8SUnB5rwcVrigL5Hc8gLYMQ1UD3jP6T/VydLZe/Bl6o0
         zvv8kuMYP4fQJjxSZpsF9FpHZwqPruzxH4qsiGp23z1CbLS/SzNUaDOi5Gm5oNEwDsXu
         GLKPW314WGMRuERhEiOWUscTeYx4cGDUrr9a3wI9w0C6VvxLhuvDw4galTHMX8PgryEI
         VrpFF7gq6RYSo2BwaKN5UYd/5gVc4vVa6jIi+r5TUm4IJTVt0PcilFD+wW1sL3+O7oH9
         MwfA==
X-Forwarded-Encrypted: i=1; AJvYcCWISLwAaLCaarYhbjHmSicCwcJq2L5wFj7BymKdfk8K7itmsU0iCGm+IkEYxdLSzUAWIzWcHkCS0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1Zvoemry7iqZyLh1nuAHrFjYuSxmphOGMBzUi/yHzVwVASGg
	m7tOJ5AWHcHNVZ6QitjmzlxGNFCL/+/tWapac0YclxBrcbYs34TOIgOYeig/tvuSMsUt1YLmebT
	x+pb8+LTZbcIdChFuUJ+Gj6yjS3FOYgITKGd6UUoTYUJN5Vz5pfWXlc+P9Y3oiA==
X-Gm-Gg: ASbGncsDrTtwhcbKvEAX/Mk81/SRzR+CY0bhqLAgXhwvjqKdjtTZrEvp3mDReZAMlyi
	o8J/ptSlwrZ6wJ3aqOe1znrv5nCHCC0bDkNnpOy2LOzJIh8JIK0++srdoiUWeHMFbSAIwaZr1ZJ
	qHeE/SHPklesxK8JnuoGmlvN03BwbyqWlx/LnEe2VTqrjR7YsQlwitEstxpc3lyrxlc8K5Rk+xC
	r26BnvNYH7aCQL5ZbDhE9nRya09IbDPvIiKtOs/32wncwLA7poRwRHGy+rsZvNHGwXSjTUcI0pJ
	hpm5UfPkd7K8TVikkFtPq6kDbENB1RK2sFIY7zwGoJjRHw5PdrILbrlxoOdHgdNwCBAaqU46kA=
	=
X-Received: by 2002:a17:903:22d0:b0:240:1850:cb18 with SMTP id d9443c01a7336-24096bcc7a9mr150191675ad.53.1754040939351;
        Fri, 01 Aug 2025 02:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbZdxiptvpigi7eLXKhWCFOZQbYGfK+h+OEAOD3ELNf+6iC45wP9TbESkBH3N8d372w+JIbg==
X-Received: by 2002:a17:903:22d0:b0:240:1850:cb18 with SMTP id d9443c01a7336-24096bcc7a9mr150191225ad.53.1754040938913;
        Fri, 01 Aug 2025 02:35:38 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc3266sm4196042a91.13.2025.08.01.02.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 02:35:38 -0700 (PDT)
Message-ID: <7f1393ab-5ae2-428a-92f8-3c8a5df02058@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 15:05:31 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
 <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
 <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250801085628.7gdqycsggnqxdr67@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=688c8a6c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=lAXUmMm_w8SOBygwRYEA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA2OSBTYWx0ZWRfX8Tt9iq3SaNrY
 hWzg7HIBbMudToqYMYKnEG4DrxOriSD52mdral+p8Lh43LtTBCHvyDXa/7f6rcJsessZx59XRWJ
 GdyL3pamabPHWwqBmPUththo3Url969MoGsI6TJYAjYbnW99QP0kxEvyTGxs0KKHlUe02A3hduP
 IRDyvXe17CKp2D2yL/JuPZwoj4rwy2WSKYFrCUtm68rTHQ8HLlWiLylIogBqLME+eXGGFpUG40I
 RrvfqSvn0F3rLeg2DWHe1tcBVPxIzEdGdVyTy92LfNfZKrta/siGtH9u00adApM7IGGYoNdZtFu
 Imggy5YACgaNF2dr+GWKgYm2UGIw8mbfTqji9PtplIK7v9jpk/cN7DOyN9m3AUxkV7jnUwxQLzW
 9OKMA2WseGqo1rWH9FWYjWXBSOuTkg++z3W32cYxKMfUxhV/ZI8OW43JulDV7E0QJKsWFwqm
X-Proofpoint-ORIG-GUID: hd7rLEg1KxUHTGIZs6lhSCESUE0IIGLT
X-Proofpoint-GUID: hd7rLEg1KxUHTGIZs6lhSCESUE0IIGLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010069



On 8/1/2025 2:26 PM, Viresh Kumar wrote:
> On 01-08-25, 13:58, Krishna Chaitanya Chundru wrote:
>> When ever PCIe link speed/width changes we need to update the OPP votes,
>> If we use named properties approach we might not be able to change it
>> dynamically without removing the OPP table first. For that reason only
>> we haven't used that approach.
> 
> I am not sure I understand it fully. I thought this was a one time configuration
> you were required to do at boot time based on platform's configuration.
>
I am not fully familiar with OPP here.

> If you need to change the performance at runtime, won't you switch to a
> different OPP ?
> 
yes we do set different OPP when we change it.

Currently we are fetching the OPP based on the frequency and setting
that OPP using dev_pm_opp_set_opp().

As you are suggesting to use dev_pm_opp_set_prop_name() here.
This what I understood

First set prop name using dev_pm_opp_set_prop_name then
set opp dev_pm_opp_set_opp()

if you want to change above one we need to first clear using
dev_pm_opp_put_prop_name() then again call dev_pm_opp_set_prop_name
& dev_pm_opp_set_opp()

I was in a impression that once you call dev_pm_opp_put_prop_name()
the previous votes will be removed. we don't want that to happen.
if this is not correct we can use this approach.

If this is not correct assumption can you point me any reference to this
I was not able to find any reference on this.

- Krishna Chaitanya.

> I don't have much knowledge of how PCIe works, maybe that's why the confusion.
> 

