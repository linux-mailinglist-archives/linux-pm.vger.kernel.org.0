Return-Path: <linux-pm+bounces-41890-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EVPOwV4gGne8gIAu9opvQ
	(envelope-from <linux-pm+bounces-41890-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:10:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C38CA99C
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 11:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29E5E302BDFF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66E93570DA;
	Mon,  2 Feb 2026 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1m/l1hN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SC6a3JFF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4734D3AE
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026620; cv=none; b=KyI5EAc5MhiB83Wj/qU544rPwXuck7VZUJ58Wvy6xV/9ht5PaDY+yofG2AsbnpRwoKtZ9lJBhmBCsNZRFdAVxqTPZru7FAM77FhZnemEYkqXY6nltLX/oCJqB0jEitsUGd3yWc/uRGP4wzeTD+DDxFaDLCXrD7pDLVz22EAWHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026620; c=relaxed/simple;
	bh=6MYOYdYMyCKrY+q5X+P534qD7KPIhMkmL6RSMY4gi9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zq3nV9W5t4MvrqV8H22NEQxxN2enXviCJlRjhauWTTFAF7sSh4TsYx7jNw2u1eITgLdMjRJGt8OUCJFo9ZX19OqdZt2PDpG/WNWkR+lfbhnekBFILm9dag6uuTlD0PnqfCHHflUHYxUh27Wn0y6gMA3XNEXXlscxK2nI53Xwsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U1m/l1hN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SC6a3JFF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61286Fs91331761
	for <linux-pm@vger.kernel.org>; Mon, 2 Feb 2026 10:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1HAVl79FNGlIAUtprackUJ1sai7oBy7Ct1ZWYx+SBpQ=; b=U1m/l1hNzPZo56Yz
	GGGpqzouAxR6PfAIa5JUv1nsKSzB//lGpDmz/1LiyDhnECeZ5ZmDoB06KAgFI1E0
	fvEnHrWqL40QdlXJehjm99A8MyZV2+zB/mI2CRWtxtDP8UmsLf6KT526mYztg1nT
	vAuYGZAC39LR2/eSyrLVbGPQBvZXlxv3+HbW0P+YB1HJr3DlI+R2P0fEZbh6VsLj
	sNM8AXk8uMiu+MFtaSz15zgPxGojRmcHrfjaC2xyCpgJMKzNbNhxgArnU+4OPGui
	YOSOVgGclh6EsnNd7FFgejMlg0yjzmjewUt8n1iHK5zzfA7J8mJQSihopDUVyTH4
	0t4ouA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1awnw18h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 10:03:37 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-649b49aa449so447134d50.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 02:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770026617; x=1770631417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HAVl79FNGlIAUtprackUJ1sai7oBy7Ct1ZWYx+SBpQ=;
        b=SC6a3JFF30g1/J/wrOn5QetpfQktA7XOch2gh8oM7jCz4SZBbHoYP2FO7i1PJ/AKL1
         mpxmo9J2dBLhaikOqSz/LCBcVzdzAS+bAuywe2WpD4aPuPNEzqkJ3FE0RobtBRiL5CTm
         2uAaLpChLF6bQJw0YSaIAKofCl/smiIJYnwSvemKQynamWiAsaPzq0KBFzmy9qMTV0ie
         XYuH2Db4t9Uo6ekzwvByv2F+1dh6bgG+DVP8ebFX3Vdql1rr5jRROY21rvxdu//1eIIW
         Dm7EbaLpXaAoCAmW563sCw4DkLtG23XiTr4QIuPV7lc0DKxX+oyE1w1sJOoJJnzKxyvI
         pLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026617; x=1770631417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HAVl79FNGlIAUtprackUJ1sai7oBy7Ct1ZWYx+SBpQ=;
        b=V/elim/zMXqGc9Z/Y1TwmiWf9TabsBIUS1OmI6WFnpFpV+Eu6VoacX8PbKvf2+91mq
         89aTamnEdNqQ0tPyyo/fAbSoXp2RpemwxBdR/Lw7loEe0j/JpNA9ZD+UTxSMeHKFf7bd
         plSA+jfuR22xxq7oaXI9fUfAHrnK5tuzJxmXfI8wVqju6XlIxlH8GIcdXcvvsAa3VBtk
         q2CiATRMMMjHHi8KlzpWa3eIbDRLisb/rx+d6dNTPnjCPPiABLAHBRUAUM4N3zNraHAv
         GGL8ymQEAknQnIpZ3VgjdvVxFcv2c8zchDfwDxQxyF5z9WL6K/hR/eio0RwLbxfXHL3k
         F3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzzBaA//ebJpxpgp+/5DcMgF2ocp6u62jPr2r5qBCG3j5SveiicGEeIqMowjqjevPW235acH73sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cbdvR/pJbzSDzEzfWlsaEDuY46rN6Y6/SubyMBJbx/zykWZu
	mAiv3fCgKVZD7HrYOyjKOd4OtIXrukRY55Xschll41HyUrwK/SDFjrnN5cLEnm0+tSC0VkeJujl
	4+LLDVAxZ0PpEwnxNssKCBfaKfgKJFiFWcGtBe+9gl8YzbTKj9qWqRW1zEYp8Yg==
X-Gm-Gg: AZuq6aLyTpFGgkmXdzcDl8MA1c44UIcOVTKZtgWeQdhem1jOR2F5JsV5G1c/XWQ6wMo
	0E68MHtRyY2Zeyly9IAM700VMS1Y2+KkDCcWI6GsyLoAfD8kkNJJfHxwnfdUIT6pXqJQnu/0K1l
	sr37LoduOIiN2hLhAvqLBTYNQk2TMxumMRUGHzdfI80cLuwoWJU8kNxRw6XHE8esrhZcAgvdWUW
	3UQ0dGBuiTj8ivExPys4Q4EnHhOOfWBTvjfdbtTT3WUVrwXnsYUszfOuuDTZNGudcKQt+tpdPci
	aBBesTcQr9vTTA8XeCkOKcEA1pkv3m3xT5XG8h0BnpGAhDXz5bPwosCsWSFvWFNRtJDjG/XeL8C
	3kqI9maKCCSA4iuBNvwia/zm5YfJbTH9gWdJ9i16NvhBsloEkwe0APysXDWTfWKjei6w=
X-Received: by 2002:a05:690c:fce:b0:794:d80f:d029 with SMTP id 00721157ae682-794d80feb51mr14857397b3.7.1770026617344;
        Mon, 02 Feb 2026 02:03:37 -0800 (PST)
X-Received: by 2002:a05:690c:fce:b0:794:d80f:d029 with SMTP id 00721157ae682-794d80feb51mr14857207b3.7.1770026616951;
        Mon, 02 Feb 2026 02:03:36 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbef86deesm853407766b.3.2026.02.02.02.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:03:35 -0800 (PST)
Message-ID: <b06767db-e3ce-4f68-8111-70cb6e152975@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 11:03:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: sm8250: add MX power domain to
 the video CC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
 <20260201-iris-venus-fix-sm8250-v2-6-6f40d2605c89@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-6-6f40d2605c89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNltWcZl c=1 sm=1 tr=0 ts=69807679 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=qsDWvSvgGUoFJVTE-XUA:9
 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: j9VAHJcvGKrrRRJcJ31EJSD4OSgIiZJc
X-Proofpoint-ORIG-GUID: j9VAHJcvGKrrRRJcJ31EJSD4OSgIiZJc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NSBTYWx0ZWRfX+/6gsXJB3982
 NZHdrdarFdk1CbQkJimXTSixgeVGeyqGskEGSBAmTO7pEo22SnTMXNySG/gGOTjWiU3rEhwKndR
 yMC7b3qiVeR4N+OK/jG//i3YmN+H+FxQzeggw9nW7Qx9jO++kMyiun4++6YVhSJyG9ovVRMFQr9
 4wPg63HPlwJEtvnkUWTLhKg7bttqjhc88J+J/U7ibJZEIODYBx+sJy3EPzd1HgOvO+78OETsMJd
 Tvn2FSc0XGdPjYTv06kyPDoi8Pfd6yV30mhiUqPoZep5pdojTHNLmjml29ojB3kXpEZVel1h3DL
 Thcmuqgd/BxLBod7ysyz2CUwHD3pNctXwOgowkRFPvkGeIeKAq9fmThpAR8e9LTsxYBE29aZOsn
 5oOc/szXTfbhwoT6hjD1XVdfkgYHiJrSAIXEzrEcPM4rVrXloo4lY3w17TT6YeydKEoq7WeObMU
 nQQSqS43LYMd6kHdWtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020085
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41890-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 78C38CA99C
X-Rspamd-Action: no action

On 2/1/26 11:49 AM, Dmitry Baryshkov wrote:
> To configure the video PLLs and enable the video GDSCs on SM8250,
> platform, the MX rail must be ON along with MMCX. Update the videocc
> device node to include the MX power domain.
> 
> Fixes: 5b9ec225d4ed ("arm64: dts: qcom: sm8250: Add videocc DT node")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

