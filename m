Return-Path: <linux-pm+bounces-41195-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BA8FegPcGlyUwAAu9opvQ
	(envelope-from <linux-pm+bounces-41195-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:29:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D934DD04
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 00:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A29D96527B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 23:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3F322557;
	Tue, 20 Jan 2026 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXbyIv2U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AhD0TyYk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA33337B89
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950509; cv=none; b=bHiFEDDq0RlKQrp9Z+ZRYACl3P/rS3t/o8ciAwu4E0R6g5VdoB+KZAuAv1pA9g0uSXkABFRhqipjLDAni4yr2YN80baFVLLWnQsBxfDAo3WNqnjTO3sqfdfYzmnHiKf64kuVhAFAqK5lFuKjPVtqs62Qc/s/DKNFJ1ZILK3eKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950509; c=relaxed/simple;
	bh=1DMeQynHScBJFrSHPAMedUNej5dPsXOwWFA6mNyJAGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHcwJyVseidtmykL6H4myxfmHzZ4a/2MnzbFhhHY2w+4OmGTi2OLk7Us0tIil7w2pxdM/cS2UNHorU29FKJYX0Qk3iEtnBvFq2e33fkqyjRBwuiadmkss+z9FQ+aYMh9z4J0kRhtDM66aMIpurLoUqZ7TrOM2WVvKrL4cABkFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JXbyIv2U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AhD0TyYk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KKVdoh388139
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 23:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hJiAggJDqoi1UxxXfJTxZFSG
	047MWQQxl88t2M8QlQA=; b=JXbyIv2UPpXC7GMlv/tEI5DqyBddK52CgvEu6JYU
	bgObzhNQjz4jdYuDUS0Un0KoEDZD8d5dEtUSFacnXMgDcuVwEZvhKOzL4vpaX8rG
	dLrfytVJmo178V2IqwEuV+ZGVoQcr7xGXPTakgSalx94k/qMzbM1HM22/H3rij4t
	s5IN8rSr6a9hU70ySfp9p/52Ol5VTliT8hum2XwgEQMLP4NZRtOQOH8eyjblbZb1
	pGeE9y+g+PzzsfmMI8Fm52abERapcz1oZdHew/XzdeMictLuQh0N2re0GEE4qDoT
	FthGPKRFtOmsbfn+sJMk5NSU9Esw8eixrBu2sHYzFTPTpw==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bta7q9yyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 23:08:26 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-40414b6f18dso6261565fac.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 15:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768950506; x=1769555306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJiAggJDqoi1UxxXfJTxZFSG047MWQQxl88t2M8QlQA=;
        b=AhD0TyYk7yxbVEc/6E0mk/XOqP5d8ogP7xCjY1GTHRqIlU/LAaohBR3Emy9I+mO2iP
         PuqQOZ87An+dg090faHQwlmB1Y+jiTsDV2IrhAP9n8T0NaYfTCXaBacTxGsni7iv7wZ5
         BUjcKqDsXxeDx5h+H5DO4WNM4h1u6/1F04GOvSIrSNkK0z/UPweKRHKcVd1q2uRtIUR4
         UbiS/GkE3aPjMByr8InO3vvCy15PQdKqKBlVtoHO9OKCYXYvT2D5rD4GUXpHMSdTyClQ
         yG+7jDm7a7Dq7qqwkoyXbrfPcbAb4ZdgasU1ENLMtK6c9yKR8jGJc4pMKc05kWxiO9aO
         Ys4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768950506; x=1769555306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJiAggJDqoi1UxxXfJTxZFSG047MWQQxl88t2M8QlQA=;
        b=o4E5RtjlIVMfhfrmfxkcMRLD+CQebpjldKJnvN017KpIymGIZWRxau3b4DEgAF/5DY
         chWT9ZFSeVa63A0jzs/gHGSc3ZuEBxaeSgMDVc+IRdiGFW6Y9T2elaYUWbWCx17jfDKg
         +l0NV5KGBzlB1TCF5QF3r6TbocOg1818uJH8aSqxdfWM5N06ORHhB3XJo1aH1lNJgxIZ
         6fv7IbDAqWlY+PiRcqt1Xf2narKTDsWzmO+4YY+v/tgS/0kQaqz1NfMdaSOV+9T+sW3W
         yam0JKuO2M1i2rB39SovnnbRZ1viR7Rta37fwErM+1DXeYpnEO8A+6G/bogwBmtELWMB
         W8JA==
X-Forwarded-Encrypted: i=1; AJvYcCV79v1GiyfHzKPmCfHYli6TrpM9WzVwXMUPl9QNHwR/jnMH5ps12gx31ueR3A+HRxY4/yUG6Rp7jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRIXwgahrpUs/5ifqYj9+6iTH481MlRXmMxuabGLcXIskn8MJx
	+r+Ev5NARHyyNXAEjcvzoD2tPcLykPRn1MMd/rJhhcuKqiU7iMmoiEBxfyVCVeQJNvT9ua81GTd
	WT5PVIGdAXuWRaTgZsm8dINRrPatMs96o8MDpPxVTu7M/ZckOCKOq9ydCvI0pHw==
X-Gm-Gg: AY/fxX7Vzlt8IwA4fNRR9mgUFy/xUCKmuSM0PnMA8I8HG6ZW+fU7A8UwWwhABv1pqV+
	jU22e5cwud8KarcvUGATkZ7ldjbfM/vkAfzTCN6VnlSzqPLi9i97s+QxouQ3wlbLDi24p4EsO++
	eEnHPxOQVPPQ6wCJ3CUHOuEexBXNCrP3H3BrfWgqPXzMBor5nR+3iQP0MBFD8H3aucaQ9MwblQJ
	FNA6UTV5d0B1ZdI65MhHlDYM3hIkr556N+Aa4OrHFjENsm0H2wJrWL9h4qo0MLOZVoabmmhRywY
	WVOvol1V45pUXxwMiJYlE/4vzMb2rXH2oO1kr/Dy800LuFpRgDXrjWJ+80KWDjk3GjMTRPm3L+K
	9WdkJF8CacJ5MwAni7IhSuze+6fyfhcSCefaVYCG24NCe92LVPWPwG1XKLgNjedIcp6jGssl5ZB
	6Wg6y7m55HPxCOD89M7bDrTaA=
X-Received: by 2002:a05:620a:460d:b0:8c6:a57c:8cf5 with SMTP id af79cd13be357-8c6cce95775mr392157785a.24.1768950033216;
        Tue, 20 Jan 2026 15:00:33 -0800 (PST)
X-Received: by 2002:a05:620a:460d:b0:8c6:a57c:8cf5 with SMTP id af79cd13be357-8c6cce95775mr392149685a.24.1768950032550;
        Tue, 20 Jan 2026 15:00:32 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf34dd0dsm4350213e87.26.2026.01.20.15.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 15:00:31 -0800 (PST)
Date: Wed, 21 Jan 2026 01:00:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] interconnect: qcom: qcs8300: fix the num_links for
 nsp icc node
