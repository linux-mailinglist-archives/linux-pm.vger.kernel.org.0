Return-Path: <linux-pm+bounces-43494-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HSkLw7hpmkPYQAAu9opvQ
	(envelope-from <linux-pm+bounces-43494-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:24:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 826411F0247
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55DD9303E1CF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458C426ECD;
	Tue,  3 Mar 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lOF4/l9h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52901426EBB
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544216; cv=none; b=WFIlIgV/idClTtI9eF9iqcDwWWj4+8iJP9kcI5+I8egqvc5GQuYQGXrcPTUfvnoIsjM7EUd2SJets88yhEJ2RO7JXvjtCnAP0X21WAWP/RcMP2goHdQ0D/4tRHJ7NPlcYJE6/wGyRaphgRjUByUVC8GZiCk8PydJ3ogf49yfKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544216; c=relaxed/simple;
	bh=jVvBBV/zsuRMqgxHsBrAH7bVrJpNyNeo1V3ejrzfL3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaTLqslpk/Rv4qjy5sBO9WNC6SCBPR0WHikOwlpTKnA6Om/So2aS1uorwiptbXyaOc5/Q5fhf8LDBAdMW3k7yiKKXu7Fb4MN0YpBo4lyWXgC1FPSuP8HV6Cr7HfHByYyP/6EDMF35wYBwW9A/EY2PSIHtdzHAFjv9aZwEesY6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lOF4/l9h; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a23cf08e0so4591201fa.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 05:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772544213; x=1773149013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2MfjI+hJWOgg7EoLk+8AQIgm6BBATog0kRiTKcn0Tk=;
        b=lOF4/l9hAM7pP5bs/S3dj+isz9QQ6kbLrXBhSD+EIuZzcoOnKVoBGBskRtS/mudFth
         bu3CPknUH3Yx+w3mVaZHn1nA8eRobcba3LwunrvaY9vE2eHZAIPwfBMNCssJdwWd0LNZ
         IwXD3hfujd0yn7VTvdE+08vshnXYFZd+1ldp1Jo6vDdByd+ggOzrZ189YYV8lZ1CCX/e
         VPpbeWrcVyikgRp4g3eeAMQJYFxXRYTHlfvY0cpLFqPxDeAgpkK7yibAtvmIKHKumLq+
         vALUlV7K1/ynp5hJNGPhJpUTjhWtev64bb2OP9B5bFomtuPNgxrcnYcXX15dFXpKhcxn
         FXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544213; x=1773149013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B2MfjI+hJWOgg7EoLk+8AQIgm6BBATog0kRiTKcn0Tk=;
        b=WuiRphDwQOof7j4QtOirZbn4ED+FjDtm/81vf5rVVYtTVWiyJaZh2MPSVbTdgfu4iK
         EM6PU2IPztwVcgGb0zdIm0G8xfqFDT11LEMrEv3KMO85DdGAL6OrpimqO/+TvyQJVGfe
         oI/t8G2F4PrP2ll3aWp12g0LKtztvfgh40FHip2HE+VLDwLJDueU6YH0Ck83nQcB9Khl
         K788hBu7lMsTIlD9U7QX6lgPiilmqrmo34k+R1foBL4la4+0R1ZL2176SLza2EsgfUd/
         rmgyjXpEq9kFSBhDzXc1FCRMSkcjvBxTuNdSE+OikukkgVVfR7D1sYpYMBhMK9WwQTFp
         343w==
X-Forwarded-Encrypted: i=1; AJvYcCUvE+osprXE2hOu0tUA6C62060deJLVnfIUknvINyZmVSCcrzSjdP4LiBlPn6jCF5qxsrE3/EU0vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYzqQ99vX0el33oruwCqXbRYaypA1yvgOHpx8iMhbVBNWKbsJo
	UogcN5HU0+3MjteiZFABTCy1x3boEn9LTwDxVRdU/tSK08Gu/UyGSsuVzMoYERUBibA=
X-Gm-Gg: ATEYQzxWw1yCvdiQRQna5cOnQvzyffStrQWcJguHdumUkr35hPTw4iBTPJKgoWC3aHf
	SINW01fm/KIj75Q6hJUXRNNt/V5Z2+ysckHlYBpodJkDQnbnhIt5M6tHbLlIOPtPEkrYKff69TG
	aLLQo7P7ge/wTe348Ssm3ntIL9GTV9EmbVYHZzNJKs0QtBOvqKnsEnRLtXgoSc1nrdkcGYgVp6i
	VyACSErjQAp9ANYMcI11r7pirRoUx64Fk7OCvqa4MqAw0EQOi5cPklj9cQe3lNqlWB5m81y3ox+
	ssLQR35Nihm4ttG9AqOAhfrr8U1goK4JPSS9KjlVOPy9gM5JyxX4KSesbkQ3Eexoy6dyadIAveZ
	4GI+5poG+J7tqOyzOrGh5WripNaAki+iiDaJfg/khUb2e1n7njpaIcEpFnAFuAx4XObx4/cOOXp
	Q1bnnQ9IkXICJTIBIb9iuLI42PHPSN4MarmbDVihnekc4UfpRg3Cnyf8xbB1AnPXBvK9ozGOSm
X-Received: by 2002:a05:651c:515:b0:37b:9e27:89f with SMTP id 38308e7fff4ca-389ff363a7cmr109584081fa.37.1772544213430;
        Tue, 03 Mar 2026 05:23:33 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235811e3sm587866e87.29.2026.03.03.05.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:23:32 -0800 (PST)
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
Subject: [PATCH 7/9] pmdomain: renesas: rcar-gen4-sysc: Drop GENPD_FLAG_NO_STAY_ON
Date: Tue,  3 Mar 2026 14:22:53 +0100
Message-ID: <20260303132305.438657-8-ulf.hansson@linaro.org>
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
X-Rspamd-Queue-Id: 826411F0247
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,samsung.com,oss.qualcomm.com,oss.nxp.com,ideasonboard.com,gmail.com,nvidia.com,linux-m68k.org,linaro.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43494-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,linaro.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Due to the new fine grained sync_state support for onecell genpd provider
drivers, we should no longer need use the legacy behaviour. Therefore,
let's drop GENPD_FLAG_NO_STAY_ON.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/renesas/rcar-gen4-sysc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
index 0c6c639a91d0..81b154da725f 100644
--- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
@@ -251,7 +251,6 @@ static int __init rcar_gen4_sysc_pd_setup(struct rcar_gen4_sysc_pd *pd)
 		genpd->detach_dev = cpg_mssr_detach_dev;
 	}
 
-	genpd->flags |= GENPD_FLAG_NO_STAY_ON;
 	genpd->power_off = rcar_gen4_sysc_pd_power_off;
 	genpd->power_on = rcar_gen4_sysc_pd_power_on;
 
-- 
2.43.0


