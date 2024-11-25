Return-Path: <linux-pm+bounces-18105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD89D8DDF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 22:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370FE16A8E1
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 21:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748DB1A3AB9;
	Mon, 25 Nov 2024 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AjJ0mxeC"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9829CF0;
	Mon, 25 Nov 2024 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569661; cv=none; b=koHm8WUSY+CnqoCGgEn879MmGk5wn175nZRXGR5zB24LeI5qMg7NGSKyWYb6WkFXiA9Uj1/1uReKqgOk+nxrQSoLcrcBeDDQ/WpjesRahDg183u1N2PM27ZM0gkjwz+SowZ0fbs8Ka0xP4DttEU1Yla04l9XCJIKbthnKj1nrrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569661; c=relaxed/simple;
	bh=TBn4GCrh/WfYjRfNUoDjtRI7in6N7aD9t1Df+F3kcLg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c84+/SJBMdImps9cdlQBHg+R+M5IL8mnJL7B6fgrjYLmMtMJEcYewu9ifOaxVASky94QU8SOdmCr3TrqDRlYAb9R0FKVVHYv2WOWGwclkaZQPMnK3QDRxsFL8q/5LfQKJ8Fp4iEUKq+X76g7irXNc4FSZ13QezqHsDv6ikWC05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AjJ0mxeC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732569657;
	bh=TBn4GCrh/WfYjRfNUoDjtRI7in6N7aD9t1Df+F3kcLg=;
	h=From:Subject:Date:To:Cc:From;
	b=AjJ0mxeCylxaNDYHU0wW1TaOcxTioyLmpbIZsmwJu/sQwutdwY0UokpY1zOxyvymh
	 mMZaKTQ/XgEKCNlQkv5x8U1LFMjbononY8fRsdVlkEU/wLqgq6/XQgSXBnV2uX+wT4
	 JKp/Me7vxcbgJEElBqVdLQ+rpaj0jzPKLc9T3/uEmfVwu4ChFSCwtybzMWmDj0Zzzi
	 MDR0zBfrMU9hliJaZIb7K+xYPgsRvxWcvdlmaBVQ8MH3zhOhk4Ln66tACjAV3lSJEN
	 E792fx+Snp3dYrLZkipEMDaEw+aUJq0axVVtDc8miqfF5JFAjpDQz6rS1OqlBnMRp6
	 a5p6tefZD8DEw==
Received: from [192.168.1.63] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 29EA417E37C8;
	Mon, 25 Nov 2024 22:20:54 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/5] thermal/drivers/mediatek/lvts: Fixes for suspend and
 IRQ storm, and cleanups
Date: Mon, 25 Nov 2024 16:20:27 -0500
Message-Id: <20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABvqRGcC/x2NwQrCMBAFf6Xs2YXuWqH6K+IhJk9dqLFkYxFK/
 93Q48xhZiVHMThdupUKFnP75AZy6Ci+Qn6CLTUm7XUQUeF3HeWsPC3V+WFTRUFi//qMnJr4cTj
 1R41hRMSdWmYuaHpfXG/b9gfgps9rcgAAAA==
X-Change-ID: 20241121-mt8192-lvts-filtered-suspend-fix-a5032ca8eceb
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Balsam CHIHI <bchihi@baylibre.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Patches 1 and 2 of this series fix the issue reported by Hsin-Te Yuan
[1] where MT8192-based Chromebooks are not able to suspend/resume 10
times in a row. Either one of those patches on its own is enough to fix
the issue, but I believe both are desirable, so I've included them both
here.

Patches 3-5 fix unrelated issues that I've noticed while debugging.
Patch 3 fixes IRQ storms when the temperature sensors drop to 20
Celsius. Patches 4 and 5 are cleanups to prevent future issues.

To test this series, I've run 'rtcwake -m mem -d 60' 10 times in a row
on a MT8192-Asurada-Spherion-rev3 Chromebook and checked that the wakeup
happened 60 seconds later (+-5 seconds). I've repeated that test on 10
separate runs. Not once did the chromebook wake up early with the series
applied.

I've also checked that during those runs, the LVTS interrupt didn't
trigger even once, while before the series it would trigger a few times
per run, generally during boot or resume.

Finally, as a sanity check I've verified that the interrupts still work
by lowering the thermal trip point to 45 Celsius and running 'stress -c
8'. Indeed they still do, and the temperature showed by the
thermal_temperature ftrace event matched the expected value.

[1] https://lore.kernel.org/all/20241108-lvts-v1-1-eee339c6ca20@chromium.org/

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (5):
      thermal/drivers/mediatek/lvts: Disable monitor mode during suspend
      thermal/drivers/mediatek/lvts: Disable Stage 3 thermal threshold
      thermal/drivers/mediatek/lvts: Disable low offset IRQ for minimum threshold
      thermal/drivers/mediatek/lvts: Start sensor interrupts disabled
      thermal/drivers/mediatek/lvts: Only update IRQ enable for valid sensors

 drivers/thermal/mediatek/lvts_thermal.c | 103 ++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 31 deletions(-)
---
base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
change-id: 20241121-mt8192-lvts-filtered-suspend-fix-a5032ca8eceb

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


