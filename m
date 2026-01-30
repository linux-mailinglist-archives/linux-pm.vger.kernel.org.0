Return-Path: <linux-pm+bounces-41786-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KRmIR/LfGnaOgIAu9opvQ
	(envelope-from <linux-pm+bounces-41786-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 16:15:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF745BBEAB
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 16:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E346A3019148
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29F319855;
	Fri, 30 Jan 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gmy6svRU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gDCeJ8X+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42F1E98EF
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786139; cv=none; b=XXSl/u8KsLzje1BuRCC6bfAfXYnP/AfXV9aCx/qv+f+BlTdY744rde97/RRGJVJKybz66CtVHIml/K0gTZZ8gXym8NuV3yDcwy/BY4w1EjiKdENudr++Q6cMCuVr3hFQYolCGPnROBUFh6OAd/3479Kjdo47LDaQyVvjK+hr560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786139; c=relaxed/simple;
	bh=QMaFrcjLt4waT97iMzumzlM+XY3F1p9RNuu8D7U/QZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nRpNTS9/K/Wey8awe1c+MaD9UTnZKhqcBUjEHx3eHzOAtx0bzWjrP7Vny3RdzY2He6yMtwQ3STjnblYms/EdqOYi2p0S/DcnQtheM4H1EweC12tK2D+q4q6k8W8zTJyEK83ZdeyDSKOyd2MdnsdOqwSOM5C7UB6oekvd6Wk6R5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gmy6svRU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gDCeJ8X+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UABp6F2992829
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 15:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mIZREWITnjl1/FIFaSe23yCY0lDik0S4hWoOA7m7i1A=; b=gmy6svRUWsYWQg1H
	gWSRgxZf0Y0BcJ+NOrGdoSUG5V7/ls2X5r52gEI9QycnVMPVifK48Mrt5GBRwtLs
	KZ3AGcmmf7/Xqp/htdSQJ/cD3kp+iTy2l3RzxfQdC/TOFRcZsgFQoO/taFNk57Ke
	tDWiLOow69qFqk1Drw1xWQtl/UibG1/NncZpP/UJOIGGfOQtt5f3wKcXO+eIrhlA
	DBpvKLoM+dSTgfW7Z3KbAtoZSTG8XrBEvVlUf55jeccCvNcXGen46bcVNUjj+NoM
	Gaez8yIhsu4pQ4PIRdbeMF6L0GPKcP8pNWJvmI3YbhesqEqYOCjZISXxuWc8/qbm
	OQjBKg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0db1k8wx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 15:15:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b74766fae7so2679113eec.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769786136; x=1770390936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIZREWITnjl1/FIFaSe23yCY0lDik0S4hWoOA7m7i1A=;
        b=gDCeJ8X+QDm8FMscUWiCbTh5m6rXlpxg8rz1LlHncSpIs9ivh6/5XdGPCdWun8LJit
         2Q9S2s5QQ92FoxEDmkiaLFsu9lpQx+y6kLmxmvO5Hx4nI2guKNT/EqB3wAYYpEqES1V4
         QSYG/LP2Y7Gg1JW6V1gtkDnGxbIuVRv+u58tF5+bcGnd3d1RuDIKnHylX1dgBbSYJhju
         3VWLiT1yZY2h9pjerBaY0qd2sYpknBO57pWg24ZZYTZX02rZpDOOWi3hhKhIz4KAOb4X
         lCuJxLzQ3WgsE00cUxDuqykf7HgT3CDRWAw+DK7VNPzglggZ2dk5SyAK8pjPwo5uRV0n
         oUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786136; x=1770390936;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIZREWITnjl1/FIFaSe23yCY0lDik0S4hWoOA7m7i1A=;
        b=feBnmMNH0XU6Jf9eIaOHXFIu0bxfxZqxGH2Zdc6srW1Pebyf9VU/JVTEQAks+7q9+z
         zfRQsR4G54bCL5pRn42xHk6jT8PukWtLzN/VG7Giiy7MJYusyMg4Ucrnd6n7mfudKeSq
         0C4Lta23t2GjTq11QM1Sw5KPLAzaKxZesppvDgHhU0Let8eqHnGBWpodoE8M84sDuhLa
         FAm/CA4BB+hbs9COkUG/lVwJFxbc9sQfkkAzkBni/TZpHSf8jolD0yjLDWAW2iL8UYgF
         qGJXUSZlCmc/SocGvDM6mYa73EnbIe7zgioU4Cn/qo2p1lTo2ijYFD+wO0tTeU73ROoS
         BB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFbfvoaNLTEbw70KJXt2Mbw5fPsg8qt1jM5OossFna0gQOwjJsasNioesO6VjkEo0wTPTEDmQXGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQL+sBi363XAxpCXAmib00WfbqLaFXoYb8GC9UZxg1QFpBuVSB
	GRK8KNCHqmBuWRhKBfTXxZM55fOrqGZwFvjLXzcYlKazNaMzeDQjd0bsOIljxE1FYeqO8Dl+NzM
	OJEtNMwuEVib8W02OXLn6PmsSd0WngCY0orNPmgCWcRfpyW7EoiCr+aqr1kXg0g==
X-Gm-Gg: AZuq6aIXiXitKITWEHtpHR+l1781m1FmyarCzd2fIQo0TUyqGS7aT3dAt27Lj+1FLhh
	AW1GsdaX0W/T2sYCJiaMdZzBDHn2WYvhQeO8Md9roGwkN5lrzFvWFE6esQAtGQzDAzd4W05izZ9
	etDBLgtbot++yG0GcdIE7SiwXsMhnVFJjRP+Xn9UP38LUNRFkETG6dSuYMon92/91ilsxjlVVpT
	QyD/0g2KyRRlJCoxP8IEDK2KWdQ/E+WGM+5ybLXKTSGKLpmGLsWg2DxXb+ishRW4APqfQHLS2qb
	SCrehJo+U/PJoUS0QD6yAKnj/nWhv/IfE68w4pvdkQdGQ0obgzR1Q/xpj2w8lY1PL83GoHuLWHx
	cVNTXfYvJMHVOGQT1IpkRy0kb27JxjdW7akcjtqIcwG+5gRKJL5upX9q+RXAU6rls
X-Received: by 2002:a05:7022:396:b0:11b:d211:3a64 with SMTP id a92af1059eb24-125c0f1e671mr1354692c88.0.1769786136386;
        Fri, 30 Jan 2026 07:15:36 -0800 (PST)
X-Received: by 2002:a05:7022:396:b0:11b:d211:3a64 with SMTP id a92af1059eb24-125c0f1e671mr1354659c88.0.1769786135739;
        Fri, 30 Jan 2026 07:15:35 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f95asm10252849c88.7.2026.01.30.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:15:35 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/8] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Message-Id: <176978613488.3951544.16310124318895182345.b4-ty@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 07:15:34 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: ZhuqnxkUU5mdktvs4wqYDzGjfLfDzk-g
