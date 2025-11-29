Return-Path: <linux-pm+bounces-38907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C039C935A9
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 02:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 608474E04B3
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 01:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE0815B135;
	Sat, 29 Nov 2025 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VcxcTHx5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EfpITwxa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7791547F2
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764379023; cv=none; b=UFG1NtyqL4XubrWcHLCmW7NsyyeUY9SVRJ6RT+ddMHDvXBEHcYYBX+DyBF4CJhTT0Bz56hIEfyb46jUCbc0PijpcIaVaL3NQ0/CDWc/zT8H9Qxn9gfZaQALSQRtWurWIhfsq3Imqq/g1hbP3P7/THd/ZgLuajLs++UQXTwUaFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764379023; c=relaxed/simple;
	bh=pgAURVLImgMHb8PwJtcprR51OYG01XXNuOHMZZUWhXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U74WyXg8AYZcJZsIScmGRB7n0+srrlpxpa0esWNlLna80ZSdGC0tUnnjEWzIsJW+VWKKxBlzTEwraGNV7Q5OFbkKwzLD69vp/6InvLyhFWU0vs5d9N1sUw7r6ERj/fLvmnLdzgGvg1YbM69vo89YOPqb1jx1IWgCtMBRreDZCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VcxcTHx5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EfpITwxa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ASH6W9v4089698
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 01:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TVHjKZjAbWP0AUEVropn5Esz
	RHs0ZKRms/XjXHlRyWI=; b=VcxcTHx5h0SbPR+r1WZbySbkoaJE/Cm3jcKk/ORy
	e8XbgtuhvcGcwS1FAJZuwSThO2QuJXjhGEyI4Nv76pdxZQrEeqI5tjbeEXwbxw5t
	HiS1LZ4+7XmtoPpTIASo4sz05GNz8Z56f+Sz7ylv4z+sDIzrgz5/pJgt3kMYFqdd
	S6lGD6vfROOlSJ/WR26qrD1vspVPpgzk0byvDIgp2tGrN3zGGfCQvker2ilMVBQV
	o+PnTHv2UgUWiywHmF5Qar5DVp8KXXAH/wKBEwB8+FnhCbuBc1iLgmbiTGZC3/wm
	HyWBggdpESImnL7TmpD/qnbsdSp/c0W+FfV6mC1ybYZzPg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aqfuj0q96-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 01:17:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b26bc4984bso656940585a.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 17:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764379019; x=1764983819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVHjKZjAbWP0AUEVropn5EszRHs0ZKRms/XjXHlRyWI=;
        b=EfpITwxaBCfaoNb1WHbI/Gw6oP3Qsn+SRssfsyg7sxMUI1tylQS+l/X0TrWRGODq3t
         MrXI6I2qYZF8J2u2eDyYlHKCaKGt60eWFpGqTEnohtrThd7HGIJESy8IoVR8R1OOkafl
         65lwBrYTuXFuILVNn4TT+sM5M08HZi7xKVcRyZ5NcvLlFjbLlCYOh/sWlUPGFhrmykZq
         1mE+WV3+Hke7h7NVVKVoBecSRZXY6uG53KKiDEw8YyKc4U3FxZZ1TbcFN1v5GwQHVHr6
         lTKybuVHQpuSmUGod2QDMXWZ45fNWa5oXtR02lrBYMqMO5jEh67w9nzM1piiCWWnt6Rh
         DNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764379019; x=1764983819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVHjKZjAbWP0AUEVropn5EszRHs0ZKRms/XjXHlRyWI=;
        b=pOl/Vo+oogzWs43rFEAhcSxIT6AKmoDYkXK4ZhzWF6cogemnlHzWxSf3pjQ9fgF0/t
         GoW80uVZR/DBIvCsbsz0K7Z2Nn10jpN0nXsCS/cv1OKXlB7p71wqEdzqZtALAnyNiiMn
         jZ/PNmznYpg5IZXZ2+kFXEA4lLtBq0Vj6/xmrByIO/DSZW6Bk/Cq1R20liD3qxFTwAsV
         W7HnQtRlHgTAPB5R5tHn7zrQmPG91CrBYBjluGN6Qf1su7Jxztb8IcIgad+ynWX7ey9U
         xpKr8SLZlDanhfqpWZdvftljgNKg3Vx/9cnLCB70jnM/wa4wAynm+kaIpBe4KFrxMEN9
         87xw==
