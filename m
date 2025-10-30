Return-Path: <linux-pm+bounces-37130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2360C21C2E
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CF8E4ED715
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2B93678DC;
	Thu, 30 Oct 2025 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X+q//aIJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L4iAQRN9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3E238C2F
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848677; cv=none; b=a4M6MYpN8zKItqFB3MsQWabO3JEyECGVi1EMpMD6FyAwghxn+Al9dI1FEI7SXzHj8kRG8dDIsHaz7RL+KeEPGbrxAAa/NNnKjrkw4UFxrj6UBAj/6vildvMb9Q6DiOVMA7TON1xnD2SqSwEKqbD7oSy1eObjTOHSr/RFGvPsNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848677; c=relaxed/simple;
	bh=n5LDDnU31B/FU4hkVylg5WKwzdJmETUQKTTzRhOKfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6dw60vFmHbZF09bzBSqhrJmvkeYw0sgYBt2hWEZemziZSzDDkUYRJz0HuGc/QDmjbyanwZWIthVWoIs2VaH6QdIiiv6ZsBYVaEqh54xUCspa913UlaprWY3VZknFjDtkv9DgT2baV6VWE1pXotZrry8TJmi7eBuLQijUSyLaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X+q//aIJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L4iAQRN9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UF4iaI1599075
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 18:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=syXUOD6JoN9BeOT8Ps+v7SB2
	QPgUbs++JkB3a+FX+aI=; b=X+q//aIJYPavTm/MJPOaMRJnxV388UO7RYFQCWvK
	JjVcniBUwCX1CaGgS8IBovEx11gbOmz+apnTAa5WXHAQAwSWCXlAzcbme/YjQAW6
	ldmw5uxe0LF92pmZmqW4HH+tHa5Ukec5c/eKlquYkm0lEhCAv+Imdg9NeDcUhXjC
	8+AgnFGp1JiUyzEbLgO3Z+BPz0OxBWQKXDHeF4pOUmV2a5m4nPrArDUivC0378+y
	sMji2N2LnUx0aSS7Uv+5VZIRyt2bX70YWQgWl0WDnMQU69HuAon/igIMoHj3pKVa
	8xCzUEcnkL2q+5ohUXhM2N42XFD35qE0ms3YGsdRlCi5Tg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ta7uf2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 18:24:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e8b33c1d8eso29527071cf.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761848673; x=1762453473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=syXUOD6JoN9BeOT8Ps+v7SB2QPgUbs++JkB3a+FX+aI=;
        b=L4iAQRN9DXO1eznCaNfMRvre8dvaRlLK3GJ4JyZUqDqGpSJppHYbmSFXSFME3TgLQ3
         o3C1NO/25Wn/YyV5aJA3YSu6H9S39wsDyJ/EFqMfufCrEGL7O+o68wihPJxOr7pLY5Ue
         9BnPpBM4zJ50ngNNk6QVL8dhcFgY8Q9CJ5KKCCRXqQ8sfWFwFxGHsfzsgzWbcfaJHXiz
         u4wBXDKp71mrGr17r5NrxZ8ATjlLOfpd+AGMIHvo0+ZhaNVDFcyu/PtdyJn9c99JoGF/
         0hoLOdiSyIdnODgihyK2PKNXOm/54/s1+OyS9/aGc4e7SFkwDP+2uKvHBM8O4VvxZOSM
         INqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848673; x=1762453473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syXUOD6JoN9BeOT8Ps+v7SB2QPgUbs++JkB3a+FX+aI=;
        b=riQODHsHFVwRd8fN6PqK2OWVXLg0gr1KogxGmaqGU5J0loUId9BtmAsl1tTFNvOYQV
         uA2qTLPCAqEDu4SdD7q8BDCARYLgxNgHnoiGrCRKFd+knWrR7pkunsA8nfTWtqEn3Xe+
         E04/2I7mmY+kO297fJ2iEzA9wyiPVdLIH0HycTzjq87mRax9CoG7X9Q1IwNR0f9kNzfa
         ekpGOzsPy+MdqDMG71bKUVG0wn9iDQv1k3dLxDKAECqBH/nJnPulE8H3O/gLsRAccK6Z
         8ue4jwh8Edaer9GE7iV10HyC+pdA8WkLtSUTEE5EeeUMuIKIYTaN98KzAx8Q8DOQgXHa
         ZFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG5Jbxl0o4ObFeX3T8wihy39okfsmV15bR8waOYjo4gxQLTuBFLliT0RD5c1YbRjiB35RTUYndXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVD7aZNgY7qASwZLuTuACj7cYjKZf3ChRneosYQZ5QsW7YAwj8
	3naU3l6AANO227Z4Va5L2xV6IneTgJAaVUb5OdqDYy83916L4xPStTN9dZM9IactlnAFZ0zmtBd
	efCZq5XTvN+zGVhFX7qZM7JdsbZDmx/W/cHx2f2OOP0LOGiBBdLWD0oFwhMO2vg==
