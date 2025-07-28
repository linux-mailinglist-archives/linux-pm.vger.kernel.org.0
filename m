Return-Path: <linux-pm+bounces-31480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46959B13A5E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 14:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C262189CA68
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AA7265CBD;
	Mon, 28 Jul 2025 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgbPobpO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B159265284
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705113; cv=none; b=WDibdt+fSyEQar/2Gczbe9/nxGC+QPzVx2sm91pUV0/pzqWmipdcIey+2Zi9Hx4ll4l9TliONRduJRuzVTstmyufscinICzXQYUKgvqdoJUj8HQEUW2qHUuYkKNSL+ncSrWNi8RDcvjoW0/7xDmPcEzKdggst71xmUfK46BS/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705113; c=relaxed/simple;
	bh=9e95o5ES42Qy3NuMLEhsb824Omv6MBqqtITr/wkRRqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIuBLHvYv7xhipvT+p8mmQ5tB6dPMdXfzkn6UyfJAZhcHsaetb7sWbJ7RBQmtpATM0f9Lby9VD4CWhXmjMup8BYzI3apf7FoazbBwcWFLQKUJRskFdTmxKUYuQCU2CS6i64fBc+soW93+d8RNWI8hDb9ngZa5v0PVq/p7S5uUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgbPobpO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlMlb017619
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 12:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PH6H13lKfyjV9tH+szug2gg9c5coUKwsnv2sFKsLsV0=; b=mgbPobpOpRLovdWs
	oCZbeb8RnIr89dOgOTHFcZuzKAdWJqZ09TJv1nYTQb5tLK8jjyd1D7hC+RRqu+DI
	lHhAUSxK5jViiSFlVbKM4woCsIa5laN+2KlkUXxEuzEZ9VXtaF2pJhkfFFbSnyN2
	pqY7grx0W7XphOtY6sFBpwIeUvSLN7AowbUIzqX1A0Y7BGUmhVFua+oHTp0MbfCn
	oxNiRdjba5E+8heTkAvK/dJblBtlTKBYEyQP+LQHTRDViCw8uYL7MbaY60lUVk6W
	GOIPQzHmgliZpg9uKWgaHKG6BYB47uect26wUldvNx4O9zT2lA71lKbri0N6yqY0
	dhOXBA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1achba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 12:18:30 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70748301f71so15066146d6.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 05:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753705110; x=1754309910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PH6H13lKfyjV9tH+szug2gg9c5coUKwsnv2sFKsLsV0=;
        b=ZsPLzjOroMya57ChP/hmmmlldbUHb7RXRtp1WOPMx6faV8KKEPxfN9U6Z+YYFQcTuN
         WO35AoKDmZSqRCRxgaoe1FMXWt9jGwgp34xCl8SzHHqVuqx60bpt5ToXiM1ddEmJEreF
         1PvzFj1D+fYqA2/vtzJFmia0jtn2YD6264gFKgS7GguIyExHVOK/sMIEK8Wk4KwDreUH
         iYSHQ9SouaLSwE22YlM8u6rEWESLmm0cwgSq7lbzwZ3DDkGI9VMRSppxd97EjKje/Llj
         sh5AnglT4/3UIsBUDhxMoIeLGgjSH7gvniMohxiYQ6IMGba1uJtVq+Br1LJZzKCsxAhq
         Wd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfGAK1uUrlMk52cp5VV81YB4MrnjjbdnnpEMAB8HXA8RqY5sQRTyX/Ofz0ZdjevQWR05FIG3D6jA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Nlvb2N9/ahllI+fbJaGth6VcXAcJbTe5ArSHaqULDjcFqsvu
	AnGBC3a9LPdhcoi76Y7zxbGGeLkCFvaR3FXirNKzqrOoswIOXI1eVZCqtKYo+DHLh0fgNhCXO16
	pnDj0AcEWutxN3fpOwrtR0K3Bv6yHhsusemW/ZLGTkV6Y1LBplavWjrIFI45+xQ==
X-Gm-Gg: ASbGnctm9pa85ZFoq/tboKuOFec4rRaQPNiSEVd7gwMg4s6+0uZf+9PreWzIOqgi5En
	/EvBVf7dUJMD4InAHF7431aFCHxHH1YGtRJP7xqiuyMEHQemyVfvl6Q+CI0typIxXiNTa8tfynM
	XS4BJKYSRou6yeJxHYI2i57iuFJmF5VmgPwgwLrdJSiI5kWg47QpituQy8UiehqUxNIyLujDtb0
	hlHJmUfhlg4x5KtIq09IIk/4Zcxjw5/Jx7JAUfk8AJMAkM3ijVY3kX7/CZFsevKaSpNxnpn3xZs
	t/paOtCl84W7OV+M9kb0gRmt1A9W25ihowwDVlD9ns1Ia2gvYorBB6DduT6y74pblnDJmKhw1Nn
	IWqFtxmqROsT92IGJeUMmqUK0DnCOitk3gG9LVuAAcLAUwKkUKIxK
