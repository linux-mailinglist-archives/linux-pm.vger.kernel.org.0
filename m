Return-Path: <linux-pm+bounces-11026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC9192F539
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 07:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2900BB22C74
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 05:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93F182B3;
	Fri, 12 Jul 2024 05:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kSnVwY+K";
	dkim=permerror (0-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGtjMtJ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3463199C2;
	Fri, 12 Jul 2024 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763559; cv=fail; b=TiK2b2YIdpA+XZgUkGjhYUuXJ12IIPfPCQyJKdeklUfa3Wcz8FfJj+BAdS08K8gKmKUSWg1SoZSz14mTUacMWQXYcJeGvvdjPrBrY53LhtLYbjO8T3bLwJhWuo9nBcGPL31elBpFzSFWQyzCB5AqEU5sngxxxgplmgzX45sm5kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763559; c=relaxed/simple;
	bh=0iEPTTWla88kMglHsl85QPPoJWk213fMRPzOwvdyj/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version:MIME-Version:References:In-Reply-To; b=rDncInNi/N7zrHz8JPXqRyamvMp98/hDb1OMvsLoLYBlZzJ/ZJSQwp2OoehKw5BN5yXU/DZW+fKHjxBR6Y9Icgk59rl2lbljlRmfPhtP+AnXcY0UFmqqiY8Xf3uEgltYuO70J4ovFLZfihMT/AaPmisCAdXoGpdaq/6bMNvwMZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kSnVwY+K; dkim=permerror (0-bit key) header.d=linaro.org header.i=@linaro.org header.b=QGtjMtJ0; arc=none smtp.client-ip=209.85.167.43; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C3cg8M007466;
	Fri, 12 Jul 2024 05:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:in-reply-to:list-id:list-subscribe:list-unsubscribe:message-id
	:mime-version:mime-version:references:references:subject:to; s=
	qcppdkim1; bh=12qbkY/kqMkIWMA+16X340XQ7RDSqUUvWKfrrPqViPw=; b=kS
	nVwY+KmpCJZgpf240JQqybvKjWYE3K3rp5RMfSN0WFncUaFpqGJyZyNmLCs/0Gkf
	9VNyQDHz0WDh143Y4XVwn/TzkktYyFAse7aBWfhOiDvWHQX9pzVA6UgRqu51ORaQ
	NEsefdLLR+CAOgMxHYFAhYEVIYefuLqzEIeGqzbowrBt/yFV6bGwYc3YqjowTKeE
	8u2LAwyr7Asas8j6ZlEROioiZ/jF03SqCtwbrGHJraZVMYeQ2qXrgfzlSseT7FK0
	2Bn1OuB8yLoOlE7Q7xBZbKiOd2p+yhVMUk+ntDodgqee+VXCC8gc/CBTlQliGKxt
	GbmnBVriThGKiGGVOGKA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4091jdrf9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 05:51:54 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C5nAmR020510;
	Fri, 12 Jul 2024 05:51:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 407g4fvb1c-1;
	Fri, 12 Jul 2024 05:51:49 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46C5n5AY020459;
	Fri, 12 Jul 2024 05:51:49 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 46C5pnEt022498;
	Fri, 12 Jul 2024 05:51:49 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 2643A1287; Fri, 12 Jul 2024 11:21:48 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Andy Gross <agross@kernel.org>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH v2 01/20] media: venus: pm_helpers: Only set rate of the core clock in core_clks_enable
