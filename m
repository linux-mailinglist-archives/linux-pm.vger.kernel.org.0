Return-Path: <linux-pm+bounces-29896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCAAEF716
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5AC188491B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A362749CE;
	Tue,  1 Jul 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/nnYi43"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B82741A3
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370477; cv=none; b=Fu2WZD3Z5ilFXzKIRJPWHS7alup6N+fPGzP4p7keUkezWjNtZWGGrBZ0+KREfA9qdOy9R/1MzWfPwFw5SU6Zc8Dclx+7uBXN57bmsXuxrmj1JFL5hapo1HgPIKMWXFfUQ3jUp8XS0CneIQ08/e90wljdMUM1mVg8xGocfs/9SjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370477; c=relaxed/simple;
	bh=nFPOWBdB//Ck6xl2DT/3pkreVq/YJsj3c20cNby2iqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uH9ygzvS36yRWIZJ+NnStoLV8s+FZWW1OazyFnNmdpDlPCNoEOUBTyoiIQ8j4ucvCfT92oe1CYYsLzs+JfWHVSjPjc97h0SIz/li98QI1cAmokc6tYwoTDrYkykmhphHtR+dp/iC+FRnxxtXyv3ojxDkd6l9IYIRyrW+MjhqKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R/nnYi43; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553c31542b1so3663391e87.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370472; x=1751975272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+3aTAl+M+lH6zTTjz5VE7X6/AIzvFAfUkESBddcdw0=;
        b=R/nnYi43DYcyZn9jeLxu/NtnWdedk1ylXgJcBl9yg4HtwX2pzXyw3uLIIIUDWB+KKK
         Cb2eSb9BJpWNz9GTu/dyb/uB7cqrAhDdRP2o0d5LKov3f619tRuFCDPOthENsbwADXDa
         F7oSKGoPX3U7Xhkb4eg1heSI6mbgETnmajvPOgsEjeN4qnaZs8K8p/1PfWyEUuinHijT
         5uJGabmd+LQJhhF5JkZZALbF9POkxWyNWzjZI7dIG0QcguT6cW79f46ILHyc/VvyRvF6
         bkQCEgxYoxatOp4XCMXoe9g1H/CPvVNzMO65SDx1kjHOAtoSFzmtm90iqRj/6GSSt9Bv
         UkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370472; x=1751975272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+3aTAl+M+lH6zTTjz5VE7X6/AIzvFAfUkESBddcdw0=;
        b=AlX+BVmcFtS06egj17TquQonfykP15b5OCDSOLeYM80pnFOa9wBrsd+65RFmMvsbLS
         3+JMgtiP209K4TTfRjqqcNlK4T09lSnkdbWjsYhpn9W2NduvOJ1h/9X6/f0ZKRLugBTG
         DpLG35DMpiztTDsugDi9QFu+UyzRhTm1InjXhO0BSxlmSgNtVRSKGIiDsZ4gVnZimLE8
         Vbt988Qa8QXIItCPJAgzV/N1lCC6A7iNqkAUl4ekqJo2FgVdiE8YIkzc/amNUKklPTZy
         yK/6E0aQeDkpspbyDVh7jlOK4HiTX97XA/cum5TGJdrSDvwT5bSmQNFnYe1QrCuSs3MH
         ID5w==
X-Forwarded-Encrypted: i=1; AJvYcCVPiiOZC6blXbOTVO0Er/VKljs8VEG/ytxgyqOUOp58xtQvk8Q/Az03NVQWIWEHcjnfoRkwZWiUgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/eTTokicoAnlAJUNwm6trHWWdufAtgaBhkvELxkIMf+Lw/6A
	DC/kqxbW6guE1IrHkIrxJZUiHnKVT8sNBNvGyn5bUa2WOL/ED1mWXHW+86OVQboL8q4=
X-Gm-Gg: ASbGncscDr2EEFDxSOXVYWWE22R1RmjHCaWb5/w6qFHyg7mNuUHPzneJIADjK/z7tDb
	nPc79vZ8QCe/fMjOmQwMF3CSBPrzE//Amdwh5tLh2vIFCEnSGOR/9SQhuEYm9m2DpwNd2mnWfQz
	iFBmNihPxadYm5d2Z89KueKl/6rEoWbINobEIh36K6mVbBkXbuTyfrFWjrGb6TWkjVDkX3xoFbP
	vpJlaszjL8YmaEYskamFIpxzLDu2wcSRqZD/agw9vpjKYFZZ1mHz0d/nHeHDnABvUgDR00Ht7vz
	dUmBrjH10zPt3baeO3Hxs20sZecGT/1G1lc3Ru4eJHFxVBiYDafxpu7zYlORIUsB/NWjpu2/S9h
	I6EColoCQC+V6RHT2QN4/1zHfXYOovzaFw9xV
