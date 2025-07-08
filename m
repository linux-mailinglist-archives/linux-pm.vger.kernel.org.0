Return-Path: <linux-pm+bounces-30332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E327AFC1E5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 07:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91161AA521E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 05:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5E179BD;
	Tue,  8 Jul 2025 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cPzSo74+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0DC3C01
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951733; cv=none; b=tBGXJH63ctUaczAQPgWJm/fuP/x5QjGaLfvRbvNjcedY610HK1M+0bQEEwjteBv6VBrWz4WRsqOwtcjJHtqQP1TQWLffKhc0RwmLbL+XOTjVTR4bRkJe9Gou1yxsNZfjxeA+HDw0VJQGKoBsRhWYJAa2FlY6YbBdkSB7z70Hskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951733; c=relaxed/simple;
	bh=GUJSgzOY8x5DejKin8CVk3+3IlMrgKHiKe+11HLlue8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qWjkE6KsZRbsFVF5paUJTF8Jx2JS8kWhvXTcJh6Pvw0e0E7Pj+ndBhRnRQb0/C6HIN8JomyMbZWoQJe8CQNxWuoawLekeu7/D59UuOFO7lfb4VU3GIwSq5HNhHrrDzSod6CsO0+HYM0Ah/TR68+AI2pHabUmwtEa/ZfFYN8esfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cPzSo74+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567KDbRM016356
	for <linux-pm@vger.kernel.org>; Tue, 8 Jul 2025 05:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/HSqkRbY9szwwusjkZtKjQ
	6nKbk1f+svXsRXYI4M81U=; b=cPzSo74+nj/KGQ1378O/KfiHLuExkNFZ7Trk9G
	IQMfmkQnBTnxRTxSWuP86qxN5KwhUAYiLqoo6ZkQl5aqC7ltRerHhpZSl8S8rZXU
	7nkcujHVhgPQ/SeGqxqjj4GPegs2UJy57+/aXSumc6IAi5natgTGnIg5yNsPj8ox
	W1nOhdJHIkQxJMDV8LGx6MYvO1Qy75dvuyxTE8v5HUdOpX/gPaQJfaOOopobL3Kj
	rIh0DpDmQLzHVywhCbNyEtM+bJ/XrXHJMMBrsdo9O30/iP4qOuG5pYSl/T2hHjJr
	msBfIwIeHR3MdTnQYtkFSzlCinT5bAtVyhmJKdIiMuYAVeTg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefb2s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 05:15:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748a4f5e735so3940813b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 22:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751951729; x=1752556529;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HSqkRbY9szwwusjkZtKjQ6nKbk1f+svXsRXYI4M81U=;
        b=UHy+kBHe6eeKU9oxh7tJpw0BYIXHrccFLJBjFiyh6s+TKp51zZtol3RJ6o39He2LXI
         VXGpLkvvull7vFNsi0CmfSFy1uU2zR7/tDAKpfhiheoHPYjpjtdBa9uWpEfHQ5lS2cOu
         8LWRqEBdCxDLL7bJTnHFYfQmZJ9upY3OJ3XuVyxA5wEP38yXNfAt3m7QWpUV+dpO3vdv
         U90KgebgbTz89k9VNXP+mHnmK9SmmRZoyWjOlrcbdQkcgXWY+m3McB5B1CRFuwX6pEmu
         AUlRbayapfl+4c6Qo+a+H1KOdRI/IgF0BvIfTxGe1IdLEzqaa/NSidB7kRaz394JLzRi
         23XA==
X-Gm-Message-State: AOJu0YxqaIKtFemglI0NaJFUMu6/LBL6t3IaGUB5N4Htxz3lwlkUnqRQ
	JnfqvH2T7VNWdUoDH092BtWTj5c+foFFvXxwL99okAeCERfwALRPCRfCPghIXYyMkmZ9P0wrTvS
	/IpZrbTM0TA6Naol0pq0ALFhCUDltV8Vxy/0rPmY7DwLFZw6coWF5lp/ZXAuJLg==
X-Gm-Gg: ASbGncvSc5m1w2A3l69+xt2dn01hbFQgElBWj9VrTvAtYw5OuV7bSdMnwhVqbkUAcvF
	GSRwTC9zEYdp/WuMIHIADx4r1BU42EyXrKpHSBGr4O3zVkiVZ1HLFXGFAaFm3aGqLM1IRVotj7W
	C4Ek2nWBKj8kIZycgyngHWxBGGNgPDumoYRLL7PBZtjLZGrnuylyN4wFeiaFwTZP84O89X1da9r
	1GigJpceNim0RFqAZSh56q8JHE9sfS8IDG3Sy/cuvit2fXTowM3dmSCyUxsuIbko/aWG9gmInMS
	MiiJFYwmly7Q941TvmX+7L84JhvyWvyn+Yms0ndkm76qANT0Xv8=
X-Received: by 2002:a05:6a00:1143:b0:732:2923:b70f with SMTP id d2e1a72fcca58-74ce8aa78bemr21625651b3a.11.1751951728827;
        Mon, 07 Jul 2025 22:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWmkhsxSUYNC8evqge2XX3eLE+VkbL2hIvI1Ch/Jog1n3y7SXxAmFfLl7RWA3RYfevNd5ARg==
X-Received: by 2002:a05:6a00:1143:b0:732:2923:b70f with SMTP id d2e1a72fcca58-74ce8aa78bemr21625618b3a.11.1751951728323;
        Mon, 07 Jul 2025 22:15:28 -0700 (PDT)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35ba014sm10372397b3a.19.2025.07.07.22.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 22:15:28 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Tue, 08 Jul 2025 10:45:22 +0530
