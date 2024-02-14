Return-Path: <linux-pm+bounces-3891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB818540CC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 01:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FC6288A13
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 00:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D11191;
	Wed, 14 Feb 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MBmkW3MJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8697F
	for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870004; cv=none; b=JHANcMmRDSWL3KVHGkA8JmZCKAsXd1is1MHs90jb3KiXbpZtszg9LQUOV3BzCmimowtVUpQE2b3swsBWRlpaoBrWqrKAYuxlkTDmFerywX+uPLgkHnQNbWUoJIsk7MsNLEdcVwYfmcIzpnG58JnbdlmgaDJmjku61wcWCIYG46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870004; c=relaxed/simple;
	bh=kUtjKcXsjfGznlGgwW+MXLSkGKbgpyMgxVXwr1fs24Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAkVYztUgk7jO0YZj/zacifK90azH622KGvXKlAHqzEpxy1EWRW1aT9TeMd2OH4ZHMW9yJLAYZWNu0U5vckun974QcRN9Hr6N0k/9HLrmRNwbU7nnFuylzD3hMZrZoM1/vddQ4rWbWZclEPcOtZNy8qDhiBHtHLyBvhg/b+qk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MBmkW3MJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DNYGmQ022530;
	Wed, 14 Feb 2024 00:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=0tbHS3CcFvxSF/KOZCdnXXgjJNrwtZ8eQR05Bfb6cio=;
 b=MBmkW3MJIAzsQ4eFmdSrx9L6kCz7rfJ4rBlT+i6SevF5BhkLrZH5xOH1cSs09UEAFFt2
 QmcvB0L6aXr7ZJdC/7j9jmt425GKbs0ipS8dAL/cG2TVDrjRgMNq1ZZjXyWnCME3j7PE
 oG6vI5hIk7gvPsWK3Wuxce6y+R1E+XxAmM9ZeEAtsAGdGEWOoUWFDElhOoxHKKFHV8Gd
 zfEv3gYI+q/HZaOrlllUaC6XWAeiG/RP92zp0o+83KxwTS7UmgDIo+NJCB28dVczCi98
 fwcil5bPYiFfi5KgnbKnLLzqyxVzMIQN+U4wli0Tbyuaf+RP6i3BbyBOUe5Gjj/2eJIw Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8j76r1xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 00:19:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DN3YkI015414;
	Wed, 14 Feb 2024 00:19:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk85jgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 00:19:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41E0JuaB008362;
	Wed, 14 Feb 2024 00:19:56 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w5yk85jgn-1;
	Wed, 14 Feb 2024 00:19:56 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: lenb@kernel.org
Cc: samasth.norway.ananda@oracle.com, linux-pm@vger.kernel.org
Subject: [PATCH ] tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()
Date: Tue, 13 Feb 2024 16:19:56 -0800
Message-ID: <20240214001956.3087944-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140000
X-Proofpoint-ORIG-GUID: BYzV4avMa3CYJjQCIkTFbetDO_YamPbV
X-Proofpoint-GUID: BYzV4avMa3CYJjQCIkTFbetDO_YamPbV

In function get_pkg_num() if fopen_or_die() succeeds it returns a file
pointer to be used. But fclose() is never called before returning from
the function.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
Found this error through static analysis. This has only been compile
tested.
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 5fd9e594079c..ebda9c366b2b 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -1241,6 +1241,7 @@ unsigned int get_pkg_num(int cpu)
 	retval = fscanf(fp, "%d\n", &pkg);
 	if (retval != 1)
 		errx(1, "%s: failed to parse", pathname);
+	fclose(fp);
 	return pkg;
 }
 
-- 
2.42.0


