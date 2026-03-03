Return-Path: <linux-pm+bounces-43496-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMm5FLDhpmkPYQAAu9opvQ
	(envelope-from <linux-pm+bounces-43496-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:27:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C192A1F02E5
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8DAB30C9DF8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66770438FE4;
	Tue,  3 Mar 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ag312Kro"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0964301A5
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544219; cv=none; b=tHTOsy+uqriTfbDzbVHQRA0Xpjv+l9oUPLvGP+EXLW6ppxgTqY6eqScsTjpJKVKEF+lKTHvsBkaBH/ScvPNyr9pxM+h702ts50lNIqymYbzraQcQhFRoIgXf5eNLfCBuizBb3B9Lu5NgDNFa9kzmHdhEPl/buVP/up8sjT5KxtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544219; c=relaxed/simple;
	bh=HKlFck/FAja/HueIxvm1gVErLwG96G8TBeIZBi+S8vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBCb6hmtKQF15TcAbompojTWFu6OHot78FC+Qrs8+S2/UwNqV5VmzbvKeLpp8LGnnsv/2pzmm+hx+4PcwxoDabp2cjF/PS+gZzvlY9+gZJafOP7Ku8OM95Z30zVQFkNTBBRQOJWBf3mFkvLtynsaN5KD2nyJKXWfeO+N3Phj+J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ag312Kro; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-389f200c26eso82746491fa.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 05:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772544215; x=1773149015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjWtw97EefBuIXKvc4rM905LfmUWExWCySCPbaqXUa0=;
        b=Ag312KroB+f5X0noKX7ECecqjY0P3rL2RKtIV4SOijx0BYmenXg1fmiy7SjEq7opCK
         d+YzlBZHFIds8hl+4kMFVVPvQsu9u0MVaHBym+yTAFjwXMS1LIczSajPCzQ0VZjNvW03
         4kTTUpOzuNarawrdznHRC6SAEAuRUTmKiULlojqxDhljQmtjXEfkwfYb2PfCSflqO2Bf
         nyNo0qRfj3j/j8gBclrnboI43FVZKbA2vbKEPm3SDbfVcL9U3mjoJz2ZliicUkUHPO19
         uT5dZllaMmv+neEP9m1SykI3vSIsjirOPdiRGRTqv3kRuhel/YKOfnz9kzg0Pw1caa4m
         +HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544215; x=1773149015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MjWtw97EefBuIXKvc4rM905LfmUWExWCySCPbaqXUa0=;
        b=uAQn/0PmkPKkhfx7mEI6T4vdJWIfS6tAhYBhs4F1O3Lsh/PQUR40Umx8rQCpISJJVu
         Bci2e8G6kEz3+hIG6vtokQL5CUdvuu8FfOqLMOaBrwwhM1zdMZdsH9aOsV5PujdUSRce
         QEOaR6kLMil0M6bYUMdx4mlHeI136VH7u6MIirQqiy40+TBWZSguC3WGRI4FXb/taDJm
         F9wlFApFa6l5LV+2/VcRvctWcMR1fYUL+YDbWH9iqkWLaMnEHj/aD/q6WjyzjrACFDyE
         QOeIHGrcFtEgzVTc0WL9wYncSitsCdJWhlPRULQRBFpuAUdSzc012OeTlv+sItRHLDk7
         bDNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgT49Dy868a9Yizs7ZHU+AmO0Z4+DGYDO0bJb8ottsRJqzqhey8BKq1/sSSpQrHoOJBgXmyhhxjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsy9E4iEiuDz+hXA2Lexoqyf5UpcqLTZ2O/0sbyP3PWco11/a
	wI/qK5k90+25QDImgOvZ/4HVZFGDbra40Lp3Wyv4LBmsEiJ5uUqcwqk857SkLNY8Kyg=
X-Gm-Gg: ATEYQzwRlynfS/Izr3ujRABcElXCzBXVkVcVcBkBHswrNPEXr45jZHfDwpcVXJN8qQ6
	i+wiPismt8IGDLmjATG1b2g/gyYRyuiNNqWVeAv2I9ZBRgGtBI2HTVoLA8e5A0urC0UNfa0o8FB
	9QGAiWiJvUBjyDjtx8azwW6SPhB3AeyrBIJ2nB4jGFXw/rvJNeCTVyKbfjUmF5Pb9BpRDe87zv9
	eErHQA8zfYCrP1MAQOsRUJGGXs/Lpmb/utK0D4larzJq5+HZ237d78+d2eaad7stIEPUuZwCjSL
	puBswUgGA09pyl5a/3fs+42a8bWGCoCfFdG677KYf1zyOQ2g08dnNmyzg4ioEBdfNrJEZYfN9Y0
	/kPE0NVQFDaoa7vYPtptSXa1nVMEWUH1rSnKX1sh73Fn/SdnuFg5XW5QeKjW2/8lzFIL/YQdaRM
	JkOEa754AApnxeLjy0+1+DoYZt4R7cb2/XihM03H5lN9J2u5j5TmxE9DuNCK0y0ikr/9OQ3VZ7
X-Received: by 2002:a05:651c:1507:b0:38a:203:be8d with SMTP id 38308e7fff4ca-38a0203c336mr90018001fa.31.1772544214722;
        Tue, 03 Mar 2026 05:23:34 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235811e3sm587866e87.29.2026.03.03.05.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:23:34 -0800 (PST)
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
Subject: [PATCH 8/9] pmdomain: renesas: rcar-sysc: Drop GENPD_FLAG_NO_STAY_ON
Date: Tue,  3 Mar 2026 14:22:54 +0100
Message-ID: <20260303132305.438657-9-ulf.hansson@linaro.org>
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
X-Rspamd-Queue-Id: C192A1F02E5
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
	TAGGED_FROM(0.00)[bounces-43496-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Action: no action

Due to the new fine grained sync_state support for onecell genpd provider
drivers, we should no longer need use the legacy behaviour. Therefore,
let's drop GENPD_FLAG_NO_STAY_ON.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/renesas/rcar-sysc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
index bd7bb9cbd9da..e4608c657629 100644
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -241,7 +241,6 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		}
 	}
 
-	genpd->flags |= GENPD_FLAG_NO_STAY_ON;
 	genpd->power_off = rcar_sysc_pd_power_off;
 	genpd->power_on = rcar_sysc_pd_power_on;
 
-- 
2.43.0