X-Google-Smtp-Source: AGHT+IH+YI+owf5uflw/NB8o85eX36NM0PJWNRuH/JFBRyImY1nsQEgV7d/scYEuexIuCW8Xp7EgQg==
X-Received: by 2002:a05:6512:3b9d:b0:553:a2c0:da70 with SMTP id 2adb3069b0e04-5550b9e5d1bmr5690955e87.26.1751370472237;
        Tue, 01 Jul 2025 04:47:52 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:47:51 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/24] pmdomain: core: Add the genpd->dev to the genpd provider bus
Date: Tue,  1 Jul 2025 13:47:08 +0200
Message-ID: <20250701114733.636510-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To take the next step for a more common handling of the genpd providers,
let's add the genpd->dev to the genpd provider bus when registering a genpd
OF provider.

Also note, to allow us to add devices to the genpd provider bus we need to
make sure the bus has been registered first, which is done via a
core_initcall. Hence, calls to of_genpd_add_provider_simple|onecell() must
be done after the bus has been registered, else they will fail.

Suggested-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Prevent adding the device until the genpd provider bus is registered.

---
 drivers/pmdomain/core.c | 44 +++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a41f5f91e87f..79dc0bf406f0 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2611,16 +2611,25 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	if (!np || !genpd)
 		return -EINVAL;
 
+	if (!genpd_bus_registered)
+		return -ENODEV;
+
 	if (!genpd_present(genpd))
 		return -EINVAL;
 
 	genpd->dev.of_node = np;
 
+	ret = device_add(&genpd->dev);
+	if (ret)
+		return ret;
+
 	/* Parse genpd OPP table */
 	if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 		ret = dev_pm_opp_of_add_table(&genpd->dev);
-		if (ret)
-			return dev_err_probe(&genpd->dev, ret, "Failed to add OPP table\n");
+		if (ret) {
+			dev_err_probe(&genpd->dev, ret, "Failed to add OPP table\n");
+			goto err_del;
+		}
 
 		/*
 		 * Save table for faster processing while setting performance
@@ -2631,19 +2640,22 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	}
 
 	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
-	if (ret) {
-		if (genpd->opp_table) {
-			dev_pm_opp_put_opp_table(genpd->opp_table);
-			dev_pm_opp_of_remove_table(&genpd->dev);
-		}
-
-		return ret;
-	}
+	if (ret)
+		goto err_opp;
 
 	genpd->provider = &np->fwnode;
 	genpd->has_provider = true;
 
 	return 0;
+
+err_opp:
+	if (genpd->opp_table) {
+		dev_pm_opp_put_opp_table(genpd->opp_table);
+		dev_pm_opp_of_remove_table(&genpd->dev);
+	}
+err_del:
+	device_del(&genpd->dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
 
@@ -2662,6 +2674,9 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	if (!np || !data)
 		return -EINVAL;
 
+	if (!genpd_bus_registered)
+		return -ENODEV;
+
 	if (!data->xlate)
 		data->xlate = genpd_xlate_onecell;
 
@@ -2675,12 +2690,17 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 		genpd->dev.of_node = np;
 
+		ret = device_add(&genpd->dev);
+		if (ret)
+			goto error;
+
 		/* Parse genpd OPP table */
 		if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 			ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
 			if (ret) {
 				dev_err_probe(&genpd->dev, ret,
 					      "Failed to add OPP table for index %d\n", i);
+				device_del(&genpd->dev);
 				goto error;
 			}
 
@@ -2716,6 +2736,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
 		}
+
+		device_del(&genpd->dev);
 	}
 
 	return ret;
@@ -2748,6 +2770,8 @@ void of_genpd_del_provider(struct device_node *np)
 						dev_pm_opp_put_opp_table(gpd->opp_table);
 						dev_pm_opp_of_remove_table(&gpd->dev);
 					}
+
+					device_del(&gpd->dev);
 				}
 			}
 
-- 
2.43.0