X-Forwarded-Encrypted: i=1; AJvYcCWWRlhYegMQMheJ25apAkhbclyuRBYOUjSk6YbGrFwGIPhlcTMgivQExgQ7T+zs2tWw+zmvFIKp8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqmPediPicRC6bPFc/kDy4UKVcLiB+injBA/O4T6Y/TjQb2jV
	0MmFIkMjPpPFg1MLqR4H2bRuF8QDnYLL1m/WURrKrLuIqabISIBl6FYHAl0HPE3tMeCj5iCBBhO
	aK/QI0NrgJPTaFdV6CYe6ZwUjdRE8/wf4rg2qYbdSPgW0n3vJVpLCnfBO5C04rQ==
X-Gm-Gg: ASbGncshOrFIaYXPs62jLnd0wdXE0G2+2g40GrvLafSEiES4q1t3i8Q3/3wgTyKn3ZZ
	0TKmEuGXRMky4u4YdNVqsgLuFiZLi1mVQGrKciUD424U8iyL8X/p0V79f1n2ciWfrmYvcbm8YO6
	OaiXHbaKa/HQxsMEoiIev4SN7dcDYmiduNnCzpuCFL3PXYUZd/rD55iRgw9TaLJCcniPdAIbV5W
	eJdxj9r/CSoL3I4xRFm6s9OzDJfS1Vw4gE6dZP0VUaXiWifSRJwbaL7B4ujnCImGafINMqW8S8Z
	jyN8e7w2IQZJIoeAIS3+AbvZyGeQ7wl3PYF3y68xNnejXGm1ZRov9LSn65Z7M+/edJ0UV4uBrRs
	PED+CFk7F/nMK8oZgZl7VQ/Qg4PXjSo24CmP5Vw0cApRhqfaLwqEw7BFAp4BW7XMruYqSCZsea+
	gxZj016DxhaxmipO6tCQ5Mm04=
X-Received: by 2002:a05:620a:4411:b0:8b2:6251:64f9 with SMTP id af79cd13be357-8b33d4a74f3mr3680748285a.58.1764379019230;
        Fri, 28 Nov 2025 17:16:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjE68x2bojMalmuvKB2tsss4Pvti14VaY3rG2kFcJYXxvhe47IAVMBGZKPnslduXQS1/rNVg==
X-Received: by 2002:a05:620a:4411:b0:8b2:6251:64f9 with SMTP id af79cd13be357-8b33d4a74f3mr3680744285a.58.1764379018747;
        Fri, 28 Nov 2025 17:16:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bf8a7cffsm1586146e87.18.2025.11.28.17.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 17:16:56 -0800 (PST)
Date: Sat, 29 Nov 2025 03:16:55 +0200
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcs8300: Add clocks for QoS
 configuration
Message-ID: <vgwtuoiq4rginxk6qvcfe7ccsi6udeqlrvul2wsehg2fbrrorq@hk5im2w4y6k2>
References: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
 <20251128150106.13849-4-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128150106.13849-4-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX4CUP3ja369WO
 ASKrLKMaqIpkIRx8ZO00kMltsHC8OkLi+E1RmxEi87rejN+0UqtoEOrNrVC5fhnNdw1Qj3POZmy
 Ktd3PR00ynH3RCiu46fkWSpPBA/1HbrI9V/pXhJjC+Aj+lrsSh0z+YUWnwJ3B2BKUvsUsUQf7rW
 G06Qlsz6+y2DD3mFPoFXZyu8RZMX1dk07zALUOinTHmzgY+JUY6WaMWDWW3rW9kr9F92hzb+KPj
 0KqGQaZpbbdt/wTScZvSjIMrY7ZYLgzPcx2d0JGkTjWQMjOXggiqUHwF/LhQem35ZYzcqWUb9h1
 Fo8+PJE+r7dhyXpobCzez1FZrW5dHM56yys0OdUBfgic5dq1pp/a7rI+KqNNR1rxY1SUHls9X4A
 4G+U/A8W1HXNrbP6xMONXm0NWPX9Tw==
X-Authority-Analysis: v=2.4 cv=GupPO01C c=1 sm=1 tr=0 ts=692a498c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=sc4ExDOf6ksMT09hswsA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: CbkfHXdW3_sSJlATr8kPeFsKMXa-cTEI
X-Proofpoint-ORIG-GUID: CbkfHXdW3_sSJlATr8kPeFsKMXa-cTEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511290008

On Fri, Nov 28, 2025 at 08:31:06PM +0530, Odelu Kukatla wrote:
> Add clocks which need to be enabled for configuring QoS on
> qcs8300 SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

