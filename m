Return-Path: <linux-pm+bounces-12038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781394CC68
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 10:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB157282ED7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C7D18DF93;
	Fri,  9 Aug 2024 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A6gj3Ghd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6C175D2C;
	Fri,  9 Aug 2024 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192665; cv=none; b=XJsJm4CZ258TFRcrsGpbSrJHL+85iWIELfOfVxoqGSQFVfLaExpeM+Rzq336NAkZbxJnQsaSbbvFqgz/xp6ddQp+hzRPEyKZ52PQYlwLNldrzs+v6vZT0Q0dEpEQXSTEo3+mwBTl3s467I5yYksCjZMkMWyFCC1tGtqJamdEaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192665; c=relaxed/simple;
	bh=DbdiK35ZHT81xhZmlHoEBlBPpDomQgJ+O53QLRkanhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZJg5KdlveJml0HVOubkmMFAbOzpnok4xnUQujRCW2+oO0YzKwXT2tSzGVWp6a3jcac7oDRzhOEnE2XnOZiiu68slTIInYi+7NOzJClwjlVJX08Gzkyv+km+vtLP3gxZXzpyhBiEkeCc/MDTARHIUyA7MymFsO4uk31dyEIhWhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A6gj3Ghd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4793wA2p004168;
	Fri, 9 Aug 2024 08:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=bdXccOGBFHWMrbokfBqeUhJBKL
	haWV+1EvEX0h4uN0U=; b=A6gj3GhdqEhurn7bw9q33efnqUazpjApy8wJfPYhq8
	kueOCKtoMiPVGbMiLpdduXKu/wmqG1bSjtLGcIz9cCh0JKZNFgA+opUZ/ieGWYSy
	7/D//OWOSH25yO93VNxOAT7AiuNc0ioFgd1AbDQWX/h2EBZmxB7zMlCaFeFxelCL
	J8CfUdV7z0EafpPwiri+Kr9Y47lgLKv2tZKS34zR9HO38TbxSsb8CfUyl8hcki5y
	vCAGDA06s6pmR6B/6Qhk2KYYPFxsc5gxlIt9tVtS3VNDtcgSZyulo/wqKoFclyh/
	9vTMoKfEnjDREHDscPyu+wKtmAJr5DEJL5aL+O2iYA6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkcjc1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 08:37:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47975MpV024212;
	Fri, 9 Aug 2024 08:37:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40syvptp6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 08:37:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4798bWIj20709722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 08:37:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DB9F20040;
	Fri,  9 Aug 2024 08:37:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DDF12004B;
	Fri,  9 Aug 2024 08:37:30 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com.com (unknown [9.43.8.213])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Aug 2024 08:37:30 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: trenn@suse.com, shuah@kernel.org
Cc: aboorvad@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tools/cpupower: display residency value in idle-info
Date: Fri,  9 Aug 2024 14:07:28 +0530
Message-Id: <20240809083728.266697-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SS0vondixuuV1bKYk5yeH-CljjIwIpYe
X-Proofpoint-GUID: SS0vondixuuV1bKYk5yeH-CljjIwIpYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_05,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=802 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408090064

Update cpuidle tool to display the residency value of cpuidle
states. This addition provides a clearer and more detailed view
of idle state information when using cpuidle-info.

 --------------------------------
 Before Patch:
 --------------------------------
 $ cpupower idle-info
 CPUidle driver: intel_idle
 CPUidle governor: menu
 analyzing CPU 28:

 Number of idle states: 3
 Available idle states: POLL C1 C1E
 POLL:
 Flags/Description: CPUIDLE CORE POLL IDLE
 Latency: 0
 Usage: 7448
 Duration: 207170
 C1:
 Flags/Description: MWAIT 0x00
 Latency: 2
 Usage: 7023
 Duration: 3736853
 C1E:
 Flags/Description: MWAIT 0x01
 Latency: 10
 Usage: 18468
 Duration: 11396212

 --------------------------------
 After Patch:
 --------------------------------
 $ cpupower idle-info
 CPUidle driver: intel_idle
 CPUidle governor: menu
 analyzing CPU 12:

 Number of idle states: 3
 Available idle states: POLL C1 C1E
 POLL:
 Flags/Description: CPUIDLE CORE POLL IDLE
 Latency: 0
 Residency: 0
 Usage: 1950
 Duration: 38458
 C1:
 Flags/Description: MWAIT 0x00
 Latency: 2
 Residency: 2
 Usage: 10688
 Duration: 7133020
 C1E:
 Flags/Description: MWAIT 0x01
 Latency: 10
 Residency: 20
 Usage: 22356
 Duration: 15687259
 --------------------------------

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/power/cpupower/lib/cpuidle.c        | 8 ++++++++
 tools/power/cpupower/lib/cpuidle.h        | 2 ++
 tools/power/cpupower/utils/cpuidle-info.c | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/tools/power/cpupower/lib/cpuidle.c b/tools/power/cpupower/lib/cpuidle.c
