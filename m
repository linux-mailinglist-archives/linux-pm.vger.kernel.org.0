Return-Path: <linux-pm+bounces-24531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F74A71D95
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BA38418AE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 17:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D31023E330;
	Wed, 26 Mar 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fexh2oru"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5723E322
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010910; cv=none; b=S812GRo2tr+5TtesVKAoO+ipxq4Hb9jA9UAudtmPoUGllP6iZ8dPT+BnFfQnmEf091LTvjbrwIbFuKbcgReZyfUVPGYTepawygTLsnWrpJ8JqeX2JYcDeNKdpb+DFe3HYkzYSPaNcCTXeU/gtYBDyLrcdX8oY64YRqbtCiiBPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010910; c=relaxed/simple;
	bh=VbMAnTpopdjLkmZXesRjVC8mZ8m6kPoSqNU934M0L50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+xWRN8K7Rw3dHQ928xWm8xvAUbUUK5OZtQ+wAj6LAiSf7eZt6QxSiYRo+E7FupEXWIZd/FO99YppTyfvRdWlkboKboevF2V62yCrCYlOPkPkIgjyDvN3FioTZUYQ7d4NWuvxH1VEWDn1dSpnQtG7abF1ADqyTSMBCT6d5KQ/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fexh2oru; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QEcIs9006180
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AtUnXSz/pPSjd1StFFw///pe
	5D57Ql36lWJoHWVv3Fg=; b=Fexh2oruYqA7AuiHnh2DEl9WXCEYdshYebDWjZlc
	JGNFGWH5RHBhLhbjlQw/2B9zVe90qF3/7SCwNH67i4/Pr0glrp8WrUils6l08CMq
	5RouYJWoF6vaRSWO2odAH2W7iPx0PxJEv4sOPcl/psulIyAU6+o1Jp1yjapiPr1L
	KwkhCvR+ykjSReuDroCi5U5OmaemfZgZScRN01peHqUTVvGS5iBelFE5gOkQRzc9
	khDybEE2Ju7HQykeZVdshjfPwV3XkJjcemmh11uDcgQ2me7XnO7OeO2QgM7svRT0
	uCxlWmmwFe2GER1K0LgQBdPGeilrUGE0/eYqiMO5dUq5bA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45manj26se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:41:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c53e316734so19993685a.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 10:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010907; x=1743615707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtUnXSz/pPSjd1StFFw///pe5D57Ql36lWJoHWVv3Fg=;
        b=XDC+uGe6sVurqzwUrqLqnfWtXNwmyOQc0F+3DxJsuKJoyTnjAg9fzuKzhmjUyqgtbT
         wMgKKU9QGpVTHfYl1iYDwuecvIpoZt4HKHB4Tg4PuW2a0ZgzQgE3pCpSf3a8Y9rSOfjE
         CV3tmLeXHg+L8d003MYmISfVEZWcxAInyK2BB+oegndcX8Of2ziO4TBeJWpeBaTWbnY+
         89Eh9k2L/ZBBsDGJS5qxhSefPOkdkIOPcR6qAxqJzHwgWwJSJwwZCbMU62n0sbsYU2TP
         SfrooKvZjFWWj4XvyXeUjDdd4MWdDOaPs4OALLyr+HS64U7+ECI62Nl4tpPoLlI3YD0O
         w1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBqfJz8r4RiYZkCRHy2KY7Nn+qxsXRf0xbuzugV8AAWG+K4VrOHxFrzy+KJ7v5pUbc4lGEcRUigA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6c+hSQTfpXSmOL9Wkby+IVVWJFIzYlBtYqmFLurfJAI2a5ND6
	mXaOgrXNjntTrxZtxO2G5aw6Sodpjcej70kMEjbDpiqDIEfVExS4DEo8yynK1TYJUjcjQOeJUxS
	U+LUZA6AXdcIebQN1YoIzVPGL84WncNyIs1aF0jJ6RWe55fBYyVdMVvoebw==
X-Gm-Gg: ASbGncsbbczZzTqWAuYEKqTxE0hgGA4N7wK76zByzSAIiCQ53bXsmDmbPKUR7bNyBx4
	u47Q95RZFehJ4rCBPqdnYHcnED2FapNFqmOG75RGBUJgenJRzpl3+qemMRekT4WTZAbEC2TuiKC
	Aj4K36sfT8/hu79VdNhA5PDKCOMi/WPWxRqw1SmlVmRmp1moI6CCg1aHH3zZ8mjzoWdkWMQ567D
	0K82q9E7TxB93KtMalCXhQuLSIW/jNMGHIQj/68/PeBV/vMg12um5ZKrjd4y3dW7ZoCDonW1Ub5
	A9CtsaZeSyrH+o7Hr0SFeMinKEf3RnSO+uJ3iSDeZdE2O5ButmFrJ8vnNDVEREPMc4QHzxrbY4j
	ldl8=
X-Received: by 2002:a05:620a:17a9:b0:7c3:c111:8c3d with SMTP id af79cd13be357-7c5eda91760mr82460685a.49.1743010906949;
        Wed, 26 Mar 2025 10:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuqcfnhkzb0FRV+B6Fzo8Va+R5lmfJZjN21TrvUtVriwmR9+t0F3bAporcIBSfQDBEa+GQUw==
X-Received: by 2002:a05:620a:17a9:b0:7c3:c111:8c3d with SMTP id af79cd13be357-7c5eda91760mr82455185a.49.1743010906411;
        Wed, 26 Mar 2025 10:41:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7e0ebbsm22090901fa.34.2025.03.26.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:41:45 -0700 (PDT)
Date: Wed, 26 Mar 2025 19:41:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 5/7] interconnect: qcom: sa8775p: Add dynamic icc
 node id support
Message-ID: <bpjjnvw4mkjieidi7ooukt7f3bgxig5ezyuhp4tjmufr77eoel@bwj75fjd3mxs>
References: <20250324183203.30127-1-quic_rlaggysh@quicinc.com>
 <20250324183203.30127-6-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324183203.30127-6-quic_rlaggysh@quicinc.com>
X-Proofpoint-GUID: iEywFQi2AIxTnl8LY4Is3Tb6B-OQQ0O0
X-Proofpoint-ORIG-GUID: iEywFQi2AIxTnl8LY4Is3Tb6B-OQQ0O0
X-Authority-Analysis: v=2.4 cv=KvJN2XWN c=1 sm=1 tr=0 ts=67e43c5b cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=oKCiNua1F0BOgjzGbBIA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=876
 malwarescore=0 priorityscore=1501 clxscore=1011 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260109

On Mon, Mar 24, 2025 at 06:32:01PM +0000, Raviteja Laggyshetty wrote:
> To facilitate dynamic id allocation, discard the static IDs
> from node data and set alloc_dyn_id in descriptor structure
> to indicate dynamic ID allocation. Update the topology to use
> node pointers for links instead of static IDs and forward declare
> the node pointer to avoid undefined references.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/sa8775p.c | 952 ++++++++++------------------
>  1 file changed, 347 insertions(+), 605 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

