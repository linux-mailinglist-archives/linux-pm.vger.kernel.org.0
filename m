Return-Path: <linux-pm+bounces-30144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87EAF9880
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757853B483A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFE5309DA3;
	Fri,  4 Jul 2025 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nSerBA09"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D9309A42
	for <linux-pm@vger.kernel.org>; Fri,  4 Jul 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646932; cv=none; b=oTtDDBoN4XzJy8FaI+3EocxDZRZZp0imVoAV7Pz6+BYoUir5jJTShSsVYBJSwfaXDgKshg400VQ9ALg+aTgjOqcpdUjEYRxWMyHc8YyIlBIDZU38y9A9b/TX690G9+mzgudmrVWEfinFfG2pQNxXefEwNXrQRaOet1KJ3gvNqZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646932; c=relaxed/simple;
	bh=CyevXooayJgTRHhip0Jc/dJHXf5dF8Ulyrh+9bR9yQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDYeY5OjTS2ccvMt049RchzmCzoXNnUKNoprclw7S6Koxms4mOYRervEF8IolCk5DAZtln9lRuddae8mYKceDF77xDgE08jyxxyS6FlWcSNx9OAD91svAb6NNFeH/U+bYuCScTc4QjK21z9bmbfSdN9oddrclr0oDkXqyhutUvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nSerBA09; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564948YB024889
	for <linux-pm@vger.kernel.org>; Fri, 4 Jul 2025 16:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dDGlOHr4NgcDVCXG2RQ6GCKnY1CV3e4EG2J6GhifJ9w=; b=nSerBA09waORPynJ
	9xIJz0oKz7EZXriAz/0jiZ8Beju0h6pQcRh8kaZY/ZzRZ+goLMAL36IOkzpvDUQN
	AGNDulFozzwVO87CwSOZ/aHjPh/zofT0q951mI6dmNmPzRYuoRG7rPo1FWefinLv
	ZBB+m5th2K4N5WNAm3bQctupngU1DU79iE6c6QTt51rFHu5ZG80OQg68lEvG/pFa
	QVuSbRpnipGyKbzF3nVLNrNsvFu9chtsZpnpMkg9O5Y/0IhcFsbTdF/J+nQ/Oews
	qSpyEcaWxDGDwFtEgEEhrhg7eaVznJ83C1/V8YqFBXFXJfZFFFLbPgf+4O66zkiR
	Dl1CwA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j802c7jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 16:35:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d399065d55so130384785a.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Jul 2025 09:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646924; x=1752251724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDGlOHr4NgcDVCXG2RQ6GCKnY1CV3e4EG2J6GhifJ9w=;
        b=uc3LZAetmTPilO5U6jxOTluu7avQalVO4qGtxSGP7EIxzpj9pMR1zEpd+CQViYMx3b
         2IXemhJhL1I6HWsjAKFmTT/A9AZsWo6LrmlKdF1NcpSpTE0v2fev8UVQR53y/vknpQQh
         UU7aP1ljT8maMhg1hxAyPOq5hll+4f/oZlF/lUW++bRyUGchymWfaHbvC/jELpdWz/mU
         7cWMMcbHE4tmR/mNUFA2ihqKsyNTZd7J/ht4qTV23hU/mG2QDq6aVvpi2gX97zozQbil
         zEygs5tDB/YAEWiUsMRsJYdXV0Q0YkL6mlRFQdxnwFR6tJT9T2p5Ty1fFkQ7LUlxV2kl
         1W6g==
X-Forwarded-Encrypted: i=1; AJvYcCXP8FEjkF9x4K3GnHXQ3/s01wkH7ZBth1AOmsWDvvt3PYpwEoYHnHy3R3L8gMaRVynFXv8inFbbCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTBaHf/212oGFW+HE3FNFsPSnH1eHs9KNZEGwl4dkQtbCXKJV
	/3iMgmQLf7rsLTCmc3S3pJKssjAsRd2bAyHJ/3Npe+Eg8oDPsLNXZp1MwMRhqJ3N7RSOfvVg6ob
	hG3vm1Ns8OWFNgD8F4dZZOw1QWlYMqQgeb/pukKaY6742KHR9m7yQYpIRIFG8cw==
