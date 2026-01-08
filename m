Return-Path: <linux-pm+bounces-40430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1D5D02799
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 12:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD6E2307C4C5
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 11:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191FA35FF49;
	Thu,  8 Jan 2026 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="KJej+N6e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C4350D41;
	Thu,  8 Jan 2026 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860831; cv=none; b=spQilgJ026Td4CGbnB/BUUr5Xcgv2yuOkS69wVvkNv6IfJVILhfgQNSz5ks2zXdt+qlML31s0TrahGe3inkW4swlu6Oeha1dKUYYzMBO4camkBU6be/o9LeNaffgfJh8R28V+NM5x4HIsN1EIcLTm0a6BLJAUG+ueQe60Qe9JtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860831; c=relaxed/simple;
	bh=ye9EsldyVtkyFEEHWlpwVnLNt05/xILj4xvBjgVBhPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSD7Du++d1v9lM9lnPFTmf7/LtmsQ2ryw8pzi+5n/thwm6EdshAQiwpKGR/1OdkyhVsOJWviHP+AW/U2SMS1E6NuMVZAXIeqHsOVAewHcAAVrTGe/H9HJvHiUx5YO2uyL6IVSSdErJSZtAe/4QlNspzMim6Q/rjCEX7vhjCr/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=KJej+N6e; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sgbPhfaFLVrbkpz4PqBhY7w/yeiN7lhQkPSEva2tULE=; b=KJej+N6egpcNSGRSIDDDiXm34j
	gRfFIreBUNUNlzGuOq+WgHgSKu7wyoNXUu932sCL317b9/pJ6Is2aG7JAlLEFMiw5lGVNASJ0yBsM
	LYYTMaQuhOudmvK7tyRAJWSe7yfga0yckzLGfEnPYN7u06/3rzUbWMimuw4qsYSzJHJHjiLusFhBk
	Z05oqBHymIn5XrSc+MnzfgAz9DMf0ZYTyn1tAk0WuPoHVi3Wt/Hv5Nkz8RlbbWAlcdhkmB3uzzy0I
	Pqlwe8bpm1gQsXDCXe68r5NJuN1gRi6QNNu5nLpBZpsPS5N7Iuuz5EmDe4ilYLTLYUv2df7esG3Wo
	vmIM0/kQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Thu, 08 Jan 2026 09:26:13 +0100
Subject: [PATCH 2/2] MAINTAINERS: remove omap-cpufreq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-omap-cpufreq-removal-v1-2-8fe42f130f48@kemnade.info>
References: <20260108-omap-cpufreq-removal-v1-0-8fe42f130f48@kemnade.info>
In-Reply-To: <20260108-omap-cpufreq-removal-v1-0-8fe42f130f48@kemnade.info>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 linux-omap@vger.kernel.org
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=564; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=ye9EsldyVtkyFEEHWlpwVnLNt05/xILj4xvBjgVBhPU=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJnxWZZd7ib110zc2gLvvfJlZyxfOYnvsInGG5d7AnMvF
 M8X1BToKGVhEONikBVTZPllreD2SeVZbvDUCHuYOaxMIEMYuDgFYCLbFRn++3/cOuG1jA3POQZu
 iVdWYn09JzeUN0XrFJypMF5Sz/34M8P/7AnHDl0L1HlV0ODdG6pmdd3F/oH19b/PWSZLX1ffEL+
 aFwA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Remove entry for omap-cpufreq, since it is removed.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa2183..1065195a22ce2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19132,7 +19132,6 @@ M:	Kevin Hilman <khilman@kernel.org>
 L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	arch/arm/*omap*/*pm*
-F:	drivers/cpufreq/omap-cpufreq.c
 
 OMAP POWERDOMAIN SOC ADAPTATION LAYER SUPPORT
 M:	Paul Walmsley <paul@pwsan.com>

-- 
2.47.3