X-Proofpoint-GUID: ZhuqnxkUU5mdktvs4wqYDzGjfLfDzk-g
X-Authority-Analysis: v=2.4 cv=VMTQXtPX c=1 sm=1 tr=0 ts=697ccb19 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9BDlGpjYJg453-lo7M4A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNSBTYWx0ZWRfX3LZtsytmaLD/
 ukcMTKOoE2/jkMGNfRndzr4AlyoeqVlG2Y1Dkkx7JHkwwd+blO0HNWgW+543wr5n5m3ceWd9LJL
 CPc5aa6nrQGB5c6sO2/TvSSmDE58NKyaoRdz1vRL+bJRhNoXtDlFd1Oy6Di3FrUsOBGoytgPtch
 uVsGUCD26rmCTQvrOQ787E977/9+DebAS0OazsaTr11JCaBMR2eOpsXqNRQDsmnS4XU14mk+ziM
 AnzHTV4AV5kPABQ/94ldqQeavRHJ2VNQTUo6ghtmk7gwyX9Cp7wrkNghbNTfTxPsLRrBcwkqPJJ
 l8b0XOa8L1NWjTftgHYQMYxwJhVFwH1Gm04USfLdJiRyY+gNm2e6AZXTM9Q0N5jZS9w22y1ESV1
 pD5RE0E7jH0p+6JjMxUUkaZlDiIRFh05+T4Fw8/A73P6g249eC/5Ko+atXi0655yIBorcVlPzGo
 eKJJQpVIqnLKLx+QVXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41786-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,holtmann.org,quicinc.com,chromium.org,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EF745BBEAB
X-Rspamd-Action: no action


On Mon, 19 Jan 2026 19:07:57 +0200, Dmitry Baryshkov wrote:
> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> voltages over internal rails. Implement support for using powersequencer
> for this family of ATH10k devices in addition to using regulators.
> 
> 

Applied, thanks!

[3/8] wifi: ath10k: snoc: support powering on the device via pwrseq
      commit: afcf3ec615c918dd71139e7ca2f4812ceea48cd7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


