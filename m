Return-Path: <linux-pm+bounces-39385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F892CB1ADC
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 02:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4952730C0891
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 01:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457DA230BCB;
	Wed, 10 Dec 2025 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="puiiVmk0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FS/eMFA+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3487481DD
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331796; cv=none; b=S9WThcQJiFpm24yfTB0oVTTWmwvpOLqtJmNbIzVlzjxNSfo0oR1bmnNutGcS2HsJ3RHWRYWP/6o22KNtxkqhj60zCyvZlTOdy30pR4e8NtkWsCHumAqvXmbRbh/Txe9x0G4GTCqQF/DS3xdhGMSBSnITT0eerYBrt0/8RKSeI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331796; c=relaxed/simple;
	bh=e4fcYpHyZqzDEsYWXD/fCBBZoJQ6ccmxF1/S33V9RfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxIBOkOoLuSr1gbPlSAp4N9pI+nSXoqrBctmHGW0w+dDsaxD5JKGEhq2TAbNxbv8FDUk6FDK5jD8m8J00aH5GARadfgXi3DlrUVSHY7tXcnBqnyCcK5bSTUACu/gzubzeWDrJY0DeSZG6J+s1v/xQkEpIWwdtbMnxVkiLvvS77U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=puiiVmk0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FS/eMFA+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA0PSYQ1724390
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 01:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8UlHqByzRs1jqUK0cOJbZ6dh
	LQhbGEcO5swtR+2QQVU=; b=puiiVmk0xmNxyNTCv5jf0lowwjKoFa1l1uihwU0c
	RszUDgGunSBOzJQ+DkPKhs3fChW7c2dqC29w/n6pR61irP/fGNRLPrsYDWI8XE2x
	eo6uuNFmBCKfyeC5m1timrWREhzRaxbvSsaEj1SBcoB9qJy33ZDuJv+avrPmVh4F
	9zwm5AvuxpW7iU9UvZTIP+bKiZsLhSs4N0RnJ60xKSV6XHFpueixdRQ3Pu79umPM
	/4ujEkByUhIVOHZhTo4tEm7D9cHW86olcI5Jjaw9OxVixH2z8H2r4tO5xJy0BN35
	5eS507vu5ZjQkJFGUtJP9yewwZq3HyWV17xIgJL9MV4kUQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axqu59h10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 01:56:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6ceab125so7137311cf.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 17:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765331793; x=1765936593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UlHqByzRs1jqUK0cOJbZ6dhLQhbGEcO5swtR+2QQVU=;
        b=FS/eMFA+IihMWuVX+cHlTdzuof1pwjgWaZC3AyueE5jPqJ3Jf1xQlJeVX5aPUbQl9O
         rFbPiA4osmoWmsh5iWFwgY26fvdLxRIehG49aYho3lNTrU2Zz7Vv6bbxX5taA1m56jVP
         gxdMmT6N7YMCZvpHw7QP3ZBUcVt2AVDiMEzFJQNAA/CIa8ywoyE8G/f5YM7DuZS2dwOQ
         +XSTWxSEcWlIVM2K5Mn+OdkMCabvOD2JKB8Hoc08F8N+mkgxZWE3LeugFkgDj3n41rpy
         snQ+gO/O1TMUKSna1j3lrukfaE+9xEd29rRRbiEF9PmZHA+8++J/rxIdh/4ViOX8h9zA
         6+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765331793; x=1765936593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UlHqByzRs1jqUK0cOJbZ6dhLQhbGEcO5swtR+2QQVU=;
        b=PkS+vBZkhv2Eih5b36RYGf+FIA8iK+7FtwglC5vaSN6EAF64bF19gPyGwEo8SZit8q
         qXGcODB5JJ40tiA0ZQa2zyqTfkTJt8jGDlZbitET1p+l196hURPHgp7TfLqxdeFyJou5
         JQUS6268ITndMAPjfiZwUMXxo91JHtvUiy0bjEk8WMfzo0uYjd13u6SxuZkJNmoVkSCA
         CjMA2h1F6WK0QHwiHrO+jmy3r4R5JmbYhNrnEFVcQgiRAQUoWfejo/2wxOPIxyke3HDo
         7uZQKtDb683403+JumER7OdFR6JN2o0aanUvlQvML07vl7hVgMfkMOcMTlmF9xjYMSQC
         jXHg==
