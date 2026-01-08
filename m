Return-Path: <linux-pm+bounces-40428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC839D03C85
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 16:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A326306D730
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0EA2FD673;
	Thu,  8 Jan 2026 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="q6I7B6Ww"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2335F8BA;
	Thu,  8 Jan 2026 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860816; cv=none; b=madnIzT4SIpD492+vKpzbVcGSI4gMDlcKCl60ZMAkX650oVp4tNlyA54+OHsrm1L2tCFZ9POOVsVdJp7hBp34kS0T/dTXwSks70McQcQ41TZ62YQ5lEWqSaOJ3L44QneoouGqnwrCpg0FgWljsPdwE0MFaw7VRqfhk+T0vFpxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860816; c=relaxed/simple;
	bh=rdEwDabUWU2buJZW2ZyuGq8H/bqEDCqdfFLn0U7j3MQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M7Rs4D1DzZ3HjJh1V6QCffhTndvayQ2fi2tDOv8UlRMkWIsF6T0HaGEd64TxnFx8iylHLfwqRBjsqIUibg8sLkKxUhZnrv5xAnJwCQnoJR31BZ01LxDxW+mW/lg0BJEfrn5HHcLObjCJGYp1A/akTPCvBcrivWuelYnc+IaFFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=q6I7B6Ww; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=5K1mb25vjRxs8M3KsS9XWxb/bhwtw9aw+OSOppGStAA=; b=q6I7B6Wwl9z6fZUZGi1VlaFmtY
	8+bNul5jJ3uLqMD/0Lv8u3VOQ12fcrZ4GGmFqOT09at/6IJEkaWaI4ClOi2zu3qDjf5l7yTmByISv
	qVv0S4jfiMICHgmtfFVc0gW931kzSYbOxxwQ6RqM3gvf5HLSJIcfmewUxiBljQbkaVr7usHslBDGd
	sSBGmT/Yvtp+S5MDbZ8styy9zmL0MZN0Vwqp1buehMx3hQbBWd+/5xQhMJ+o8szzbGncGTsc2pHOY
	cPGEkte6H+7lBwUJxrP9m8F43vQcMSfxTvYwvPmhlOvbUQEQjhkiTbubZ0pyJZ/XNTD940vPCa9YP
	BfCVuiXQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] cpufreq: omap: remove driver
Date: Thu, 08 Jan 2026 09:26:11 +0100
Message-Id: <20260108-omap-cpufreq-removal-v1-0-8fe42f130f48@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRqX2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQwML3fzcxALd5ILStKLUQt2i1Nz8ssQcXVMzQ9M0E4PU1GRLMyWg1oK
 i1LTMCrCx0bG1tQC2ALhCZgAAAA==
X-Change-ID: 20260108-omap-cpufreq-removal-5615f40eec96
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 linux-omap@vger.kernel.org
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=rdEwDabUWU2buJZW2ZyuGq8H/bqEDCqdfFLn0U7j3MQ=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJnxWabXM/qvMBprV+ZqHJpwwCA1v3dS5r2yucuWvtcQK
 pDbq2/XUcrCIMbFICumyPLLWsHtk8qz3OCpEfYwc1iZQIYwcHEKwETkFjEyNG/pVAyTUhNXjHWt
 N9zl2643feHyCU9Y7z8J+B/aLfYxm+G/M8fq0hV/Tmly12m83x3p9Hyx9oHzsgpH2beWfdjUaHC
 GFQA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

The driver is not useable since 10 years, and the affected
platforms have alternative drivers, so remove it.

To: Rafael J. Wysocki <rafael@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Andreas Kemnade (2):
      cpufreq: omap: remove driver
      MAINTAINERS: remove omap-cpufreq

 MAINTAINERS                    |   1 -
 drivers/cpufreq/Kconfig.arm    |   5 --
 drivers/cpufreq/Makefile       |   1 -
 drivers/cpufreq/omap-cpufreq.c | 195 -----------------------------------------
 4 files changed, 202 deletions(-)
---
base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
change-id: 20260108-omap-cpufreq-removal-5615f40eec96

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>


