Return-Path: <linux-pm+bounces-11676-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDB694149F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C293B23D43
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9407E1A2577;
	Tue, 30 Jul 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A1xB0i4i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A31A2566;
	Tue, 30 Jul 2024 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350689; cv=none; b=inTsXRh5QKsYwiezEEBJpoy+r+cf+BwoKHNKaeNWKghWSP4adMzcOh2D9R5Bq44qorcU54rLdx1AM0dvurfSvaa3u+6saroMa8Azp+iTFcAD6qtp/H1Gd/dd/P1FdolFw4P8fH15P5LK5v49dnT0UL4RICzHmMTAJCHyli5SNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350689; c=relaxed/simple;
	bh=Zg7Gu26EzKMKzHxOQ7zHevd4M+HPi10basJAJS3MVFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RhoHRqWkz15bQuBkrf09vAf04TI6Ey9IDV3p+WGl1If9JTy2bGVglnwtszCg3eMh4QKObAPi3R7FbmVOf+9N0H+0GAbVgkpdQgE78NYgf/z2/gfZesu1zupD8SAwoZsjAdBi9k6J1vbXxe1oOBmc7EjWuy+xnkPzYByQZ5QvnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A1xB0i4i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U8v0si024037;
	Tue, 30 Jul 2024 14:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GMNruIY+K9jpwicdaVc+cy6vXtLs87UZzM1h6GqsOvo=; b=A1xB0i4iAicv5dNV
	qRKGlTCiWBIAUi681fjSuqGV6+GJ3VPM/h5U2qGP7h0D1TmxV2jcz6HuHZx7B9+6
	bZLtmXx2D3pxSqz+tK84hkdNoyrQc5LhDp2kcd1Xnikg2kIHz5k0VabHV1JISarG
	1t9E3w2h7zj/xFRiW38pUhzGPCknQromC+JRWSblciT7yvo5JuxxotrNqwBbaaxE
	e0udjC2BxxcqmsYvfSjtrQoM78PfN2++LP0FuxVx7vzLtvbe3snEEOk/v4bPmoMv
	w8PlRmyd7thAoua2ZKpfJ36YVEiQta/u6uCr9vHUZ2uO30NIvKPTUkQCopJstIiU
	9fEfGg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pw4512pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 14:43:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46UEhOP1007100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 14:43:24 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 07:43:23 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 30 Jul 2024 07:43:22 -0700
Subject: [PATCH 5/5] locking/ww_mutex/test: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240730-module_description_orphans-v1-5-7094088076c8@quicinc.com>
References: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
In-Reply-To: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Russell King
	<linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami
 Hiramatsu" <mhiramat@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        "Pekka Paalanen" <ppaalanen@gmail.com>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter
 Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue"
	<alexandre.torgue@foss.st.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman
	<mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
	<christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Jeremy Kerr
	<jk@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, Alistar Popple
	<alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery
	<andrew@codeconstruct.com.au>,
        Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nouveau@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <linux-pm@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-fsi@lists.ozlabs.org>,
        <linux-aspeed@lists.ozlabs.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CL9Lpp5ClDhqO0GAeDXKPiCN_WgHsJDS
X-Proofpoint-ORIG-GUID: CL9Lpp5ClDhqO0GAeDXKPiCN_WgHsJDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_11,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=934 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407300099

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/locking/test-ww_mutex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 78719e1ef1b1..10a5736a21c2 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -697,3 +697,4 @@ module_exit(test_ww_mutex_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("API test facility for ww_mutexes");

-- 
2.42.0