Date: Fri, 12 Jul 2024 11:18:32 +0530
Message-Id: <20230911-topic-mars-v2-1-3dac84b88c4b@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
References: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551846
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43]) (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32217C8B for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116; t=1707512993; cv=none; b=FMp/04d3SaNqKnleql1Xx2nTSGRZ1U34j4xvgZo3NcwJ2lnlVFwrN/Jnlpa0H8+yXejUF0BFIrKP3oE5OgyMU2fVcfcTWrcEQdyP8KFpcUR/jZADPFt33CLjdbJGsu7NJcLbSjZMr12CLHKeIap5Uazk4FcqCY1odzWdkQ3FKwk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116; t=1707512993; c=relaxed/simple; bh=lb27xhI4gdBF4UHcwKFr8ScxLgxp1+CafppHA2L6fhU=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References: In-Reply-To:To:Cc; b=q4MSu2JaNaMOFDlAPx3HKsGE5BewrVAVMuSBI2GOBdfdSBWVQ+jQKGurILfr/AyV5G9jPyKK6PnBZ+NMqvuX3jJm05KnQUssE/XmhDs8oRD+L7qakTpfdsxyqx2HZG8RFMAmQCCrmRRpHat+g4f84b+AmIKNH1V2gPf5wLUgAIs=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QGtjMtJ0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5116bf4dcf4so1706037e87.0 for <linux-media@vger.kernel.org>; Fri, 09 Feb 2024 13:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google; t=1707512989; x=1708117789; darn=vger.kernel.org; h=cc:to:in-reply-to:references:message-id:content-transfer-encoding :mime-version:subject:date:from:from:to:cc:subject:date:message-id :reply-to; bh=YqgwRixA6ApDI8sPrNg91MKVrvVSPJRcKUUS08MgCmY=; b=QGtjMtJ0N3qkuPeXYlY1zXVgAtpVw/3TTvcuYClM0TT44kKkWufABtzkJR+pHgcyIp HTatj9O+aHcJfUIU2QgbNbFOwO4JSTAazNmV5Zs7v0CP/EyFPBjpC3sj3qSjJ4tv5616 kZ0NBKhNkgImDZTsbz9wE6TLpc/Mp6rlbazFgyaEFuHkqzP2W/SWEMvDZqobfTqIV3vK yZzGl3s8Ls1rAp8w8wvxieEb4I4USp1rmGbvLDSrQpNbf0kcbCPtdyXSlGeZGt75FkDc UkOugIAZolzL3YmR7TBZUz05ZylThbageeBG5MiMpUm6t8t2ydgNOIjZSvlmuWK4t5RZ 4EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20230601; t=1707512989; x=1708117789; h=cc:to:in-reply-to:references:message-id:content-transfer-encoding :mime-version:subject:date:from:x-gm-message-state:from:to:cc :subject:date:message-id:reply-to; bh=YqgwRixA6ApDI8sPrNg91MKVrvVSPJRcKUUS08MgCmY=; b=kucetlRfoTTpuNZu6DoPjYpmicwYLNiwpnECQshtuF2F9zuVgE98KkazZaAXrmrUDD tb+JleHqRm8N1PJiLJMge3guIZ1SinWk7qhxauOkhUmnJl9whKvCaWnZClNEic4gEUSt lnGdDk8YZUgahvGxjcicxy3yUEZ7iq9b2TRf7/iRYJcRXO03159sfAEipVbll9LLne+J 7wQ4yjrl5enL4RznzZrj+tyiFOQDwBKopBf05cKxJ3yDCv9+6D1+hwkSS3P7m2o6z3e5 RjtArCUbG/QUwiloBthFwPlBG3CZ5rSZQMP2cqy/oSQcehX9A7h+/GFJtP5eisb09svp 9t7g==
X-Gm-Message-State: AOJu0YzOCMrjg4Ym3OGOomPlgXqmF/3G9mUz3ybft20Yoi4z4sywQBy6 GaKlaK3svocp27ruXq59JquzJ681jnMXUlfkS1eIAol5i2HcvFWQvxH3bZzrMPQ=
X-Google-Smtp-Source: AGHT+IFIqd7UT5C7l2jMBJF05GfGoDqK+2W7pPUhWPkwx1CTkOTNg8Cw2D6fa2Sge1IUZ96uK0/t/Q==
X-Received: by 2002:a05:6512:1251:b0:510:c55:a3f5 with SMTP id fb17-20020a056512125100b005100c55a3f5mr168236lfb.23.1707512989482; Fri, 09 Feb 2024 13:09:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJl+AqbHTvF3WV8vFVVntucZdXXlMJ4ZHb58tZF7FmHOj+rbFcNR6L01/SUIw8W0HtYlS7C8YqV1sr1qGzI+g86in6mo68AsjTEScsXBPRvnEJsUOaYfXNYSwT/H9mUR3PUDBezQumpTWbyiBd2ZUGLXzLQ8sIgv793E27kK5dhP+vNkKXtCasPgGZDfEbTWz7UIrQTFQmv3Y94TvNQtRB270pT0L/z66uersi1ac175Q3orb5WYdurbV57NQVyopgi5EtzSmtezdsKhHeJUfFUX4vI8cYjYOdJF4B5MR2WZy1ntAV/sLt68kCfnG8UAj5dsXmZ2vc+aapy/HOP2tg/lnTvkncMuKRCQsz29mVl9Up434qQO3jFC2prJi7T6gN2GVKuqlHGTBWv6ibfEKLnoqT7VshfFBWKAj0b6xA0x9IKv0IFm1QCdkaZKlM/4I1thxBZsgqgFRK5m8ir9tXIUFobZcMAvHWaaqSnoh9Nlqr0ow9i4EdT+KkUk0LSwNVjQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233]) by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.47 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Fri, 09 Feb 2024 13:09:49 -0800 (PST)
Precedence: bulk
MIME-Version: 1.0
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=1871; i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id; bh=lb27xhI4gdBF4UHcwKFr8ScxLgxp1+CafppHA2L6fhU=; b=+y8UnWj7pBxnLDQzTuFCX0qHqfFWaIW8ltcFXMCcilkClq26ATIQQ8zPa741OTNWGh2ip2q7E FIadbLDch+AANPvAZz2qy+xxWDyEljuOMqEfsjrjCuhKguAPfK83x5U
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519; pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Content-Transfer-Encoding: 7bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jwSuxVM3B3oLWyCjwROLw9A5ROO9Y5f_
X-Proofpoint-ORIG-GUID: jwSuxVM3B3oLWyCjwROLw9A5ROO9Y5f_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_03,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407120038

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Commit c22b1a29497c ("media: venus: core,pm: Vote for min clk freq
during venus boot") intended to up the rate of the Venus core clock
from the XO minimum to something more reasonable, based on the per-
SoC frequency table.

Unfortunately, it ended up calling set_rate with that same argument
on all clocks in res->clks. Fix that using the OPP API.

Fixes: c22b1a29497c ("media: venus: core,pm: Vote for min clk freq during venus boot")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 502822059498..8bd0ce4ce69d 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -41,24 +41,23 @@ static int core_clks_get(struct venus_core *core)
 static int core_clks_enable(struct venus_core *core)
 {
 	const struct venus_resources *res = core->res;
-	const struct freq_tbl *freq_tbl = core->res->freq_tbl;
-	unsigned int freq_tbl_size = core->res->freq_tbl_size;
-	unsigned long freq;
+	struct dev_pm_opp *opp;
+	unsigned long freq = 0;
 	unsigned int i;
 	int ret;
 
-	if (!freq_tbl)
-		return -EINVAL;
+	if (core->has_opp_table) {
+		opp = dev_pm_opp_find_freq_ceil(core->dev, &freq);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+		dev_pm_opp_put(opp);
 
-	freq = freq_tbl[freq_tbl_size - 1].freq;
+		ret = dev_pm_opp_set_rate(core->dev, freq);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0; i < res->clks_num; i++) {
-		if (IS_V6(core)) {
-			ret = clk_set_rate(core->clks[i], freq);
-			if (ret)
-				goto err;
-		}
-
 		ret = clk_prepare_enable(core->clks[i]);
 		if (ret)
 			goto err;

From patchwork Fri Feb  9 21:09:46 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551847
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64839847
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.218.45
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512994; cv=none;
 b=nWUaPrudnmxyaYZQ1XJONDRkpf17w1LGH1XRhbIgjZ5H5ONODbyEd7NbGH2IFNhsVaM6afAQWvRvVr82TkkCZdoQ4RKUzeYr78Z3g0F5aaFGae5V0s5Gq9x9Rx/LRF71m2evi8+oZUgnCuVr3GFU2c4g7ICfJNIGn9Ei+hic4Ik=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512994; c=relaxed/simple;
	bh=4x/me5yeOEh7Kc0NCGCe3k/ewNhk7l+PTAXEKLbJtdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=B6j5V/fCKsq0tcEHFt497r+L7F5Uc5I793Be5HNRPTv14H6p6Y1AV6RC7vQF7r1YqAJcmrqtI354s3grpq4ndEHf4fkiTDdErbNUEEINnDCQYk4xl7KWYRPAKWVeYJsGGZDG0FVvKOAgCgsbC6CrcJ3txbtK3TBUhM2N3+SWPN4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=UhiZz07Q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="UhiZz07Q"
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a3c0d92ca8aso69096266b.3
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512991; x=1708117791;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clU3y8fBgJIxt4Cy2lqLbmum74KaZZM8VM+LPgiv+vQ=;
        b=UhiZz07Ql0p+y24zxQIMqRo1zLmhdji2ys76dPIywqHDgpw6lJqmS+a+FUs6wCWD1v
         lYT2jUE299B+5kq22myFDjdTRl4qOA5NuAu25q/g2XuHdL96MK8srvfoSxNzG6wET8cY
         rBbIpUn/H5jgnt5SJBzaRkLPQrP8XXh7BqBcQM7Peu8s1uNqfAvZmpA/0HajUYkqUNtn
         sWMyfQtcw5PHASYWWPBzfFpP3sQgWIX32b+ZO697KZksWWG3iSvCW0nQNi/fXCw8caav
         NWuj9l4thVUhh+jypKsQ/Bo0FPipzp+Nma14mbsUOki2HkHJ31lw2SYx4B5eNo6h8x2S
         6dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512991; x=1708117791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clU3y8fBgJIxt4Cy2lqLbmum74KaZZM8VM+LPgiv+vQ=;
        b=RluKxOaw5aEJE9HKy9vx9Oompi52AzYY0ET6b7xuz3XfEHrSycD2EUBIin4p59Fiud
         Gd2yeaSPP3zBj/Sl4AKGhce4gYb18JdEfeAupCbT++o+zP0QphyPoq/Q2l5p90q++uH5
         ggVKJXu5JOEWVGKvHyyx0oP9AGCIlUOdgqwt+47nnz4IbxAeo/LI4rdlKJaBbvjXMyBi
         eSJp8i/uSsCuR/7/cY6ojTG+1iCLrbG6tcrkzIkC1B8jMeKKcOvofTkzBh3gxD262Xl/
         knxAS8ZbbBH2R1TSmLmT3Fa6oGj0tZSwXithnmsk/xZEJq1hF0ft85HNCs0zHeyjFMI4
         IHqQ==
X-Gm-Message-State: AOJu0YyP1kQ3Ww6o9hhjno/SYlSAqU1z5JjSst60Y0Gl9k+oZsg2mFHx
	p8L8jsN5mDFCZps78LtSI1sVxmtJJsLrhH1vXvk8KbuGfDKvgv2SZix70i4mAgY=
X-Google-Smtp-Source: 
 AGHT+IGdCSLjmTu54nZwy4pt/JpV9RwCayC/JuDbyxwWbkLW1VMMBQxw2ieEvUAsBp3Fe5UvW2bBmQ==
X-Received: by 2002:a17:906:5f86:b0:a36:f314:d8be with SMTP id
 a6-20020a1709065f8600b00a36f314d8bemr177645eju.38.1707512991022;
        Fri, 09 Feb 2024 13:09:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVfK1hN2/I2FkTD/QlN2R7RH8j8SoCMNxmB8yrXSniS2G+ww3u2pToMXvVJDjVf8MGI4vTsLSNenCDCP2h5/olEpuVssyMgf9/94iNVi1gO2pCiGDasz1AqSOexpvElGbRI1VbLzQVllPrtiwK9ghp4U+pKOez78H/avBzE5sx7wnQrDMCdwrtKQzG9Ps6cC4BnvtK9Qo9Y277DDvobKnf5HF0xypDNnH/AbFD1y2WbhfahxppvC8csVkmN0gb6WnlQi2bbPh6zHQJ0Hp0QknUaNRVWShWfWfkdvXkLRsCQfPXtJ4gBJKu7MGFRiXPPhh22U3dm7wmKuvITllIZaqtEdlQfkm7RQkpcxAmxZcqt0E/l+rDPHiSnMd3iYtsKkPg8ooFKs7vl4gVeaHUgNgETXitZq+HtrEQz5xGrxfT7zotIr0BcwzAQJbM00ffSCQWfOdtbqhN68yfbjI1XTT05TDcVsraIgCRos7sEg+DUYM8tqf36EC1x6x9CqlwtBBrPqg==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:50 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:46 +0100
Subject: [PATCH v2 02/20] media: venus: pm_helpers: Rename core_clks_get to
 venus_clks_get
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-2-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=1211;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4x/me5yeOEh7Kc0NCGCe3k/ewNhk7l+PTAXEKLbJtdg=;
 b=AQAHlC80oGjh6PEJ42jPoSKbuJtBPAtDuFcaMaRA3r7rCnNIsr34E63ziRxXFsC+tD0h8A3HF
 KPIe1HYtMWkB4CySePVKqc5bctFpRgss76IcLM6BGkBSxFp9DgmD6vb
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

"core" is used in multiple contexts when talking about Venus, rename
the function to save on confusion.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 8bd0ce4ce69d..ac7c83404c6e 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -23,7 +23,7 @@
 
 static bool legacy_binding;
 
-static int core_clks_get(struct venus_core *core)
+static int venus_clks_get(struct venus_core *core)
 {
 	const struct venus_resources *res = core->res;
 	struct device *dev = core->dev;
@@ -294,7 +294,7 @@ static int core_get_v1(struct venus_core *core)
 {
 	int ret;
 
-	ret = core_clks_get(core);
+	ret = venus_clks_get(core);
 	if (ret)
 		return ret;
 
@@ -961,7 +961,7 @@ static int core_get_v4(struct venus_core *core)
 	const struct venus_resources *res = core->res;
 	int ret;
 
-	ret = core_clks_get(core);
+	ret = venus_clks_get(core);
 	if (ret)
 		return ret;
 

From patchwork Fri Feb  9 21:09:47 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551848
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAC139ACB
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.218.49
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512996; cv=none;
 b=dZydTLzn9arQaJA1hkOzv62x7mMY2cIDetzfgbei94WOgKhDj4CaEjZ81GwOnyerasZIl1m+TRrSQZHJOVnnkVHBwN1480HedGw27znczi2Rhlc0S/6QemFQbNjgF92gwdACkf/N4DtxFO6Vn6SbEQ7Njv7p0UNPRWdM2W4YquY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512996; c=relaxed/simple;
	bh=qRFNx2a0sPyBufJHjBf1XzrjeKK7bQ1fasBPqhqnRAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=ZhaS7CHmch+oIYugrTf4t/GPfNlJb+OU1nmDoo42PodQzIp5n7qgiDvi7JB/+gS4W3d4Voj3CLLP9pazxNDI9iiML/PSkkE4zCa+LB9KupaTq6jioZSg0kVcjpUUGaNCAwLiBUsHTLSsrApCYq2wPJ7kgxGf9L/fQYN7gXqZhgo=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=Ei+0GVQw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Ei+0GVQw"
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-a3566c0309fso162900166b.1
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512992; x=1708117792;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P4+a9/cIAslmQuzQjL8EtOxDSeXqHOG2MyxLu4mmL8=;
        b=Ei+0GVQwmIii0J3Qk8pJRGPYG2qfgMy89wRlSYTxhLkhLl49HFl7eZpuMZ0yaRCogV
         wBKUcBBfLjnAcn5w0AOz1zewn5RSw6z5NMnolQuflrqduig80bAAgIdYxSAovEhyYaGg
         q/OyKywLSn7rSg0gT53fG7F4vgTYkVvS96GX2CwVroq0W7vHCsxVzYLDwPXRQiQvHhfK
         G9Hy3y+2i5Ni0KdYmVcbW4IXIJOJTK56pJXpftJ0JFQ7T8qFDBAIx3jugl9MOAwEYYO/
         fEAx7rsVtYAwkPLcNIhQ6Ki3pyLImRriRxagXwBEtJyz9hcQ0dLcDJjYO+gJ5NMwND+z
         brqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512992; x=1708117792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3P4+a9/cIAslmQuzQjL8EtOxDSeXqHOG2MyxLu4mmL8=;
        b=UuWgLVeNOFgsOdYNKN2Vf26wOBPZHlHgDY1likylYTwb6km83YUlL4qdZmhywGDucy
         olDZpXh77wHjRT7tvqDdIYbEcag4+BjGqP6mZ5O9LImhx2LbiPaUaEbtt4nIPqaZapnN
         NA/oEpfpDYGWAt/IJnGWtlkkPkEJS1RIa49zjOskgvm717IJ3t1vQaeItjVSg17KMXlX
         pASsSzMubNLzaRd2UzouaYcqLLIDAS0rZ3kyauJft7FQ+8YGcdwXDa4QHd+K/Xnn1Jn/
         XQ/fuzGPJs8ytvay9jURRZSn2X/SWAVhsROsmblzhtxlqv6wz9Rbg53pPRuUi3HZY7D3
         jdPA==
X-Gm-Message-State: AOJu0YyoRiFOgfHBsVJdsgdUduRdpSx5s1VJtl8NCvS3xL6PMr2Zc3yD
	RPaUFYwA74Fo/PM6lhYOekZMM/7NVUPWJLNfdpeEXfnsjDuswbEQQ7bOok/AyqI=
X-Google-Smtp-Source: 
 AGHT+IFa0HMwlocBhyQVWEI4wW6URTgMPB8gNjtBmIuHK10dYYUj5mZIjH1dXsaiZkP9IrotHDsD7A==
X-Received: by 2002:a17:906:395a:b0:a37:bbe7:6002 with SMTP id
 g26-20020a170906395a00b00a37bbe76002mr155272eje.19.1707512992623;
        Fri, 09 Feb 2024 13:09:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUN/6DcLKLHb6GpaRqOLsbKnEuKbZHWazCmSiIi/eBFKEIPXF8GGxewPt3LMu1/QmPuqGL1TiJn3S2+2Pnwv7+2+GAtdhKke2ScKRCZbkP7p4idBo/NO4Gb8tp3qxNOUfJPqq80cSgdwuOPYRRcyOHUz2/F1UTVD8yl7mwo5W1COK3w+X6jkjIUnMYSrDtD8sHj3jq+0cuJhWUPfIuM+dxs1TRpP1uKEajqm8hnuzR9x6Gd9iWUZwX+DwnBO6Fd0CQ0cFfY8e5jCM7+jjG7bJGtFq/4h02aYKmsq8giDJK7C4RVOEkIOi0Wxc6HTMv5300m3hs5jLM+LSgXxsiiQcHCQkjOUSMTmr/cQPDtW7Xl1p88eif6jhjQSpbLIp+sDeFFYw7X9j7BMn9O+y24AKmQqbPx3xhASLrICP8/lh324hdJkoQP+t7DF256Qr1iJkQIWKCtYRaC8kIIkncAZh7d6Q2rzUEMtpVRd1ayA6/Ccf2blDlOvgEZIblLSuEdjp5vkA==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:52 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:47 +0100
Subject: [PATCH v2 03/20] media: venus: pm_helpers: Add kerneldoc to
 venus_clks_get()
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-3-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=2105;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qRFNx2a0sPyBufJHjBf1XzrjeKK7bQ1fasBPqhqnRAw=;
 b=8+L3XOpMWqZuFrz8AFmFy2qsmwKomGg/5nzZOYPH7CzOEOf+OTS6f8impKgr957vacUNlHiBq
 GN/FOhcaKgbAwFpT4jldS6XE7LvitjMa99xbc6Y0qCHGV6DWv5GxIHq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

To make it easier to understand the various clock requirements within
this driver, add kerneldoc to venus_clk_get() explaining the fluff.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index ac7c83404c6e..ea0a7d4601e2 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -23,6 +23,34 @@
 
 static bool legacy_binding;
 
+/**
+ * venus_clks_get() - Get Venus clocks that are not bound to a vcodec
+ * @core: A pointer to the venus core resource
+ *
+ * The Venus block (depending on the generation) can be split into a couple
+ * of clock domains: one for "main logic" and one for each video core (0-2pcs).
+ *
+ * MSM8916 (and possibly other HFIv1 users) only feature the "main logic"
+ * domain, so this function is the only kind if clk_get necessary there.
+ *
+ * MSM8996 (and other HFIv3 users) feature two video cores, with core0 being
+ * statically proclaimed a decoder and core1 an encoder, with both having
+ * their own clock domains.
+ *
+ * SDM845 features two video cores, each one of which may or may not be
+ * subdivided into 2 enc/dec threads.
+ *
+ * Other SoCs either feature a single video core (with its own clock domain)
+ * or 1 video core and 1 CVP (Computer Vision Processor) core. In both cases
+ * we treat it the same (CVP only happens to live near-by Venus on the SoC).
+ *
+ * Due to unfortunate developments in the past, we have to support bindings
+ * (MSM8996, SDM660, SDM845) that require specifying the clocks and
+ * power-domains associated with a video core domain in a bogus subnode,
+ * which means that additional fluff is necessary..
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
 static int venus_clks_get(struct venus_core *core)
 {
 	const struct venus_resources *res = core->res;

From patchwork Fri Feb  9 21:09:48 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551849
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A139FE1
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.208.50
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512998; cv=none;
 b=hVMIdSH5UFdJyz9Gyx3DrAhENQhmKLamyi0zq2NJ6TrO/8ys+TaCHshbxJkEp69iLx/UzBi/onfn7Rcb8KiA1+TrZarBrKvzDtrg2zRx4+V40USxeWVr/rDM0jf8r5fTkvCY7uXlKodtIjsfemaKMF9VX0geNpb7dxmC0Qt3Es0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512998; c=relaxed/simple;
	bh=y2JWZvHJdVFdS2JPzFc6K4lM3ffIwu7LSCAQM8cYwps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=p/ynHiJc+XCBpYduEt4jqoB1uKDScWl2tL4LEmAhFisUmdcMooJ2s9eomh/CtzX7caPTlmO/Fs8o2wtTHyjAG/w8HSoXWCldkPxlGHsNVFrjadhOlZ+yFe4zumN/V1X8RB4GyifGyR7gLdsOzXDrxlFXdt0lvbTdFj95CtO2Vak=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=M3eKtIPT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="M3eKtIPT"
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so1809128a12.2
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512994; x=1708117794;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHqRSPmMg9wEwP3rMANc1kfU5BrHC67r5uXE7Pbrcfw=;
        b=M3eKtIPTBqosWJIQ7Od1wDVHeQYwKLmZT9p4Tl5NbXWYf7A8cl8PTiCyhFhpyBI3tQ
         uG2cj863k3KrJ/C0NWw2hIUqMBBfkNXQ2VS20z2yyweKOVfQIBlaHlFh3XGxX0oZ8LnO
         oItikgINfFSyCQ1WRVO4jDb9AjnqzkwXrQf7MEtwpEIXg4SGqMvifcySKHTl5CX3hRcc
         QHkt8bAVokpk99n490U9UlDD3pzlpocTsd0ezvt63QhAMJGZPyx3Cgt8wXFaPQWZh7rj
         OxzjNJxu4+nbLNdh8gszjx/4pCfZcIw3Cmr7YUlRn+fAhU12c56L3C/alc+kjfOM8Dyb
         hcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512994; x=1708117794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHqRSPmMg9wEwP3rMANc1kfU5BrHC67r5uXE7Pbrcfw=;
        b=LIbKwgMkVmCCQXQcNjScakMI3d6BhCvMgOi8HnZXQx3c/pPgXRRmLzkKL7SKqtZz+N
         q8qwqcILwbUOaZ/uhi0UBL1lS+Jr2fDoMM2sr/OTpuC3RP7t7XdkFaaMmouWd/o/PxPa
         PFq3sOrlQSIzD7vU2lKCjP41+aZdFqLipPQO5wyR6rZlvGiEIh+5KcYONMeQb/qs+zDk
         ZPPxwCF8ifPVEX540QmlhwT5bdqkiEWSgLA5mjSdZQgm1LOfcjj2sLR5DmIakpjHHEgk
         EFYnRr6mRQauqrjxN7Jl+R5+rUq7nXkj+WErgUbbDZ2o0SW0R2xgHOttJlOYKBjMw+M4
         ydRw==
X-Gm-Message-State: AOJu0YwxJyyEQIiN/qegro1ThN2KX4Wl5yB53oeUJWjgg9iog+Y4DfP2
	NWWjA5ABDCN8ehMf+C1FoGCviQs4y2sV3ZKKvmrcmBBVjI5Qs7zE8s3kGgVBkZM=
X-Google-Smtp-Source: 
 AGHT+IFCRWKIfsiL82n4TdoS64yVcnwMBOfM5a1/WQBiaXKRFrUJF45vmgNQwB8+gNMCtrg0vsq52Q==
X-Received: by 2002:a17:906:ece8:b0:a38:1673:682a with SMTP id
 qt8-20020a170906ece800b00a381673682amr190148ejb.32.1707512994747;
        Fri, 09 Feb 2024 13:09:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX7M3Z2lfJw6CYTLfI4lk7oZf4X/Tt8KydPPEjARXyuSj2RTAotoZMWc/4LontHspfsZvs2mavsE0O7vLe4AwgjKuGNQVD1gTmJVu/kQdu/BTIqerDe8c+vzuNfEhsv8pMxt9MMug51L2Gg7e/FAnvJmt/4XtcraJbsMt9xW0h9VBzs2n9mws+KI0ZlVdbAN6dKdGqa1Dob3dR4YoPWLILCLdo+ybAwJOLpb7b3ZslDfDnQ0H2NGbVv5srAnvbs+5cMj5gQCdloW1ToEHz2hiAs99Enc+EYRQz2Mrm6XHv3XZNZiNbMXVbp4VVd/I0UfBi3RY4gE1JVJtuD3843w7lsGqdtNxNdJUxgELZAu0lsIqehMMedmgZFsCsNbfW5L9xU3LQr4RJ3q8W7c19ZyXCAT/wi9UG2I6bRx52SdEHDvhk1n5cNCGiYBUdXcZUccz2Ml2gbfHrQMilutfat/p3IDzXnz9Lm2rUvdV2/2dz747SiXF4CBeO5iXKd7nVMaXvg0Q==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:54 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:48 +0100
Subject: [PATCH v2 04/20] media: venus: core: Set OPP clkname in a common
 code path
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-4-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=2649;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=y2JWZvHJdVFdS2JPzFc6K4lM3ffIwu7LSCAQM8cYwps=;
 b=AtvahE0Zp8lNnsXEZ/S0J1BDdGYP6MemKHscNYsYbYfY4wMxb5DnKSFgdvP2tzd3LvvAzgeJ3
 4f47+3XEPlJA57krg+XF4NHdT1tiITEo7TCJLawQhpnW9hM8/4jvzL1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Calling devm_pm_opp_set_clkname() is repeated for all HFI versions in
pm_ops->core_power.

Move it to the common codepath.

This also lets us get rid of core_get_v1.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  5 +++++
 drivers/media/platform/qcom/venus/pm_helpers.c | 23 ++---------------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index ce206b709754..5ab3c414ec0f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pm_domain.h>
@@ -319,6 +320,10 @@ static int venus_probe(struct platform_device *pdev)
 	if (!core->pm_ops)
 		return -ENODEV;
 
+	ret = devm_pm_opp_set_clkname(dev, "core");
+	if (ret)
+		return ret;
+
 	if (core->pm_ops->core_get) {
 		ret = core->pm_ops->core_get(core);
 		if (ret)
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index ea0a7d4601e2..1ba65345a5e2 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -318,21 +318,6 @@ static int load_scale_v1(struct venus_inst *inst)
 	return ret;
 }
 
-static int core_get_v1(struct venus_core *core)
-{
-	int ret;
-
-	ret = venus_clks_get(core);
-	if (ret)
-		return ret;
-
-	ret = devm_pm_opp_set_clkname(core->dev, "core");
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static void core_put_v1(struct venus_core *core)
 {
 }
@@ -350,7 +335,7 @@ static int core_power_v1(struct venus_core *core, int on)
 }
 
 static const struct venus_pm_ops pm_ops_v1 = {
-	.core_get = core_get_v1,
+	.core_get = venus_clks_get,
 	.core_put = core_put_v1,
 	.core_power = core_power_v1,
 	.load_scale = load_scale_v1,
@@ -423,7 +408,7 @@ static int venc_power_v3(struct device *dev, int on)
 }
 
 static const struct venus_pm_ops pm_ops_v3 = {
-	.core_get = core_get_v1,
+	.core_get = venus_clks_get,
 	.core_put = core_put_v1,
 	.core_power = core_power_v1,
 	.vdec_get = vdec_get_v3,
@@ -1013,10 +998,6 @@ static int core_get_v4(struct venus_core *core)
 	if (legacy_binding)
 		return 0;
 
-	ret = devm_pm_opp_set_clkname(dev, "core");
-	if (ret)
-		return ret;
-
 	ret = vcodec_domains_get(core);
 	if (ret)
 		return ret;

From patchwork Fri Feb  9 21:09:49 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551850
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C72E63C
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.208.50
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512999; cv=none;
 b=GQKxQPW8ohUTpsoZsvIILwaKL2mx5pF4/5mmIU/WlqplPoz3fl1RfsFQqm4W66KATbCDqC+eh6afrMYW0aqkjBvKxAAD6oC2TChrRmSciiSj7rCAtb4oht3KnPoKhdvsfUHY+E/dsT1WYgts6fXk/qVdTtgqJ/g482j+TKHy7Cg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512999; c=relaxed/simple;
	bh=3dtrntbOogwjknLFZqca+wBqcS9QWbQOd9iEEJQfOvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=DfC5hHKabaHdGdaZ2OhUd035JQKKmlX0cjRSlT9UeRmxWmkUSP/usFRoOfDq9BoHVTu7w+fi+895nBB1mLWEIkk0qFNWRimUAasnK7yhJ2vEdnsYNaf+OLvqftR2fbYxSh4wY5j0z5BuzF+zCd2/lQXFLY2IhNksA05uGLJKNew=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=rIOCa3FN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="rIOCa3FN"
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-55ad2a47b7aso2074757a12.3
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512996; x=1708117796;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AK+SsOpDJXwjdmEkPZAy2mx09ivoS/IARlVKsNVFoYA=;
        b=rIOCa3FNdNrVbpHo30DQbDAzLFeRuRBrY9FZvar1nCu+M3ZF5OOO6axwxVia8pOczF
         CLILcUlZ8NsooyGQvWI7gtJoz4WQbNNsH1kAQTPxTbyVlEQ+EyI4eBTCE8633J+23/bi
         FbZQwXYk3trULXdzPS8OphdZCZT8aswpdCEBxt3BLeEm+Aa+uyz0EBJpTP+G56ehBPmy
         OzefBJiPFmLkD1V4nIEsvkZsw93O8gK1KncKR5nJCVni23Uz53E1s7c2xwPOhoqhZG1H
         Lmd4lZH6hNG/C10zl+D7RB7bcw30rNNxoumd50GRVhSsXL4fQx5ngAkjxwBWDUCHKBYr
         x1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512996; x=1708117796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AK+SsOpDJXwjdmEkPZAy2mx09ivoS/IARlVKsNVFoYA=;
        b=rc06ba+bZh/cZhAj2GYlzq+GtThQzTNOz9SRWXeLfo3qqBHBGRwampbnOwDFooL3IU
         AnlxUG25kST229bes3GTrKwsnnRsiEBfuAfXRNJUwb/CcMsgyYsBr0fvXtuKyUgUqg6P
         O4/hZS1CFrahqukwncVVWuL1RSAbNeIFi5R6/uKRoGW+Pkhq8FPXxNj5l98JtKc0icyf
         b530K5BYYeDwfUfWsrb5l9lvgrzFR4fS8XzOLUZ6RUNK2ElQqW/uI8LV5PvfGo6tX+jy
         wUNd1fEdpXaFsbUd3wGJggscrqf7mX137C6PhWGttNCXg20afgz/zHgWCM8XR/rnuhLd
         bx6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxKruFdrJ6E8vUOmapZO73U+NGgw4muC3QBSldd+5q4m6+vzTcCGl9uJ/GPtjdaY+EdKjvJFSYDq7TVZxoAkKH0dDfJha1CRjjImE=
X-Gm-Message-State: AOJu0Yy22cPLkZujNYLLq5iDrHX2vMVGrWxUxtSaQR9CGCh0DVN0JVKJ
	e2Zi+gjqbI5kybUjkzPtWsOJVUdkFO0/CP5ANgu0blIdbBH/FA5q1wJ0iI6WnDg=
X-Google-Smtp-Source: 
 AGHT+IHcGl9JHJqOe5VmdQ7VeXCk54tJsLRobhhO7hKVsXdIqB+9dtCWHyxR0NIAJY7xkg0o+FUGxQ==
X-Received: by 2002:a17:906:af94:b0:a38:1938:3d41 with SMTP id
 mj20-20020a170906af9400b00a3819383d41mr189889ejb.10.1707512996410;
        Fri, 09 Feb 2024 13:09:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV7yR6qZYcLxMBFDCwovXqEY+5tzDFTiFCuF97xuBkVj2p/H9HKYNngM33WBfc13n9vtJD7IfZtdZrhoiJQ42U3KGXh0WwxyQl0pYiAQW2AOggDtknGTPABl0wpdBu8CBxgyUGYRw9uK99xhZO6wVUH4UKRZM4z1BbJE3GPxC8CihdoLXfoUsoIb21+rjdCJjDj2p+YowtrWSjK0cX/mikxvSVIHA/jHOqwOeJ0/ld6iDCGG9PUOncIgEm6HricqdHhhonjlBVPpyzV79q/M9Xmo+q4hdkprUAopGoQNxwic1GySl9bUeyxVtSuVuGyjpkKZiChcjhAAfE+CrwZokvkabm+8CGp+Q6fEgmj4MSxgWpeacUL9ZFh1DpAPSVGHxoWEFkNmiswfeC+hs+AS87KPKyGrSYhYsWxNrpg0PdlE8crwdI2aWYt6/VXxpkn3+jTePc68hz/1zMgjaHlHECFv6JZEdTNJwHTsvlbPkHZXVjX3FtkjOdpc9oDLBMPybjI3Q==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:55 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:49 +0100
Subject: [PATCH v2 05/20] media: venus: pm_helpers: Kill dead code
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-5-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=1555;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3dtrntbOogwjknLFZqca+wBqcS9QWbQOd9iEEJQfOvA=;
 b=oh5FZnz1G42Z7kWhiKa1BU+f/0l6PypNRePBfJONaCzYzRLoGiiAaxtCapT8+vTs2EweuC6lZ
 PlUS6YMzmQLC4SkVj5CuP5XX713SshpGMNA9dXY4b2/tOQrSWSBrAzx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

A situation like:

if (!foo)
	goto bar;

for (i = 0; i < foo; i++)
	...1...

bar:
	...2...

is totally identical to:

for (i = 0; i < 0; i++) // === if (0)
	...1...

...2...

Get rid of such boilerplate.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 1ba65345a5e2..7193075e8c04 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -878,14 +878,10 @@ static int vcodec_domains_get(struct venus_core *core)
 		.pd_flags = PD_FLAG_NO_DEV_LINK,
 	};
 
-	if (!res->vcodec_pmdomains_num)
-		goto skip_pmdomains;
-
 	ret = dev_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
 	if (ret < 0)
 		return ret;
 
-skip_pmdomains:
 	if (!core->res->opp_pmdomain)
 		return 0;
 
@@ -928,9 +924,6 @@ static int core_resets_reset(struct venus_core *core)
 	unsigned int i;
 	int ret;
 
-	if (!res->resets_num)
-		return 0;
-
 	for (i = 0; i < res->resets_num; i++) {
 		ret = reset_control_assert(core->resets[i]);
 		if (ret)
@@ -953,9 +946,6 @@ static int core_resets_get(struct venus_core *core)
 	unsigned int i;
 	int ret;
 
-	if (!res->resets_num)
-		return 0;
-
 	for (i = 0; i < res->resets_num; i++) {
 		core->resets[i] =
 			devm_reset_control_get_exclusive(dev, res->resets[i]);

From patchwork Fri Feb  9 21:09:50 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551851
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0FC1B7E9
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.218.44
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513001; cv=none;
 b=oeWGgDkGU5PVhaQwa/UD5Fg2AaKLvLc/8p+dF6sj+rtkvxFyj0i06KQNdfhVMi4tmANmjK903zaC8hIX1MbjOsUbNFzernR/lgmtMZBXtXa+XwPHHFUzGHMiEPBNFYLL6NIMBNeI4aKebA6JkhxCIR4Fq59IqER6BXz1tkHK85c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513001; c=relaxed/simple;
	bh=emlasjHcZnzrIjnafSLSnzSeNd3kwBS4D1Wpb2NJwiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=JXG5KNFom/qIDdiT6auubnF0wFLq9CakRHXcRvDkcSNeDBjhI+H6w1zFPHjQitCak6DT7ftF4QuCMoc87gEGNgIN0FoB24t3+WrhOZwMOHGOuOBT9plnweXcVVrgeX2e7yuSqv4x6yWn0sZoXqBTX4ogtBGhYmzO/fd1fbg3r3Q=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=iNoQflyD; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="iNoQflyD"
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so181560866b.0
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512998; x=1708117798;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2YxXA2KQwmYTykbrsMuU28ijcqoH+ICj0PO4K3eu3g=;
        b=iNoQflyDa9h+8hwiffRMHkHBj6JC98z0hs8qbYw+k3TZe2zAhzBzMoNq6bWrOC9B1W
         A7miC+LAT+jpaXJu9iscfQcPZ6QKUYFb0y3vNUXpx6EyNp/ElfFKnKsiRCWt+rLRcjPW
         SF+JLQuzx3FviG2TveKI05CqX+C+5RWScJvYpIZvp9Bvvbq/qsht3uthc85TRsPuZFaR
         J4gairJNc2urNhICduT9CughT8yF8iKvly/qOIvdXqJLngXxiv2LMWyDGJnQj+PDhkfh
         5xsWyKmceaUtwIGk32HZElWONsByN+VdCZ7MmLZvpKWhAjeccQDgg2P9gil3Wq19pwuK
         KnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512998; x=1708117798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2YxXA2KQwmYTykbrsMuU28ijcqoH+ICj0PO4K3eu3g=;
        b=CTojgfGWpEEW4pnsocr4FDe6PJa9nojbNjBjM4/kxLdsHWDbxZ5K3L5mSacrnQ8kpo
         Q4JaQttPHcs5VBlDh5fy4ihHTkh4o9QkMs0bN6A/BbRr+p0JHyfMtOQ8Pt5e7mMQDLUC
         1tDxaN1AI4HDmR+vkedWCuuAdIH/ng4kOpYGjGJmzyK+VgZN/I7FEbYFalfrMepaAGq4
         xOo9/9UXX0nPMWkgPJ6qJC5DCVZplQX9i7X3s/ax3lhGxRgUUN4W2PVA8UdI43BmXIg1
         cjkDf/1QMfunUwN+y3kCsqhB22705XYY3hpqizSUTz7708g9S6BOxnU6bRU/VjpcIVMj
         fy+Q==
X-Gm-Message-State: AOJu0YxZn1r2LUDyhCoWYX2gFUwe5r5h9MUiSjfzLfS6pITJSXLE6L1q
	/lTKPQzWshrYgFvkTuFNOvqtHM10u/f2aq6mz/7Xgqecdkcm3mLEC6VKsA+3tHg=
X-Google-Smtp-Source: 
 AGHT+IHDduXE6feHEfBorIgCVQWl5Jn+Ve4Cd9AvURZgwCUnQ77qWcE4yem/H1l6J8EWd0F+RIyEqA==
X-Received: by 2002:a17:906:a92:b0:a37:f129:262f with SMTP id
 y18-20020a1709060a9200b00a37f129262fmr221597ejf.12.1707512998289;
        Fri, 09 Feb 2024 13:09:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUc8bLRgweiBVuk9eczSVYfpuNQRnuIh3vZjAIZUIJWRHTF5591PApKSgTs049Uhc/jfFXkI5reynt3T355snl3ywCzO9R6GuUzhr8cdA/UHQSluHSMVbSLVNCpQAmO8yEYqwrTLpyo18PgE8vBSmUYJPN0EKitZ7cetILptYZex+43rxpnQ+txWDgidr8kjTzy5DWjtQe87KAQsJGAVGSYfzhoL1F7fKlTxBwXTxe9uEfA9NmdVpKYTzbXuEjn8YDzGRw9YAryTq3wbMylQj9AuKtcsjCQ9O4cRvf7yDjj8ZUy0NC7GjlmLruofgpJ3eV7JqGDV5Au+APVQGNw2o0y9ORIEQYZZIU/j9QBF9SJw3B46MJ9pExMfZ5xVVkguDzpC0KJZTKsB4oBDAnIL+oKj4G7TSmHJ4NVtQqBBg9iMwdy/R745K0TMZYVfNlcvT/b1zr+aifH5JJDyapdG8bhpXWHGJ7atx4rfpk2y2wrEIVKwsgfSaaQ1tTWPhSdnmjH0A==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:57 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:50 +0100
Subject: [PATCH v2 06/20] media: venus: pm_helpers: Move reset acquisition
 to common code
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-6-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=2551;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=emlasjHcZnzrIjnafSLSnzSeNd3kwBS4D1Wpb2NJwiU=;
 b=pmdE2ES1G6/MKZfX3GzMyvavVDPlN+plxhvovU/PoEShg7rUaVAZQB3iuBi0KNpybJBJipvMf
 wdDfzCVsd/bCwFW/C/FUH3PtUuslzktUB0X3uTw3kGdcrfgsmmrSVwE
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

There is no reason to keep reset_get code local to HFIv4/v6.

Move it to the common part.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  9 ++++++++-
 drivers/media/platform/qcom/venus/pm_helpers.c | 23 -----------------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 5ab3c414ec0f..0652065cb113 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/pm_domain.h>
@@ -286,7 +287,7 @@ static int venus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct venus_core *core;
-	int ret;
+	int i, ret;
 
 	core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
 	if (!core)
@@ -324,6 +325,12 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < core->res->resets_num; i++) {
+		core->resets[i] = devm_reset_control_get_exclusive(dev, core->res->resets[i]);
+		if (IS_ERR(core->resets[i]))
+			return PTR_ERR(core->resets[i]);
+	}
+
 	if (core->pm_ops->core_get) {
 		ret = core->pm_ops->core_get(core);
 		if (ret)
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 7193075e8c04..6017a9236bff 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -939,25 +939,6 @@ static int core_resets_reset(struct venus_core *core)
 	return ret;
 }
 
-static int core_resets_get(struct venus_core *core)
-{
-	struct device *dev = core->dev;
-	const struct venus_resources *res = core->res;
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < res->resets_num; i++) {
-		core->resets[i] =
-			devm_reset_control_get_exclusive(dev, res->resets[i]);
-		if (IS_ERR(core->resets[i])) {
-			ret = PTR_ERR(core->resets[i]);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static int core_get_v4(struct venus_core *core)
 {
 	struct device *dev = core->dev;
@@ -981,10 +962,6 @@ static int core_get_v4(struct venus_core *core)
 	if (ret)
 		return ret;
 
-	ret = core_resets_get(core);
-	if (ret)
-		return ret;
-
 	if (legacy_binding)
 		return 0;
 

From patchwork Fri Feb  9 21:09:51 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551852
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C83AC26
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.218.51
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513003; cv=none;
 b=ut5MnpPuux/kMSNqD6tHuuwaQI1vm5sircp4/tk0ZRVGHauSiOPI3cOiwn8OEzScXXjVOH/cirSmsvjitRLXDx7ZpYa5lnymJGZBkQU3yEly/Ze9YqlKYIHB1Xxwxm38nWKCiqJfSy5/rMtiEfVypgsHkL5qkORzNKHHQNhzdoE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513003; c=relaxed/simple;
	bh=2igVAqX0VNw3fNZBRPW3xI6PegwRz7NA5+KLZ+WJ63U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=oAK97rgBPLgmUCWnKGqKLV8I/hgf6p1h+cL87x5otDNKvqdaEzAiMECd4xzzU2OuCHBPctd2p9arPmWgattW1lHTJb4Y/wd8Akmcw9y0dyLiaD8Q6OPJ7++tnDqKmG1LlvdegZRIywrr70T9NBeCJLRhE/SsLQRwu6yjecPpcV0=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=SPrfwAj2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="SPrfwAj2"
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-a3be9edf370so142770166b.2
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513000; x=1708117800;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlIzPxVWq+bsAR6HPmAA/ifEN8Nb2TRGFiIMlA64yBs=;
        b=SPrfwAj2kg3ZLBhxtTxDB4ydSQjdTpZr7xYCYlZ7W7eGiH7nX/WrDTLOm7Pp55ApmM
         hRAszqjZ+DaTkKnB+WHtM5JDMwgQCPcyBCHLFTPchA+USR1mzepx4YRRnT0Vu8FPkm6J
         q3AjnUGIwooRtGMguTOyDkRiYFr/d5b5e8hkbTX+bPrYpmxUMRr08uzByDiKvEq4bzpE
         nmgKdd/QFllDT+VOgecLy07ZZegkcO5NX/LG8FzBz6vEjVxJbqvwPxWtHNXvt5roBDJX
         AOkqWmgDSYjYuxjzqARCVDshFnO7DloORwT8GIX+Fd5yGrZZgCflOpR7gH1Od+ek+QRD
         uPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513000; x=1708117800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlIzPxVWq+bsAR6HPmAA/ifEN8Nb2TRGFiIMlA64yBs=;
        b=r7YTL8glDlLbxHVPzz24g4Xgq6yHZNahl5Cd2tJnr4koxE3Cu2L22DXPmvDqQiL2RM
         d9gCqG8aC8k2IOVjjnfVP/tJJ4B0kvUTBg9COF/ZMzk8/Vz64oj2W0JHHcIfo3MfT8WL
         og7MVuP1D7JEeN/BH/buyvv4JIICl6DdQiXuLXY4inoXYE5QTq2IgfqESnoVt6/6pKkn
         EufxnB1MhYXw7mg+30jecWyrBvXCXMXbTNaMq58w+PaoUMpur48/pk+hR4FKYWfx5rdv
         xGlC3oyYLipGd/79oje5ATQ1DxqxsqH+HzHWRUqYmVRFoKktqxLQ7bEvuhxZViqAnoDQ
         QHhw==
X-Gm-Message-State: AOJu0YwlU/RVEuHP5xY9Q00tFn45s/72BC9ADDc0saHCC/E5y8DKXT1Q
	bsCCJJyDvZ1uThObjHxGpXEV8auKiczeBD6JvEawglpHB+gVlKMIAWG3OLXtQII=
X-Google-Smtp-Source: 
 AGHT+IFnCxzyEedknS8glnIpOZ9GDBMua8gfkrZRkR3e3+UJ2pcF15UePro3zx+DsQ7PS/+aZf/YiQ==
X-Received: by 2002:a17:906:230b:b0:a3b:e115:7b69 with SMTP id
 l11-20020a170906230b00b00a3be1157b69mr167492eja.69.1707513000009;
        Fri, 09 Feb 2024 13:10:00 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU43QCiyrytYxFxTxdhazfamHHqeLm5xnTyGUEoGhxRhNdGtZYwyCobuEDrz13F0peEVzF9hXAC37nnUngLF/3nwOhpGIRgQPW20GasVlz2H0PwfQNIJkZICjK3xuyh8Z8zBEknC0Z/uebrWghTa8wX+IjY4iUf4PeyjWDc0ud7GEpQH5yGlMHDkzrZbql/QDdwW4bluhNc334cQIPU4Ldg/fvBA6oAsIRQIJjiUHaaQAQQuzlhR6p4Xl1z4LWhJiTTKrdYYzbcVy0OYx+V6M5Wwdy7EsmGdjxBTFKCRBktjJMFyMGjMOSvmkTKuqSmdFWsCRjMY4I7aYsrh/JlRkX1KYnlxxQzlvAa+Wb8Ou79RA1AkP5rKBuiAlEv7TzeLjIWTneR6xqG6Q9UU6mMIMxEII8m3nHcZ8fa4xjNvsR9snrx4algbLlIjTtO4UW/aG8c/oUZUDVbCVx6lilNme4N3NWFO3Gg5TArMwagfoh7qtHq6wJE7M3Duu0GUV9XAvipeA==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:59 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:51 +0100
Subject: [PATCH v2 07/20] media: venus: core: Constify all members of the
 resource struct
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-7-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=2706;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2igVAqX0VNw3fNZBRPW3xI6PegwRz7NA5+KLZ+WJ63U=;
 b=Y7nFOgWoxzW+xfFgI0rML0+tWKvbFCA3TQs/Nwf2AzFXA+IkV7piuQt7VgOVY3+o7nrSsc7H/
 +E8YHaQRkrxBYhXeRsLvZZmvyVFRd9yxBK3UHiT6QONOW5zXQCNkUo1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Nothing inside the resource struct needs to be mutable. Sprinkle
'const' all over it. A lot of 'const'.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h | 58 ++++++++++++++++----------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 6a77de374454..6b1887f7d9cb 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -56,39 +56,39 @@ enum vpu_version {
 };
 
 struct venus_resources {
-	u64 dma_mask;
-	const struct freq_tbl *freq_tbl;
-	unsigned int freq_tbl_size;
-	const struct bw_tbl *bw_tbl_enc;
-	unsigned int bw_tbl_enc_size;
-	const struct bw_tbl *bw_tbl_dec;
-	unsigned int bw_tbl_dec_size;
-	const struct reg_val *reg_tbl;
-	unsigned int reg_tbl_size;
-	const struct hfi_ubwc_config *ubwc_conf;
+	const u64 dma_mask;
+	const struct freq_tbl * const freq_tbl;
+	const unsigned int freq_tbl_size;
+	const struct bw_tbl * const bw_tbl_enc;
+	const unsigned int bw_tbl_enc_size;
+	const struct bw_tbl * const bw_tbl_dec;
+	const unsigned int bw_tbl_dec_size;
+	const struct reg_val * const reg_tbl;
+	const unsigned int reg_tbl_size;
+	const struct hfi_ubwc_config * const ubwc_conf;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
-	unsigned int clks_num;
+	const unsigned int clks_num;
 	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
-	unsigned int vcodec_clks_num;
-	const char **vcodec_pmdomains;
-	unsigned int vcodec_pmdomains_num;
-	const char **opp_pmdomain;
-	unsigned int vcodec_num;
+	const unsigned int vcodec_clks_num;
+	const char * const *vcodec_pmdomains;
+	const unsigned int vcodec_pmdomains_num;
+	const char * const * const opp_pmdomain;
+	const unsigned int vcodec_num;
 	const char * const resets[VIDC_RESETS_NUM_MAX];
-	unsigned int resets_num;
-	enum hfi_version hfi_version;
-	enum vpu_version vpu_version;
-	u8 num_vpp_pipes;
-	u32 max_load;
-	unsigned int vmem_id;
-	u32 vmem_size;
-	u32 vmem_addr;
-	u32 cp_start;
-	u32 cp_size;
-	u32 cp_nonpixel_start;
-	u32 cp_nonpixel_size;
-	const char *fwname;
+	const unsigned int resets_num;
+	const enum hfi_version hfi_version;
+	const enum vpu_version vpu_version;
+	const u8 num_vpp_pipes;
+	const u32 max_load;
+	const unsigned int vmem_id;
+	const u32 vmem_size;
+	const u32 vmem_addr;
+	const u32 cp_start;
+	const u32 cp_size;
+	const u32 cp_nonpixel_start;
+	const u32 cp_nonpixel_size;
+	const char * const fwname;
 };
 
 enum venus_fmt {

From patchwork Fri Feb  9 21:09:52 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551853
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F03B79D
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.218.52
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513005; cv=none;
 b=IsU/p4AAY1OGiQvmtcOWVd0mJkVJ8DuyPdCMTaDvmlgwwlh/cPHqx8QXEfU+kLvDlv4nlZCPpIWnGMDGdZRYKpuXIbfAN1xDDhI46sdDMrnZ5xcY3WwdL7CYwsKudM1PaTRBHbcY6j1Ub5+wU6bn8iraTW2QEVxxUyjXhFN691U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513005; c=relaxed/simple;
	bh=BxP6mknLkkhwH235J5PftaK8VpshDs1dIkEqExrl9fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=mHO6hnStztDggEocBabjKegIzkuo6wBtdi53ro5f8xo26iBbqPgnyJrcbR3YeXYKZZ5oHOWRZkj6Q6TAZiIH770ElbcN2ZJI0iX+fzHjqgmcVHe9VOfrwDBeRJtw4ohG19dLhAHeBlLF533talLI3VxplA5DkB3637I/+nDsH6w=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=uw+dS9PN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="uw+dS9PN"
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-a3c23b0e06aso6095866b.2
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513001; x=1708117801;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjYVvA6/x62tiGnPrd+cF2sjnvoUPDtV+GlugrRAEGc=;
        b=uw+dS9PNWVj9wRNNOG5bzLY9bPK0Dxx+luF2Tlipv6M2tcvnsodddiOWFFWRunxwjO
         QBE4twoGsGieLmcRHnZTqYUlH+M/yNrJS4UkzYLZVBgliM4bG0xqFPd5UJsKfkeT/VFx
         k8W+9dC3fvtrd6KAy6vkoNRTAMvaMaebjp+hSxCwXKflscZrIieBzckTReamPRTfA3dU
         jYAdSpbIu+USe0eWZAOc72myx2N2NTIqg8p9iLxVS8KmHzzMfzJu6dN63oAGauX1KffV
         k2GTeJbGoC6nYPPv0exjPXAYxKs9F/bXfBOcCNSx1/bBqApMuQZNxWIM9jzKdip8zpUl
         SBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513001; x=1708117801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjYVvA6/x62tiGnPrd+cF2sjnvoUPDtV+GlugrRAEGc=;
        b=f2bcDOC28SdqN+8/MFyTjd7HfHT2TBVB+f6N0kKvPosk8ksfv3rcaG6eUtUHDe4JGc
         M/w0dWnctaUCT8hHCpmhU8U0SazTZK5pz37UFqtNI3MRU//HgnrmS9VhjQEm1PTbGt1D
         DG5E0ZZw2cFZFbhxfWisVG5XTHnPptr9CsSpYKpoGQVOhOsOdu/nbwXVxWmYub/H3PQH
         j1sJwSPCud2eM+UFNNlsZUumypCxzrTJDujYbycttJqM/t4sZ7kkljXtoZdQYPtpKvFz
         yFoWPK/nJBOxgzzeXA6/2p4fI9+9JyvSjK7YJo25kgSuN7FRAOPkjgaNa2iH97N7cOuy
         dkjw==
X-Gm-Message-State: AOJu0YzPuFAZZwoYLKZdpdGozqRxvxTXc2yTXi5Qg7EWB1EBgUZsgA7E
	D6Zf+x7SRKfZiKmHNRxp66Ds48fUyCRGf1NWlqMg6WocdOIBubU9JD+EG/VtjCI=
X-Google-Smtp-Source: 
 AGHT+IFp1PWTyLpycl+jUCQr1eGQJdI8e9Yj52cDT9vNrTaarpIUHhbVsEGxWxvBkn2tg4TGxOQwcQ==
X-Received: by 2002:a17:906:378f:b0:a3c:45e:77fa with SMTP id
 n15-20020a170906378f00b00a3c045e77famr152223ejc.11.1707513001665;
        Fri, 09 Feb 2024 13:10:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW3lTlfXWRs2C2UOrTagbsQew+Gmppxm8P6uAd4UeQ6vHAxDZQD/PFiYRdIu2Pvs6xsyGE5XhMSd6knHTNovwY0LdPfMydvGzPXievOL5F1E2IQvlL9loDKEaLeYW7NrSVwe4Oeknob8QeNkmGM3g5JIz+EL9mePMrikTdpopi1CPpnk8TASPJ5u+AR9r+GjjXwmT6ByDcuMXBB/AC+OKONvRvt4YvyNeYooeZDfbfteb6yfGpZvsP/N5bQCk7XsJYBxdiC+/+CiIUtqgi10pLMIOn51grS8/GvSPGknoLbjmA8alkfDSaHcKsdoOuJ+tdBvCBsVTlnk2WCBpHQaJSEru4eqiwKLcnQQI2mYfXbLxTHi+LKg2mE0idtTP7ibp2WYKb837rpctER0MHPZ8OsYBP5b5/lfa5B7CKLa5q6VRwA3YEk9zUHqCkppAQvGP24GZHNQUf01P6VOQDKYpI4aQ2CmqHlkHLnf55SzD8ZhHDhfZNsf0McnPDiYlnfreCcrw==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:01 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:52 +0100
Subject: [PATCH v2 08/20] media: venus: core: Deduplicate OPP genpd names
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-8-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=2465;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BxP6mknLkkhwH235J5PftaK8VpshDs1dIkEqExrl9fw=;
 b=2O78uSJw10ViDsWmi83rvPytRhzx7ZDuSMlLSa+Uj9Pn4gvDUJGncWd8/wYFas8VOoMyqHPLS
 ZIpmbvLgizuBUi3m3Ie3kg93LDgEy+p1MBVHqKMajDDshiuVa9awE25
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Instead of redefining the same literals over and over again, define
them once and point the reference to that definition.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 0652065cb113..83ac68f1566f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -538,6 +538,9 @@ static const struct dev_pm_ops venus_pm_ops = {
 	SET_RUNTIME_PM_OPS(venus_runtime_suspend, venus_runtime_resume, NULL)
 };
 
+static const char * const pd_names_cx[] = { "cx", NULL };
+static const char * const pd_names_mx[] = { "mx", NULL };
+
 static const struct freq_tbl msm8916_freq_table[] = {
 	{ 352800, 228570000 },	/* 1920x1088 @ 30 + 1280x720 @ 30 */
 	{ 244800, 160000000 },	/* 1920x1088 @ 30 */
@@ -721,7 +724,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = pd_names_cx,
 	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
@@ -770,7 +773,7 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = pd_names_cx,
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -827,7 +830,7 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "mx", NULL },
+	.opp_pmdomain = pd_names_mx,
 	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
@@ -886,7 +889,7 @@ static const struct venus_resources sc7280_res = {
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
-	.opp_pmdomain = (const char *[]) { "cx", NULL },
+	.opp_pmdomain = pd_names_cx,
 	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,

From patchwork Fri Feb  9 21:09:53 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551854
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF58210E7
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.218.53
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513006; cv=none;
 b=FzEvtz5kIOAgyhqIrZnzaama34TJOg2g1nqkPDB16t2zCtxZV0XxPd4JNWjneBGVdyjvlB8g6AUpVBZDqCrAIG7KT9i5tKKjDgCf/IoKU43PmlDlfppRaSMUZv7MIy5IQuFNuVCmbH3LYQy1HqDc2RUXv2OZZdm6qCKlUbK3ajE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513006; c=relaxed/simple;
	bh=Nc8bwLF77VvKlbJugx5YChhzVAEJFQcCZ1haIFmgnXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=uFKWEOpaRWxyT2zLL6SRJzU3U5Fw5EQt3E9o81A062XWEEY1N44t3UMNQvzHIxNy7i1JbUHNwjEJuSUVCerLd8SQSUuY2+ae0mdq1XIp4mPXj5jYmr5HJ47xC+2EE4lWly9AhR4cqxmkUSP2F3ipK7Mxlben3qaLzmQidwX2Ba4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=Vkfta0ap; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Vkfta0ap"
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-a3c1a6c10bbso21197366b.3
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513003; x=1708117803;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBIdOxdSkaLnpY2Xy7kKGuuvDn1LsIy3fb0GF15YoEg=;
        b=Vkfta0apVABq+LMrD5q3GGh8pkFOIBg6oShfJe0sspOgu6LDgYSb9FEQB/jAsZWqXH
         t8wZFMU/wUHtgjlLq8NkSmayeHZu1t11oSZT7kobhVEpnxOJmtfxX5IZBjcmI8Niv1MY
         YTesAQSLCQCddsR3IWya1H0wTH3earHz4VN5tN4m6apPka9KPPABHwV05zVkeLlOEt03
         b0aXRGjxJDT1YQ1VIiBpc7z4Uf35+ytYnJsukbZlyrC96l1FTrOC9yggVNxC25y+imny
         /S3QK35VJJiUGErHNmX7eBoIq6Z4tegcAbYY+pV3yhN3uu/W2XV98iHq5O2Lg8XTW364
         Y1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513003; x=1708117803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBIdOxdSkaLnpY2Xy7kKGuuvDn1LsIy3fb0GF15YoEg=;
        b=MvTZpoyjb1tr5O84Vucytu96mJvqQ6W3t5tC2GLBofysZcH1CsVyyqi8v5vlz7DIal
         00V7bze4444BMcO9/VY36DjnYPcWgTVPg0gLl/VzCT7JYC2y3hIwVywZUP0dfut99BtE
         Oo42DqwriqXypgNZEU0W6rDjW2OpBiB4OCD3FyBbaO5xb4n7vd4j7mdbqX7TPJ82znZr
         rHQotK3aeqbINc6iZk54OUPQoBtdmEtNoMJi+TDtn+7SVAQ+PHppGpCvGVTll8AffM7Z
         r0RHJktr2/nEX4YJf9VitQBMuHDWUicN32gy5jMGTVZAYvng3J5CBG9tLWgTWYmGgGjb
         HAyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmdQsGrjqzid8v2nGJvc8mLtOFtgxFMx4Ti+ErbBgA1dC+BG84BgaY9Y52I+MCVZLVHQ/xVLEeSgz36dwljoXj8MF2Wz7G/P4i2lI=
X-Gm-Message-State: AOJu0YxsqTofF8/6ISXbpnfmaJ+CSDbQdhdM66YNP0yko8r3uLyYrQlg
	UVdb3PsTB38sdHih0t1zKW2AsITIfwsdrUo+qsodlEHuSvc9mxpn+GiGIv3BWfg=
X-Google-Smtp-Source: 
 AGHT+IH/TIy7X8EFV828kV6GDBQNmCkaZOa/+/wNDX4c6AkkZd1gyri5Htt6OghhH7g3b1kTKySOZA==
X-Received: by 2002:a17:906:2988:b0:a2e:ad24:da8 with SMTP id
 x8-20020a170906298800b00a2ead240da8mr196858eje.19.1707513003245;
        Fri, 09 Feb 2024 13:10:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVGxDG2/AuEOpnUYKbMxOy8gJOwVXXY8PKb/8q91Orcv8ZA37JyCZ8VHWHwyt9OuW3GPX18oh+D8dN/3w/r14hxtqtcvPBzAcQpBKVNx2w0j6qv+cpF5VWoj1arHgaSrkf3FpGhIyAhSLwOw9jHhTE/VAgYxtJlEGMxDMvyxbZ03Xnmw1N3KFGxe9346YBRop2lj25mooETIF2gGH3d5IPp2XwbbXETECgn9ZR1Slvq6LykEAU08qWGUlKgZjahAjYPriHuTeqg7sa2FzV+C8kNyApDaT1IjqG2EmxkTCGVkr+Ru4yEbpaOxgpmFFip79jHiHEBhJ+Tt31REZVvjgN9L6RSlQt+kKUuF0EnBygeEJWkAYMTf+g8fQ3dTaeTtwU+Zu4PdLg9FeKi7L7i6fmX1lzDw4W+iDukgBa8hkRMS2RaXOxXgb+LLWT4lJmEd8+vy2m8SfzUINuuoR6UdMfX51RG7mIGxKrxdD3z3isNdNuYiyjgsZkjLlz/BfqrrIxzaw==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:02 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:53 +0100
Subject: [PATCH v2 09/20] media: venus: core: Get rid of vcodec_num
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-9-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=3437;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Nc8bwLF77VvKlbJugx5YChhzVAEJFQcCZ1haIFmgnXs=;
 b=Nd+zrzm1xfFXbo15AgzTjIPqJpUpwEHOn9xZqBbwsZ/j8927xZCb+EQYt9O6uFq1THjP3Wuz3
 Fh8rUawPtmPBXcezt5bFmEfM9N4XVETwds6JQbnCBIoHJz5ZPNGnz6L
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

That field was only introduced to differentiate between the legacy and
non-legacy SDM845 binding. Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       | 5 -----
 drivers/media/platform/qcom/venus/core.h       | 1 -
 drivers/media/platform/qcom/venus/pm_helpers.c | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 83ac68f1566f..1307aa9cf951 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -651,7 +651,6 @@ static const struct venus_resources sdm660_res = {
 	.vcodec0_clks = { "vcodec0_core" },
 	.vcodec1_clks = { "vcodec0_core" },
 	.vcodec_clks_num = 1,
-	.vcodec_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
 	.vmem_id = VIDC_RESOURCE_NONE,
@@ -725,7 +724,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = pd_names_cx,
-	.vcodec_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -774,7 +772,6 @@ static const struct venus_resources sc7180_res = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
-	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
 	.vmem_id = VIDC_RESOURCE_NONE,
@@ -831,7 +828,6 @@ static const struct venus_resources sm8250_res = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_mx,
-	.vcodec_num = 1,
 	.max_load = 7833600,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2,
@@ -890,7 +886,6 @@ static const struct venus_resources sc7280_res = {
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
-	.vcodec_num = 1,
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 6b1887f7d9cb..22f998637618 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -74,7 +74,6 @@ struct venus_resources {
 	const char * const *vcodec_pmdomains;
 	const unsigned int vcodec_pmdomains_num;
 	const char * const * const opp_pmdomain;
-	const unsigned int vcodec_num;
 	const char * const resets[VIDC_RESETS_NUM_MAX];
 	const unsigned int resets_num;
 	const enum hfi_version hfi_version;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 6017a9236bff..8412deb68ed1 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -622,7 +622,7 @@ min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load, bool lo
 			VIDC_CORE_ID_1 : VIDC_CORE_ID_2;
 	*min_load = min(core1_load, core2_load);
 
-	if (cores_max < VIDC_CORE_ID_2 || core->res->vcodec_num < 2) {
+	if (cores_max < VIDC_CORE_ID_2 || legacy_binding) {
 		*min_coreid = VIDC_CORE_ID_1;
 		*min_load = core1_load;
 	}

From patchwork Fri Feb  9 21:09:54 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551855
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E083D38C
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.218.46
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513009; cv=none;
 b=aHrVgiUkR/Km/waAstZx+oqiUGDE+MMnjwqz24cfkc4fm12Eqh4VwD/GMJYn54hGPPJT7foXVMJutorUS4TLG2PNMCtSjO0qJ7MnnEuaRWxcNO87YGBjSMTP4/Hxj5U3pgVDT9XZAcULb/IefZwCkpi8sh+FICGnRz8JC0ctqLE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513009; c=relaxed/simple;
	bh=jJfC467DwKCxWKXFg5drWkI8bmv02/WCRY1D3IsQV48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=NwD3kCpf9Kr/zkwn1N/FH03FEcmq/0Nu6xUhX1zIY6JBa9zEgvsCFZZVgZeeqOWcDm8wPJ90VJF913pl0SNWxhkmk5Rei8KukWV0QGIgz9hxsqc1BHXjcrvitpf9jmknxi/rHe1Q8h6rCNP/x6e0Jr6Sz4rj1h7P6erDiKF5ULM=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=XbQV9NqJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="XbQV9NqJ"
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-a38392b9917so186865866b.1
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513005; x=1708117805;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHHNIP6WO0gU8OMi/VaI5bJNCojpf+yHVI+2cBfLhcM=;
        b=XbQV9NqJu3uAOFwTnlytVqEfbGhLN8OhYtDSlU1QminDbK3eId3NRdU95EIn/bHfZd
         8p/IjdlxdcpRaOXEYsXAb+mE8nXgxa8td7CBiLge3qrKaicoSRWA2UxGGaqpLD0wqVBk
         QT2bdJIOgqyYowwJuUEeialU6e1WjaKjg90bjq4KL+AHCv95/lgU4pNvmL+gXA3QuN5l
         u3rKFEdzo5tcg2Y9iXcPKst0ioGHSCkReQPUrcerjM+oUBnOH7TI8Xu0b/65VL2cxVfD
         p3r7bUgzrjmLxlk5cUQ+oJRUIrIUlOputhuIEBqqwU9acdrQCtwZjHuLnQkRkgW+Mb/e
         wu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513005; x=1708117805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHHNIP6WO0gU8OMi/VaI5bJNCojpf+yHVI+2cBfLhcM=;
        b=AwtjSxQP1SFS5V3fbuItnkf0h8jJ/e3H9kC0SkFOQ7IfJEw8yrQTii18lk+yzaj6WZ
         fzaJl2MIl8lSFSY/sHhT+MlgzJkMJaaR4YWWtf3DCyn2Ntj2LHp91a1hP+1EpL4Ez0Fa
         sCyWYs/HOLdmrmd2x6b22kG9f6GRPPZYTyQMPdd5MSWGbio3UTU/hXQDQBDg8F2wvqpY
         BzLOA5l6UGTv02ISnzYn5r4/drWYt79zL4s3lwaHTgW5YVbY62Gxv/2V9OQ/jX+H0tuc
         BaeG1xtnYAiVyxDGIZhf8jRSeGBkIMyRbc68y1liR0Xu2ZMFQ/O/MqsufmUETDUQbI5P
         36zA==
X-Gm-Message-State: AOJu0YzjV5zDbxv8E4wejOxj+toOBvwv0YVzMi7O8rrC3H1tC9S9i8TN
	uyMfMggkiDDGuqaZKxXu0vXe+dtltA2+LWHp7oP7di7zo3+U+vOcuY87xyVpGSI=
X-Google-Smtp-Source: 
 AGHT+IFTu5O1af4j7FGN8AmZHbURUGVX7RejHX0HjgmTa32pd0DFpO6fo/iQEOyWK2Le/tKRoTEjbw==
X-Received: by 2002:a17:906:f854:b0:a38:3282:baf0 with SMTP id
 ks20-20020a170906f85400b00a383282baf0mr149252ejb.75.1707513005496;
        Fri, 09 Feb 2024 13:10:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX3nxrvLuug7z8HIMwzF5pJaONxq4VyQ1uei7niONjZO8hCT9RxKe3HKb10yHWsDMd5tmy1PlwwFwH30BdlAGx3d9elZTlrO6AFtiKdzLVjCSKbXgKNeFeInYUQJsCCe18PzwZNxV2C0u0udn/YVNgp73w3VMAgTdlqgSOqObjbb9e/W2/L2/Q6s9mcdWRDa3m9L3EWHLadCAq+GQ5TJ4BW7RlqV5RGt/F7+0ig91FA69dNdbFpejt/5JWjsuHxlUO5hFECDQ2X1oNzDORFufFWH2pqBTiASyZWrjbWNtoHXboBoBZz7t5nDxfkVQ7OK2kTSAYs32M2gpF0lxTGbV1KQhaR9xPbdb+DblBajXCvpZbvnw7ZGtDxziCKzw5FFowVdKLEOx0JO6DxCrXFt0kWdZAhR2ZrfY90wz3aEc+3jMQKjHulJGqsYp+N213xk8pvxZ5mXI6hfyBp6kS8hmn4Vb6WIJm9ReAa+pPE+3m7xp6dWzmOTwAVxwOiYvi2uM2adg==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:04 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:54 +0100
Subject: [PATCH v2 10/20] media: venus: core: Drop cache properties in
 resource struct
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-10-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=5254;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jJfC467DwKCxWKXFg5drWkI8bmv02/WCRY1D3IsQV48=;
 b=UrjaBNsJnTP3co/PybDHFEc1BH/J0yF4VkvNl7d5QtYigamNSZHSR3tZosOJ3woABlRgxaYwg
 c3GZ4Kmx+YdCUW49F1WGK8iVLTkODXwXrAvG+Le8pQjSlrq9Njl2F+l
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently VMEM/OCMEM/LLCC is disabled on all platforms.

Make it unconditional to save on space.

These caches will not be enabled until the Venus driver can reference
them as chunks of SRAM (they're modelled as separate devices) to avoid
hardcoding magic addresses and rougely accessing the hardware,
bypassing the normal accessors.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c      | 24 ------------------------
 drivers/media/platform/qcom/venus/core.h      |  3 ---
 drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++------
 3 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 1307aa9cf951..43105e765c53 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -562,9 +562,6 @@ static const struct venus_resources msm8916_res = {
 	.clks_num = 3,
 	.max_load = 352800, /* 720p@30 + 1080p@30 */
 	.hfi_version = HFI_VERSION_1XX,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
 	.fwname = "qcom/venus-1.8/venus.mbn",
 };
@@ -595,9 +592,6 @@ static const struct venus_resources msm8996_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 2563200,
 	.hfi_version = HFI_VERSION_3XX,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xddc00000 - 1,
 	.fwname = "qcom/venus-4.2/venus.mbn",
 };
@@ -653,9 +647,6 @@ static const struct venus_resources sdm660_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.cp_start = 0,
 	.cp_size = 0x79000000,
 	.cp_nonpixel_start = 0x1000000,
@@ -702,9 +693,6 @@ static const struct venus_resources sdm845_res = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/venus-5.2/venus.mbn",
 };
@@ -727,9 +715,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
@@ -774,9 +759,6 @@ static const struct venus_resources sc7180_res = {
 	.opp_pmdomain = pd_names_cx,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
@@ -832,9 +814,6 @@ static const struct venus_resources sm8250_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2,
 	.num_vpp_pipes = 4,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
 };
@@ -889,9 +868,6 @@ static const struct venus_resources sc7280_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
-	.vmem_id = VIDC_RESOURCE_NONE,
-	.vmem_size = 0,
-	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
 	.cp_start = 0,
 	.cp_size = 0x25800000,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 22f998637618..b1d0687d294f 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -80,9 +80,6 @@ struct venus_resources {
 	const enum vpu_version vpu_version;
 	const u8 num_vpp_pipes;
 	const u32 max_load;
-	const unsigned int vmem_id;
-	const u32 vmem_size;
-	const u32 vmem_addr;
 	const u32 cp_start;
 	const u32 cp_size;
 	const u32 cp_nonpixel_start;
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index f9437b6412b9..42ff96f71235 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1067,17 +1067,14 @@ static void venus_process_msg_sys_error(struct venus_hfi_device *hdev,
 static irqreturn_t venus_isr_thread(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);
-	const struct venus_resources *res;
 	void *pkt;
 	u32 msg_ret;
 
 	if (!hdev)
 		return IRQ_NONE;
 
-	res = hdev->core->res;
 	pkt = hdev->pkt_buf;
 
-
 	while (!venus_iface_msgq_read(hdev, pkt)) {
 		msg_ret = hfi_process_msg_packet(core, pkt);
 		switch (msg_ret) {
@@ -1085,9 +1082,10 @@ static irqreturn_t venus_isr_thread(struct venus_core *core)
 			venus_process_msg_sys_error(hdev, pkt);
 			break;
 		case HFI_MSG_SYS_INIT:
-			venus_hfi_core_set_resource(core, res->vmem_id,
-						    res->vmem_size,
-						    res->vmem_addr,
+			/* Disable OCMEM/VMEM unconditionally until support is added */
+			venus_hfi_core_set_resource(core, VIDC_RESOURCE_NONE,
+						    0,
+						    0,
 						    hdev);
 			break;
 		case HFI_MSG_SYS_RELEASE_RESOURCE:

From patchwork Fri Feb  9 21:09:55 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551856
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB0A3D562
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.218.41
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513010; cv=none;
 b=Nx/QrF9SOFDRahMaO8/n9j6gB2Qwf3a9MWqfpZJFPdcg0WV8pG8uONV+brS1eGRBakylMUjpuQQ0JqVprKCcgmDGhG7ujHiiFQ9zOF9QbVtoju9+HxbVIHGFUmzDUNYrWJrHGM+94wjln2/JUQMuUXhtTnwEl27FjfNZ4PgJXnM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513010; c=relaxed/simple;
	bh=jT4cYVE3H7d20Q/uwPs8NimA9d74CuArTIfCuOqGfSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=MdtOY9NPh4FTpXwH/RRmzC+ONQra/As2Mn4m29I0zJ3echM9OwDvbAvRUp94fPqJIPENaFJR4zHWsqkVmekbSai+MXJd1sHdMWLPeHx9OY0+wU4aZKnmqu8CFQdbQK+Ht0eMsc7teCsCX6hJ7J5qkpw4m1F4xPghOktZFFUI0zA=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=dwUObXyk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="dwUObXyk"
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-a30e445602cso482881166b.0
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513007; x=1708117807;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkisGcwj7EZsB2uxQJKfFxLa5Zz/RB1HixKJSSlCEXg=;
        b=dwUObXykmmsUQFUV7bkwhGtWVRvqLux/q0/d8b6wzBxOieQk9paU81JtAnXTQRJo1P
         fAjqLlTX8YQaTzFzsc1kAB+Tnr2wB3qvR80qNQCPtFewHTpph6E8EuDkIjC3Pzj5y4h8
         6xTHvaTjJwN1X+EhIThDPu411XsrCvGHZfvQpBphoHTFdv0qNdWHwHOWsLjBqMXmEMIb
         uj0gE82cN3TnrwEqK/8BXP0B6LMR3w8pK5JbrGIkMmRRUI8QKWUg2hKB7Unm3cyHnl1O
         3eo9Gxw0eVjccEq2hCLYNrQlDxaMmc8NebRrLWywi8By68+as04orn5PRzd0ynzNGQEz
         8+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513007; x=1708117807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkisGcwj7EZsB2uxQJKfFxLa5Zz/RB1HixKJSSlCEXg=;
        b=KPn8Zan+XRz3NY7AuVx9YzJ9ghdKh9I9lCz0rKTylVUVrb7OoVfRkSFJR/4cy9Yy2M
         ux1RyzwEv5Mk/DVE9LI9Wq7Uk0j032SoMEZKFtQsrY3R/gPPztKaEcdfoM6NNiJ1jspj
         yeq1df2JoyR+4UVFl3xUM34W2CaWhuIWqPbur83XHRLYgA076gcKJafArFIoaczQ/Wuq
         OkDI4YsXBdvQRkPn9YI75gGRGuAChvpTcZnxgoxeRFP+BZeTNeeWy/sZ5p6rvKRJEuuR
         BdJ1l6it9HnYDNFhSFW8wmQC71Swiq2lJ4SeZMY6382HUXAk8sgxgKcMiQUpAeHhKyPX
         kCuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrl1j8VnPdnmhh4j39n8lr4zWxNbRr9r52I24qnKZbA89S9vQocAxiU6+ddcXSaOLPZv7Zut8Q/JXx4E+DSCXlrgqxWqVZHNgD15Y=
X-Gm-Message-State: AOJu0YwTEx8BFRp+4210XV9l2FMl5gIuKMNdWvxxVZtz1lbBSWcIi7GL
	Qi8ap3dCLQQSw73Dz8Eeyr3CAo4PRLjFTsXZX3vrfsyAjL5uISOlorEQEnGUNBY=
X-Google-Smtp-Source: 
 AGHT+IEV2H34ApePMZXUbaCjKh72AuWAiuYiRsbsouxJ+9ihBWWmei4quy45Vg8EiBRX+XstRPX3xA==
X-Received: by 2002:a17:906:370e:b0:a38:4f6a:4e7e with SMTP id
 d14-20020a170906370e00b00a384f6a4e7emr261180ejc.32.1707513007230;
        Fri, 09 Feb 2024 13:10:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU8qP6K965v6pwV2jGGur2yfOhYX9UkKJcDNbPkJzFLgrzHOvxp4AoTJa1Sm2nuKXPyws3QTpEbCik7ElfeFzX8DpIFvy7t/WA9HOiswLIl/qkqtiKoYF2gcILrvpHx/xVIJXIHc2omny6cad7YDa4lU1pFwu2gLejfRKaDfgO2WrM+kXvBtffyKLFMn4+UhX9m7lMJifL7mV+epibggxhqbXS/ZUi7S5EsOPGARKkJ2h7ItEXSGz0nPY1p1ROdMLhh0AU1bkR64tlfzcxJCz4BRio0toD6xBbx7db3x7/+XssoI+Ob3FxoXBbJH9S+p+CY12XJIZbPiDrz2pdAdDTQFtnTqDVajRJv81Cu4HgjZt1JKa5MQxbXUsyFNnv3hcUdaeNHg3FyfptLlleBOmTRBRf4VxvKJyke7E78hrMQvNGKIu7iD26ymC/uBfecI7MCKBmC0KSUPwQl+otnxMLWCb7M3xoVnV8Jb1sZ9cFLoyjJcNJCqJDmmVlvRiNxtpQjRQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:06 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:55 +0100
Subject: [PATCH v2 11/20] media: venus: core: Use GENMASK for dma_mask
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-11-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=2706;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=jT4cYVE3H7d20Q/uwPs8NimA9d74CuArTIfCuOqGfSo=;
 b=klquj+6pOLak7Axq6ddq02Jht/IyRARYQgLefOrwlb581p4+JvxIEmi6OHz6/y61S/0AJX91F
 bZPG5shtVjqAhAAVOPKTlhsk+dNJHgvmzrbytoDKJ43RPIJf1MukBPz
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The raw literals mean very little. Substitute it with more telling
bitops macros.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 43105e765c53..06b78e98cebd 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -562,7 +562,7 @@ static const struct venus_resources msm8916_res = {
 	.clks_num = 3,
 	.max_load = 352800, /* 720p@30 + 1080p@30 */
 	.hfi_version = HFI_VERSION_1XX,
-	.dma_mask = 0xddc00000 - 1,
+	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
 	.fwname = "qcom/venus-1.8/venus.mbn",
 };
 
@@ -592,7 +592,7 @@ static const struct venus_resources msm8996_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 2563200,
 	.hfi_version = HFI_VERSION_3XX,
-	.dma_mask = 0xddc00000 - 1,
+	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
 	.fwname = "qcom/venus-4.2/venus.mbn",
 };
 
@@ -693,7 +693,7 @@ static const struct venus_resources sdm845_res = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.fwname = "qcom/venus-5.2/venus.mbn",
 };
 
@@ -715,7 +715,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
@@ -759,7 +759,7 @@ static const struct venus_resources sc7180_res = {
 	.opp_pmdomain = pd_names_cx,
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
@@ -814,7 +814,7 @@ static const struct venus_resources sm8250_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2,
 	.num_vpp_pipes = 4,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
 };
 
@@ -868,7 +868,7 @@ static const struct venus_resources sc7280_res = {
 	.hfi_version = HFI_VERSION_6XX,
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
-	.dma_mask = 0xe0000000 - 1,
+	.dma_mask = GENMASK(31, 29) - 1,
 	.cp_start = 0,
 	.cp_size = 0x25800000,
 	.cp_nonpixel_start = 0x1000000,

From patchwork Fri Feb  9 21:09:56 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551857
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473A33DB89
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.167.43
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513013; cv=none;
 b=K84IBVFUYpcoLSie79yQZVpJsdK7gmF/Ys3jM090SWIJZ0Gup/9YBl7IF9whjo43bgDB/CrVIzW3yRxQDCnxy1WuBKU36V1rdwdumHm4H0KCSkFhUpFe9YcGllf4XJIcNFOfzHznOLsaso1wX6/sz9fetq3iK9g+1oe4qkaLPKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513013; c=relaxed/simple;
	bh=/kFnbapgubNRtfX1KEblqNgRWZdEMPDSWK83uPCG7ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=Sgv0yKvXQhLazbNegipbCzA7xVOa4y2A5aCJsGJG1M0wWOoHXpRlWG/f35HQ15/k5b+LGr7nxz85SkSRKUnCycw2D+n0yKeQ4/pJtybR2u8fTGW//GN0BcDzgquGl3UyLyt1tsgvUxfyuzMcM9B8S5iZaD9SXLPwGdmeZ702veQ=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=qC+7pgNL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="qC+7pgNL"
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-511616b73ddso2311984e87.0
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513009; x=1708117809;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8GIqzjr5F0muhdfu+nSlnTYCrXU9jfYOiTVyQ6Sb9U=;
        b=qC+7pgNL2hqTjlyL0taRYFtGe700EWUItg4BXiyX93XWpv1eemsCeLdlJrWgk1WA+y
         B+yXAwliaTjSYMldnkhxlAZWZjzDCIIE9zohzoAXL3ibCGXhlpjNtHdY/AujqE/g779l
         qZSifBUe5tFfLm9eIiNUqvfr5DrFzDbATFcFrvRGVc1abnBwdKzNVEqKTeX0NRfctXdu
         ds5jtJcw+jJ2Pc208J3tv7k4mrR8PrasoWlwQYbg600B3gWxXWr5Wgx2G1A5BeV2TYMZ
         KEdh3B6Gf3KssYdELpBDWlb0f8jH4kviPjRS0tEEEFhb9EaTl2E0vlWTF9sZZgh/heMN
         uGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513009; x=1708117809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8GIqzjr5F0muhdfu+nSlnTYCrXU9jfYOiTVyQ6Sb9U=;
        b=M/4/UHYcrY12orD774/mmrzv6HniMSWB1B3ZNUfZK9EoG9k20lIQ4T8yFHijikR5vj
         pw94WQ006wIwpm0h6At37QyHBFNHvEG6S0w5RqrVk46dmdtuAMmA4B9X8uGBOb4aRP8j
         3R3PDIO0DN6yhKr7Psr9QgqaI0NJ7Ei7P3uNF1HGkDw2JDR2KCO7PANEeDNvcg53V6MP
         h0aCDcdOTr4uhFbI50axB1KYUQiIiQ6KyuryqvEfd4k+eYE99Yi/SYD6YsGe5PRQZ6lc
         WkbWuY+g0DqATDk8hAZnMmhMWWIKDZ8CALNOHaoi36q6GNkn4TwQZEf70Bq0OVPg3rgY
         Y66w==
X-Gm-Message-State: AOJu0Yzz0djQe9LpencLC2PSILKLv3sCnEhpFKNfI9GRjiWXVpFRB08E
	yUOAOCjJQUqyiqEKVjc0AMKo88iotR2DXDNvhixSD8wvToYdHgU6H15Lf2QfCt4=
X-Google-Smtp-Source: 
 AGHT+IFXV3KzQwy58rEP2blWOY14Ikqpib0euEGzIkKjV/J4kBP2N2s4twAQCqgmVWtRV1Jq+SXPXg==
X-Received: by 2002:a19:ee09:0:b0:511:494b:c483 with SMTP id
 g9-20020a19ee09000000b00511494bc483mr118496lfb.31.1707513009461;
        Fri, 09 Feb 2024 13:10:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVoFd23U02RRkhlYViO40gpOFYMCnq7G/cfZ0MZFVFnjHbrNv11wygCqcW+U/f8KFUpjBx8RaHsNERMwGIRWJp00rpzbtxi/MNYPSQ4wpHFIB3hbnIhJV24O7JbN6XT1T31RFaQoOfbb9R6/68uiw/yMqH+EzS2WlOygEGsAqUefY/p1v44PW/dffgdwVqQ3A6UxiQdBHJEmTzMoB0UtYruPdqOTc2UPWbL6vPL8LtalR2mukGZorQ9XUzi01PNhup3ZLlXhCu72g+hbZc33Fc9aDf7AaVjg9vEErr/gxJAPOudKqQuYm/fyItv2AD3F1E4pPWuLF0sXmf3hGEttM/6H5RuHQGr9QaYdDt2nvaUelta2QAhWDU91EiuRf3YNpz7NpEFKUW8nydd9BI73GVchzYddFVga0iRPlA/U8vbF8Zzea8FNvAzkiyyG6RFmNsJkf6BHzmafw9IQ+ts5GE+eSohjm6pWNqBjacWVBDzkarqcoIl215LF6Y1kpG+yabohg==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:08 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:56 +0100
Subject: [PATCH v2 12/20] media: venus: core: Remove cp_start
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-12-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=3274;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/kFnbapgubNRtfX1KEblqNgRWZdEMPDSWK83uPCG7ls=;
 b=XjNO/TzZnniFSFa+959SHOc3p3ge3qqR+DGSwZyLfroBs3WCkm3oMoczUsS1gsC6BlPMDBGTZ
 xYIgwPIWAcrCFu2HvHqfMCDbLcyvH6GxscR+pstT5S2CYm526//SOmR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

It's hardcoded to be zero. Always. Ever since msm-3.10. Or maybe
even before. Remove it!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c     | 4 ----
 drivers/media/platform/qcom/venus/core.h     | 1 -
 drivers/media/platform/qcom/venus/firmware.c | 3 +--
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 06b78e98cebd..65a9e815e6ba 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -647,7 +647,6 @@ static const struct venus_resources sdm660_res = {
 	.vcodec_clks_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
-	.cp_start = 0,
 	.cp_size = 0x79000000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x28000000,
@@ -716,7 +715,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
 	.dma_mask = GENMASK(31, 29) - 1,
-	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
@@ -760,7 +758,6 @@ static const struct venus_resources sc7180_res = {
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
 	.dma_mask = GENMASK(31, 29) - 1,
-	.cp_start = 0,
 	.cp_size = 0x70800000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
@@ -869,7 +866,6 @@ static const struct venus_resources sc7280_res = {
 	.vpu_version = VPU_VERSION_IRIS2_1,
 	.num_vpp_pipes = 1,
 	.dma_mask = GENMASK(31, 29) - 1,
-	.cp_start = 0,
 	.cp_size = 0x25800000,
 	.cp_nonpixel_start = 0x1000000,
 	.cp_nonpixel_size = 0x24800000,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index b1d0687d294f..9dacf533c7ad 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -80,7 +80,6 @@ struct venus_resources {
 	const enum vpu_version vpu_version;
 	const u8 num_vpp_pipes;
 	const u32 max_load;
-	const u32 cp_start;
 	const u32 cp_size;
 	const u32 cp_nonpixel_start;
 	const u32 cp_nonpixel_size;
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index fe7da2b30482..16e578780be7 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -245,7 +245,6 @@ int venus_boot(struct venus_core *core)
 	if (core->use_tz && res->cp_size) {
 		/*
 		 * Clues for porting using downstream data:
-		 * cp_start = 0
 		 * cp_size = venus_ns/virtual-addr-pool[0] - yes, address and not size!
 		 *   This works, as the non-secure context bank is placed
 		 *   contiguously right after the Content Protection region.
@@ -253,7 +252,7 @@ int venus_boot(struct venus_core *core)
 		 * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
 		 * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
 		 */
-		ret = qcom_scm_mem_protect_video_var(res->cp_start,
+		ret = qcom_scm_mem_protect_video_var(0,
 						     res->cp_size,
 						     res->cp_nonpixel_start,
 						     res->cp_nonpixel_size);

From patchwork Fri Feb  9 21:09:57 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551858
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9022318
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.208.54
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513014; cv=none;
 b=oI1aLmMx18KjO69Z+NUtGlN3IbiLoD0cFMxV1tGoANeKqu9px7UAnsaiS/YuSeiSAQYHp0PiBVXkMGoboVORs3DAUa+2fR+6xOVEabUB+9Aa+m1WgLTyY7hAiyuyrjBhZurgv5ySBT+XiMG7Jse0PWr0a+zSM2Pb26e6/+WwWRI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513014; c=relaxed/simple;
	bh=cRJFudcjiVCid3coXRofqspzGAz6z91Bv4pWpCaIiXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=Tlqol2gwPwTa5Z//P7KjJOU2EVG0EBvIO8ZYQZf/dNekqYdG90/wqMtl57Gdoja5PPQWh6EMgQPyRfBxKvbB5/TruaTsQZYgQQQ5Pz21mjcW8UyXkIK7Hb1HgjJbxuKlBy7W1woucXD/ZY7DTWXBLRJjHshI4K32XTkCeThgfT0=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=muEh7yp+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="muEh7yp+"
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so2056256a12.3
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513011; x=1708117811;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iccq4TLkD2INMIlTDHQm1CqNTexDcalE2BlNeCgcoHc=;
        b=muEh7yp+19Fs+uwZ4bkIp/VzhZNMezF68BS7wde47Bes3VKO5ZJShZuBjnx4z/GJ3I
         t8r5v39JqnujYb9EVwZyTDoGDeecL/UtlVcoQ/fIni6dx3BdhaYNsdTGKpbkxtQKubO9
         pas8sVrP8hcleZmulTLf9f+4wRi/NIHLkGfETlD/vcuEDpD5gmkOCOTxd0amRxLkE4z2
         oyZdetV0hWbXURKqWoDYRcRHmBsOV0fEpJvaYZHK1V5q+xdoGEvV/BKO7sWx0ci+setV
         d9pQDb2CiBCbjuPp86O7UkG1R7khZv4JB3nhhh0vwYtHoq7jDh1oKyCcTqjCqnX5cz0l
         Va1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513011; x=1708117811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iccq4TLkD2INMIlTDHQm1CqNTexDcalE2BlNeCgcoHc=;
        b=T7sfdTXzKBe4nGPivcUbaHBOG2YALkHm5xAlmGqz7HuTNg2QZzlyno7tUnyHQDqpv2
         QTp4/AJlRqk1465BhonsvJiRKQ8nX8Z94fcZB6WVQgov3e0qfETogyA8ID9qYwHT2mHN
         suWj8ZbGDSo9cI5tXicpsP+zGshUl1oOSO0PwsDwfycwbv9TUaReav8tHxB+2JX2mYV+
         q8u4Dgv3gRcqgsGgTx+2EkhayFm3NsbQpDKZllWciAp7qRz+0CTxpTUzcVokF7+vf/LS
         ulzDnBZU6bamed+wM1UPXEPQUUP5MDgqceWh30vt9wgWcODJ1v0x76lUt9GjXSOp4FnL
         cvKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIYKskTmwr7gUUSd2C9KQSur4ffWUkh1p6lmULecKhzuLjhlmUl2cD8pyilyyCkHohQIz4kDn9iXB1YulP57UeKsarCTRZmsEmKIU=
X-Gm-Message-State: AOJu0Yw3vwdz+lVjdowiYh4+cFvzH10pQOYfqtCEDok6yRbThm66NhoN
	R8YYKyqUUUgwXBkLkspsq5oD6TZSaOs5kc4EZLNYyxXeb66x3OfZ/VbRX4IWNbs=
X-Google-Smtp-Source: 
 AGHT+IHQrwh3QgO0B80ohQ/feL+Ziyk/NNIeHQJ6OozwsSXAR9tc91e1mwCH5spPUXxac7RB7wLCXw==
X-Received: by 2002:a17:906:f852:b0:a35:51b1:c757 with SMTP id
 ks18-20020a170906f85200b00a3551b1c757mr163298ejb.38.1707513011223;
        Fri, 09 Feb 2024 13:10:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXSMjZ577S4cYpw9sK3vDrzwI4sb0ibwgH3xKyPnCukwZ320+J3WCX8vKTo40BzOk56wHZMH1SiFTxHLcrt3Hkn0KB9hdlFBRYf0+5sBamiW7p6FijqIUNjnRwOyzTIbNhBOBzF1lXgYesYuCjRgh3Bhwhdl52a5P6GDX43jddN8dgq/iXA0BWMlrUBuwbp8bNWxdt26Kz9qVv+uhEOc3XYy5ywnVR9cqTdaLRNovUPhGnwfPbXwSjh3gPK9RebDoBSsRWWDnYE3+qtkx4+rKq0IwEVHiKb9WIGaWGsiWkGCk6I3z3GtMRpPLmrQPbjxGd+MUU1wOiIg1ICRaAW+azRrGfB0dvpn+4EX29dqXlzujAB+D3tMKNvLTsgp1qtDLZrxt5X1Dvg3Rt6AIX/PrbNhT8JTX7YbhjGrznkQy/oeVIM3smo8SAOafzARaEcdy+XsaPSBZQ0MeuSeK2AcH+9fEJRzqUnOx4JKgHQtw9wg9dKKo9nK2Xk3hvvL08kq34aYw==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:10 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:57 +0100
Subject: [PATCH v2 13/20] media: venus: pm_helpers: Commonize core_power
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-13-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=4717;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cRJFudcjiVCid3coXRofqspzGAz6z91Bv4pWpCaIiXM=;
 b=Rc3oc6RfokYXBJk1f5VshwRPBBeVoH5ZYiZDI19mfIPuqHWUxAWGIJErO/N+kVzj5BpiRntlt
 hUdU68VY56RCM8bGHaW3bzgZxssatAJDZqV9XedjWazYriDhONQhN9g
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

core_power_v4 called with num_resets = 0 and core->pmdomains[0] == NULL
does exactly the same thing as core_power_v1. Unify them!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       | 21 +++++++--------------
 drivers/media/platform/qcom/venus/pm_helpers.c | 17 +----------------
 drivers/media/platform/qcom/venus/pm_helpers.h |  2 +-
 3 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 65a9e815e6ba..9bfd2a30084b 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -477,18 +477,15 @@ static void venus_core_shutdown(struct platform_device *pdev)
 static __maybe_unused int venus_runtime_suspend(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
-	const struct venus_pm_ops *pm_ops = core->pm_ops;
 	int ret;
 
 	ret = hfi_core_suspend(core);
 	if (ret)
 		return ret;
 
-	if (pm_ops->core_power) {
-		ret = pm_ops->core_power(core, POWER_OFF);
-		if (ret)
-			return ret;
-	}
+	ret = venus_core_power(core, POWER_OFF);
+	if (ret)
+		return ret;
 
 	ret = icc_set_bw(core->cpucfg_path, 0, 0);
 	if (ret)
@@ -503,8 +500,7 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
 err_video_path:
 	icc_set_bw(core->cpucfg_path, kbps_to_icc(1000), 0);
 err_cpucfg_path:
-	if (pm_ops->core_power)
-		pm_ops->core_power(core, POWER_ON);
+	venus_core_power(core, POWER_ON);
 
 	return ret;
 }
@@ -512,7 +508,6 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
 static __maybe_unused int venus_runtime_resume(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
-	const struct venus_pm_ops *pm_ops = core->pm_ops;
 	int ret;
 
 	ret = icc_set_bw(core->video_path, kbps_to_icc(20000), 0);
@@ -523,11 +518,9 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (pm_ops->core_power) {
-		ret = pm_ops->core_power(core, POWER_ON);
-		if (ret)
-			return ret;
-	}
+	ret = venus_core_power(core, POWER_ON);
+	if (ret)
+		return ret;
 
 	return hfi_core_resume(core, false);
 }
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 8412deb68ed1..6f6de9ef1c6c 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -322,22 +322,9 @@ static void core_put_v1(struct venus_core *core)
 {
 }
 
-static int core_power_v1(struct venus_core *core, int on)
-{
-	int ret = 0;
-
-	if (on == POWER_ON)
-		ret = core_clks_enable(core);
-	else
-		core_clks_disable(core);
-
-	return ret;
-}
-
 static const struct venus_pm_ops pm_ops_v1 = {
 	.core_get = venus_clks_get,
 	.core_put = core_put_v1,
-	.core_power = core_power_v1,
 	.load_scale = load_scale_v1,
 };
 
@@ -410,7 +397,6 @@ static int venc_power_v3(struct device *dev, int on)
 static const struct venus_pm_ops pm_ops_v3 = {
 	.core_get = venus_clks_get,
 	.core_put = core_put_v1,
-	.core_power = core_power_v1,
 	.vdec_get = vdec_get_v3,
 	.vdec_power = vdec_power_v3,
 	.venc_get = venc_get_v3,
@@ -990,7 +976,7 @@ static void core_put_v4(struct venus_core *core)
 	vcodec_domains_put(core);
 }
 
-static int core_power_v4(struct venus_core *core, int on)
+int venus_core_power(struct venus_core *core, int on)
 {
 	struct device *dev = core->dev;
 	struct device *pmctrl = core->pmdomains ?
@@ -1138,7 +1124,6 @@ static int load_scale_v4(struct venus_inst *inst)
 static const struct venus_pm_ops pm_ops_v4 = {
 	.core_get = core_get_v4,
 	.core_put = core_put_v4,
-	.core_power = core_power_v4,
 	.vdec_get = vdec_get_v4,
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
index a492c50c5543..77db940a265c 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.h
+++ b/drivers/media/platform/qcom/venus/pm_helpers.h
@@ -12,7 +12,6 @@ struct venus_core;
 struct venus_pm_ops {
 	int (*core_get)(struct venus_core *core);
 	void (*core_put)(struct venus_core *core);
-	int (*core_power)(struct venus_core *core, int on);
 
 	int (*vdec_get)(struct device *dev);
 	void (*vdec_put)(struct device *dev);
@@ -28,6 +27,7 @@ struct venus_pm_ops {
 };
 
 const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
+int venus_core_power(struct venus_core *core, int on);
 
 static inline int venus_pm_load_scale(struct venus_inst *inst)
 {

From patchwork Fri Feb  9 21:09:58 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551859
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D73EA72
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.208.45
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513016; cv=none;
 b=bnjmnHCMOdqly7dKKUzz4JjvkTkrn29VpRwzfxguGKe3EpVcipS41r5c2hrtmNHi0GX93NoM/Lww2TteSgx5lRMn5qlSMxkdxhYTtjSvKUD5HCzmwaDQ17YNLoLneUwlGk5JAKbzVSvNOhRhu8LCLG1CiMtDkGFZ4F/0+Ik9uzU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513016; c=relaxed/simple;
	bh=G5EO8gWb7PxJbJwYQwPoc5ia4Xy6TP/ueMeizK0hDu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=ZFMPFiJHr0sDj4yg0DTOUFOZGHMgAmuwi6AsHI8YwQGWy1/lva/WisSKxrBT8q0D89EjDpZWZ7VyN4ypL9Hy8T3r18F4+A20Q5oDfgNRRI3mqbTctSwplbFuu5QI2a8C3cdP7KCOueTsRgTsVe7WGdCglYsVeVRn1Mp2HNzUluU=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=cn7qBBSD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="cn7qBBSD"
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-55ff5f6a610so1711145a12.3
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513013; x=1708117813;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uywZaJdRGJQ/k/o6qaBHiBl9Wlir0Y5jv/s44rCrnpY=;
        b=cn7qBBSDSfsoiXtBt9BWwA1MHvviYCjd7ttFYCdkt8EqMzsOnnxvWiLty0+WORYRHt
         5wo/1w1Ak1U8/sKE+PM2skay4qByNneUvAkxzJRxH357U0NhqnP0zR+xAe/O6yRZ5dCO
         lvQIO8vN2W3D+E8qI9AGztM8poRk3eda9ATirAvQCW8REP53uCClT1Tx+pRoXvGe6nDf
         YQ+U3rw0iHDkvG16ND5XtEBKu6Dz6bKJ2Eopdkm/kp7oLGEoILNFhel7CKOWLynubsE9
         YdNkFMA/dEwUYjKqJjZdzj+wYmcz2jeQwVL90qV/GKPbaLgPkB9eViS8L3X44aanmEyw
         wApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513013; x=1708117813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uywZaJdRGJQ/k/o6qaBHiBl9Wlir0Y5jv/s44rCrnpY=;
        b=VRM3FbEZWlZv6/dkbb0/HrIVh0ZUB10pfFpb45jcxhLKC0rc7JSyK5W5wlX3qZOxqT
         XU0SmzlhbISKrLkKrWL45v3lMnyknZwWvqFIKARb+O6Gl5wWm6qPoeYW8zd2i50T3ZFD
         DLVwScRPgSCJKrezCMoSz9ksCdc7HWq2EBY1vB0M9AdIsCGWPxgJctbaH3vRPHvDgIdJ
         ItvHkciC2/QJ9I2zVdopf/bz6kMqA201yHRCy7uXPfQBFy75UWQ4Y2kNtn9FxXqqyVc/
         1AoXhfqO/hblrK15OHONkeRVvocoGCtHM2E64tBC0RIQ7NkMggl8nrxPMTci33OUjS0m
         t/cw==
X-Gm-Message-State: AOJu0YzqEx0j+3M7T1+AqLcorRyf3h1LXnKU5Vqixj+S0EFOErd1db29
	qdz6sOJHiM7kUP6+nSkR+VCICR+/nk32MHaSZXT/cfooNWWBppJLUucFpDrL73Y=
X-Google-Smtp-Source: 
 AGHT+IFn4UUhkMKr556qFtgiQPsWQOzew24VLWvkaMqAGckTpyTqicd+NyFDWeWRm+x5K4RXMlZOcA==
X-Received: by 2002:a17:906:b304:b0:a38:9923:46da with SMTP id
 n4-20020a170906b30400b00a38992346damr194119ejz.20.1707513012869;
        Fri, 09 Feb 2024 13:10:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVcC8MslwCJOOVb9rJmnm0MZ2MoASz2q+jc9yEqSbOh4sNAR7mXF/oM6qCXwZuNEgfrAzrCA/JicbhOvX1C66ls1jpoIuyNRSF7QEeRju+3XOXLOSBG2jD1/zSnkHCWgi4ToV3H6d3uGIPXqs9Zq3wXGD5AhYfF2HCQea3GG64pKi5ec3KSosDA+jYzyMlarDmd2zRYMlEonbueGPGPsj/+7YRGExvrpPj/uTcgTPUnmfgJpFPLP3MVsqt2VwfIrfF/64ZMu9xesnHssBU2o4M18PA7XkjknRnrkEKs8Zak5+kzMyT5FhES5bGPX9My2t+1j2DTimrZhQCaLPFaesi2/HORWOEolKoMf7eZSo8k/S9GwNWHYwBp0ZbSeXKXcaY+dMZw1MJ903mhhaMI8dml3+QP6cyK3r+IlMbKsr03LTsYE1h6O+NrIXGxJFDxXupIqNVNJcB5dTWa3MtYyG3nyZ7dxyheZtXa/WcmIiVyBVhJ9PdxLzzsMh2SBTHFz6YTvQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:12 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:58 +0100
Subject: [PATCH v2 14/20] media: venus: pm_helpers: Remove pm_ops->core_put
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-14-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=3935;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=G5EO8gWb7PxJbJwYQwPoc5ia4Xy6TP/ueMeizK0hDu8=;
 b=kGDBOVa3MohGI2QSLTtyRG8AUOytaLJKLMXSZvjFq6ciBdgCT8Zd4AytyxxpZbcf5J+ZHekv6
 eYfdYC0lFD/AMfmcNDieZxM+aDTLnoV9bYCQR39NyFi8iuVNmaphXh1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Without an OPP table and with vcodec_pmdomains_num (so, v1, v3 and
sdm845_legacy targets), core_put_v4 is a NOP, jut like core_put_v1.
Unify them!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  8 +++-----
 drivers/media/platform/qcom/venus/pm_helpers.c | 17 +----------------
 drivers/media/platform/qcom/venus/pm_helpers.h |  2 +-
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 9bfd2a30084b..666adc5aac38 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -426,15 +426,14 @@ static int venus_probe(struct platform_device *pdev)
 err_core_deinit:
 	hfi_core_deinit(core, false);
 err_core_put:
-	if (core->pm_ops->core_put)
-		core->pm_ops->core_put(core);
+	vcodec_domains_put(core);
+
 	return ret;
 }
 
 static void venus_remove(struct platform_device *pdev)
 {
 	struct venus_core *core = platform_get_drvdata(pdev);
-	const struct venus_pm_ops *pm_ops = core->pm_ops;
 	struct device *dev = core->dev;
 	int ret;
 
@@ -452,8 +451,7 @@ static void venus_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
-	if (pm_ops->core_put)
-		pm_ops->core_put(core);
+	vcodec_domains_put(core);
 
 	v4l2_device_unregister(&core->v4l2_dev);
 
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 6f6de9ef1c6c..32f9ccfa9d8a 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -318,13 +318,8 @@ static int load_scale_v1(struct venus_inst *inst)
 	return ret;
 }
 
-static void core_put_v1(struct venus_core *core)
-{
-}
-
 static const struct venus_pm_ops pm_ops_v1 = {
 	.core_get = venus_clks_get,
-	.core_put = core_put_v1,
 	.load_scale = load_scale_v1,
 };
 
@@ -396,7 +391,6 @@ static int venc_power_v3(struct device *dev, int on)
 
 static const struct venus_pm_ops pm_ops_v3 = {
 	.core_get = venus_clks_get,
-	.core_put = core_put_v1,
 	.vdec_get = vdec_get_v3,
 	.vdec_power = vdec_power_v3,
 	.venc_get = venc_get_v3,
@@ -893,7 +887,7 @@ static int vcodec_domains_get(struct venus_core *core)
 	return ret;
 }
 
-static void vcodec_domains_put(struct venus_core *core)
+void vcodec_domains_put(struct venus_core *core)
 {
 	dev_pm_domain_detach_list(core->pmdomains);
 
@@ -968,14 +962,6 @@ static int core_get_v4(struct venus_core *core)
 	return 0;
 }
 
-static void core_put_v4(struct venus_core *core)
-{
-	if (legacy_binding)
-		return;
-
-	vcodec_domains_put(core);
-}
-
 int venus_core_power(struct venus_core *core, int on)
 {
 	struct device *dev = core->dev;
@@ -1123,7 +1109,6 @@ static int load_scale_v4(struct venus_inst *inst)
 
 static const struct venus_pm_ops pm_ops_v4 = {
 	.core_get = core_get_v4,
-	.core_put = core_put_v4,
 	.vdec_get = vdec_get_v4,
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
index 77db940a265c..3014b39aa6e3 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.h
+++ b/drivers/media/platform/qcom/venus/pm_helpers.h
@@ -11,7 +11,6 @@ struct venus_core;
 
 struct venus_pm_ops {
 	int (*core_get)(struct venus_core *core);
-	void (*core_put)(struct venus_core *core);
 
 	int (*vdec_get)(struct device *dev);
 	void (*vdec_put)(struct device *dev);
@@ -28,6 +27,7 @@ struct venus_pm_ops {
 
 const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
 int venus_core_power(struct venus_core *core, int on);
+void vcodec_domains_put(struct venus_core *core);
 
 static inline int venus_pm_load_scale(struct venus_inst *inst)
 {

From patchwork Fri Feb  9 21:09:59 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551860
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B73F8FB
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.218.51
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513018; cv=none;
 b=VyhRpzuF/6+Pj++MP9Lv1Uhhh3pgIaiZvwSQxavpdL5gbrhjfObL022lvhqImwFsrgRGlwYDor5q0R+MltcvNjjaaDeW71l3jE/RmdJJXVga9nWJfz52rjXT2VAq8KMHMM205ttbBNEYdTp4nVM3oYAanLGiK7lbq2Iq9k50z0I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513018; c=relaxed/simple;
	bh=SxDGgEUtWHupji3kWcgwRwlcQnOElKd5P7BQasbPYTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=gEXnCfPZGuUjdQjOEKPsxXqbPl8P8IwvASsXkNzMK7lBYH2OahzfI4URyhPW1SC6m6IkeEt6ns8Tu3riRNK7wKksgK1iVfpqNAvJTueB/Btz0ZGQm6xpbqvSoJ46pA8vvCbAeRQIyMMY9Ee6ZMtuYaD1Kk5k3ZRoknxUgpBCeLM=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=KefW0spb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="KefW0spb"
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-a389ea940f1so152515066b.3
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513014; x=1708117814;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SA9Lb59KC+nISC8BTRPiv1Z4bw8dFbjLbRpUOcP2HoY=;
        b=KefW0spbhRtS7VxOPjB3UkOU5CxHOAjIGudtxwHXuAYkdhTR8gOstfZfNsGbfG7wbW
         15hi8QrgAjZDQNKWQTRXQJnfA3JuUfAN/q7L+VzzvXAi2tW9BSWdRp8uuyVtgkyZQjv0
         RQ1G98qHpv9efYPcMTHNit5EsHVwgiU4m8x9X+ui/P/0sJBruTfy/8FDC51yJyVSbLDP
         6NUGVdiu30B8EZaJZnAfEiwO5F9/ihb+HjDhWLVof4FdGdmBSrkfoPsio1f1f3jdm+8q
         E+hXnQdjlhV4e8mYdFWkjJPJtwY75X2ox5j326NJcW/wx7nGE3nWyC9iwyofcFCibeHB
         9wUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513014; x=1708117814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA9Lb59KC+nISC8BTRPiv1Z4bw8dFbjLbRpUOcP2HoY=;
        b=Du8AI3ELTIKuEDmYlqojdZS9uIENkLN8bVD/vj+9KUHDbp6FX9+9kS/str6wLWIFak
         CXqEC0RvbMF5qbIRAddV/cFNvlI96ZaWhL6Jn0Z+mWGTjHrwGBxuBG0LRsY4hHo/mkB8
         pWRN8pBw3mGt6NmTH+WGXWp7yRz9wSP0LhQHBbDR1MjYE7hmAOqZkBhmSYBHHnSM3bZu
         /P+zjIQXwvmtm/LBUO2iGvldVK1N8b1ORJb93tUDAqWIUQ3IAOs9Pisk4WK2mxVQpeZA
         8CUlco+VTE3kYr7qxqBN36F0BlUMEAB2wRaq0TG+OMsy5KhW9sSSGrFYoAcf3aIIVLwJ
         6f5g==
X-Gm-Message-State: AOJu0Yy6aY9Ph7Nlz6rxSeRNhZQoP1VV8rEqDeKdAhf1KRSTCsWPf4wW
	/Ydql2m6iKKwPzXF4VLKPUEb18YnuNTBgyE3DhYRkghEkRgqXd9fNH7cx40vtNc=
X-Google-Smtp-Source: 
 AGHT+IHicqWilmWSII5rZ1Re/aDm6w+5uwDxEUNhIEGKLnMpzX+wfwnWXZUpp5H1cOVgVxUri2sAKw==
X-Received: by 2002:a17:906:3552:b0:a3b:fe76:d666 with SMTP id
 s18-20020a170906355200b00a3bfe76d666mr225304eja.0.1707513014654;
        Fri, 09 Feb 2024 13:10:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU+m0k+l+lLW+83FALDzJXW1dXJI4jsvzqwreFZQ5MH667zVDGstHsy4UTD4EFsHT6dNShE9GcWOjcbij7kGMGJraEryqx+6dkdMAiT1jxCGrK/e8hAsph/JYu4X3WXYix4CiQLvFUyN+P/KelycXipHdG3FonRteFaevQ17ZoVOU2YLTQxKWW8Ts2IBAMzMk19ypMLoXN5iLfJHCBwD6I6R+CTXO2W1oil9DKrhzT8Rw6Ke46Gw584uJOYs4F5kEuqAGdF34w5eUGizX3VFOYngJ10UYzetDoaq9IrRGQsQRM5dVUkULxAZw3evOFVvVlHBmJA8eJj5Y1AsSYz+3JeT56bd45K4+gGFK0hxEv076PGAqukmTP0pyuNg19ehwP6MW4PLSM841Xd3SwAJFfdefnGxVlonOF1fVuZrEJ4NWx7LLYVi9jnfp9VMD8kRqWLTOWkXN1VR/X6EYO5IgNZT96JZmoZeTEJi8XyutDRv3vmyH9YbewVYmzGYF17TpmljQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:14 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:59 +0100
Subject: [PATCH v2 15/20] media: venus: core: Define a pointer to core->res
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-15-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=1808;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SxDGgEUtWHupji3kWcgwRwlcQnOElKd5P7BQasbPYTE=;
 b=JlVCMhjWXh7JcvSS6od2SXkwsAUSLCX2191XVANLu17F3Xf11AmPRtaUq8Hx0hUpKs8M5UI07
 owAZMrHdJIXAPWy19gsvnVrXxeJHsIThsUFMbF9qiw6KLapNOngONvH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

To make the code more concise, define a new variable 'res' pointing to
the abundantly referenced core->res.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 666adc5aac38..70c3c9dc49c6 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -285,6 +285,7 @@ static irqreturn_t venus_isr_thread(int irq, void *dev_id)
 
 static int venus_probe(struct platform_device *pdev)
 {
+	const struct venus_resources *res;
 	struct device *dev = &pdev->dev;
 	struct venus_core *core;
 	int i, ret;
@@ -315,9 +316,11 @@ static int venus_probe(struct platform_device *pdev)
 	if (!core->res)
 		return -ENODEV;
 
+	res = core->res;
+
 	mutex_init(&core->pm_lock);
 
-	core->pm_ops = venus_pm_get(core->res->hfi_version);
+	core->pm_ops = venus_pm_get(res->hfi_version);
 	if (!core->pm_ops)
 		return -ENODEV;
 
@@ -325,8 +328,8 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < core->res->resets_num; i++) {
-		core->resets[i] = devm_reset_control_get_exclusive(dev, core->res->resets[i]);
+	for (i = 0; i < res->resets_num; i++) {
+		core->resets[i] = devm_reset_control_get_exclusive(dev, res->resets[i]);
 		if (IS_ERR(core->resets[i]))
 			return PTR_ERR(core->resets[i]);
 	}
@@ -337,7 +340,7 @@ static int venus_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
+	ret = dma_set_mask_and_coherent(dev, res->dma_mask);
 	if (ret)
 		goto err_core_put;
 

From patchwork Fri Feb  9 21:10:00 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551861
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20803FB3A
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.218.47
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513020; cv=none;
 b=gde1QVv0IZZRIkl4qDyfneDloidIMD7RX70JAdhFogXo1SJAZT+lOKXh/ggxXYABMRLf5HYnpw1CMKzF1UWww/o273e9l9bGDZ1Ft2CqsejvkmLv/BR3wDoUb8NmDRYsM6Qek49yaOCh96RICxVZsWRqpFLgdLWe3Fvg+LcdSw4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513020; c=relaxed/simple;
	bh=vLhLhf+CEVi6B2XJaAnvAcQ3XwKGsnZUrFlDvOw21nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=l2TS9Tv6BPXGv6NUnCih0aA2ToNaG3/pIFYYcv9MEJwcTyFM0Gp+DWlSvN5PTZFXS72/93+GoqOxjE7w1Q4Uq/P2Au1kIDf3UpeyKQPFrW3lfnGVLoXl4judV4wf6u/GJmJW6TcZy9lSg8ZzrxoW78ppht2Rz7T5mLi2mSxxBJk=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=HMfMa83P; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="HMfMa83P"
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-a37721e42feso187695866b.2
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513016; x=1708117816;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhSad/Mk1NEzaN/RVlCN4R2NZvu025BgZXc2rgwW6iI=;
        b=HMfMa83PYqMx0BIGZvxtcPRa5ZcMdQrK4+51LE50p8GJeX+Xj7AkJpOlqGpw/O/eeX
         Wiq4K3cmE1x8jIVSdBaVKJGmohCCwm6v0LyQ2cuZUmurEw5wL0k9kLCWUH/FlhUIlL4a
         Oe0QJ1GC9DWYjhCaQqeVnFVuB5FVNMeMruElscBnitO6q0HKeiqe80p+wG1ire8PQO6F
         3apRw/XohPR4HwOIM7PZ9apxUEFQ7j6XBLFtuVnNLhXFsc5UuNi5WhlxoQjroQLCNWn4
         5ySsoI3q3u8KRGhEmexsYRIDwKfWGDP9JYJOh8yCaDRd4OrA5Y1BGYYpaw3PURn5odAA
         59bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513016; x=1708117816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhSad/Mk1NEzaN/RVlCN4R2NZvu025BgZXc2rgwW6iI=;
        b=IvAKFZworfR+Eu7+f3+gp1aD07ZpRaW4/AF6oQak7KTOynAZrasns5kgpDAidYEQeC
         dT9qeoQN9ztkzeTf7JmfnmWS38HcGzVng1cQNSuWKy9i5YoVGdd0Kew0QrBE8FMKQON2
         xk5FqcSxEL8eZwIqvlO6ZnFDLRtZtts9naRUbVzTo974eRus0s1TEXxz4unesGJef/HF
         3qmEPX8ex9tvRGLXNGtqre17kTfR5pmOPoFwSB46liT8QvYF4kSHBNAKB5zSUvb0xBya
         DHyun+43gAhI9fGBV2YhRyaRccUxq0O2yGJ8WghjvcSp0wxj8BTi9CYtjAbzdguAysDr
         iHLw==
X-Gm-Message-State: AOJu0YzEEbpjh0gS6vt/ar+L494wTsu57OpPFdA7gTdx2lqR4skmNZ8P
	Lpl4J00NySfRm90VgRiI9HCPLHU3yP5QjyymVisj19Ps8ZscRtEv+oVEaKTW1cc=
X-Google-Smtp-Source: 
 AGHT+IHaoS8E2Yl5Y2nX35dslDR7oR8kEXrrgQ46vjBSQOmcY4a0mCH6DnPtBaI5STRI55sWMXL+UQ==
X-Received: by 2002:a17:906:d979:b0:a38:e745:fb88 with SMTP id
 rp25-20020a170906d97900b00a38e745fb88mr142952ejb.57.1707513016407;
        Fri, 09 Feb 2024 13:10:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUNGBejFq5PDzl1+CvKgzrv2X7Us6V5508hFb6FLlOZsW5LQdlbQdebLY9R1CIA29+ENWvT09bsJOaA6W7AZY9WlQZUsUI1KEcQ8r/w2SrumlFFAsM7UYgLLJSD3NoCmm9e9WELz4FCNij85g8Cg6wCPl0/O26bZ0jGNZakACZ+DdVVMDlnMOkFOl1c5gF3Zv9yPmISvu2Y/tUdA5VnagLJiRIRD3qWDadkBr/fvOHcDpqWe/gIZHN9RlL6LjCuhYtzFKRmpt74Dy3Upu7504C6f++WlxsitfdAYEL6eDP8V2VMFVbOi7VhJOih0dvhTd1TrNHEIaW2jC82Htkzia4sn2zxJK2gR6RXdaKKJDfEMtSsKuVR+Dsba8XUZECnTwNmLANouP0ztzrz5TPFcTtD5DM7i1lzuocIkr3BH3aK9eHq2GKwrw1yTKRkEwVMV0j09mURrSxdNOEE3PdDGVzLKW196ZPO/oEyQmVMZFtEe/JKYB0kXWOUjKGqnM5J/KSKrg==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:15 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:10:00 +0100
Subject: [PATCH v2 16/20] media: venus: pm_helpers: Simplify vcodec clock
 handling
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-16-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=13452;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vLhLhf+CEVi6B2XJaAnvAcQ3XwKGsnZUrFlDvOw21nc=;
 b=yhMc+HUWGyogB5zChvw1fSFjZ32bTQVH+w4auxc+uJf6IdWacMSVM3VvwjxoaKTVSEd7ZaVfJ
 giBWMyzn9ndDfdFOMGLfjjUnU86vMCSyjWD0yhXVsF/aRloJaE4DQT3
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently the infrastructure is set up for vast expandability, but
it's far too complex for what is just 0-2 clocks. Categorize the
clocks and simplify their getting.

One notable change is that vcodec clocks are switched to use
devm_clk_get_optional, which will let us commonize the code further
while leaving the burden of figuring out which SoCs need codec-specific
clocks and which don't to the bindings checker.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  18 ----
 drivers/media/platform/qcom/venus/core.h       |   9 +-
 drivers/media/platform/qcom/venus/pm_helpers.c | 129 +++++++++++++------------
 3 files changed, 69 insertions(+), 87 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 70c3c9dc49c6..680674dd0d68 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -581,9 +581,6 @@ static const struct venus_resources msm8996_res = {
 	.reg_tbl_size = ARRAY_SIZE(msm8996_reg_preset),
 	.clks = {"core", "iface", "bus", "mbus" },
 	.clks_num = 4,
-	.vcodec0_clks = { "core" },
-	.vcodec1_clks = { "core" },
-	.vcodec_clks_num = 1,
 	.max_load = 2563200,
 	.hfi_version = HFI_VERSION_3XX,
 	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
@@ -636,9 +633,6 @@ static const struct venus_resources sdm660_res = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm660_bw_table_dec),
 	.clks = {"core", "iface", "bus", "bus_throttle" },
 	.clks_num = 4,
-	.vcodec0_clks = { "vcodec0_core" },
-	.vcodec1_clks = { "vcodec0_core" },
-	.vcodec_clks_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
 	.cp_size = 0x79000000,
@@ -680,9 +674,6 @@ static const struct venus_resources sdm845_res = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
-	.vcodec0_clks = { "core", "bus" },
-	.vcodec1_clks = { "core", "bus" },
-	.vcodec_clks_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -699,9 +690,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
-	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
-	.vcodec1_clks = { "vcodec1_core", "vcodec1_bus" },
-	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = pd_names_cx,
@@ -744,8 +732,6 @@ static const struct venus_resources sc7180_res = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sc7180_bw_table_dec),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
-	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
-	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
@@ -796,8 +782,6 @@ static const struct venus_resources sm8250_res = {
 	.clks_num = 2,
 	.resets = { "bus", "core" },
 	.resets_num = 2,
-	.vcodec0_clks = { "vcodec0_core" },
-	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_mx,
@@ -851,8 +835,6 @@ static const struct venus_resources sc7280_res = {
 	.ubwc_conf = &sc7280_ubwc_config,
 	.clks = {"core", "bus", "iface"},
 	.clks_num = 3,
-	.vcodec0_clks = {"vcodec_core", "vcodec_bus"},
-	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 9dacf533c7ad..6ecaa3e38cac 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -24,9 +24,10 @@
 #define VDBGFW	"VenusFW  : "
 
 #define VIDC_CLKS_NUM_MAX		4
-#define VIDC_VCODEC_CLKS_NUM_MAX	2
 #define VIDC_RESETS_NUM_MAX		2
 
+#define MAX_NUM_VCODECS			2
+
 extern int venus_fw_debug;
 
 struct freq_tbl {
@@ -68,8 +69,6 @@ struct venus_resources {
 	const struct hfi_ubwc_config * const ubwc_conf;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
 	const unsigned int clks_num;
-	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
-	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	const unsigned int vcodec_clks_num;
 	const char * const *vcodec_pmdomains;
 	const unsigned int vcodec_pmdomains_num;
@@ -176,8 +175,8 @@ struct venus_core {
 	void __iomem *aon_base;
 	int irq;
 	struct clk *clks[VIDC_CLKS_NUM_MAX];
-	struct clk *vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
-	struct clk *vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
+	struct clk *vcodec_core_clks[MAX_NUM_VCODECS];
+	struct clk *vcodec_bus_clks[MAX_NUM_VCODECS];
 	struct icc_path *video_path;
 	struct icc_path *cpucfg_path;
 	bool has_opp_table;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 32f9ccfa9d8a..a292c788ffba 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -110,67 +110,74 @@ static void core_clks_disable(struct venus_core *core)
 
 static int core_clks_set_rate(struct venus_core *core, unsigned long freq)
 {
-	int ret;
+	int i, ret;
 
 	ret = dev_pm_opp_set_rate(core->dev, freq);
 	if (ret)
 		return ret;
 
-	ret = clk_set_rate(core->vcodec0_clks[0], freq);
-	if (ret)
-		return ret;
-
-	ret = clk_set_rate(core->vcodec1_clks[0], freq);
-	if (ret)
-		return ret;
+	for (i = 0; i < MAX_NUM_VCODECS; i++) {
+		ret = clk_set_rate(core->vcodec_core_clks[i], freq);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
 
-static int vcodec_clks_get(struct venus_core *core, struct device *dev,
-			   struct clk **clks, const char * const *id)
+static int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i;
+	char buf[13] = { 0 }; /* vcodecX_core\0 */
 
-	for (i = 0; i < res->vcodec_clks_num; i++) {
-		if (!id[i])
-			continue;
-		clks[i] = devm_clk_get(dev, id[i]);
-		if (IS_ERR(clks[i]))
-			return PTR_ERR(clks[i]);
+	/* Best we can do is 2 cores */
+	if (id > MAX_NUM_VCODECS - 1) {
+		dev_err(dev, "Got impossible vcodec id %u\n", id);
+		return -EINVAL;
+	};
+
+	snprintf(buf, sizeof(buf), "vcodec%u_core", id);
+
+	/* First try the non-legacy name */
+	core->vcodec_core_clks[id] = devm_clk_get_optional(dev, buf);
+	if (IS_ERR(core->vcodec_core_clks[id])) {
+		/* Try again, with the legacy name */
+		core->vcodec_core_clks[id] = devm_clk_get_optional(dev, "core");
+		if (IS_ERR(core->vcodec_core_clks[id]))
+			return PTR_ERR(core->vcodec_core_clks[id]);
+	}
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), "vcodec%u_bus", id);
+
+	core->vcodec_bus_clks[id] = devm_clk_get_optional(dev, buf);
+	if (IS_ERR(core->vcodec_bus_clks[id])) {
+		core->vcodec_bus_clks[id] = devm_clk_get_optional(dev, "bus");
+		if (IS_ERR(core->vcodec_bus_clks[id]))
+			return PTR_ERR(core->vcodec_bus_clks[id]);
 	}
 
 	return 0;
 }
 
-static int vcodec_clks_enable(struct venus_core *core, struct clk **clks)
+static int vcodec_clks_enable(struct venus_core *core, u8 id)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i;
 	int ret;
 
-	for (i = 0; i < res->vcodec_clks_num; i++) {
-		ret = clk_prepare_enable(clks[i]);
-		if (ret)
-			goto err;
-	}
+	ret = clk_prepare_enable(core->vcodec_core_clks[id]);
+	if (ret)
+		return ret;
 
-	return 0;
-err:
-	while (i--)
-		clk_disable_unprepare(clks[i]);
+	ret = clk_prepare_enable(core->vcodec_bus_clks[id]);
+	if (ret)
+		clk_disable_unprepare(core->vcodec_core_clks[id]);
 
 	return ret;
 }
 
-static void vcodec_clks_disable(struct venus_core *core, struct clk **clks)
+static void vcodec_clks_disable(struct venus_core *core, u8 id)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i = res->vcodec_clks_num;
-
-	while (i--)
-		clk_disable_unprepare(clks[i]);
+	clk_disable_unprepare(core->vcodec_bus_clks[id]);
+	clk_disable_unprepare(core->vcodec_core_clks[id]);
 }
 
 static u32 load_per_instance(struct venus_inst *inst)
@@ -343,8 +350,7 @@ static int vdec_get_v3(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
 
-	return vcodec_clks_get(core, dev, core->vcodec0_clks,
-			       core->res->vcodec0_clks);
+	return vcodec_clks_get(core, dev, 0);
 }
 
 static int vdec_power_v3(struct device *dev, int on)
@@ -355,9 +361,9 @@ static int vdec_power_v3(struct device *dev, int on)
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_DEC, true);
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec0_clks);
+		ret = vcodec_clks_enable(core, 0);
 	else
-		vcodec_clks_disable(core, core->vcodec0_clks);
+		vcodec_clks_disable(core, 0);
 
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_DEC, false);
 
@@ -368,8 +374,7 @@ static int venc_get_v3(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
 
-	return vcodec_clks_get(core, dev, core->vcodec1_clks,
-			       core->res->vcodec1_clks);
+	return vcodec_clks_get(core, dev, 1);
 }
 
 static int venc_power_v3(struct device *dev, int on)
@@ -380,9 +385,9 @@ static int venc_power_v3(struct device *dev, int on)
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_ENC, true);
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec1_clks);
+		ret = vcodec_clks_enable(core, 1);
 	else
-		vcodec_clks_disable(core, core->vcodec1_clks);
+		vcodec_clks_disable(core, 1);
 
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_ENC, false);
 
@@ -441,7 +446,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		vcodec_clks_disable(core, core->vcodec0_clks);
+		vcodec_clks_disable(core, 0);
 
 		ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
 		if (ret)
@@ -457,7 +462,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		vcodec_clks_disable(core, core->vcodec1_clks);
+		vcodec_clks_disable(core, 1);
 
 		ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
 		if (ret)
@@ -484,7 +489,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		ret = vcodec_clks_enable(core, core->vcodec0_clks);
+		ret = vcodec_clks_enable(core, 0);
 		if (ret)
 			return ret;
 
@@ -502,7 +507,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		ret = vcodec_clks_enable(core, core->vcodec1_clks);
+		ret = vcodec_clks_enable(core, 1);
 		if (ret)
 			return ret;
 
@@ -763,20 +768,18 @@ static int vdec_get_v4(struct device *dev)
 	if (!legacy_binding)
 		return 0;
 
-	return vcodec_clks_get(core, dev, core->vcodec0_clks,
-			       core->res->vcodec0_clks);
+	return vcodec_clks_get(core, dev, 0);
 }
 
 static void vdec_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
-	unsigned int i;
 
 	if (!legacy_binding)
 		return;
 
-	for (i = 0; i < core->res->vcodec_clks_num; i++)
-		core->vcodec0_clks[i] = NULL;
+	core->vcodec_core_clks[0] = NULL;
+	core->vcodec_bus_clks[0] = NULL;
 }
 
 static int vdec_power_v4(struct device *dev, int on)
@@ -792,9 +795,9 @@ static int vdec_power_v4(struct device *dev, int on)
 		return ret;
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec0_clks);
+		ret = vcodec_clks_enable(core, 0);
 	else
-		vcodec_clks_disable(core, core->vcodec0_clks);
+		vcodec_clks_disable(core, 0);
 
 	vcodec_control_v4(core, VIDC_CORE_ID_1, false);
 
@@ -808,20 +811,18 @@ static int venc_get_v4(struct device *dev)
 	if (!legacy_binding)
 		return 0;
 
-	return vcodec_clks_get(core, dev, core->vcodec1_clks,
-			       core->res->vcodec1_clks);
+	return vcodec_clks_get(core, dev, 1);
 }
 
 static void venc_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
-	unsigned int i;
 
 	if (!legacy_binding)
 		return;
 
-	for (i = 0; i < core->res->vcodec_clks_num; i++)
-		core->vcodec1_clks[i] = NULL;
+	core->vcodec_core_clks[1] = NULL;
+	core->vcodec_bus_clks[1] = NULL;
 }
 
 static int venc_power_v4(struct device *dev, int on)
@@ -837,9 +838,9 @@ static int venc_power_v4(struct device *dev, int on)
 		return ret;
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec1_clks);
+		ret = vcodec_clks_enable(core, 1);
 	else
-		vcodec_clks_disable(core, core->vcodec1_clks);
+		vcodec_clks_disable(core, 1);
 
 	vcodec_control_v4(core, VIDC_CORE_ID_2, false);
 
@@ -934,11 +935,11 @@ static int core_get_v4(struct venus_core *core)
 
 	dev_info(dev, "%s legacy binding\n", legacy_binding ? "" : "non");
 
-	ret = vcodec_clks_get(core, dev, core->vcodec0_clks, res->vcodec0_clks);
+	ret = vcodec_clks_get(core, dev, 0);
 	if (ret)
 		return ret;
 
-	ret = vcodec_clks_get(core, dev, core->vcodec1_clks, res->vcodec1_clks);
+	ret = vcodec_clks_get(core, dev, 1);
 	if (ret)
 		return ret;
 

From patchwork Fri Feb  9 21:10:01 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551862
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0D446BE
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.208.172
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513022; cv=none;
 b=DM0hlIqLSA6PtXyAfo1hWXVGxyRY2H1A/beBmwd5+7zwnkNBKjNHZXszg6DjfMPxvuxpOyaryaRPdYsGLYk7CQLmykIeOsXdI1DrUa4mzGVbbYAGw47wlW8taNZEg812k9lhySmbD+vDwGlSldtyv0kCtlEFQTgDlJDHfAQbfAY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513022; c=relaxed/simple;
	bh=MLv2EGPhgvWgejpl7fbRFyjPDkfZHFECDfabJtkG8Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=WptnesCsfuWYYtIVN9/b1f6J2TEbWAs51b2SjDkei9c48bsth1DWd+83rel3ctKTAbrJDx5bzw53qn2ESRN3E8WXeeDQwsYormyrbet6y2EXuFPZzRDqZEyg+MpzGjzJQXiYEX4IhZzGjqSg2r7K2C5vwFO/iCunja4XCqxh+v0=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=QikG+afM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="QikG+afM"
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2d0e4ef33b2so1456021fa.1
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513018; x=1708117818;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlA4ayOmstDeitRRZ2W2c5UllMpUVoGUwWdDkp9v1as=;
        b=QikG+afMnsM1kIM/Nzem4BffRaN2JoYMSspKt/5ZFkD4LBq8mEIg5ArRpYZCjyLS2m
         K4Nyr0q6AczPm6A3PYrol7Y9+el4d3dCsMdRYuEwyJI4mfmfbfie2dV/u0BxLGDd3Ev8
         VhVcET9DcD4HCBR/d8122dlICEbLTRofa1vWifljz63CP7jo6xxnvzrA53rl8MdZHFmO
         IoErZn0/F9b8/XffsEeTyNoxh3iKlzKSfsky2FqqFMt49ZVDIUwnEp670e18JVDA/NGL
         iYzJm1ypLGQIfkVxWMmxynf0fQfUi16b/SOEgR74TdhS3vdpG3CiZtL8FHkTuYhhE/Sp
         n+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513018; x=1708117818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlA4ayOmstDeitRRZ2W2c5UllMpUVoGUwWdDkp9v1as=;
        b=CVg0h0alQOmq4hqaNi787NWkgTVi0rXK+rnHRTYb2gmH4VERpz5zZ4vr4o5CpbKIbm
         Cg2jkYf5dUx1lnsyO2wYdc5H0xHDc8Aj5DAkSaBm+lERRFzJWK6Y8cZ6VMTJAih1b9uu
         JpyCvl246n6m9Nw09YuAXRJKnkWAieQphIHDFK6idVRVsZmY4s8qSw2pn6rIfVLYvvG1
         uQ1LgQIaA3dEw0oimiGVnyq980XEzPNIhrWiVZmMfm/pUoVROYFQ7xJH9XVLdsOG9XiF
         50+g/4/dnMnE4z+KYI2CDsfBHhDqhV23X8iqmMrwnuD0h7+Y7Bm3NmO8n7t/3UIR/cHD
         z+KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb5PpvVBlKZ5RFRWFqkjrBQiXLrmSL9GcZTIpCpfKUZeNNMfijBti8wUxGCB7RAcLcS0S/h/FoCXQ8rb+XaKKl/gYM+k+YNoogj0g=
X-Gm-Message-State: AOJu0YwdwVhDGbQmJ9ukxPJEIpjdlyXNfQolriZ5bNzLSTFOMH5a1COF
	2TnxHH5fPdGQAZpAY4qXw0ou3+i5uE3gGpHUpqR8EMNNCsdAfliW3h+uorE7IEQ=
X-Google-Smtp-Source: 
 AGHT+IFzzZN5KL4cYG0hicyLZubpRFb4oezMjYE5cyxLTyWE7sgQ6y2pJ7SpOmZIS/sM1SfYlpEBjw==
X-Received: by 2002:ac2:41ca:0:b0:511:1ed7:61b8 with SMTP id
 d10-20020ac241ca000000b005111ed761b8mr138919lfi.30.1707513017891;
        Fri, 09 Feb 2024 13:10:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV2vSXOWP0zPTdPzgr2OB7mO2zO/BBUb6MycDmMBo7iyCA2zGdMN08BEZkTi3oXHkq73Gyr6mJnMewJbhfCN0g3QgXHZE83t99O5gMpRiQ+ubauJZ069Kj4IH0j8fil17TwydvqiE7EyqiHHrOb/UA6FKnEiZJNKUHfSjovojWbyHOaHpYLii5mg5HTYW7nYf+rwGwyLwvqeDf1RQg7qpkrwja72n3pUtqIarC6ZjSKd4ffjkRFoiuj56ZKnjT/NP/f/8Z7Cz/WRodOnc1SJRsNEluaneAid6a1yoUhjvPYmgC+F+JBPRVdYbOgsHiruBK3bZQAhNDQYK785jNLXe5rGkMh/BRIzhzLhpTZGDUElUAvyrdhRYyVi3ScwZqKb7xeDiYH8VQyF09qpIx7yzzyWVUUyyS2pC1mZeifVQSKzHq/GzWUaMD5FLcw6vXU4ZCR86UO3Q19vs4Ql+yePMEtaF0N1jyReWzrh5HwS6usTMkP9XL6XtgESVKeiroCgPHkCQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:17 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:10:01 +0100
Subject: [PATCH v2 17/20] media: venus: pm_helpers: Commonize getting
 clocks and GenPDs
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-17-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=3311;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=MLv2EGPhgvWgejpl7fbRFyjPDkfZHFECDfabJtkG8Ts=;
 b=nU5akJ8S6NPlZWhfphKzyqepTvPetn6PGSgT5P4fuPWJfhCa9tlFcNZQek5SuRx1S+ZmHp2PL
 7G4hT8ZVxMODhmSzX/S3H5V0Bz6ZahTDetAMN4Kw5+Ry9JuFZHzA73m
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

As has been the story with the past few commits, much of the resource
acquisition logic is totally identical between different generations
and there's no good reason to invent a new function for each one.

Commonize core_get() and rename it to venus_get_resources() to be more
meaningful.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       | 8 +++-----
 drivers/media/platform/qcom/venus/pm_helpers.c | 5 +----
 drivers/media/platform/qcom/venus/pm_helpers.h | 3 +--
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 680674dd0d68..873affe17537 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -334,11 +334,9 @@ static int venus_probe(struct platform_device *pdev)
 			return PTR_ERR(core->resets[i]);
 	}
 
-	if (core->pm_ops->core_get) {
-		ret = core->pm_ops->core_get(core);
-		if (ret)
-			return ret;
-	}
+	ret = venus_get_resources(core);
+	if (ret)
+		return ret;
 
 	ret = dma_set_mask_and_coherent(dev, res->dma_mask);
 	if (ret)
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index a292c788ffba..1cbcffbc29af 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -326,7 +326,6 @@ static int load_scale_v1(struct venus_inst *inst)
 }
 
 static const struct venus_pm_ops pm_ops_v1 = {
-	.core_get = venus_clks_get,
 	.load_scale = load_scale_v1,
 };
 
@@ -395,7 +394,6 @@ static int venc_power_v3(struct device *dev, int on)
 }
 
 static const struct venus_pm_ops pm_ops_v3 = {
-	.core_get = venus_clks_get,
 	.vdec_get = vdec_get_v3,
 	.vdec_power = vdec_power_v3,
 	.venc_get = venc_get_v3,
@@ -920,7 +918,7 @@ static int core_resets_reset(struct venus_core *core)
 	return ret;
 }
 
-static int core_get_v4(struct venus_core *core)
+int venus_get_resources(struct venus_core *core)
 {
 	struct device *dev = core->dev;
 	const struct venus_resources *res = core->res;
@@ -1109,7 +1107,6 @@ static int load_scale_v4(struct venus_inst *inst)
 }
 
 static const struct venus_pm_ops pm_ops_v4 = {
-	.core_get = core_get_v4,
 	.vdec_get = vdec_get_v4,
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
index 3014b39aa6e3..7a55a55029f3 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.h
+++ b/drivers/media/platform/qcom/venus/pm_helpers.h
@@ -10,8 +10,6 @@ struct venus_core;
 #define POWER_OFF	0
 
 struct venus_pm_ops {
-	int (*core_get)(struct venus_core *core);
-
 	int (*vdec_get)(struct device *dev);
 	void (*vdec_put)(struct device *dev);
 	int (*vdec_power)(struct device *dev, int on);
@@ -28,6 +26,7 @@ struct venus_pm_ops {
 const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
 int venus_core_power(struct venus_core *core, int on);
 void vcodec_domains_put(struct venus_core *core);
+int venus_get_resources(struct venus_core *core);
 
 static inline int venus_pm_load_scale(struct venus_inst *inst)
 {

From patchwork Fri Feb  9 21:10:02 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551863
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69F4D584
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.208.51
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513023; cv=none;
 b=Inz5Lc6MWMJmsxky6Ij6BgAG3orTkcRYr1XY+Eaqxjt//5GqHMS1o5DucGNY22hd/lU6yk45iBJdSAH4GFlPV12dKvLl7J/Qw95i7mip4Spt/iAzcYscNEAMpWU1uEwqni34vF3mnw/UmmWe+YWmS9mP/U8PrOn19HzyU3+pDoE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513023; c=relaxed/simple;
	bh=j6RqB7qhdLQ/4O4liND2yJpb9uwEoUR3RICjb3kPkBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=ndDfOCWqcsqYZUTuMBZr3hJKGTc/UGj6kHyZMdBPXTWiJckm16hVmjIPaDgNeOfJML5OyBFvECmNc3YcGxRQwiwZbYm8FNJSiaPpxkHnkMpVOaAJC7fFiybcZPKpySBts//3YL9XPTCNc9oVRh7SaBrf9eHtLifXk2vsHb6mt4Y=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=zaLCgF10; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="zaLCgF10"
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-560c696ccffso4278297a12.1
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513020; x=1708117820;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=js2pEuzAV2nN8L7KReaasWsLTFytDhFcrYh7TQGAyMk=;
        b=zaLCgF10SoUcJpVrjbPlsxr2BftQgi9Kl0FsRFzKFb9Qt0xgAeTi6XZ0A1Vm/FWrku
         f6b2RLKzeiPIppiySgWamvlNt2r+YTWIgMNpsO0RlbmIswK3e78hGwE/L64rdkYxb5wH
         3LtnAvKzymyln1b0N183fqjsdaLfdOPI9RRrdW3sRIgxX9hF2zCng0TGREqz0HuqQD2O
         F0zfkLvf4Cr/rTu6G0BPgWwK2TiHwgoC9gkCT8h77eXm1BZ4TKOFfp91wNy5IiX49tEz
         WXyofReHQA+/7LX9YyCzZtzCfAoCUduwZtHM2xYNeSq2JIxuCNg2dvBjjFvqnp3izf90
         kV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513020; x=1708117820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=js2pEuzAV2nN8L7KReaasWsLTFytDhFcrYh7TQGAyMk=;
        b=v7LUQRKBDgGP7n3u/0ZvbWv24deKWnsl1Oiu2Xi3ELAyrL2xxl9SUWnI2EaXqGrTWC
         +zNATnXbvt4DeeKoaFeJsC2v86/XoHQF4u3UTmiCGYJZ+pmXBOylGI1x1KPeXeMmqH4s
         WtDCYekVg2QOFIj/mGZlFszbqVSr3Y4cMG3sPmLigXIQrfyZDcyALy0mjpTTztJl8v5I
         9cPL9MPMYgzqQTKcuvuA96ln02mWVqvGW9lHnkA3vel9ADYtIWUx4WZRiJhQZRXScr+a
         fpujAWw0pjNxLv62tjVY4ykkOdA0GulYCD82FxryHOIGhOGd8dzT/b5Zx/O7PMBbSHg6
         +mZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv5gXGEgZSy3YYWg8EYXzK7jYl6oAmVa9KvJdWS9NR77yXWQagvFW15MkH8WZ/8oa1PhCAF23ItZ4vJsRxN6hh7nO0s5YM4qUmVmQ=
X-Gm-Message-State: AOJu0YxLlmDno5WwXZYH2ig7dlon2o12aL4BorGwWMjTjP7V89Yk+fqk
	9dQPHvNtb/G4IR02tANQAJ4Til4Drn9skU2xhNfKbezxO5GffKR5Kkr7RkWn8Mw=
X-Google-Smtp-Source: 
 AGHT+IEbaYD180/1YWnZfYBOu4acFr+aUCsPsCkXwJANGBmdc0kktppCzoGX0W+52rZk5nA8+pjDHQ==
X-Received: by 2002:a17:907:9872:b0:a3b:dde8:6a57 with SMTP id
 ko18-20020a170907987200b00a3bdde86a57mr258546ejc.23.1707513019779;
        Fri, 09 Feb 2024 13:10:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVPsj3/JL+m49YumWioOb6hwJ4PZyfKAxV5EBoHXLB5kuDoUHAT21d6q3TbKuDtpnSbNT5eti0yu8inmkuW8ZKWsGOB8MZnb0uZL4O6bOK42VPeszj8Nx5eLHUJApnynyPhSFx3aJG4J68M1X5JYcn+dXtmof8GcRQi+ChJXdlun1vgU4aYYnKuDlKD37dv9i4Y2Vftyt4A0iUX7A1jqGiSim/FhnEUO+udGIqK9Mjd/AXQ4jmpHvN+w56tUf1E2atIi75D/S2ck/2wk2B+tBTcLzYHANjLba98Gc/LhF6MMcHl25dPW0YZ8JEfgeYKXAm/mErnuwJE6zWDOY9XzWQEett5QI5qI2Wbizos8SeA3BWakMc1rdWozZKoUkK01Ue+y2zZkQzx4hhyMqBKBdxuCrqZvwyzw+aejGPstn0ukY4CN5GI/O/jSPo1FN0MjF60xxpaQzpKzn4sFOrFRxPRs5LbTapiszolVbeQPov7cy6+vRDV2+HPS/lnpOXCNuXLFg==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:19 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:10:02 +0100
Subject: [PATCH v2 18/20] media: venus: pm_helpers: Commonize vdec_get()
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-18-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=4126;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=j6RqB7qhdLQ/4O4liND2yJpb9uwEoUR3RICjb3kPkBU=;
 b=9Y5pQbsbW/NkpOZZSBVKI4DPo8gIzWCYvTPJUpWCb0ma63WrBhZU1JhFW+k4Zm4FDhDj7S0kp
 Y0A4IGdL18fBYS2FcvBw1mtqr/tI+ssfAfheQykKMGtFBr2FBMYgYYh
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This function can be very easily commonized between the supported gens.
Do so!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 22 ++--------------------
 drivers/media/platform/qcom/venus/pm_helpers.h |  2 +-
 drivers/media/platform/qcom/venus/vdec.c       |  9 +++++++--
 3 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 1cbcffbc29af..cf0794acf5d0 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -125,7 +125,7 @@ static int core_clks_set_rate(struct venus_core *core, unsigned long freq)
 	return 0;
 }
 
-static int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
+int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
 {
 	char buf[13] = { 0 }; /* vcodecX_core\0 */
 
@@ -158,6 +158,7 @@ static int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(vcodec_clks_get);
 
 static int vcodec_clks_enable(struct venus_core *core, u8 id)
 {
@@ -345,13 +346,6 @@ vcodec_control_v3(struct venus_core *core, u32 session_type, bool enable)
 		writel(1, ctrl);
 }
 
-static int vdec_get_v3(struct device *dev)
-{
-	struct venus_core *core = dev_get_drvdata(dev);
-
-	return vcodec_clks_get(core, dev, 0);
-}
-
 static int vdec_power_v3(struct device *dev, int on)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
@@ -394,7 +388,6 @@ static int venc_power_v3(struct device *dev, int on)
 }
 
 static const struct venus_pm_ops pm_ops_v3 = {
-	.vdec_get = vdec_get_v3,
 	.vdec_power = vdec_power_v3,
 	.venc_get = venc_get_v3,
 	.venc_power = venc_power_v3,
@@ -759,16 +752,6 @@ static int coreid_power_v4(struct venus_inst *inst, int on)
 	return ret;
 }
 
-static int vdec_get_v4(struct device *dev)
-{
-	struct venus_core *core = dev_get_drvdata(dev);
-
-	if (!legacy_binding)
-		return 0;
-
-	return vcodec_clks_get(core, dev, 0);
-}
-
 static void vdec_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
@@ -1107,7 +1090,6 @@ static int load_scale_v4(struct venus_inst *inst)
 }
 
 static const struct venus_pm_ops pm_ops_v4 = {
-	.vdec_get = vdec_get_v4,
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
 	.venc_get = venc_get_v4,
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
index 7a55a55029f3..4afc57dac865 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.h
+++ b/drivers/media/platform/qcom/venus/pm_helpers.h
@@ -10,7 +10,6 @@ struct venus_core;
 #define POWER_OFF	0
 
 struct venus_pm_ops {
-	int (*vdec_get)(struct device *dev);
 	void (*vdec_put)(struct device *dev);
 	int (*vdec_power)(struct device *dev, int on);
 
@@ -27,6 +26,7 @@ const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
 int venus_core_power(struct venus_core *core, int on);
 void vcodec_domains_put(struct venus_core *core);
 int venus_get_resources(struct venus_core *core);
+int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id);
 
 static inline int venus_pm_load_scale(struct venus_inst *inst)
 {
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 29130a9441e7..d127311100cd 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1788,8 +1788,13 @@ static int vdec_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, core);
 
-	if (core->pm_ops->vdec_get) {
-		ret = core->pm_ops->vdec_get(dev);
+	/*
+	 * If the vcodec core clock is missing by now, it either doesn't exist
+	 * (8916) or deprecated bindings with pre-assigned core functions and
+	 * resources under the decoder node are in use.
+	 */
+	if (!core->vcodec_core_clks[0]) {
+		ret = vcodec_clks_get(core, dev, 0);
 		if (ret)
 			return ret;
 	}

From patchwork Fri Feb  9 21:10:03 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551864
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D504F211
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.167.52
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513025; cv=none;
 b=ceNXk4jDUXVwUrpymDtF86L/d56X4whw1ppA7bs9TO7P1VqxhpWhrnFBXwJoFQIRPnWgIT+HCK4m9kQbkfcTLYZeV+v5lSlIu+HDFLleSQIx1oUSbv6rq+f5FPnBFq4yjTTiK2UPSfoy0325k5VtauSSPuQ0lRV6o+dshr8b71M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513025; c=relaxed/simple;
	bh=xmr9gBLALZZ4tCzhH3tzwTSX0EVNrOb18RsCpry8TQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=q5z329ISFtGrejD6W00oeR1y/JyKFVpTOFHxRqoG5/x5OyFmxnBXqKGDTnuH+7JOOnIN4Tyn9k7lgVl941Egv1RTzBC5i3zVRS0sDAjL4dK/i0JMolT1K9DCr5MktUFhiiWOB4FkXA6366uLOS3H0ZVKdk9rDrPmN6N+dF5mCuM=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=ySdP1GTe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ySdP1GTe"
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-51178bbb5d9so1084982e87.2
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513021; x=1708117821;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFsyNvwxQilGz6zxZXhAEZJ3UdBMC1zpxUAmMEMQ0vg=;
        b=ySdP1GTee9qIBb82i6hVQjoMA4TKieaiB6Hw5nhkFAIhPj4z8jkrF+V9h2GBWhBz/0
         wRhZNFBKKOH73DDwvw/yc55FNuZyu9LGxlULyy9+lyTlovct0nmINdbD1DI4g7H5dnR6
         LT8w5RO6n/gyM3WeDMIwdgrR+r0OQfqwx3hOkcHNcHk6kBXRDETjJCKskhXik/KsWxlK
         gZxsEPG38R+RLtXHwG9PMUplyJhuSvQsnwiEGtnLvnWld66P72DVUnmuOiq62/mz4E+W
         KtmeirEexc69Yj7EKdXBBgxYj+LtPc4lXOpfLrxPWZF0QwneZTc9seHYATy/KIMncgNs
         AwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513021; x=1708117821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFsyNvwxQilGz6zxZXhAEZJ3UdBMC1zpxUAmMEMQ0vg=;
        b=PXsGBJ5dpm62usgm5xkvWHar7sweyWzFB42kKNldkBPHpO/WMc6YR86QDreHMVqy7G
         yZ7rZDk06TKxPJS0rW1VK6CWoCfSDPKZZvQxvXS11WniIWYVuUe+z1GWlftIo6WlWhvk
         pZZbpPOlh/EUBAEk5N+KQrz8JJsHNdTjAa6ktlawmduEDvECzL+FmehHdKnT0WbPvvg4
         rD7MSL+7v1Y7BnviCH/m2CUUwjzDCHB/cOv/o9nxL8++EbhuYiGsfnkSALO3rZD2Z+mG
         ODupa3oXU/ODLSnZ1PvdaLs2Be6H3ruQNri4oxcaR0SC4jRTmWNS2TgDltu3NaQqkdTm
         08+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYONvvH3nqxms1k6foBG/nEvoVnvey8TRiA1Ke1xzl8YIBJnHvOIBW4Ov8QLvinU3mu/vCQsjx99qztzuh65u2HxCjaoYnAZBbBfM=
X-Gm-Message-State: AOJu0YyL14Y364Icy1BJbqANLy5DDrtkydGncYWajxHv0g3AAH2Tgpm+
	V5mA751cIB9St5E9Y//Ez1lPU+2Hr2rog/t2Gmb+S4aVFqvo/mAEIwuuuYhOc1E=
X-Google-Smtp-Source: 
 AGHT+IH5m6Adda+lr4r8RqsH5XXoU3LKMfPcMTVpNY8oF3akchcnqTu6j/lvK7FFqJPKmaL7zKlX8g==
X-Received: by 2002:ac2:4243:0:b0:511:7fb5:91fc with SMTP id
 m3-20020ac24243000000b005117fb591fcmr138038lfl.20.1707513021249;
        Fri, 09 Feb 2024 13:10:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUKO/zPhvMnpN6+uHTF30b9UESaSFB4bZ4gS38403aT0q+1mrhv8dT13hiJGJWoj1ozvWqP4pac0v9QBYBiyN2VZ0n4LTUJkFTOK+oc/Oa66alZU2VKzH/ct2bYwPDI/1N75GoJn94MUxmoTE2ri5x3g/K9W3Nkhbz7ZunXYtfZf14tPZh0GJJL/mq7stwyzLXzdoocAoIMaTmqlK02PtQ5ao59lx9bwPjy4Zr3zJ2Nv78zvEH+g0sGWdqTOdsw/dECzh3ZAhBUvg8qIKbwXh8lhc7C1VedGZVSG46ZBIpzd8MpF/l8XXMsL9MFpK1G/ByDYSJC/e6jRJu6G3n+KP0Sdb7thPNhkjIJ9mPb5kStv2O5AUVshlG1cyp7TrJ1bO5tuWCPPjffKHNqfJuwQeELVJFlonuDsuu6wEHUz+cUS68mPrR46FGz1WjFWO89+8OHb+eQAzCf5G9ZClhHQjXmIti30OgIT0jqI4jDD3Cll7yTF7EOmlj50SmLr5H26XuBcg==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:20 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:10:03 +0100
Subject: [PATCH v2 19/20] media: venus: pm_helpers: Commonize venc_get()
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-19-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=3254;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xmr9gBLALZZ4tCzhH3tzwTSX0EVNrOb18RsCpry8TQQ=;
 b=MwE+XQyOfpxkRSYew5l9uPJPp+xTAWAOlE0VUdIFsDi45PwmWNoRZ5WsueqGgFCumjHspTGlP
 OgMpCyCOFhfCl8/Gst+Hkaf/jwhKbL/R957iYMzifXJpYt4qzrhYuDH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This function can be very easily commonized between the supported gens.
Do so!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 19 -------------------
 drivers/media/platform/qcom/venus/pm_helpers.h |  1 -
 drivers/media/platform/qcom/venus/venc.c       |  9 +++++++--
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index cf0794acf5d0..9df8f2292c17 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -363,13 +363,6 @@ static int vdec_power_v3(struct device *dev, int on)
 	return ret;
 }
 
-static int venc_get_v3(struct device *dev)
-{
-	struct venus_core *core = dev_get_drvdata(dev);
-
-	return vcodec_clks_get(core, dev, 1);
-}
-
 static int venc_power_v3(struct device *dev, int on)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
@@ -389,7 +382,6 @@ static int venc_power_v3(struct device *dev, int on)
 
 static const struct venus_pm_ops pm_ops_v3 = {
 	.vdec_power = vdec_power_v3,
-	.venc_get = venc_get_v3,
 	.venc_power = venc_power_v3,
 	.load_scale = load_scale_v1,
 };
@@ -785,16 +777,6 @@ static int vdec_power_v4(struct device *dev, int on)
 	return ret;
 }
 
-static int venc_get_v4(struct device *dev)
-{
-	struct venus_core *core = dev_get_drvdata(dev);
-
-	if (!legacy_binding)
-		return 0;
-
-	return vcodec_clks_get(core, dev, 1);
-}
-
 static void venc_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
@@ -1092,7 +1074,6 @@ static int load_scale_v4(struct venus_inst *inst)
 static const struct venus_pm_ops pm_ops_v4 = {
 	.vdec_put = vdec_put_v4,
 	.vdec_power = vdec_power_v4,
-	.venc_get = venc_get_v4,
 	.venc_put = venc_put_v4,
 	.venc_power = venc_power_v4,
 	.coreid_power = coreid_power_v4,
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
index 4afc57dac865..cbf54e6c6eab 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.h
+++ b/drivers/media/platform/qcom/venus/pm_helpers.h
@@ -13,7 +13,6 @@ struct venus_pm_ops {
 	void (*vdec_put)(struct device *dev);
 	int (*vdec_power)(struct device *dev, int on);
 
-	int (*venc_get)(struct device *dev);
 	void (*venc_put)(struct device *dev);
 	int (*venc_power)(struct device *dev, int on);
 
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 3ec2fb8d9fab..d17aeba74b49 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1557,8 +1557,13 @@ static int venc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, core);
 
-	if (core->pm_ops->venc_get) {
-		ret = core->pm_ops->venc_get(dev);
+	/*
+	 * If the vcodec core clock is missing by now, it either doesn't exist
+	 * (8916) or deprecated bindings with pre-assigned core functions and
+	 * resources under the decoder node are in use.
+	 */
+	if (!core->vcodec_core_clks[1]) {
+		ret = vcodec_clks_get(core, dev, 1);
 		if (ret)
 			return ret;
 	}

From patchwork Fri Feb  9 21:10:04 2024
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Patchwork-Submitter: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Patchwork-Id: 13551865
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3134F8A8
	for <linux-media@vger.kernel.org>; Fri,  9 Feb 2024 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
 arc=none smtp.client-ip=209.85.167.49
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513027; cv=none;
 b=t2BZTVAlvyGY9kRy7CEbJZMXOJkwQ2XeFYR27O+Y1/tNWpKjJFbfNKx2a2vasgINmml5nkdyWBjBqDdcdvkTag+VEklq4K2kBYXd4a/wcXFbqS5YPSmh0JcwKmDkN5s5tyK/cpYt44XWdMePLNLuMjlX41VOVX6oKx7QPDGspaY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513027; c=relaxed/simple;
	bh=Fz9/3nwY3iRMESW9ND892gH2ujeyGwLuBsrH62OMhc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc;
 b=ktEW23ViQz2eC8f+5GVxRXtSH/e1T66jN8fGxODJkblPAEbNKT1VBUhEV0Kb9dTkSiO+gOu9GWF3KqRU7oaxN55GxhkRpP8+WPw5aPsxEMTtROtqRgLjqNvvnInLE2U2IH6BrTa5gJ8PfiflfccLr+HNcQKg2ZlF+6MMAoT3LOk=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org;
 spf=pass smtp.mailfrom=linaro.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b=H4v71HX6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
 spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="H4v71HX6"
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5116ec49081so1577972e87.2
        for <linux-media@vger.kernel.org>;
 Fri, 09 Feb 2024 13:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707513023; x=1708117823;
 darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBuTuqSBCGp1wdV2drsgjw3VLfRlaM3TQsPOZG9m4W0=;
        b=H4v71HX6mKe5gMPn+3B0kX/sDpU2QYy3U+BOFhg8E3nCKWFJo7GI1rXNMq5HiM2i7d
         TuWz1+ZSiSRbkKkfSGkbpnaruRWc8gTPTaczdVCigRJ6FdF3lsZkP55Q9xUIa6M8ml3G
         4yicNypI7/+2yaL+CigGp0DP1XZV3IOoIrqxIwZ1tcZ+6PKutB3WiNvDVrtTV0hZTbBX
         lS2OjFEDXVdBjYbmvuGVDrvrIZYcPD+1Ag82mOCenYR309KDLEKIdzDTT4B3BjQVJnyE
         Ik8Ck0JYm1NJhzH28GC+yYXc0Ocho8WnI9lOXI7q/dOL8C+ckwSEUgiOvTrgbEdAewgD
         seNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513023; x=1708117823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBuTuqSBCGp1wdV2drsgjw3VLfRlaM3TQsPOZG9m4W0=;
        b=MhVKRAfYoG4LVYOv2pdD2pRPqkX6/IxpogjWScjYCwz7d2TZP/YfxEYqUN8aNChKb4
         5pBU41fnbzAA4xVXNIll5CxU+dr4LcSt4Nqq4XQHg+UmIvd9vf1T/OIu2pWc7C1xCbtz
         Bk8wxhaRlNVttFi3D9Ks5nvGzErdFt8MEJdC5TnQMmz3jYqyfi1wd+pJ9+8jk60yWrv/
         piCeVsWs9aHr7IT59jb4LYdtlaC3ALC/0x9VtxI3xilbJLJBPsUUVkpWdK0V8T4fA7cp
         l3fu5tDthHUQPwcmvSmiLzyHdSZdnPRKzuR3hmdMDl9G/W2igwFnL9XVphjFBSkQAQAA
         v3rA==
X-Gm-Message-State: AOJu0YzrjXkC7NrPmDw+6xYJMD2TaciryZYTUgOcmmUqM+Hs+LCKP9mM
	69TKjYkqT3/HvDH7feBb0lurD68mMLK203tIF6y6iDe3VwlWSGT5pD/cRRzcAyk=
X-Google-Smtp-Source: 
 AGHT+IFmDovCNo8IXlypQCGqzNluIsgzHOnrtPCmHDEWychihLMIbm3oYmNVKBmYhUe4EhbDalBWGg==
X-Received: by 2002:ac2:42cb:0:b0:511:429e:43d4 with SMTP id
 n11-20020ac242cb000000b00511429e43d4mr153429lfl.11.1707513023199;
        Fri, 09 Feb 2024 13:10:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXaCO1qT04kwtps/bfEISjBC58UTjh+OzcG6dJ/58GzZqaZ4sJXT0ZCCFTSZO4GEUOoVbaCB2hkW2i+iA8G+/jiWkr6FmSe3dUxfhzl5X7XuewdWZPHq72K/dUggw9LviQbCuhILgmFoZlf/UWuAXfeE8ZB1ICSPB1DQSPE02/PsVIwmiaF0c1w2tPagVpJczZXASAWiid9Frgy5PphXUxjz0qpSZoQwm9wQXfZGyM9BwoxrbBl/rmiqovVVxw7WHtftYgYAbJm/e3I6EpSjMC8oayLxmZXCRkaryoFx2b3Un+gZZXJMd20001HWk5q76RHVB+tFrq76AlanSx2mQzoGdpyAaRD7ilmuQudlWtiep6I/mAlpnfka0U3c7oBrpsAeMD0+BLP3M/4g/KSly61ErLdj1mvdBooNXwsbIB3RW87YIbynNB6VOfB+tQJGnw0XpgpXzipH0uEuLzNSVN4HN/qo368y4TUlqYT4ULzxKZ2J8AkWThmxWTgPyZcSTmnbQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl.
 [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id
 vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:10:22 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:10:04 +0100
Subject: [PATCH v2 20/20] media: venus: pm_helpers: Use reset_bulk API
Precedence: bulk
X-Mailing-List: linux-media@vger.kernel.org
List-Id: <linux-media.vger.kernel.org>
List-Subscribe: <mailto:linux-media+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-media+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20230911-topic-mars-v2-20-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512986; l=3454;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Fz9/3nwY3iRMESW9ND892gH2ujeyGwLuBsrH62OMhc8=;
 b=Fd7i7FaWiwaHVHHLebF/wCA/vcsVdLEcCtmGGg18YNUn3FNRyH6lEVGWeoBqDEYk1gfz8xMJZ
 MaSw0hu4S5pCKtrocK1nPDg6flxKKaGSCbv2ywxGWlw/Sy04vZUlTz2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

All of the resets are toggled together. Use the bulk api to save on some
code complexity.

The delay between resets is now correctly determined by the reset
framework.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/qcom/venus/core.c       | 15 ++++++++++-----
 drivers/media/platform/qcom/venus/core.h       |  4 ++--
 drivers/media/platform/qcom/venus/pm_helpers.c | 15 +++------------
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 873affe17537..ff5601a5ce77 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -328,11 +328,16 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < res->resets_num; i++) {
-		core->resets[i] = devm_reset_control_get_exclusive(dev, res->resets[i]);
-		if (IS_ERR(core->resets[i]))
-			return PTR_ERR(core->resets[i]);
-	}
+	core->resets = devm_kcalloc(dev, res->resets_num, sizeof(*core->resets), GFP_KERNEL);
+	if (res->resets_num && !core->resets)
+		return -ENOMEM;
+
+	for (i = 0; i < res->resets_num; i++)
+		core->resets[i].id = res->resets[i];
+
+	ret = devm_reset_control_bulk_get_exclusive(dev, res->resets_num, core->resets);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get resets\n");
 
 	ret = venus_get_resources(core);
 	if (ret)
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 6ecaa3e38cac..2376b9cbdf2c 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -130,7 +130,7 @@ struct venus_format {
  * @pmdomains:	a pointer to a list of pmdomains
  * @opp_dl_venus: an device-link for device OPP
  * @opp_pmdomain: an OPP power-domain
- * @resets: an array of reset signals
+ * @resets: a reset_control_bulk_data array of hardware reset signals
  * @vdev_dec:	a reference to video device structure for decoder instances
  * @vdev_enc:	a reference to video device structure for encoder instances
  * @v4l2_dev:	a holder for v4l2 device structure
@@ -183,7 +183,7 @@ struct venus_core {
 	struct dev_pm_domain_list *pmdomains;
 	struct device_link *opp_dl_venus;
 	struct device *opp_pmdomain;
-	struct reset_control *resets[VIDC_RESETS_NUM_MAX];
+	struct reset_control_bulk_data *resets;
 	struct video_device *vdev_dec;
 	struct video_device *vdev_enc;
 	struct v4l2_device v4l2_dev;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 9df8f2292c17..170fb131cb1e 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -865,21 +865,12 @@ void vcodec_domains_put(struct venus_core *core)
 static int core_resets_reset(struct venus_core *core)
 {
 	const struct venus_resources *res = core->res;
-	unsigned int i;
 	int ret;
 
-	for (i = 0; i < res->resets_num; i++) {
-		ret = reset_control_assert(core->resets[i]);
-		if (ret)
-			goto err;
-
-		usleep_range(150, 250);
-		ret = reset_control_deassert(core->resets[i]);
-		if (ret)
-			goto err;
-	}
+	ret = reset_control_bulk_reset(res->resets_num, core->resets);
+	if (ret)
+		dev_err(core->dev, "Failed to toggle resets: %d\n", ret);
 
-err:
 	return ret;
 }
 

