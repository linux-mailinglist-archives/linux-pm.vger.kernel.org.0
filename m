Return-Path: <linux-pm+bounces-30695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA8AB01FF0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 16:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45F61C43BC3
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3252E9EC2;
	Fri, 11 Jul 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ejmyyd4r"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC152E9EC4;
	Fri, 11 Jul 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245882; cv=pass; b=alRd8trqVP5ZuYRMfF1LMz8XnordO3xQFkeInmIn9UPgupTDE0Z+YzbgqfYTSoz74Kr2FFvZbQDeSoi6Pu5Y0QrpOH53VbH0D59GRtP+6fH+CdM1CKMOgxn8xv2AwkREXCCUK6kuRZlDhDU/x6vEHxUAqLI8PrPUu1SWEZ2N3qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245882; c=relaxed/simple;
	bh=SI7hIy6WcNZ6BFnKCV9ckXzmL0w3hUeYiacSsLeT+70=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ocTqpgG7W37mFR7TMmCjGoWLlwv3F39MMepkJnXjrZxV+ZI6HN6LL2TmdVcyePsloy4LmQQxUrkyA4Yz0bNSHoigfcueAU4BmnoOWJkQaLimOxj2rt9hPnh9zlUuu/d7QheN6/SMgwXePtTqztG0nPWFsz5ztLEobWBcDAAipnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Ejmyyd4r; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752245865; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BKXSQmTRtZE4n/PLG40EzPKN3e2ZCFPV2jt/BgYTlrlobqCUMqYt9hdAOlPNsgpGjPGSrG8izWIOy4L1yb4k7MGlLsYD5keiHPQUIdWp1xDXHTKpjiEJFciYqBjqh7yU5G/YKhfVbMBG5yA2ceRzXJlIJSyW2ZYG944CCpbbCw8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752245865; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t0chg3P4XqvgAZUIms8Yq5sWYUihi9BDdnPNYfdKkT4=; 
	b=OBlXM7syQnZanUMLqHGxwSEkqXDEB38Obj7ERRSuZ0idi08ZmGycssqqGQ/7wjXWmjUtH8QPNpUUQMSCstJbZD0KjeL4ztqc+9lgp060KH/hjS4SRFuBR95SULi/XmSqn64KyEyhoOpV8jrLk2hBvge7FRzkQSu4lh2hTAeeUYc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752245865;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=t0chg3P4XqvgAZUIms8Yq5sWYUihi9BDdnPNYfdKkT4=;
	b=Ejmyyd4r2PfMQXooQj/iEZ7wQ49PnjK4PrYSt8mit6FbtiEgEIUj16e+FcwdRN5E
	ukMbsM6eWIwnMgA7xGah1DRYgBMgoS4z/IYJu8tge1Sbqm1co/WvJG3ewqir8VfsutB
	G29v0IV6azuNyNKIer6rI3MBCjioGglFyK1weBWs=
Received: by mx.zohomail.com with SMTPS id 1752245863784678.2744682613209;
	Fri, 11 Jul 2025 07:57:43 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/5] MT8196 CPUFreq Support
Date: Fri, 11 Jul 2025 16:57:32 +0200
Message-Id: <20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFwmcWgC/zWMQQqDMBBFrxJm3YEkpal6leJC41hnkahJLIJ49
 w6VLt/nv3dApsSUoVEHJPpw5jkKmJsCP3XxTciDMFhtH/ppDIZSmdqhX7Yx0YqVG2pnyN617kG
 kJdHI+y/4ai+W2ybdco3Qd5nQzyFwaVSkveC/De15fgFkX5LDkQAAAA==
X-Change-ID: 20250711-mt8196-cpufreq-86d961e2300b
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Hector Yuan <hector.yuan@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

This series adds the necessary bindings and driver changes to integrate
MT8196 CPUFreq into the existing mediatek-cpufreq-hw driver. This
necessitated two preparatory cleanup patches to the driver.

The CPU frequency was verified to actually be changing by comparing
sysbench cpu numbers between fdvfs being enabled and it not being
enabled.

Enablement in the DT will be done once the MT8196 DT lands, so don't be
surprised that no node uses these new compatibles so far.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (5):
      dt-bindings: mfd: syscon: Add mt8196 fdvfs syscons
      dt-bindings: cpufreq: mediatek-hw: add mt8196 cpufreq binding
      cpufreq: mediatek-hw: Refactor match data into struct
      cpufreq: mediatek-hw: Separate per-domain and per-instance data
      cpufreq: mediatek-hw: Add support for MT8196

 .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |  64 +++++++++-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   4 +
 drivers/cpufreq/mediatek-cpufreq-hw.c              | 140 +++++++++++++++++----
 3 files changed, 184 insertions(+), 24 deletions(-)
---
base-commit: 42f78243e0c6fe42f2710f98513a55c102347ff0
change-id: 20250711-mt8196-cpufreq-86d961e2300b

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