X-Received: by 2002:a05:6214:e4c:b0:704:f7d8:ed70 with SMTP id 6a1803df08f44-7072062e764mr184819926d6.46.1753705109386;
        Mon, 28 Jul 2025 05:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWy8cl4llv5EfO2hT/ONlzPkHlbcEQWhwDYQ7xVXLCwbI1g9k97zRYjQ+BvR+pAwGjmhFxEg==
X-Received: by 2002:a05:6214:e4c:b0:704:f7d8:ed70 with SMTP id 6a1803df08f44-7072062e764mr184819166d6.46.1753705108653;
        Mon, 28 Jul 2025 05:18:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b633b9d7dsm1241315e87.209.2025.07.28.05.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 05:18:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 15:18:24 +0300
Subject: [PATCH v2 2/2] thermal: qcom: lmh: add missing IRQ includes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-lmh-scm-v2-2-33bc58388ca5@oss.qualcomm.com>
References: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
In-Reply-To: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9e95o5ES42Qy3NuMLEhsb824Omv6MBqqtITr/wkRRqc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoh2qQ1WIA551bGuqAkSUGwM0j9qk0fBa68M0I9
 pHWzOXudjmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIdqkAAKCRCLPIo+Aiko
 1bv7B/9uDaGnWjlngohMhKs+TNAb1XlN2kHqKTyGvo77ZfeJDLKtnk5nciHH4z9DtuHj8VPqGsc
 9LXAIHCZzmEfxeUzXcZZb5KO66i+CR9A7wvqWkFUSMcFzf3zo9t5K7Wp3WsjpxEK8xdFABKqCQy
 fbHHytoHK7GYbE04xf1YHoV0Y7s5x9LDY0E5OWB9LMu9xNjzgY4EyySvTGszMiZGOswXxWg/4SQ
 6RQJRZy/hvfg9+qGj/8OIb7yf/BN6k8VFTi34k7OFgnodHBGw3W4dDNhTifCvKkt+1d1rl+2sjg
 l3OleMkxa3cvRS8+r7iek9v97+2Ore5rVPpgGqJ8u75BtZct
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: UkInwD4gTp9CE4kamQtaTZWNc4OYok8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA4OSBTYWx0ZWRfX1GXJ1H2YLUPG
 6CICk1g1HIKR5lZ0bStxj3nGhctNBTEWmEFeajjVVEHT+XtoufQF0xg/hBq+e/AV89HHUITG7vE
 +z58lIizCcbcvVQjlFg2ETnTiLG6+uENRBnGvCMcDR3JwiAbI1nosiRRUit0bzDdw6njjCj8vSb
 +E/6vaZvn8g2BHAUq+Srq9QiyPY+wS9mnzEmmHjuOFMtzQYzbhEYrcxTZ93npEUcAXial9rXISt
 Bsa+Mw0t9tc9ym+blNqkXQhN27YfqTItuv9Tw1RrcIHeI2ki0cOR5gbCx4ReSfIdN5pxa7anR37
 CeeSeNEDuXgz51fG7vE+gs9pY9yEYfs9ML50I6WZZ1USYexn8ZAk+qJudYloTFO3cyNz9NeC5cA
 M4LJDzI3zGwk6Adz++lATvg+SqRv3F9fUm1GNp5cUNvisn0nLhsCh5+adXWWm2NoAxkFPag3
X-Proofpoint-GUID: UkInwD4gTp9CE4kamQtaTZWNc4OYok8q
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=68876a96 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=im9EaX7qKpYNKp65MTYA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=909 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280089

As reported by LKP, the Qualcomm LMH driver needs to include several
IRQ-related headers, which decrlare necessary IRQ functionality.
Currently driver builds on ARM64 platforms, where the headers are pulled
in implicitly by other headers, but fails to build on other platforms.

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507270042.KdK0KKht-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/thermal/qcom/lmh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 75eaa9a68ab8aad7f7dcb575b3ea34b9a12a0dbf..c681a3c89ffa0b9aa0713d6db45f444cb79bcf03 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -5,6 +5,8 @@
  */
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/irqdomain.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>

-- 
2.39.5


