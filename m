Return-Path: <linux-pm+bounces-6200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0017189F34D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 15:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB8428BBE2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Apr 2024 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CA715B150;
	Wed, 10 Apr 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HV2v4aCO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA915991C
	for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754183; cv=none; b=L1EbvRHpRnyEgp25wS/tYaRH/Uap44Xljo/jwBpOTTCM38jnY3I0zWacVhkhv/eE9Y0OeWlNNGu//H2yRl1EK2XoghVqpDrAYCHRC35UK6XUEt9tMuibiia7igbBAoYR1bz460Dk+5GlF1CkIZ1ftJYEeDYxPssLgVUVPn+NesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754183; c=relaxed/simple;
	bh=Mzy1RLChKpTXckeRfOn3L90L6pWcJRlTrF3gU8yBosw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ah8gAqj2VfrN3TMyw9tfFmZNciEGVLGPqPtURdX1L9d6AeK+lfzCUFhPpCMwLwy4E02p8VhwFhztGzHHnujzNaGQyY9pRgfuBxg7R/ydiQGetwbFa7jTHDL5LDlgnWeW5/TfH6FCFiKBRXsaU2PGJMR5eV1xtj7k189a5XYN/J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HV2v4aCO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e411e339b8so25299125ad.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2024 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712754181; x=1713358981; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3Y56dDS984KsDzs2nzTKgy6adBy9joM/agCd66RARo=;
        b=HV2v4aCOwl3k/clrmZQFBqxbjXAfywP+A1nfAEERh1oEHpPCE7lp29TZeR2QRva8Zk
         FuSULnBwlZSZOJTBnZblK6yDWkepeoEH9aVcnMgI3+d4tW/aEutjpsuxgZOxMv3meflG
         bF4foDQoigW1EGhuGL5wJOYjtaIXmq6njJ5GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712754181; x=1713358981;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3Y56dDS984KsDzs2nzTKgy6adBy9joM/agCd66RARo=;
        b=EJekbfO7VAHyaefyIPHzE7b519zA6HwqEnEjx6LhFJpywaYaS5lg+jN8Gx78G59eCm
         udy4r82eJ9/r9zc8PGlY3YNd56vxlK7iY7S7rRACsnsqkkXUTXIuGMzWp33j8wCeUm2i
         5k9cpTYlnRjfwdi9eNJtWNAEff7a8fRVCSOPKh9mUA+NvnzNwStA+XlckJKOlBFZmx+e
         tkK4+8qvOiE0jgMnImaqRcwHynZcksTHNOzgMbm2IE7k3rU0VdScvzDlP+qSncWOSNMo
         UIwTABeXonQ/rT7c310R3MA55W5OnnLBZseWGIukczO1L7N/tHaFweCYevM4dW1i3X0K
         4UwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF9GA7x4JOBWSdM+tvf1QAgjK1QpTqsGv39AI5i2Kb5t3+B1lusZJFDMB8p6BxFo88JyNsZ5JBReRT3VB2fTGyupiHkDOz56c=
X-Gm-Message-State: AOJu0Yz1/KGn4g2BIq0rdu2ZqQqeKEhWpJlaUFkT05TTwa9pll+zi0tC
	kYSiMxcMeRT4PjPJsETV2AbKFyE4KyRGf8Y42E+73cKZQxctlt2Mz1d6Oa2YMA==
X-Google-Smtp-Source: AGHT+IHqZzwYa8MxtXFxj041lgd7J88+1a1m5BQKJBRqUvFpLKeI9bdlPRTEzn2uQM5glqcDtWs7AQ==
X-Received: by 2002:a17:902:fc48:b0:1e4:10d9:5dfb with SMTP id me8-20020a170902fc4800b001e410d95dfbmr3179942plb.38.1712754181302;
        Wed, 10 Apr 2024 06:03:01 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (88.216.124.34.bc.googleusercontent.com. [34.124.216.88])
        by smtp.gmail.com with ESMTPSA id kq12-20020a170903284c00b001e29acb2d18sm10726341plb.4.2024.04.10.06.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:03:00 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 10 Apr 2024 13:02:48 +0000
Subject: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Add coeff for
 mt8192
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-lvts_thermal-v2-1-621cb7c07a32@chromium.org>
X-B4-Tracking: v=1; b=H4sIAPeNFmYC/3XMQQ6CMBCF4auQWVvTFgrqynsYYrBM6SRAzRQbD
 eHuVvYu/5e8b4WITBjhUqzAmChSmHPoQwHWd/OAgvrcoKWuZKWkGNMS74tHnrpRlH1Zm1PVdNY
 5yJcno6P3zt3a3J7iEviz60n91j9QUkIJRCMf+mxVY+qr9Rwmek3HwAO027Z9AUg9I3KrAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
 Balsam CHIHI <bchihi@baylibre.com>
Cc: Alexandre Mergnat <amergnat@baylibre.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.12.4

In order for lvts_raw_to_temp to function properly on mt8192,
temperature coefficients for mt8192 need to be added.

Fixes: 288732242db4 ("thermal/drivers/mediatek/lvts_thermal: Add mt8192 support")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v2:
- Reusing mt8195 coeff instead of creating duplicate definitions
- Link to v1: https://lore.kernel.org/r/20240410-lvts_thermal-v1-1-ee50b29c1756@chromium.org
---
 drivers/thermal/mediatek/lvts_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index fd4bd650c77a6..4e5c213a89225 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1530,11 +1530,15 @@ static const struct lvts_data mt7988_lvts_ap_data = {
 static const struct lvts_data mt8192_lvts_mcu_data = {
 	.lvts_ctrl	= mt8192_lvts_mcu_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_mcu_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
 };
 
 static const struct lvts_data mt8192_lvts_ap_data = {
 	.lvts_ctrl	= mt8192_lvts_ap_data_ctrl,
 	.num_lvts_ctrl	= ARRAY_SIZE(mt8192_lvts_ap_data_ctrl),
+	.temp_factor	= LVTS_COEFF_A_MT8195,
+	.temp_offset	= LVTS_COEFF_B_MT8195,
 };
 
 static const struct lvts_data mt8195_lvts_mcu_data = {

---
base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
change-id: 20240410-lvts_thermal-3d365847acff

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


