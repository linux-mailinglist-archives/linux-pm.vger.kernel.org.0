Return-Path: <linux-pm+bounces-42304-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO8OIZc5iWmW4gQAu9opvQ
	(envelope-from <linux-pm+bounces-42304-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 02:34:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ECF10ADFE
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 02:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2BA330254F4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 01:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3411C2C0F8E;
	Mon,  9 Feb 2026 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sv39CkZH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NQNW7EfO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE12BDC3D
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770600762; cv=none; b=ax7OXGdWcuPfvQvgODIU33so+VkYZ/QB6V1wKAjqkFtIeM2l+ch2Km24f2rzkfX1carsFEm9QpqMUc7BDKsK6+V7cdQo1AgYxJd8P1EcySi2SqOlBvPtIYE51JZqC4eHAUJmsNGdOz0kTOCmRKl1G3zVCCUxoyZuKqbSrvmXHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770600762; c=relaxed/simple;
	bh=mp7znh5yUTXGIVAo3yop0t0MQrXUpW7C9vuYHOlkZ+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WjwSphJyLaPAFMNCF0jo9fio7KcKa5N317UqPqRaeGt6nuJxMxcoiMKd6EuoxD1D+Dd3+F6CKiy1RiAttuIpWML1Q84/5wFbacSP3L0a2Ae31jUBAnwJ9TsDUp+JLZA2fGEGJDHJ14J+nY+89rRx29gddjgTeVJcEh3JuDlM7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sv39CkZH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NQNW7EfO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618NVOKH1989011
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 01:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OLZC7NStGj9UHK+dN1GsxWqO1A6r1SVJAMjsxlitvPk=; b=Sv39CkZH3lvXKsSk
	OUj4hlTSGaMxV5UN92ZbLeadowgI/gkGaPvtBUnJMdb0OrTW6C226j4jXosbjCYy
	IxWdAyl4CeQx+l8HPxxeVU4tzvVFd6rWWJxX45ii4saJ8LxqBjC0y9fHnRHcRwQ2
	JIolkha8+OBohduHoa6v1UZjZcU+xxlawekWErX9vmAHPd+zITcYm22ymmyBgV72
	+i6di8IeYA1GFC/ndbE38I81l9dqjL0RSZRkConurzFXpJgRFV4HjDcjdKVGBW0J
	SC2P0JFUdNZd+i1SWbqSwn1nGTlX9ou46wU63Qns1aUNBUApuv6Dy8awTLcbXZGi
	vjwl2A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xamu8uw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 01:32:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70d16d5a9so643596785a.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 17:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770600760; x=1771205560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLZC7NStGj9UHK+dN1GsxWqO1A6r1SVJAMjsxlitvPk=;
        b=NQNW7EfO6fW6n2DENZZ0cL5Dq6ZtEBB++R19pVKqNghAvpdNSNsTNsqAzS23xNkD8t
         1JGNv/6Yp/a2b6CktyryD+9yZlaLcWNMXblPngk/A8eEs6x9EO3FUrLd4OHwXgJ6uoTu
         uGwy+OEBnu1zE8hP9ob59af4R/fZzdJCLkS4SJK8HPBK7waSqeFjROs9eIhMuRcZZPki
         Epzmr9auVmCcvHzAGMDE61GJa4PrQA6fCR7e5KM1xYN7zVXp4NMIOhxtn/Uut2+nkfdl
         YtrNh5/HYTx8Wnsk8vVhM28nRHVGG5vIYjfmskSqIHgod+ARJ3fA3H+/3tOe7uvsUAt4
         K5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770600760; x=1771205560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OLZC7NStGj9UHK+dN1GsxWqO1A6r1SVJAMjsxlitvPk=;
        b=bP+DEa2CkFkJpClO+seq270NHBdAEsOOSx2mzUbV2+y5v8HNJagDZYvtcEYUJKP1Ii
         Qzpw1bYaLEuWTaAvqNPPtzDoGEAUuTRq0b1u+Kspf0tiXmHAHadbT3b8TaPHtd68D3xj
         gKGsZB/6ioxhA/wgqTKzOI7ng1U5QXPNEBOAM8qc5DQ/50NmpuzoJOk5O5P77SSdyhSM
         QKaIolxsTgKuRUTM+OEoWFu/U05g/ofbcftxPCZxr6fqyxUiP/T1OQyOBVatpdOpzcBP
         TZhDkFxz2UxsgBq9xcy0+QR1vVmFpgfPi6o0dAbtBiEDCtiO2Rbi8ZqE5mg3zBGeNYxh
         9hKA==
X-Forwarded-Encrypted: i=1; AJvYcCU+NLt1DAqPygVo2pLa5KZQwQlNyin2Qnhl6fMJGoSIo1EKxR0b80LXRSMW1owqFzUz0/ManneGPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbi48DHfCDB1eQ8Z2HygGHVx9Zae8CkwY8Zr+F/J005Vkzphp
	tSjw4CFuBBXF1f1E5AQavRQzBpy6UeyKM9yn1awq7e93gYp+EkxJuflM1JwfoFOnG9YreTU+RXs
	ucA8kgl54QVPN32EvkK59Rh/tqae2VTgChQy9WsuPIEQj/C6jl7Ht5dF/X0HDMA==
X-Gm-Gg: AZuq6aJxfJA6Vbv8JLHywBPdT9Er2ljIvrJ+WQjLz6avY9hbbexfu/XTvbT62QKp/9w
	bi4IONzYiieqja0WLqAyVXunVQkpTrJFsq7Uc62kVGgPKuF2FA+c+FRo2AqJmAomzG0LmnaTFx1
	V/pWaTvKcfMrhI3zVwiSr40gk976rX4v/R+aMSf1AJX+sm94U4DCBLRcbu5tkIG6GfJ13f7/NlE
	7gNyUKTSD5iCiQUM9OpdR6Teu3S+CJ1zmyrzXAV/gMVtTzWVuGUZMtwGSHHJDgXJvel0ZOK3FaS
	psMmtpo+OFNEvyiWdkcoFq+OEvg9/RjR5eXbCdOeS1CHUB5UyQ6b5V1K2l0U4TmpIGEbRfaVlv8
	P0aclgr75gOxFpLS3MU0sfeAogyVf7r+FYRjAWRAxtz9GH4lNrSIHtiZUwWRvRu4P4D2/Q/3cc7
	V5xI2T165K9w5pJDMLoDJKQ7g=
X-Received: by 2002:a05:620a:d84:b0:8c9:737e:384f with SMTP id af79cd13be357-8caf16ec50bmr1247852585a.76.1770600760123;
        Sun, 08 Feb 2026 17:32:40 -0800 (PST)
X-Received: by 2002:a05:620a:d84:b0:8c9:737e:384f with SMTP id af79cd13be357-8caf16ec50bmr1247849685a.76.1770600759693;
        Sun, 08 Feb 2026 17:32:39 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b623668asm21688601fa.3.2026.02.08.17.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 17:32:37 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 03:32:19 +0200
Subject: [PATCH v5 4/5] arm64: dts: qcom: sm8250: sort out Iris power
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-iris-venus-fix-sm8250-v5-4-0a22365d3585@oss.qualcomm.com>
References: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
In-Reply-To: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
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
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2348;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mp7znh5yUTXGIVAo3yop0t0MQrXUpW7C9vuYHOlkZ+4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpiTkmrrMdMhMEbVQIM2UwZj92DyXcxp10jHwj6
 jLWEQRZZzKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYk5JgAKCRCLPIo+Aiko
 1RiAB/4qIi1i7I+vVAzoVhTQFOz0gVhc0D+EnKHisbvFDn3vTLE93OCIyy1sT+R3jpJT/I5FGyR
 aILzOSwDk7bmNV9iqh8Q046Yi1z5FwxGcE1PYC6ZclVsqzUkMjoP/PS5V/ZGPmA0M5e/To11NQ0
 iGrVdZ1Dx9B8vl0jVOL2MuGtNsblUbXKpwhpbDAx5b0Ia0jdOOUPWhJngOTxnsKEeRX+6XcBgXX
 fuHvmZ5ayuvKHqlSj/jC4SS7YYdPZMKzYqlSOmv5BXrK8rhzvFb/XKgKByn+55bRZOiKCYAXp6a
 Ucvx5TukvxnlZ0OimOI+itVCJgQ85l2t35XIHTDESkmypKLZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: gNWYfC5piqKJ8TzrGJM_g0jZVfSwNV97
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAxMSBTYWx0ZWRfX/F7uup9BQA78
 g7h9W3OGSm/rqE08qK1zDbAznF8bpm/EPSw8cK2+kdqWv5XsUXt4ejpFhyB4PYv9MAHnGbGU5uD
 n1qXdBfGtz8Zgc2CmdT/E9dj7tjckR9M/QJPVI8NAydkhKyujiWCu6KUySoi7LZ+pTLIhWeHGYI
 YE0Y97WFCanVaPTHkczcXJzqmR2Oo1tNaehZ/dW5wy+A8Lx9nvUKRIPYWLrYpeEItWZQfKWPDjC
 eHT51S2VLzBZhTL+V241HMEe8j2t/tG9KChCY3m1k2qXZdDj5y08ulf+N9cuICyeeQs8cJ4yknm
 YMsR5SCGZ+fzldeGhorXKc22kxhXCsnwhfVZUA+/eqEwMI+S1wNQ3HXLkXnbdohQZKewHU4O+kj
 MLOBu50iGmh6xSOWpZO7EtVyUqWDABqC0CY5eUgDvULg+nlISPlfg+sEQSiRtXH6J8oFEumg3az
 Fm1sGlh+P+QTeQ3SI+w==
X-Proofpoint-ORIG-GUID: gNWYfC5piqKJ8TzrGJM_g0jZVfSwNV97
X-Authority-Analysis: v=2.4 cv=Or1CCi/t c=1 sm=1 tr=0 ts=69893938 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=tBOqMctlXquWO7Kigf0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42304-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,aa00000:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 14ECF10ADFE
X-Rspamd-Action: no action

On SM8250 Iris core requires two power rails to function, MX (for PLLs)
and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
qcom: sm8250: Add venus DT node") added only MX power rail, but,
strangely enough, using MMCX voltage levels.

Add MMCX domain together with the (more correct) MX OPP levels.

Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c7dffa440074..a1ab8c3c27e6 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4321,8 +4321,12 @@ venus: video-codec@aa00000 {
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&videocc MVS0C_GDSC>,
 					<&videocc MVS0_GDSC>,
-					<&rpmhpd RPMHPD_MX>;
-			power-domain-names = "venus", "vcodec0", "mx";
+					<&rpmhpd RPMHPD_MX>,
+					<&rpmhpd RPMHPD_MMCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mx",
+					     "mmcx";
 			operating-points-v2 = <&venus_opp_table>;
 
 			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
@@ -4348,22 +4352,26 @@ venus_opp_table: opp-table {
 
 				opp-720000000 {
 					opp-hz = /bits/ 64 <720000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_low_svs>;
 				};
 
 				opp-1014000000 {
 					opp-hz = /bits/ 64 <1014000000>;
-					required-opps = <&rpmhpd_opp_svs>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
 				};
 
 				opp-1098000000 {
 					opp-hz = /bits/ 64 <1098000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
 				};
 
 				opp-1332000000 {
 					opp-hz = /bits/ 64 <1332000000>;
-					required-opps = <&rpmhpd_opp_nom>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_nom>;
 				};
 			};
 		};

-- 
2.47.3


