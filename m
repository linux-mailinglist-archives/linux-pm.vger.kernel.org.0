Return-Path: <linux-pm+bounces-37396-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC83C33936
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 02:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9102D3A7218
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 01:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B5240604;
	Wed,  5 Nov 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iGoVardh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YTrp2EIF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A813D561
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304416; cv=none; b=pj8m+dv2asT4PCsDZamW2yWuYQcLBRlDouLbjlaL2MXf7erbq1d7AWFqkGH1kDJtCftr3GvmlzFptcjcv8GPM0nCAMokjigsw2b3hPUZlNrnHAOiVUifVjzx80s5cvjMXLdptIHGi1aZslA9Oca7eOHdFPSupzTW6JCgvzDFhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304416; c=relaxed/simple;
	bh=tgepo4GyQ802eDd4JshSs8ce0W84dBIvvbNERCTaaRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieEr2kPOG44dE/fQsR8nRD7OrMTgvozCHsv7nYfo2O0SVB8WTWRl706tHW+PcLvLdiO7/6uIpwzW9Qi4vD/zg+LS0n8MeRXVybFempPPhEfmnTMTtT4xBSVcJ6qDfKUoOKWmMrgMbIzdq/1ylSA9sKyic9j2Mfo/c9ZE0LAusug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iGoVardh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YTrp2EIF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4LADoc3090853
	for <linux-pm@vger.kernel.org>; Wed, 5 Nov 2025 01:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AIXwpv35/cEoHD08K6XXK7Yl
	+Ig/mTbB/PkIxymEVQ4=; b=iGoVardh78cSgkPJ5FWpGXPDrqObIvo/ZaDR8CXQ
	NFi4Ruh5GwNqNAcZAEzFUGMtyxMFl4COhEFaC9G/Nj+wEHCkyiQjfy9Bmlin49hJ
	ygdb+BpSF34Oz4oI1dk2WwXwFxhJwjD/Mq6vDOBCY+nS0VZ7U6/oSllIcNLJqAfx
	9VSMd5TkrstRDqnvmsx9di4j75B/OCHwqz2aOB29BW+TkypqbreGwmXexqRWUoOm
	g9pGQprXsIkVlTVoE7q2wrd3XvqofqXcpV9fb9BY44R+CF8iazRWX53RIE4MgTJm
	BcjoYcqj/MpQxmzLNmgfbF5Poc04+6Ra69O3bKqmJxbrvQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7s5e8ku0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 01:00:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-88f81cf8244so2544180085a.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 17:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762304413; x=1762909213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIXwpv35/cEoHD08K6XXK7Yl+Ig/mTbB/PkIxymEVQ4=;
        b=YTrp2EIF3ozvuT4scs1yKNH4JEdp1gOj/Jil62NIkjGD0qCDIxCwOCe2EjCX2bAD2t
         R+p6EcKVgueVsBKyQKsEwsAvuCYRZqR37K71MmVFyqbR+Zhy2xBZqF2PmNDCwX41UCZj
         HCgIOefN+KjRseJVx2FdGQX7L8weBC85MNLnkxzx5/wPtpSmIYpR6NuM5FLynmY/Rp3y
         gIuyybdU1oZ3GHImsjEkPiSlFt05GMpcoKbOVlTLhv4eY4zeA4bkjI/LNn7YBHD0xJZ5
         INOoPHZYfPYjJ12sSOcA/IrUAs5JuTbYYn8Foljl1ll2ZET63wyqCCkDPg8DcdUNUmL0
         ymaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762304413; x=1762909213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIXwpv35/cEoHD08K6XXK7Yl+Ig/mTbB/PkIxymEVQ4=;
        b=kFb18OALm7VUBm5URxl0XGlcpGCac7BlVj7Wqqukr8j6KKz/BnFmFKlaFqENfdLHQt
         dDNotE43nB4XpX1r+92NmlPtiVSG4g8B0xRrf6pYDhD63+BUFLS57rEjJpBsAjaDnKQw
         A55wgY7l38C2lfVe5nWhB+tvKlnvYwPjPSdRziFOuhK4fksTz4cRm+Vw6/4TRPeFZz/O
         Cw5QQKWKYXjSctMz5RBM2r1PDaOU3j/b6rG/JOn3vuEhpJ3mjv4rtEB0WASP7QFthHJB
         pAuFbbuL+U1KbyVCKL+2CrdZuBzgZYgp9b7xdpKW3HPo0zUw/6IfYgttOQWwz1go9Gb2
         Xjug==
