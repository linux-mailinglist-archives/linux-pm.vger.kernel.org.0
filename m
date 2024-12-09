Return-Path: <linux-pm+bounces-18837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1279A9E9C62
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 18:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78FE283D08
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0563B1531E1;
	Mon,  9 Dec 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bHOtKjS1"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BF13AA2F;
	Mon,  9 Dec 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763628; cv=none; b=ZPyklstJJk+ccCGdSaKlHmNRGXPCeicS5aDoJcJHtwP+IG0rxjXJt4XLF8Cgbv35hhDGcaAoOPhjrqa1Uai56Dpo4P/5xxkXt/z7Cy+iMfVh1hTBri3fQiEydn9HjSy09cbppu902K5pvqUFV+HzpmHUnKhVZu6WJt3rvlkgFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763628; c=relaxed/simple;
	bh=ysn17uQxkXzPtLZxnOMKYQsJkVa5vH4rdmQv56kQ19U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hEDs7guiyK6/bCcfry618MX5Aus04rHvJGKa227oF3P0pwfJlMzk2PhqMSRJHLbGhTOeXAb9i0/5h5tbme+fDG77w8FDdt8ptlEErj49fZ47Dg4BQCF7r4opA9JAFgOdKYelgi01zjPd+urqduQ0AsWVbyvtjbC4oIxRKKd1TN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bHOtKjS1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733763623;
	bh=ysn17uQxkXzPtLZxnOMKYQsJkVa5vH4rdmQv56kQ19U=;
	h=From:Subject:Date:To:Cc:From;
	b=bHOtKjS1103e+9ea300h6Mz17GGWJIWxh41GOfvGOiUUrJ6ghWqieWRAU/xZXPP74
	 DQ/V9z5EC2TUMDPKe9qLaCKTj04sK4F8gGEPgAAEigp0+aMtMGaQpEUPYW1NRhSpTl
	 VtfLSj/k/tZqkldi+PH3AUbGwaTEiXxhpPoV8FvuFPTvps/q5MI5J97Ndjiqyx5yUM
	 r01L6rhobmsLN9olbYcG92sMeXkb+szabyxGDekAkmeBfGrRI5PfifXXfXZXwos3Lo
	 5e6mJlOk3FW/eAoygr9t/+jlEK0v7EYci1d8dsAKr2BgWK56GwzTJsipO2XQe3vZo3
	 failmmYZYK5+A==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8A62317E37BF;
	Mon,  9 Dec 2024 18:00:19 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/5] thermal/drivers/mediatek/lvts: Fixes for suspend
 and IRQ storm, and cleanups
Date: Mon, 09 Dec 2024 14:00:01 -0300
Message-Id: <20241209-mt8192-lvts-filtered-suspend-fix-v2-0-5b046a99baa9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABEiV2cC/4WNQQ6CMBAAv0J6dk27gEFP/sNwKMsqTQolbW00p
 H+3knj2OHOY2URgbziIS7UJz8kE45YCeKgETXp5MJixsECJjVKoYI6dOiPYFAPcjY3seYTwDCs
 vYxEv0K2skXTHxIMomdVz0fvi1heeTIjOv/djUl/7i7f/40mBhAa5JtliRye6krNWD87rI7lZ9
 DnnD8dyvrHUAAAA
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
Changes in v2:
- Renamed bitmasks for interrupt enable (added "INTEN" to the name)
- Made read-only arrays static const
- Changed sensor_filt_bitmap array from u32 to u8 to save memory
- Rebased on next-20241209
- Link to v1: https://lore.kernel.org/r/20241125-mt8192-lvts-filtered-suspend-fix-v1-0-42e3c0528c6c@collabora.com

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
base-commit: d1486dca38afd08ca279ae94eb3a397f10737824
change-id: 20241121-mt8192-lvts-filtered-suspend-fix-a5032ca8eceb

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


