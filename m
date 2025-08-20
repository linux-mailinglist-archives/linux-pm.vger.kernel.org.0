Return-Path: <linux-pm+bounces-32683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C0B2D65A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 10:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7422B7A5DEE
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D392DA767;
	Wed, 20 Aug 2025 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DhSXmS1D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D52D9EDF
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678551; cv=none; b=Soec86Aa9JCyA294RXZF61Eyn7jagu4YvSG4aCN+N9fku2iIV9WaATeJVA/NzXo41qXvPQr3UagpHhwKXiE2C+GDjrDttfuAHdUo3ohfr4F+J++t3VjJ3ftu/XuQnF+ABqrJYZ0SF/6+203uOmJIho1gt+QC8Tq2qP2hdDIkofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678551; c=relaxed/simple;
	bh=qbiTA97ecG75CN8dtvPjbRcNXFdrEC8SJKen2afmr8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSMfQUzTmaEP+onJTTprZADK92mxleYwv64JkR1/ZsenD04s7crv9GGtny7XAWWqfTUEw5piCLafOtIbRQdlD8jZddrq+DuNfqM5CViwVcAnfHAMq32cNnIETIehwMAf/Lk+GI5GWYHJzp0Jk91Gzj3tnGp+v51iPJEjdkyOzWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DhSXmS1D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oWiU006118
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wWW4BGFpCWnZEZLf1V0C0XICc4F6I83lE+aOEu8pGoQ=; b=DhSXmS1D2tEcfEs+
	0F1dr8C9vF75Db1WZpcBehjJyqnZDzAmxIQ/2eeLoQGP3x6SaOX9iU1elAFGoZY3
	Pd787xDJ86WbgVE8OhdGxRlX+Xt4F6zGna6qkpocWZNJ4s0BjNSxlGG3MCxP1mmt
	jwioZudGCfVFco/FfO6AqEi7BpmFOVrdoTRbA8FncN/Dvg7ScApr6WwtPnf/S++l
	Zq+BHogpGSttwdOaZWk4hY1IydOIi2Is880jq365zlQ0o3OWbOdlBkBRA1otn8wa
	fvaRxnSk/vG+TKCkCNqzgO+cWBXmy5sIwl/Ii/hdtSNUhi5Ka40LJYFtGlgRNnFA
	K/lB4g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290yn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 08:29:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f42254so149193625ad.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 01:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678547; x=1756283347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWW4BGFpCWnZEZLf1V0C0XICc4F6I83lE+aOEu8pGoQ=;
        b=n8+WEMNnxzJXt/OEuXQ+qaPzDnOcsqIGZx0Ak3g56yJAvv9wC8zOdf1Ag+h/U/wwe3
         UPuGR4iRfOXo+RhSLPmvTQM4QtkJqLyTObiaqJyL96biA6BpOf++HpdNU3F4valW3fgI
         Ft5+w4Ex62yrBbSFcPd5eFqve/U4KySc8uLYg8rRDYQXeeNoOTgRXrmrmWA/DVTpjoJU
         WISAal9T1QvVcOYlfQq7HE8WWUkdpZvnjM1luZ/bBTeClvCD0DqFrAYMkotAAoMTpk1S
         YTrinByP1AHKTv7TKv445rQhTpO0TNPddwv16CM9/EiJ06CIjF95aDu199A9HcbB4bSE
         keVA==
X-Gm-Message-State: AOJu0YywrruU4oRVVBfQRboS17ydM+KY5lvEVqmd2QSnlgjyqJyQCGuc
	vxM2ezQujbGM0u/WSfPGqyKcDrPSjxCrmnhabFVh5Mlt+cD8xZDSxd6bAXraro2hOSb0PZvYbdN
	qeDa8Ih9iA+UbyOLa7Wlea+P0c8ia42qAoY/x3LK21E72kx9gFnYBcYVJyUV1hA==
