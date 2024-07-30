Return-Path: <linux-pm+bounces-11680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC979414AF
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47D01F24896
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACA71993B0;
	Tue, 30 Jul 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AnjlNmbB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840AC33C8;
	Tue, 30 Jul 2024 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350713; cv=none; b=L5pmxNN59/CpQHBvpyZATHeJR6y9qKtCN7hI5aqHjF5pX7wpm9eZmPfCHBvrb3DyJIO3QipvakNWxyIc01zB1nQ36nDPKaLgiMOo8Msf3uQYPCcpwq59magxymSeHecykq++N6v1Ljs4EpE5yC/gcF4dvHE6L04XbzYSnz/ks3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350713; c=relaxed/simple;
	bh=CwJYhEUaPNIVbQLltmIq/IFNpOk1w06yP3Ygzk3JB+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Gyzt8vmW9zu5zvNj7mb6HanQjZLQSj3GcC1lzZUg/MQip9MRanwXYEgPL5bjeoInDqcDaGpLSIMz+JCV7Narw8Z0evrvKN5Szf2XeSIN08MjwAYS7FOkUKG+2a5oD7ZC4KZyIjvb79o0gOsAPgtEJIOT9fGkAXIFwXytYpKYTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AnjlNmbB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U8uoVk029471;
	Tue, 30 Jul 2024 14:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wH7k78DzN2skaTkUYf38VIuxftVRI/yXdAfH8Liu0sc=; b=AnjlNmbB/TepJ/TB
	1vvmb8F21rr7eo4d4iYO5LyeaSMvDsI7AfD06SojfJkvu4BpvK6eKdSLi0PUzOJC
	NFJrydV+w+n+7pSGCYSThwJP7Zy8eCvV2E7GdTiVgPd0LqF00dF/JII24K0xjGLb
	rZthQxtbqT+mOMvPXZYw0tU7O8mFwhzAA/nyHgpzKyteKcYoeKhbfXxHRI/ygV5m
	Br23DLx21qfN2GUxu/tTPEn2BoyfylH0RbazBLRKwXXVdFGCv7lpRe3MkNYFidB1
	2Ygd0sPVxsLXBalgR8ii2yTV/xw7aExHxGEfArceZqS7QU7pnGzE5FvecXEpjTNF
	/b2qrg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pw4411vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 14:43:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46UEhNwu016075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 14:43:23 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 07:43:23 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 30 Jul 2024 07:43:20 -0700
Subject: [PATCH 3/5] cpufreq: powerpc: add missing MODULE_DESCRIPTION()
 macros
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240730-module_description_orphans-v1-3-7094088076c8@quicinc.com>
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
X-Proofpoint-GUID: 2umuwhp08lL3Mx5heA5nQNob1WBmBzpV
X-Proofpoint-ORIG-GUID: 2umuwhp08lL3Mx5heA5nQNob1WBmBzpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_12,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300100

With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/ppc-cbe-cpufreq.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cpufreq/powernv-cpufreq.o

Add the missing invocation of the MODULE_DESCRIPTION() macro to all
files which have a MODULE_LICENSE().

This includes three additional files which, although they did not
produce a warning with the powerpc allmodconfig configuration, may
cause this warning with specific options enabled in the kernel
configuration.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/cpufreq/maple-cpufreq.c   | 1 +
 drivers/cpufreq/pasemi-cpufreq.c  | 1 +
 drivers/cpufreq/pmac64-cpufreq.c  | 1 +
 drivers/cpufreq/powernv-cpufreq.c | 1 +
 drivers/cpufreq/ppc_cbe_cpufreq.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index f9306410a07f..690da85c4865 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -238,4 +238,5 @@ static int __init maple_cpufreq_init(void)
 module_init(maple_cpufreq_init);
 
 
+MODULE_DESCRIPTION("cpufreq driver for Maple 970FX/970MP boards");
 MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index ee925b53b6b9..5fc9cb480516 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -269,5 +269,6 @@ static void __exit pas_cpufreq_exit(void)
 module_init(pas_cpufreq_init);
 module_exit(pas_cpufreq_exit);
 
+MODULE_DESCRIPTION("cpufreq driver for PA Semi PWRficient");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Egor Martovetsky <egor@pasemi.com>, Olof Johansson <olof@lixom.net>");
diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 2cd2b06849a2..9d3fe36075f8 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -671,4 +671,5 @@ static int __init g5_cpufreq_init(void)
 module_init(g5_cpufreq_init);
 
 
+MODULE_DESCRIPTION("cpufreq driver for SMU & 970FX based G5 Macs");
 MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 50c62929f7ca..bc55723b4d87 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -1160,5 +1160,6 @@ static void __exit powernv_cpufreq_exit(void)
 }
 module_exit(powernv_cpufreq_exit);
 
+MODULE_DESCRIPTION("cpufreq driver for IBM/OpenPOWER powernv systems");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Vaidyanathan Srinivasan <svaidy at linux.vnet.ibm.com>");
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index 5ee4c7bfdcc5..98595b3ea13f 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -168,5 +168,6 @@ static void __exit cbe_cpufreq_exit(void)
 module_init(cbe_cpufreq_init);
 module_exit(cbe_cpufreq_exit);
 
+MODULE_DESCRIPTION("cpufreq driver for Cell BE processors");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Christian Krafft <krafft@de.ibm.com>");

-- 
2.42.0


