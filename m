Return-Path: <linux-pm+bounces-40101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5C1CEC3A6
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 17:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 245EC3010282
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7717528135D;
	Wed, 31 Dec 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PKiaatVk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UdWzDXZ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2F259CAF
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767198058; cv=none; b=unBxszLnN7gmB4ZalJt8M9Cd9mXjjO/g0WFSTAdLsqrnpefonJzHrkfTb3r9l5yHO8/67VHT62IhrjOQhSGfKvm4uknNrvQP5RpCh9IunjvkNekMt8P1o+l/fPYh9zs8byO0e0UFcruha1x+or/HCXy+Ac3EsmrZyo5Gd164TrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767198058; c=relaxed/simple;
	bh=UVAg56rkM+auEpEP194lxDA2RuqsebNQ02WdwnZoJ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaK5wBjPR7KrwH+LCxApQFMWiY5vRSsVk+9S3rVxnGo802nOWL+6GAIAGFfXAH4xihJoY3LBE5GzFvPYQy4bDuwvHfn5xQ+ioKtXFVw399jhAYFBOrRMlNt8pEsr9Osiu+owxZ3bWeTQcM9+y01doOL7FSqJniMECOfZqa613m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PKiaatVk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UdWzDXZ7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BVGFR2K3496707
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 16:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GCtRj0kGJkzqJqbBi+nzUzz3
	hAt/gdZ19OL7R78+TBg=; b=PKiaatVkwcqrWuY8DFvYqxHgFWBTdDtGeebn3+7m
	dTlCiYdpxYrotSGQN3J3EzH5e4Uqi5vyxAys7qOVn9+vYGNtfeuZWRQNZ15gdRyC
	XTYw5OCExmIoWrDa/699sbcu0o5P0SPvJyCEqg5BbIwNqxv3LlhZRKKIPWd+nR37
	7J4nR3ki4eRZIcJbFk987EGPu0o2/dG4/payno8QEF0lgpMwVdGmKIO2sZEtQrdv
	YEfIoIMWUvGxiRfY85cSRrW7NpwXdctXoeNYplYYNxT08Fn9sJNzsGYJ+pFUfd9n
	kIVFKkeXGsE0T78aGjFK/FvIAeyea8c6iS1YkcUoTMa89Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd76n8095-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 16:20:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1d26abbd8so326487861cf.1
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 08:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767198055; x=1767802855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCtRj0kGJkzqJqbBi+nzUzz3hAt/gdZ19OL7R78+TBg=;
        b=UdWzDXZ7G9IwQYC3SDoGAHjz1Z4/TdPz6fZpgvOTGaD7CaLGNkAawjkC9REDKjElbB
         1aRXbDe2XWUBa6E3dykDlHGgih2w0J7a0XC92SxlfC+omkOIDjiJjGKGDA+0H7ai7kb0
         0P2DTtmfKMfn3EfQcKD8Y/ByzDulJCjGc5eDKlZT6AlL366AbkXPDU4nzArxJY6N+yK6
         SMyTdly4ofl6shtCvDTcUXXqxgGM2A489qzlIgZXVr/qTxrrC2TfDSlBq49rhRoo92sN
         n2ho82bBq3iihtPOFKku5RkVHmzaXSglz7Dhlwgm3kguTawpevSImuaPZsKuXRGdTUK6
         U6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767198055; x=1767802855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCtRj0kGJkzqJqbBi+nzUzz3hAt/gdZ19OL7R78+TBg=;
        b=EHEsTmjEKk+/N1GfUxpKF3SB9IBIAHtn2uS5MCAF0esjNCdv0HmnaG6vM/CfrDXmRq
         H4wH+BDGtU9fxl+zFI00xHNbopYN7HF4L1Ok/DuLiXdMTXMOSsmW3zwueB9OByVPcUJ5
         SdnlJ08Ghk+8YBjS8UFUQsrw32UjHA6FLeF7f74cWWCHw8EM5RrO/Ocyso7IYdCzWxzw
         UYNP/00hWa0fVOL1Tb1bbpXr1W3E6cCtxT8Zo/tU908aSNmIwIp/BukljgaWePQL03/Z
         nCbvMluy+aHoYtkHQhtZywcXzoL6ms4j419qdTx4Y8AY+0lgGEmr+krDaxNcHuWoD4jk
         FegQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2QyStGICjMGce71YO0vEC55K74l/Jfade4w8talENBp1aVQvLWFx/HvutpfGv0qyHbDTOK5091A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzytaI5Mg3rWdivnGvnR2a638TQtiEjaxwLmEko3W2jVkjSK5Pz
	Lzq3bEAxNfYY8Ds8ew/VwsPStDwss27fZqjcCXlqzqSxneW67sAc7tTNkjj+b3z5wb+YMYTuWb+
	TJjkFFSfiv+AAts5mA/zwPKNQbgorC3sO8JjyWtN9RxXkQ8j9btufp02ygmGXSg==