X-Gm-Gg: ASbGncuppXD+wieGiIQJpEbNEWW75A56aDj2DsTktPEFAEPi3BSMGNjojTN9ajVpIdF
	V/mt9cMCumKEalQ1lrLIJ8IDbyKDaNu3At6H5z6T3rOmlmZ0gWig4rZSk66eBQsP9TVob7mjPJh
	xEJfvh4JQJ+iwFkB4TC0m+SCPN8QJ2OXeWShln8c9lpEAbbkyUma1vvMOasBRRW/LLA8xXtFok2
	p/WAmrRyj+GX6AgX6uolN8OFvOe07FNFYKqgCd/9u9APEZon6dsI8vGI2il0jpUwzYXrwcnUEIl
	2DK+ADK7K8RsltLatYax87QAB7k1mcHHFGDnFSGOkLHs1wlqViy6wS97MMW9gZ8659IO/kwfXsk
	=
X-Received: by 2002:a17:902:ec88:b0:240:a430:91d with SMTP id d9443c01a7336-245ef0d5915mr22618735ad.10.1755678547499;
        Wed, 20 Aug 2025 01:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSJ1H1k68/Z9d58rrQY87Pvbazso9gHhcBZnMUte8gdhBHonHKpDa9vvaIPOQgp3qW13nehA==
X-Received: by 2002:a17:902:ec88:b0:240:a430:91d with SMTP id d9443c01a7336-245ef0d5915mr22618395ad.10.1755678546826;
        Wed, 20 Aug 2025 01:29:06 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:48 +0530
Subject: [PATCH v4 2/7] OPP: Move refcount and key update for readability
 in _opp_table_find_key()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
In-Reply-To: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=1497;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qbiTA97ecG75CN8dtvPjbRcNXFdrEC8SJKen2afmr8Y=;
 b=Y2kKzNaAKkSTFkX+ee44JG1EL0b6zaOZsUtgDls6JWW7HqrCg8Dons6oSWblDqtIqytD7X1iJ
 PylRDO/5ugsA96VHM0f7uTAOTYikgrV1LorOMCRMWAuPEYWHOKoTpC1
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a58754 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Zg3aejBZfcS9hqUhyUQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 2Q_ik14orzch4O4HysvqFIYTeu8mlWmg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzPLj9cGVA/G7
 9GSmP+MvXxyUxFH05YV10SaVkrfEe2QtorMiFixZjUJaF67kHkXewgwixXDV7chqiE7jPJQDBYP
 88zVpAoW0bD3WH8VJMmJoonvqLB9haiIdLyP5hRUEMEl+xm9GI7aXEbiWfqkWHPjfo1Hsk+nm+t
 AoAQ4WW0HAG/GS3en+kFmmzgVlbtE6IEXAP6wnMtjr1+/lB0LkcQnWnOhBa9icZm6ue/dn/d8RA
 Kq4PHQp9fgVFXrkPuU/ygnqVrjlGlxD7S2DTt5ttVSQfawQMxgCfKktaZAMOwPWQHvo4oNWjefe
 Q1UV2+kRXkjuXoRlbQ23AkVz/DCqZeEqfT144YoBLXTMfHgL9yT7kYpoK9oNkUJpMaM1Dl7ILgJ
 YeDyRkIR+G4p/Peukw1+W437ciC+bw==
X-Proofpoint-GUID: 2Q_ik14orzch4O4HysvqFIYTeu8mlWmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

Refactor _opp_table_find_key() to improve readability by moving the
reference count increment and key update inside the match condition block.

Also make the 'assert' check mandatory instead of treating it as optional.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/opp/core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a36c3daac39cd0bdd2a1f7e9bad5b92f0c756153..bf49709b8c39271431772924daf0c003b45eec7f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -544,24 +544,22 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
 	/* Assert that the requirement is met */
-	if (assert && !assert(opp_table, index))
+	if (!assert(opp_table, index))
 		return ERR_PTR(-EINVAL);
 
 	guard(mutex)(&opp_table->lock);
 
 	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available == available) {
-			if (compare(&opp, temp_opp, read(temp_opp, index), *key))
+			if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
+				/* Increment the reference count of OPP */
+				*key = read(opp, index);
+				dev_pm_opp_get(opp);
 				break;
+			}
 		}
 	}
 
-	/* Increment the reference count of OPP */
-	if (!IS_ERR(opp)) {
-		*key = read(opp, index);
-		dev_pm_opp_get(opp);
-	}
-
 	return opp;
 }
 

-- 
2.34.1


