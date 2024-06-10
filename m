Return-Path: <linux-pm+bounces-8900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C09902C5C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 01:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7414F28119B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 23:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6817152176;
	Mon, 10 Jun 2024 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fXUiwL9I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3B4779E;
	Mon, 10 Jun 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061244; cv=none; b=RmMIKLzuENVx2/HxBjHoOHrkZSdJJYFCJRQunI/0YaaVFfCdxOUuj2YWZQ6r1Mf4kA0ewqttYEqtTemgEf0ceqRGOyg6rYxz9f37qtFSnFBv6KhabznvE01Sx9HoV/EAbUEErsku91HSbFJT1HFlZj/anvxNMSwYzvxZEDRLMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061244; c=relaxed/simple;
	bh=XU6BOh2DEWLUvg1y8dXWq4FHicB8QmFWvgMoo960iAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Ygq0IPiep5AZMmDA+K6/QrCt/0Ptt+xgeoeS2GpEU2kkVyt0CB1bxL74cGMUajZJkGAUtH+b1eMyuvocESqtTuaU2pChW+cFzNlXOYL87sESbYxG4SLIyw6/xiMHi0ubNUDD5+Qj4EkiSvy6gjb7EhE2Xpe0Z8t66tS+LrjQgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fXUiwL9I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ADUbXf029624;
	Mon, 10 Jun 2024 23:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=098YuThUKLesrwkEfnSYpE
	zw/0qjZqI3rNn+/RSq+G0=; b=fXUiwL9IkAt5DuJwKP3P2UpNW5ed2GtjmUFvVQ
	djdDf1u0hVw0rDCla2CPT/jz06OsmrU++Fo9SDAEVQ3LRlzge49tetqQfe4/F53r
	RegjwWo7jIeK7iSIk0nGdhh+konGlGLPNHY8e16nQZFyAUoz01KY94uqFPNa1Jnr
	rne1HdwKNlMPjSReoAdrTxp6wl2QYaKDf08ojVjVDhfCE2rUM8rZY+znR77yuFTY
	dZO9PcAjG97Fv3yghtdb+yMtPyCY3Tm30BYNmUfEMsvg8sCyCommMM3jGNnPzjQG
	LeLjVxXC23Jq/K02b12tjwHhwNaHn6/4tnJBV6zn6ihJKa6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymea6mv79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 23:13:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45ANDuux031529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 23:13:56 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 16:13:55 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 10 Jun 2024 16:13:55 -0700
Subject: [PATCH] pmdomain: amlogic: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240610-md-drivers-pmdomain-amlogic-v1-1-b49ddb1a8bdf@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALKIZ2YC/x3MwQqDMAwA0F+RnBdI3XBsvzJ2iG3UgG0ldSKI/
 75ux3d5BxQxlQLP5gCTTYvmVOEuDfiJ0yiooRpaam/UOcIYMJhuYgWXGHJkTchxzqN6HJy7P67
 UEQlDHRaTQff//npX91wEe+Pkp985a/rsGLmsYnCeXyKdRE+MAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        "Jerome
 Brunet" <jbrunet@baylibre.com>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -3o1y20JkrcZJ8gLc3NK2SDvoJ6_HOJ6
X-Proofpoint-ORIG-GUID: -3o1y20JkrcZJ8gLc3NK2SDvoJ6_HOJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_06,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406100172

On x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomain/amlogic/meson-ee-pwrc.o

Add the missing invocation of the MODULE_DESCRIPTION() macro to all
files which have a MODULE_LICENSE().

This includes meson-secure-pwrc.c which, although it did not produce a
warning with the x86 allmodconfig configuration, may cause this
warning with other configurations where CONFIG_MESON_SM is enabled.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/pmdomain/amlogic/meson-ee-pwrc.c     | 1 +
 drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c | 1 +
 drivers/pmdomain/amlogic/meson-secure-pwrc.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
index fcec6eb610e4..fbb2b4103930 100644
--- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
@@ -648,4 +648,5 @@ static struct platform_driver meson_ee_pwrc_driver = {
 	},
 };
 module_platform_driver(meson_ee_pwrc_driver);
+MODULE_DESCRIPTION("Amlogic Meson Everything-Else Power Domains driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c b/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
index 33df520eab95..6028e91664a4 100644
--- a/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
+++ b/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
@@ -376,4 +376,5 @@ static struct platform_driver meson_gx_pwrc_vpu_driver = {
 	},
 };
 module_platform_driver(meson_gx_pwrc_vpu_driver);
+MODULE_DESCRIPTION("Amlogic Meson GX Power Domains driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index 4d5bda0d60fc..b50e5678abe3 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -355,4 +355,5 @@ static struct platform_driver meson_secure_pwrc_driver = {
 	},
 };
 module_platform_driver(meson_secure_pwrc_driver);
+MODULE_DESCRIPTION("Amlogic Meson Secure Power Domains driver");
 MODULE_LICENSE("Dual MIT/GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240610-md-drivers-pmdomain-amlogic-f117930600ea