X-Forwarded-Encrypted: i=1; AJvYcCW5wXdiRdcvykIAUfiH15M3Uvbr9eFCGOBkSK7U2G4FfbmgB5BOkHUMCEV+0jpW21TzDi9vXz76oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGQpsMyCQl/ox2O3X20Dgtd9wYHxLgTjmjyEIzTel5QLsvlWm
	ibVxIMp/SpFoMI1gn79+wDikFY1EYwUS2x6lVcO3CZh3AjnMeDoNv4eeTmmel+GC4I8rEH8yjBx
	LHJoF8D27JGAkBAYhzsBObrjgZsDycR+bDJZHCyh02vGV9ZQsUzE4wl6IvFpPGA==
X-Gm-Gg: ASbGncvrypch7mmLFrLMx+d/0sU8KwDFYaGJUb3EgxKHeDNwUx3DD0zutqZdKEnaedz
	wu9xumgb5xf23GhAgm/WgdIzT3nadSW+j1rjVGBdwcC6X85M8Fw8a0JDUhsSfx2qD2FIdGr6zjd
	V9MxSXtf0y5oYOTxkYIuqqinCSY2BjC5+Lg1U1Y/zbuaQ06vA2gWIKWvvAuyPWI72woL4ZtVjui
	yd7VHEloO3qdaK3HrBFUx95pik3hFdQ0dneL2AlMfxTS5Kqn3RaJ5bgV84HTF9/cMOf+tyE4R2d
	nTPmUpNZRNx5hJcRO+HB+WSdjYL3/qq04R7hXtygwqkh8fVG3oE1L3GX4ag+ZLAMahsnmhSrf4A
	/9pSQhyzSkQvhBm2MmNbE3lHcXgz/nZwsdZzGU5zjofdGp8PdDL3GUpCy4f9VSxxlx4ik/NUiL0
	MGG4DxkPOsdyaT
X-Received: by 2002:ac8:7f56:0:b0:4ed:6574:3a90 with SMTP id d75a77b69052e-4ed725ad94fmr15843981cf.35.1762304412809;
        Tue, 04 Nov 2025 17:00:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqM9wPuzp7mI3UoDQmT6XFIeKLdRKJwOrx52uQwcaZNJaLGlcadS9yQTQb88x9OM5PTiSjZA==
X-Received: by 2002:ac8:7f56:0:b0:4ed:6574:3a90 with SMTP id d75a77b69052e-4ed725ad94fmr15843431cf.35.1762304412075;
        Tue, 04 Nov 2025 17:00:12 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943445aa08sm1184504e87.107.2025.11.04.17.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:00:11 -0800 (PST)
Date: Wed, 5 Nov 2025 03:00:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links
Message-ID: <hq6bgwan5yma3cxl5fcokyglwsvfonvawzzkl35iypxagl2twz@caeainjotpbr>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
 <20251104-topic-8280_mxc-v1-5-df545af0ef94@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-topic-8280_mxc-v1-5-df545af0ef94@oss.qualcomm.com>
X-Proofpoint-GUID: GHGN5_I4KhKAaVtw3z4duqrvNNFA9Tcs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAwNiBTYWx0ZWRfX+g9pT93KWtH+
 VXt2ul2SM7iR1uYxL32ykHLArcFaGkAtwTJlBHUsQVbnNbOrocZME+jrO5TgweAFRAOREH2oPug
 2aPM/zpifvew6xwYLdpwLX8GKe7uI1MKoF3vID39GTaj6PWek6zGbM8NwbGsYgmqTgo8f+3+ohA
 BukBgjjPwZbQyNPam12mkeDnDSDxYWRnZqqR6MzGeZQEah+MXqV9glOLkXRHCQY6zZGMlhQKSrq
 FnXt2q9W4hxCqfaxoCcPcNsOVdr8yD2M5uHA9kU8tlMNCIEz6ElmQXVi4D2OwDjVr0LEzrrvG13
 G6A347EeyBj83sJS0Cf5j6KCDpzS0BRsNTZheSor0AiOAhznzzyEekfc+9IdnYyyKCk/5+MRK4L
 9jaSWvNqcwTyFh8KyDKmtduv1EwS7A==
X-Authority-Analysis: v=2.4 cv=OayVzxTY c=1 sm=1 tr=0 ts=690aa19d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GkPfKR5kf5ua8B1uwKAA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: GHGN5_I4KhKAaVtw3z4duqrvNNFA9Tcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050006

On Tue, Nov 04, 2025 at 08:31:10PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> To make sure that power rail is voted for, wire it up to its consumers.
> 
> Fixes: 9bd07f2c558f ("arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp")
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