X-Gm-Gg: ASbGnct0cSh2iaWaAOIezgzygcooR0GQq4Kel0m4lBwuCy3xBL4CSN/tg1UL7En96g3
	C6uXzp0jBx1SMHfbvik6ZaqZj7ryuaKk4/1Xv+Go6CpxVtHNWMgTURi4qrKy15GepX9VhB5NAFH
	a8NWw7MFZh3hx1NTCgiwf0cqVKTDspOb2dnwOjQqIWMGwkGh2D5hHlMha4rjnkHKA5sz/ywHuy2
	7uP4dNG1mmp6B7iUY/yuc7tNcURjzs57h/PZC909mJCT706yVAx+cHd1Rr/TVcy9cdLaT9Idn18
	kywNpKNU7D3y9i84vmUYwhA56orCLTntatjGrBDtvamh2Y7dWZH3xDFEPiAeKy/Wgu/Jbs0KrKC
	CCEBTG68+hvD9fY3+ih4VXQYC2MfOuoRK40dyKUEfG7OcMJPzvLPl7lYWEsoVpGaugClZE25XNP
	RzQi4P0/BAdSih
X-Received: by 2002:a05:622a:44c:b0:4e8:a3aa:7a89 with SMTP id d75a77b69052e-4ed30f97698mr7501951cf.45.1761848673056;
        Thu, 30 Oct 2025 11:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmXHfCUfcD2P7/jhUfHS2Z3Z/sOp48KQ53I4Yb9fWNOd7sgUr+yJyHxsPDN81BBTCGrNVwpQ==
X-Received: by 2002:a05:622a:44c:b0:4e8:a3aa:7a89 with SMTP id d75a77b69052e-4ed30f97698mr7501491cf.45.1761848672452;
        Thu, 30 Oct 2025 11:24:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f87f14sm4837077e87.112.2025.10.30.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:24:31 -0700 (PDT)
Date: Thu, 30 Oct 2025 20:24:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8996: add interconnect paths to
 USB2 controller
Message-ID: <hlj6cyeybsct4flwvm22t4u5coeyrlwcwfol2cuzab2fjkluwi@frs6m2sjyksp>
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
 <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
 <7ef8ba74-4e9e-4b19-998e-40917d997ca8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef8ba74-4e9e-4b19-998e-40917d997ca8@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=6903ad61 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=nBxtwQxsS3NGOZXr17YA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: VJkDovA9vK0tEi1OGCL7Rk14JGXOOnNj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MyBTYWx0ZWRfXxn5keH8jfxso
 c+2rPald7UICfVkwKTcny5yV4oaHoGOzcLW5cWsy6RCDLsebU3Wh1Mxrw085ulvufN4V7mS9d/g
 Ob9A2cLYc91QB47RLvwka+/mMwORl3c9IYfTqgHbFZQr64osn7ztUBShJJsmNsi1/Q2ZzuCOjqS
 iYUY6d+z7BJDjDIHqOBkpLWUwYD/WJWMmnZ5TCheANnrmRNbydTkXNadpcpe7d++npKs7oqsL6Y
 DaUavDcbthsV3S/cusj1KU0LwhCq9pSNaT4DhLmVIR1pcj92Z/iytrk0MVKwC63Hlsv8kLT29T9
 kHXdJMTAkKMaMY55+EpaAKSILCss8NNnXs5XpAYoqwMUnCPxQDcTeg8ec0OFV7TyoYr2xBH2dpp
 uY4EJAzeIFlzk6v4VA2lnYbM0C5DcQ==
X-Proofpoint-GUID: VJkDovA9vK0tEi1OGCL7Rk14JGXOOnNj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300153

On Mon, Oct 06, 2025 at 11:30:52AM +0200, Konrad Dybcio wrote:
> On 10/2/25 10:53 AM, Dmitry Baryshkov wrote:
> > Add the missing interconnects to the USB2 host. The Fixes tag points to
> > the commit which broke probing of the USB host on that platform.
> > 
> > Fixes: 130733a10079 ("interconnect: qcom: msm8996: Promote to core_initcall")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > ---
> > Note: without the previous patch applying this one can result in the
> > kernel stuck at booting because of the EPROBE_DEFER loop. I suggest
> > applying them through the same tree in order to make sure that the tree
> > is not broken (or using an immutable tag for the icc commit).
> > ---
> 
> There seems to be syntax for this, at least for stable patches
> (which we should probably either use or add +noautosel):
> 
> * Specify any additional patch prerequisites for cherry picking::
> 
>     xCxc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
>     xCxc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
>     xCxc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
>     xCxc: <stable@vger.kernel.org> # 3.3.x
>     xSxixgxxnxexd-oxfxf-xbxy: Ingo Molnar <mingo@elte.hu>
> 
> (deliberatelly added a bunch of 'x'-es to not interrupt the maintainers'
> b4 workflow)

Bjorn, Georgi, Konrad, how should we proceed with this series?

-- 
With best wishes
Dmitry