X-Gm-Gg: AY/fxX6WU0kQp24Y8Kekrd3VCmg668dau6lwzUeSW830YCtv7S7NnqvlwpxDIuuWqqk
	MNYmbPqJSU9VLNFmDizuYo43PrEzKpUelAbGNspwjkNrmkQ99DRA7919Gi3LGanW02rvGb6j3Ge
	vKSfesfOI0NFyg8YGwoudTHooG50IbWrhR0NAhaJXlxuiM3gRYDXvi1ZHdRHviJNEix1jS/wwWy
	RFjqRVwMEnD7aaYJVzlhA/PAES1aCBWfzSNDczYhhhzFSD97hE4Mb2ZeiqU2qWMst2uW8jWDjjl
	DoGDN5SNkjiPRc2jLyYaS+4+K0P5wgS/XvJ+TdVhsGmPDgC1i82d4cFX1i0P8ANlHD/HykBlBm/
	KjTNUL2Nq8OpF5JB4rNlsBNp/J+G0g4bVSR8yaF4kw/3tLfvRFOU7jr7+w/n7I1gl1IB3mjmtLt
	JWrFpejZCEC5Ah1TRvl6sOLWY=
X-Received: by 2002:a05:622a:4c15:b0:4f3:59a7:67b3 with SMTP id d75a77b69052e-4f4abcf0be2mr535752961cf.20.1767198055389;
        Wed, 31 Dec 2025 08:20:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV93a2/ytBr0yG7s3l17noCqyNn3HiIII00axJsk7y5AoZm/pGqNYSP6VR1gOdPsz+SL1V2A==
X-Received: by 2002:a05:622a:4c15:b0:4f3:59a7:67b3 with SMTP id d75a77b69052e-4f4abcf0be2mr535752671cf.20.1767198054918;
        Wed, 31 Dec 2025 08:20:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a186282ecsm11179301e87.94.2025.12.31.08.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 08:20:54 -0800 (PST)
Date: Wed, 31 Dec 2025 18:20:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 12/14] arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT
 properly
Message-ID: <fk75wduux3dilfx32mlufx7alz7cbz2xa3s5ubdpyosd2t74yh@7x7q7yhogmne>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-12-1ff4d6028ad5@oss.qualcomm.com>
 <ed3e9128-cf11-4ba7-a7f5-cac2c537c2e3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3e9128-cf11-4ba7-a7f5-cac2c537c2e3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDE0MyBTYWx0ZWRfXzbuXaffgJb/p
 jtf7vOkofOs3/6AGr72HnY3IzYkO15Y8YPr2xYao10cSa8mlx5fiSWZ/V9aDEkZcU7wsU36qD+Z
 /Ll9rvuJe/FUPBIbRkGT+N+6l1iwjXc6Ir3jvflzxHjWt+0uwgXQc2ZBI2+9SfTxBR/AHiUs1GP
 MMsOmRNBP0XUA/AJdvfPOeeQnwopSliI/6ovoPVM23UHH+K/PKP+QWZ+UJt3IuBepu7VTeUHgBw
 OLkNEOXRtcIarbBA6EpcowBu2hAg28cDHvCUjnTKdf1c9KBk2OlgTKyEwDKBnVrSq+3HHDKE1zZ
 xHoGRTDnDm+Q7Bl+lyx2h3IZum56p20I+AT/PIsRtrFWqnzmn/+turzARz5HXWVJyFyyy/hyg/V
 4NGLqtpZHYsTi1154e8qVuSFWwzbhvZsAxKAZEFFhWKel+gmbEtm/k9ysY8Xfjl6Eg0d1cHfOQB
 O/ZSbkg/kTYE0pyNDuw==
X-Proofpoint-ORIG-GUID: eNkptKu4a9n-mdFeVbmLKKilx-xNNvCK
X-Authority-Analysis: v=2.4 cv=TdmbdBQh c=1 sm=1 tr=0 ts=69554d68 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YM-ir784Kfn1-1I9OqQA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: eNkptKu4a9n-mdFeVbmLKKilx-xNNvCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512310143

On Wed, Dec 31, 2025 at 01:19:23PM +0100, Konrad Dybcio wrote:
> On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> > The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
> > further spreads generated voltage. Describe the PMU in the device tree.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > +&pm660_gpios {
> > +	sw_ctrl_default: sw-ctrl-default-state {
> > +		pins = "gpio5";
> > +		function = "normal";
> > +
> > +		input-enable;
> > +		bias-pull-down;
> 
> Ideally
> 
> func
> (no \n)
> bias-pull-down
> input-enable

I'll try remembering this for the next iteration.

> 
> anyway:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

-- 
With best wishes
Dmitry