Subject: [PATCH] pmdomain: governor: Consider CPU latency tolerance from
 pm_domain_cpu_gov
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-pmdomain_qos-v1-1-7c502f4c901a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGmpbGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNj3YLclPzcxMy8+ML8Yl0j0ySLlKQkMyPj1EQloJaCotS0zAqwcdG
 xtbUAmBocQl4AAAA=
X-Change-ID: 20250703-pmdomain_qos-25b8dbb623ea
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751951726; l=4135;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=GUJSgzOY8x5DejKin8CVk3+3IlMrgKHiKe+11HLlue8=;
 b=mjMF7cpCyuZ5q2iTEGjYPktKBSazU/v/OCu7h/vxnvASBk8RBnWtU/e/r+ChvS+CodjfoMc5Q
 QzxImPH7MO8A8o4nKEbKiX9O6jEuQ4f1I6x1DqX8JCUM1FqixtURsT3
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0MCBTYWx0ZWRfX7OkFvTxhg5M+
 38TKedX62/xSNiwETEcPixUr4rQqTcAqyO+2hJXFDHl0IgZm9ro1tETPmNY154yohcZg10zRqLD
 XoFmUMu2EE9Ux4RuG6ZB0SWwGbDH4ZTOhYkml5n9HBN5nRSSyv3Sa+FOD9xSa/GYg1mNhfjVIxP
 3EAiSnyigZIrI386ZxBfUMWL6fdk2o4TFu1UGF/SqR71TIezKik0V9YMEBKNlRxzqPV+wi8v0Q9
 IPJ3vlX/iYmpVki5EOUE9qe36Y21g4NBlZnRGug8sTF6PisCNA5aB9jSsHUpWeDLlm/Rn+8sNKh
 QGynEVDhCxbWEsNct0cjOmAsIK9uTbjGXqTdAXVKu87aHoygHL2ltv3O85//gugqLnB8GHJmHui
 Iva+aYOGCfgnQVKDtyyw/Fn2EQLY6+esRUDPZw9jZaHA7tEc7DyAQTpNUmv2svmnZYx05jjW
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686ca972 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=pR31FINYhqodxwX9k7wA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: OK1V1I7o70N3AvKK2qvYyxoCgxUz6RtT
X-Proofpoint-ORIG-GUID: OK1V1I7o70N3AvKK2qvYyxoCgxUz6RtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080040

pm_domain_cpu_gov is selecting a cluster idle state but does not consider
latency tolerance of child CPUs. This results in deeper cluster idle state
whose latency does not meet latency tolerance requirement.

Select deeper idle state only if global and device latency tolerance of all
child CPUs meet.

Test results on SM8750 with 300 usec PM-QoS on CPU0 which is less than
domain idle state entry (2150) + exit (1983) usec latency mentioned in
devicetree, demonstrate the issue.

	# echo 300 > /sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us

Before: (Usage is incrementing)
======
	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             29817          537        8          270        0

	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             30348          542        8          271        0

After: (Usage is not incrementing due to latency tolerance)
======
	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             39319          626        14         307        0

	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             39319          626        14         307        0

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 drivers/pmdomain/governor.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index c1e148657c873a6b5b4d9c0f058d54cb020c56e2..d5ac4c1b5b5a432f0072209d17379e58ec891202 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/ktime.h>
@@ -349,6 +350,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	struct cpuidle_device *dev;
 	ktime_t domain_wakeup, next_hrtimer;
 	ktime_t now = ktime_get();
+	struct device *device;
+	s64 cpu_constraint, global_constraint;
 	s64 idle_duration_ns;
 	int cpu, i;
 
@@ -359,6 +362,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
 		return true;
 
+	global_constraint = cpu_latency_qos_limit();
 	/*
 	 * Find the next wakeup for any of the online CPUs within the PM domain
 	 * and its subdomains. Note, we only need the genpd->cpus, as it already
@@ -372,8 +376,16 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 			if (ktime_before(next_hrtimer, domain_wakeup))
 				domain_wakeup = next_hrtimer;
 		}
+
+		device = get_cpu_device(cpu);
+		if (device) {
+			cpu_constraint = dev_pm_qos_read_value(device, DEV_PM_QOS_RESUME_LATENCY);
+			if (cpu_constraint < global_constraint)
+				global_constraint = cpu_constraint;
+		}
 	}
 
+	global_constraint *= NSEC_PER_USEC;
 	/* The minimum idle duration is from now - until the next wakeup. */
 	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
 	if (idle_duration_ns <= 0)
@@ -389,8 +401,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	 */
 	i = genpd->state_idx;
 	do {
-		if (idle_duration_ns >= (genpd->states[i].residency_ns +
-		    genpd->states[i].power_off_latency_ns)) {
+		if ((idle_duration_ns >= (genpd->states[i].residency_ns +
+		    genpd->states[i].power_off_latency_ns)) &&
+		    (global_constraint >= (genpd->states[i].power_on_latency_ns +
+		    genpd->states[i].power_off_latency_ns))) {
 			genpd->state_idx = i;
 			genpd->gd->last_enter = now;
 			genpd->gd->reflect_residency = true;

---
base-commit: 50c8770a42faf8b1c7abe93e7c114337f580a97d
change-id: 20250703-pmdomain_qos-25b8dbb623ea

Best regards,
-- 
Maulik Shah <maulik.shah@oss.qualcomm.com>


