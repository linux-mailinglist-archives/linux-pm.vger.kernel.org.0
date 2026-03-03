Return-Path: <linux-pm+bounces-43495-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OM4NqbhpmkPYQAAu9opvQ
	(envelope-from <linux-pm+bounces-43495-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:27:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F31F02DE
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACDE030C8BB4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 13:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC7436358;
	Tue,  3 Mar 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjfBDXMZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0744301D6
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544219; cv=none; b=NfNMTcUTBU55NxcCf1yIOFlzqXp4LL7YQZaMEZLlMdH19WEw5wrB875WVjDLY0Dm+6ZFJD4TtowX1n5kz/uqSTq3EqQZv/AAjWqHzff0BwnzMywKCbMJO3kgaxnnxVgmp/5ycTX1bAl8U1LXaQIbRSZD1oT8O+H6Q5uxVTSbhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544219; c=relaxed/simple;
	bh=ZdxakSf6jx6HjMVNW2n3RsPo1XInrHuWIUjvjrHnlTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rj7Wjcd6Ohk0PcqPs4KsqaojjPx52m2PjPB/wCC3txxDNlTRCzo3mABQh9B5SPZE+/U8D0FDgApCFQEc8wUilzy80u/8dkZmnCgTYY/E5ldtCcm3dihTPvCoXp4Q9Hb+PVB7kC3+Or+kWzTuXnHzIgSmtxC/6qYra9foUVhZxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SjfBDXMZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a26b4d830so958881fa.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 05:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772544216; x=1773149016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/KXJvU/AAYNqQHp5ebH3wq5fKE6yFx6Fm3sAczFSPc=;
        b=SjfBDXMZZd/CA2/QEbgz3fr+fxofHPsmgK8CyIBbADZ8qfUP0D+S5UvQLwYTa0dYoz
         1MSl3zF+2EzFKWhGniXbAEGVj3vISuOJRDL+Hd9fe2EOM1HM/nr31SuAAY8yklV6IO10
         sCgoTdHskrQpy1svLgfLfbKDM2+fuNzzs6xqz8bkX6kTcqie+xhmNbPqJy2GTANu1qBE
         Oe1Oty9DiagK9KjXvjT3h+fIpCubs1DdEq8QB+lE2p4wYDhUhVaQMDDBoH8bs/lk3rQH
         0R2ZgPtUBys2Jr8s5osr2U7wrpboU0muVdaJu8XzmJJgn1IHkRM71IURqLsf+V84j2p7
         zOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544216; x=1773149016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/KXJvU/AAYNqQHp5ebH3wq5fKE6yFx6Fm3sAczFSPc=;
        b=wol3BHZUTEaML3H+GlEG0Vr/tmgxal3E9DncTS6RSzCfnlFMraFfnH9DLqQRYb914D
         h6EFYgYP1twNIg8vMOI6Zz3Ml9n0ZAL6rWWZxG1VJA3gdt9rrKhOQkH2TwHafOi2Ra2p
         3FL1VaesPHBXNBXYZUUn2hQNN0M6PZKK1F5sHrfYg993YySBMma2DNVCf4wrQcx3L+Kc
         wV6hDq1A82uF0C+qegnMaQ7iJCwtihD45Q2iIF7+rpLA+7W4fiM6Tytwu4pE/YwDBu9T
         +6QqWZhS4ZquThsn/6YY/yA4eFRZ9eN92a3rhKuaS5jPxrn/zoRoe7PZAjNKIw5eDavC
         GImQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPrWjSHUwxp0WXP52wtPC+2YrCsgtBmWsSCEvzfaIzCk/mQsyyuRE0tf+itZkHPh54kBc4HWrzyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrAfIIzbhZl2Y+ya5afTozpImUbpMDk/Awnl2/QQeoKGehmbYi
	Xo8gWyl5ncEYSE1kgz5Mh8/mGTajrY4OB+nNNVZ4vBji2+dM9bu9w1/nPzqMIW/Tyrk=
X-Gm-Gg: ATEYQzzQdLeEzNLABfa4yUNo2tuVUIbcRnDPQA2gY3Z00JFxZG/VQp8rKCRUbaxrLC0
	4o0dn17Oq7VNsZkFroiPU2Gi+UangRG7yxB/1aJSMvOd2IULHlTBXcEJk3zk8zbgjJocVmk0rsZ
	08Z73u+RjmLRTXlIvaaePgBw/FrHSbJn7+rtxxcW9ecBGCD1LwM84Bz6c6ivnaHPJhDUS8G7V4O
	ek5BDdXFESsZHVvZiMvA1owO3i/v5/sXZYjKoYEra93m7uFsTYwhioiOPjZN7jkKPWrazMSncJq
	WVSBRP0M5Sgpkbyp43ZoMXC2yJzEnVFWAqfkSa0XrBPznYvj1k6JVa4bQRiRmOf1LEj6F1YSya9
	+My/xuiy4SQKas4oZIHf40h5jtV3RUUtyldeKHtWyDisagwvtVcKmUGlQoIfspuD4wvkfhVfZJZ
	Ul902XQVQEIxGAy/sB2AlvgJ1iHcRPKgD9aTYYWSVTnC4PEtdi5kpEuvg0h7/i0LBY5voGAEia
X-Received: by 2002:a2e:be8b:0:b0:387:197d:207a with SMTP id 38308e7fff4ca-389ff15e1c7mr126006401fa.26.1772544215824;
        Tue, 03 Mar 2026 05:23:35 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235811e3sm587866e87.29.2026.03.03.05.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:23:35 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] pmdomain: renesas: rmobile-sysc: Drop GENPD_FLAG_NO_STAY_ON
Date: Tue,  3 Mar 2026 14:22:55 +0100
Message-ID: <20260303132305.438657-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303132305.438657-1-ulf.hansson@linaro.org>
References: <20260303132305.438657-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B4F31F02DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,samsung.com,oss.qualcomm.com,oss.nxp.com,ideasonboard.com,gmail.com,nvidia.com,linux-m68k.org,linaro.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43495-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,linaro.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Due to the new fine grained sync_state support for onecell genpd provider
drivers, we should no longer need use the legacy behaviour. Therefore,
let's drop GENPD_FLAG_NO_STAY_ON.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/renesas/rmobile-sysc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/rmobile-sysc.c b/drivers/pmdomain/renesas/rmobile-sysc.c
index 93103ff33d6e..e36f5d763c91 100644
--- a/drivers/pmdomain/renesas/rmobile-sysc.c
+++ b/drivers/pmdomain/renesas/rmobile-sysc.c
@@ -100,8 +100,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
-	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP |
-		GENPD_FLAG_NO_STAY_ON;
+	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
 	genpd->attach_dev = cpg_mstp_attach_dev;
 	genpd->detach_dev = cpg_mstp_detach_dev;
 
-- 
2.43.0


