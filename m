Return-Path: <linux-pm+bounces-34237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9B6B4AB65
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B4718889E9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068FF32A3DB;
	Tue,  9 Sep 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuLQFk05"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF8326D58
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416302; cv=none; b=UUuilxeGVYQZv3rVpShkawHh2qAj9vaNAcVWgMvAykchLp8+OZU7IsnZHGnEXiD5TP8Tmfi2/g/yYhFAA/ISqYL1LjyBmxOkkaXg2Bfnhx72l3QLipbs0Z6VNHSXc+fRxhhPHIbdY4xnU6ytuGH/2w8/XGWgXYjBOt8EqjuU7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416302; c=relaxed/simple;
	bh=VvUp9qnNE7LRT6dFMEFfaf+OTUSJqg4fih88UVXdmOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcTMaioQNbTwZZWiZOXojeLW6YIPDXuruJDtgsyCes/ERUq1T+vocZOQID71opbcc8SHKxqeoUJw+4FFsr5PrWOX/t2KKgZVpo3Q046KRn1Bmb7RTzh9D2DqdEfU/IWtB8owPk2b7nyZzZVnQdnntAvE4VEjwLPGaz6SZqko3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DuLQFk05; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f6f7edf45so5204417e87.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757416299; x=1758021099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euHGryHJ8QWDxT7cesCDLU1KtKBsI9gmyEIIx1smyRQ=;
        b=DuLQFk05D+BPKDPUDpp2569BQoR8/S75dTvna+F3aeNY35eq3z544ToC3I7nxQK6NR
         OWWlIYgJ9t8di+7aaCkfYClEh4pdqvYe6fD6zvyibNuZHyec3zN41lgNzEo7ogbFI6an
         ZhiBHkBFZWf8dlLeDfPey66TuwQ+Kg/r91v6olnwVJ+r+6Gez7tSOCAj11ib0XXNl8j4
         DtDq3rD/0eZHPgzWOIM3SM2Gpz0SZB+2jNUkAeeb1UsrqMpT/t3IT2xnLhzLv/StZY5B
         Crj2iZtWaAjItfrELWHI0yPzxYxzX2MalV0gYUmbMuj5ay13M9hLidDSrJskyYaWk2ck
         QLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416299; x=1758021099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euHGryHJ8QWDxT7cesCDLU1KtKBsI9gmyEIIx1smyRQ=;
        b=n4YK/BCt1JnmauY9J9mZSZMaooy51SQFNGEMGammUnKmJbBrQEvmphAOBKr7nViBLi
         Xgfs+F7quKDa8aa+kTYP1wjTwsUx3O6p3y4JZbMbNJ6Ll2yEcZSftojhr2xYhbtbbM/Q
         tKNw7mnYhjfbwEslEHt7eKExH5/xPNXWLrXTwBWVv0noluKilD3fOuAv6Us1hX/CWAfK
         1ejCuuNN1Ewc2hYtvfvqQivEj8YU/fNfqm3Rx8weN387cE4IGTIEkGDRdF24E2BVbig8
         /bitV93f1sr8GWM4gDlJwxCXvT1dxEQ1qORrOVFg12ih6drrw4ZdAfJkqZrGrucNzmei
         Oa8A==
X-Forwarded-Encrypted: i=1; AJvYcCU/pq+MxlF+5A/8yLW8+Ydf4tPHCV84ctb2/FsVqSgBBq1ETtJAmU5IDghJiAN89nmzA0ESJgX9xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9E47HcEzHJ+1EJIHvcfy1uQyPdpuwNSEPJ2xZ0Ou+4/xIv14
	35JSCk9sBvZU3sz+APB7yNvJBb0GoA3w26sTd3shsR4yfzGTDUM4hQE2OgW21EWyTFA=
X-Gm-Gg: ASbGncs1i5KIH7eeP4YCZmVn4LCwsfRp9dve4E+hHNCf+okfVryFWsmiPab/QkfSFOu
	nNS/uCbkYVMg6VbMeyQ1yUeiGGfHyKp9qBGP5RAupJ3qbl4+SGmOhjWSC2ag/MuPz8d19gA8aj3
	3wFUEJfVldlCN82adn/ZMhEKxTi2YMVKVd0Jlm/IrP85BeDZYzZFV4oPT160TnHno5hNeyp+x+a
	DMIkW3PfouvRW/qlIHb5Y5U+T/S6OLRRim0jTFehOB69jF6bmDqIh53ZtSOQ7DmUyjsQmHjGd16
	EniyfWKJiqmqG8g7/UyfThv+F4uvEleGCFqgpxMVPnpYcjuUZ38ATdiGfEmCs3hN2aoK8ak5HIo
	YIrpuD6N+QzeBkLlYQzO4jF75kCdfGKj2j79g8XVK4cycDBW4VUZ+z7RnWHJZXCjEjjyD8qIQfi
	dGH4iTTfI=
X-Google-Smtp-Source: AGHT+IFfaEg7KARMsiLKzyUcPFhDsGf7F+a3gcOB6C+SVsQx9Fu2a+sXO0Qgm1wWuW8uSP6aIC1C1A==
X-Received: by 2002:a05:6512:108a:b0:55f:4db1:e450 with SMTP id 2adb3069b0e04-56260e3b836mr3025626e87.22.1757416299071;
        Tue, 09 Sep 2025 04:11:39 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-568190f8040sm445440e87.148.2025.09.09.04.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:11:38 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-pm@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Diederik de Haas <didi.debian@cknow.org>,
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
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] pmdomain: renesas: rcar-gen4-sysc: Don't keep unused PM domains powered-on
Date: Tue,  9 Sep 2025 13:11:23 +0200
Message-ID: <20250909111130.132976-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909111130.132976-1-ulf.hansson@linaro.org>
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent changes to genpd makes a genpd OF provider that is powered-on at
initialization to stay powered-on, until the ->sync_state() callback is
invoked for it.

This may not happen at all, if we wait for a consumer device to be probed,
leading to wasting energy. There are ways to enforce the ->sync_state()
callback to be invoked, through sysfs or via the probe-defer-timeout, but
none of them in its current form are a good fit for rcar-gen4-sysc PM
domains.

Let's therefore opt-out from this behaviour of genpd for now, by using the
GENPD_FLAG_NO_STAY_ON.

Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/renesas/rcar-gen4-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
index 5aa7fa1df8fe..7434bf42d215 100644
--- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
@@ -251,6 +251,7 @@ static int __init rcar_gen4_sysc_pd_setup(struct rcar_gen4_sysc_pd *pd)
 		genpd->detach_dev = cpg_mssr_detach_dev;
 	}
 
+	genpd->flags |= GENPD_FLAG_NO_STAY_ON;
 	genpd->power_off = rcar_gen4_sysc_pd_power_off;
 	genpd->power_on = rcar_gen4_sysc_pd_power_on;
 
-- 
2.43.0