X-Gm-Gg: ASbGncu2l8SLEsc97YX7M07jyp+N4k7XZZ+ATlzoAzwFCJyYeOlfqqgPs4rsq5yxl5g
	DE4k5ddXMK71YuC+3I3VBF9+slaKjF24WM/Yq33XD6OX/pTl7RmalYrvZntafGhq4mg4JxcGvON
	u/jTIJCY4VigUbS+8KCzRLJ1KFWDtC48VpSgbC5mGHhxLOCQitHTAPcC/31EAiUhrO4LUfJwDVo
	MmSgowHRQ2S4lTlboZUw7KYY4R+cvdscG/lotJvvD5kNylts2LDATh3yCEyZ5f7nobiTn1pF2U7
	Wyf7ygEQHQ29rdx/yv9neM8QHM/fNTzJxoyYZnWfFRgpCF/FkuCJD943yU62BmWNIbeqv9zDSrY
	vcTc9avDpzJELT19tugxVaACWa4Ax5CBuyvc=
X-Received: by 2002:a05:620a:29d0:b0:7d3:a61d:9e4d with SMTP id af79cd13be357-7d5ddc5f858mr369919385a.45.1751646924186;
        Fri, 04 Jul 2025 09:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLgf6c81tKZ5NAfW7cyZOGRND2Paw2Q8ymoDznjdqog2ztFHlBz2dit3m7A9pCGMNdlb9WBw==
X-Received: by 2002:a05:620a:29d0:b0:7d3:a61d:9e4d with SMTP id af79cd13be357-7d5ddc5f858mr369916485a.45.1751646923757;
        Fri, 04 Jul 2025 09:35:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d33f3sm298321e87.68.2025.07.04.09.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:35:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 04 Jul 2025 19:35:13 +0300
Subject: [PATCH v2 01/28] interconnect: qcom: sc8280xp: specify num_links
 for qnm_a1noc_cfg
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rework-icc-v2-1-875fac996ef5@oss.qualcomm.com>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=814;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CyevXooayJgTRHhip0Jc/dJHXf5dF8Ulyrh+9bR9yQI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoaALEUkxoA8bxEagDcx68Lh+2gKsTDnXtlpWqL
 z73yeeeQoKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaGgCxAAKCRCLPIo+Aiko
 1ZoLB/981MU0dCx+HBy92JpsRasCdM8V5lTEdIQ5glGSvM8ujEutrmleQROs5AEti58NczfoDVf
 w3aW/RCp4hwoQzl1XnckcyPI57FAGlpIsKPVIjG5/MUdKW6tbcA7xlJWiFY2QBIZSxTSjxkQg18
 OfhLyfBlk9SohYp2u9OALgOsjOypY+xgY7Fwn9y4BJvGFTeaWqC5+kKCnv+L+cBMf6In97xRrcU
 7StHoIns5j4BrGgvgAwGsZiTsIboQZZ5/dfbojHPLNeGqaacpYlFuPxMFldh8mLl/SMj97K8Lqh
 l8+RZgWT4MEPf82rbJ0C/g7UHTnN2arKI9OF6U/ppawN8YAg
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: SkpFf7I3jnfbM2X3H02ZGJ36RboDA0va
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=686802d1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=lLMxHPiN_djQrzgEttIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: SkpFf7I3jnfbM2X3H02ZGJ36RboDA0va
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEyNiBTYWx0ZWRfX1JnI6w2KEXn0
 gNxHa+cgE5CwioXEcYLMZZ1hHNeoe/wf7oD6sTmRleQdrMSWDE7wTVUURDAUPuR6cm3xeQ4pKWN
 hfMtBwtA9BXrlrhpQ4suw3w3SAx43ZCpLsCa33LdsZGTDeBe26P34YxXgbBHIxannMSdcY/pRfQ
 s7QALHkIibeWWNayi1c91eNnKZ4t1gpmyYvBOueXr7OlN1VbMyjClKTy1eUmzhbFbKqjl6LkNVR
 v805388I382tmdRN20Dkv1zLh7eWI+XtWqHJJSLH0kUFmfIROlPitSD5hKFvp7dZ7l4xSV93x3S
 saMCjCEMjE1wJ3PVCGG3Dyqp1RRBKDn7Bp4sXwchDlJyi6UQvasdyM78ARdKlVYA+YQnQ0/AYKI
 dj9pViEgqVYjhG+DzpMX3NxQzVfUU+VLRXqclUQyk7E2Cu+2hTy9I5oPv0fI/oaIWfaxTjQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507040126

The qnm_a1noc_cfg declaration didn't include .num_links definition, fix
it.

Fixes: f29dabda7917 ("interconnect: qcom: Add SC8280XP interconnect provider")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sc8280xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 0270f6c64481a92149cb19556acdc6e2fead39c9..c646cdf8a19bf6f5a581cd9491b104259259fff3 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -48,6 +48,7 @@ static struct qcom_icc_node qnm_a1noc_cfg = {
 	.id = SC8280XP_MASTER_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
+	.num_links = 1,
 	.links = { SC8280XP_SLAVE_SERVICE_A1NOC },
 };
 

-- 
2.39.5