X-Forwarded-Encrypted: i=1; AJvYcCV8CTdvqnPxtcKcYyrjigwIrCo0xtbqFcfkk3NJuK708flNdhR7LxYEbpilwowQQRLgtmzY4YQm8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBX1A5Xl46J659uQal/oJ7C8PS2Tvzj5XeADoGOy8p1czTIVKQ
	hTxNv0qKpAJCnkHrDzIym8jBqQkq3qVbm/kM8Wvq0Jz5VzpAqqHuSgFafvALCwyAEtNm9TXrn54
	es1XdSTGhJhJLqoz4wH1vnUVyWRRSvZ1maeTJd4C8XzzFjFRCGt3kT60VKOYyrw==
X-Gm-Gg: ASbGncvLP34jOhT2zDlC0crVpkpfWHRzvZWakVApZTtE6S5dWS+EfdaHBw1nHaSbmZV
	aXqJ2unk3gJz2UrT/YCd1fZXlu34r+bk8vq77uPKXn5RpNBHTJt/St2C/iI8yFWWoWkoB8zqtDf
	H6qv4P5RE6l3upLBzhdwbIE92LrS/vnnABb2xnLE4wJ4O7tt2IfRLJpd1uhFz8vacGURO2erQL8
	VFeEeXulcbL4emm6JqoxHiy8mvz5F+7LUSN2nTvtlz8SSzmTanVzpXJQDs8zyNlaz0MEpDJqoal
	dP8mTXA0tVlzk/Cbz6PsCyuGieAjpEXiw/ffJowyknwHnRDCb6DTIs9VwlmD3am7NwhbYB84986
	Zf4T8/hyZ00hYo2KIz/xqCVtevYTZNnDtxULZapdSla0SACILZXPDxYfHqPL8bABu+t6OwaT/dN
	HeTrumLTNDbQeXSp6EUUQ1ogU=
X-Received: by 2002:a05:622a:190f:b0:4ef:bd1a:501f with SMTP id d75a77b69052e-4f1b1a67517mr11770651cf.23.1765331793209;
        Tue, 09 Dec 2025 17:56:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7gqj3G1BiKUzip4pW3nsB9M1LGKa8ryFA0k+LN0QOWznITPFHf2QMQ02Nxgz2L33VFBTrLA==
X-Received: by 2002:a05:622a:190f:b0:4ef:bd1a:501f with SMTP id d75a77b69052e-4f1b1a67517mr11770411cf.23.1765331792756;
        Tue, 09 Dec 2025 17:56:32 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7b245b6sm5681124e87.28.2025.12.09.17.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 17:56:32 -0800 (PST)
Date: Wed, 10 Dec 2025 03:56:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 6/9] arm64: dts: qcom: Add PM7550 PMIC
Message-ID: <3h2kag7drftc5qiz7h5xapnj2kuaqexvknogkvusgca676cvw2@x2nkz6kmiphi>
References: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
 <20251210-sm7635-fp6-initial-v4-6-b05fddd8b45c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210-sm7635-fp6-initial-v4-6-b05fddd8b45c@fairphone.com>
X-Proofpoint-GUID: 77FKTLhISCNaIEQKs0kjKgqKUdSBFNkp
X-Authority-Analysis: v=2.4 cv=Y7/1cxeN c=1 sm=1 tr=0 ts=6938d351 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=5gdSdrsV3EmceHnK_3oA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: 77FKTLhISCNaIEQKs0kjKgqKUdSBFNkp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDAxNSBTYWx0ZWRfX/IdQXmShkeBe
 2EgXDot1Ot4O5FEHuVpmuW+rlAQDp9m6ZTEOk2Tk84ljAOJN0PAhInRZkybtGLL/kAG5hrPDXPt
 Iqoq/USb2Tr2R0pj6xtyAASxjEPf1FH0OL2taYEEq8Im2nO7tjiRH1o38UvmXDiIgVM8lRUFzS8
 Iv56nQQ7PFy2gmsjYvrjELkO1tfF8A1Us57RQFOTLwDzHjI9gOK8A5e4WQTa3lCzCVMIdsT07n6
 YzSspWET0gYLmO42RYET0TG41SOmiJ+ugojUcKWX4cLMUChCRZkycLUpY483yEevbskxFp6cYza
 4J1DdCeVZVLuHHYzrzvhOMagc2DGpowtMsebRGALb9yHBsf0vsZQuAqdl+WSfao9JYrZ4fG2PzW
 q6bEhTu1M4QwCBVM9tEfLtxA14fFCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100015

On Wed, Dec 10, 2025 at 10:43:30AM +0900, Luca Weiss wrote:
> Add a dts for the PMIC used e.g. with Milos SoC-based devices.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/pm7550.dtsi | 67 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