Message-ID: <7jnd27u6qssvsh7nmqag6jqdy2aze2zc2wj4ti6sksf2rhp2i3@zqmw4rdoryyc>
References: <20260120-monaco_num_links_fix_nsp_ebi_path-v3-1-536be21ce3ff@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-monaco_num_links_fix_nsp_ebi_path-v3-1-536be21ce3ff@oss.qualcomm.com>
X-Proofpoint-GUID: IYbIczT6tIebre3vMvjJLMoIbnqRBM-G
X-Proofpoint-ORIG-GUID: IYbIczT6tIebre3vMvjJLMoIbnqRBM-G
X-Authority-Analysis: v=2.4 cv=LPBrgZW9 c=1 sm=1 tr=0 ts=69700aeb cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=jxiL0x3TbA1XT9YnT1oA:9 a=CjuIK1q_8ugA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE5MiBTYWx0ZWRfX2GCYoepXUo7d
 MmQSWLW8PfPllEnnFK8w4jMuxocJuLk7e5Q4zSHzyfxtXFSpL/RxBfQr1msJQgslBB7u1LaME2z
 jm6nvJQpRmzK7UA9A8IVlVfdAF0+4aN9vB6KMpCKsLZEc+Puc2/4pPBCth4L/9AqO0lJ1jcVDrW
 yKvpDOZN8iwmYp8rgjf1n5svX01a84pbmdXmP5pI263qk0q6thwkagRbFrhZkP7+K/yl+2FLUvF
 iikgiBEdrzM9DgYvh28o1nlgKSdJjdS4ose2mVSPKnr04rw2cZa00BgwT+egVWk1e68bhbOlWxu
 9ZLTk/fK7NxLf3r5ieq49YLoOhlYflitww5FkpgZDeCRnUQqmRSQKY8WHtnfmUvbNYUpXPtrUeI
 ZghIvp8TkdW1jXs7A7LcD56JrtlYB9+MJjEYgsX4Us3wMe2YQiODXRK62kidG7Uq9Th782FXECx
 ZKNnYzNy0XwydXchnrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_06,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200192
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41195-lists,linux-pm=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 07D934DD04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 09:30:10AM +0000, Raviteja Laggyshetty wrote:
> The qxm_nsp node is configured with an incorrect num_links value,
> causing remoteproc driver to fail probing because it cannot acquire the
> interconnect path for qxm_nsp -> ebi. This results in the following
> error in dmesg:
> 
>   platform 26300000.remoteproc: deferred probe pending:
>   qcom_q6v5_pas: failed to acquire interconnect path
> 
> Set num_links to 2 to match the two link_nodes, allowing remoteproc
> clients to obtain the correct path handle and vote on qxm_nsp -> ebi.
> 
> Fixes: 874be3339c85 ("interconnect: qcom: qcs8300: convert to dynamic IDs")
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