index 479c5971aa6d..0ecac009273c 100644
--- a/tools/power/cpupower/lib/cpuidle.c
+++ b/tools/power/cpupower/lib/cpuidle.c
@@ -116,6 +116,7 @@ enum idlestate_value {
 	IDLESTATE_USAGE,
 	IDLESTATE_POWER,
 	IDLESTATE_LATENCY,
+	IDLESTATE_RESIDENCY,
 	IDLESTATE_TIME,
 	IDLESTATE_DISABLE,
 	MAX_IDLESTATE_VALUE_FILES
@@ -125,6 +126,7 @@ static const char *idlestate_value_files[MAX_IDLESTATE_VALUE_FILES] = {
 	[IDLESTATE_USAGE] = "usage",
 	[IDLESTATE_POWER] = "power",
 	[IDLESTATE_LATENCY] = "latency",
+	[IDLESTATE_RESIDENCY] = "residency",
 	[IDLESTATE_TIME]  = "time",
 	[IDLESTATE_DISABLE]  = "disable",
 };
@@ -254,6 +256,12 @@ unsigned long cpuidle_state_latency(unsigned int cpu,
 	return cpuidle_state_get_one_value(cpu, idlestate, IDLESTATE_LATENCY);
 }
 
+unsigned long cpuidle_state_residency(unsigned int cpu,
+					  unsigned int idlestate)
+{
+	return cpuidle_state_get_one_value(cpu, idlestate, IDLESTATE_RESIDENCY);
+}
+
 unsigned long cpuidle_state_usage(unsigned int cpu,
 					unsigned int idlestate)
 {
diff --git a/tools/power/cpupower/lib/cpuidle.h b/tools/power/cpupower/lib/cpuidle.h
index 2e10fead2e1e..2ab404d40259 100644
--- a/tools/power/cpupower/lib/cpuidle.h
+++ b/tools/power/cpupower/lib/cpuidle.h
@@ -8,6 +8,8 @@ int cpuidle_state_disable(unsigned int cpu, unsigned int idlestate,
 				   unsigned int disable);
 unsigned long cpuidle_state_latency(unsigned int cpu,
 						unsigned int idlestate);
+unsigned long cpuidle_state_residency(unsigned int cpu,
+						unsigned int idlestate);
 unsigned long cpuidle_state_usage(unsigned int cpu,
 					unsigned int idlestate);
 unsigned long long cpuidle_state_time(unsigned int cpu,
diff --git a/tools/power/cpupower/utils/cpuidle-info.c b/tools/power/cpupower/utils/cpuidle-info.c
index 44126a87fa7a..e0d17f0de3fe 100644
--- a/tools/power/cpupower/utils/cpuidle-info.c
+++ b/tools/power/cpupower/utils/cpuidle-info.c
@@ -64,6 +64,8 @@ static void cpuidle_cpu_output(unsigned int cpu, int verbose)
 
 		printf(_("Latency: %lu\n"),
 		       cpuidle_state_latency(cpu, idlestate));
+		printf(_("Residency: %lu\n"),
+		       cpuidle_state_residency(cpu, idlestate));
 		printf(_("Usage: %lu\n"),
 		       cpuidle_state_usage(cpu, idlestate));
 		printf(_("Duration: %llu\n"),
@@ -115,6 +117,8 @@ static void proc_cpuidle_cpu_output(unsigned int cpu)
 		printf(_("promotion[--] demotion[--] "));
 		printf(_("latency[%03lu] "),
 		       cpuidle_state_latency(cpu, cstate));
+		printf(_("residency[%05lu] "),
+		       cpuidle_state_residency(cpu, cstate));
 		printf(_("usage[%08lu] "),
 		       cpuidle_state_usage(cpu, cstate));
 		printf(_("duration[%020Lu] \n"),
-- 
2.39.3


