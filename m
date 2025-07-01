Return-Path: <linux-pm+bounces-29891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16490AEF709
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130041C01D9B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E568F27381D;
	Tue,  1 Jul 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7F/pNaq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18A25A33A
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370470; cv=none; b=NOjUd2kPfwJ/k6jxMzw52Dp+Owcbyj4rWgsxciTpEUW18vzST2fReO8lz3WX2JUhTGS6X0f+KRdmK4tWhMsaFzZd8pJGNPI7qn1PT6Pu8nNDN/IYQWNoHwBoiQHOBPM0jpgrmoWv5ZNHZw1VJdmK9ugZ+urBslZfIyxq04hkqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370470; c=relaxed/simple;
	bh=pVRpR1S2HDeRvzXbIKzoXt5qvVDcQEyiyD3SHvPQFTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHyUy5QYsx62rMkv+i92GW8WDz4VpCBcwssNnThglse275b76j/Vbp44h67+vpIof0+KKp3o0chey+5ZMluN63O64LdcH2bpcJnpeahDW+BjiG2vr/6FdaaAQFGhZurgIYGXa2kD1J1EAPeJpmeSmhKwuLKPfxUbdYFVbahbRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K7F/pNaq; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b5165cf5so7449235e87.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370466; x=1751975266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2djU9nLQ8VglyUcEstpnVg4eaMTkukRCnzKizHYIlO4=;
        b=K7F/pNaqRYDyFQ/EFhymu/ZSYXH/sEhGgIvSutg1yhmCnVcLQLYpRUKodic1AKfch1
         FeGGvyfoZ9G8/el3XEXIODLUl0uzlFyHrU7CjdeNpgrDn+dGhoS5fMn8HZSbgg9GOWor
         +GXECQz4piZ8ZFy9Br8mLwMkvfhoaqFIKTr2OpszLeWNPuodjnoE1X6oNWBFW3e50Ukl
         aH1oPp/EW73dIsChLheHsU5Xb8CSbE+ebPZC2Owb+3luzPimp2Gp9ICSCFIvPZuF3wFs
         07ay+pYT9X4yGgOPIPerRxA/zlc1iPbFtI4g4DFwo93Ing4x6B55CtLXnnXDjQ/cRdTR
         R3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370466; x=1751975266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2djU9nLQ8VglyUcEstpnVg4eaMTkukRCnzKizHYIlO4=;
        b=MUBChA9LYJdJkgY8mCBEUJ8zlV7Olz977wWSNiPjDTtHrOY83OFri7p+J/mmLFGhUP
         Y6gG64heStAjll2WG1gVkEnaRuZtBHD6KsPe6oFNQrx7U1YVLBzrNd5snerI1oWj6Zo+
         p8jIfxtgUTsAON6NLRUOIQlkj/EmLBum/Lulb/6QyvYdh0pL9Xl8/sg72GdRdATgjYIq
         NpVC8ULlwiXU6vzNTEfinli1GWo/KlAsG/Gonh787AKevEtYxWmx3yC8ylHmcOyHARyy
         7FzH3nHCGS0cjPvHf+cwNboteSCavZ+v4mjndgylJEtzlv3ROeXFIjwoLbc9kweMVWJF
         tiTg==
X-Forwarded-Encrypted: i=1; AJvYcCWGtDH/z4bYhiuzOV8f5UxFvLXaJ03ya2os9bJqeUwwD7nKsAjug8BXhQdRi2aHmORi7PIOPqFnWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWZGeMHQsnN5z0nXVHWrZRHpWvQjRdNqQsTd8RH8s4uvZ50qB
	A+D9o52WmKqUrc9QddBtxmRIwKNhl4T4Pi8LjfBcoGn0z0rCfWGmrTBuc/bjXYnhn4g=
X-Gm-Gg: ASbGncvohdwvLWbLJopsJmCwCryVpPLyLI0wha2gF2agTMBadBCp19whnbCiW6aqY8+
	exR1HQWCOA4cwe+SwVCDMfqpv/gUR6Inf6foYOjxUSbcP77fGSIrc4kEIcuuhWdMkUEkTCKLHuW
	pMdtveg70WYHQXbrLMIWkOJok7sAba8BJUH1WPJ5ey5u6iKpCjQCQBBIUpUZSUeludKkziWyTen
	ek6AzugOerkku8/pCC25XLZNHsxb0Meqw/4oLZzKhx2diCDneQEHahhuEQlmsAgYF35yiHSyXkg
	araonsu/0OjTQpKN8HgOALoE4NpvXX0doQjrui9XOBBR5K8lx+XmU+6xwxwQenlwClKfN7S5Y5X
	O7IbneaYpfxCDaoFedauF1zlIAao2CrRAA1x6
X-Google-Smtp-Source: AGHT+IFk1+sM2wFrURHBujkY60jtzQNdzYc3WqI7dzo+D/13c4kVHtOgYXZqpdwPvp8P1wttj8OecA==
X-Received: by 2002:a05:6512:b86:b0:553:2154:7bd0 with SMTP id 2adb3069b0e04-5550b869fedmr5078899e87.5.1751370465534;
        Tue, 01 Jul 2025 04:47:45 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:47:45 -0700 (PDT)
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
Subject: [PATCH v3 01/24] pmdomain: renesas: rcar-sysc: Add genpd OF provider at postcore_initcall
Date: Tue,  1 Jul 2025 13:47:03 +0200
Message-ID: <20250701114733.636510-2-ulf.hansson@linaro.org>
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

Subsequent changes to genpd adds a limitation that registering a genpd OF
providers must be done after its bus registration, which is at
core_initcall.

To adopt to this, let's split the initialization into two steps. The first
part keep registering the PM domains with genpd at early_initcall, as this
is needed to bringup the CPUs for R-Car H1, by calling
rcar_sysc_power_up_cpu(). The second and new part, moves the registration
of the genpd OF provider to a postcore_initcall().

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- New patch.

---
 drivers/pmdomain/renesas/rcar-sysc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index 047495f54e8a..4b310c1d35fa 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -342,6 +342,7 @@ struct rcar_pm_domains {
 };
 
 static struct genpd_onecell_data *rcar_sysc_onecell_data;
+static struct device_node *rcar_sysc_onecell_np;
 
 static int __init rcar_sysc_pd_init(void)
 {
@@ -428,7 +429,8 @@ static int __init rcar_sysc_pd_init(void)
 		}
 	}
 
-	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
+	rcar_sysc_onecell_np = np;
+	return 0;
 
 out_put:
 	of_node_put(np);
@@ -436,6 +438,21 @@ static int __init rcar_sysc_pd_init(void)
 }
 early_initcall(rcar_sysc_pd_init);
 
+static int __init rcar_sysc_pd_init_provider(void)
+{
+	int error;
+
+	if (!rcar_sysc_onecell_np)
+		return -ENODEV;
+
+	error = of_genpd_add_provider_onecell(rcar_sysc_onecell_np,
+					      rcar_sysc_onecell_data);
+
+	of_node_put(rcar_sysc_onecell_np);
+	return error;
+}
+postcore_initcall(rcar_sysc_pd_init_provider);
+
 #ifdef CONFIG_ARCH_R8A7779
 static int rcar_sysc_power_cpu(unsigned int idx, bool on)
 {
-- 
2.43.0


