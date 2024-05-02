Return-Path: <linux-pm+bounces-7445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C31DD8B9BD3
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2024 15:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB9D283294
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2024 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D62113C676;
	Thu,  2 May 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SdNm8TVL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A77441E
	for <linux-pm@vger.kernel.org>; Thu,  2 May 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657575; cv=none; b=Vy+hY7H02zOKs/7ASOQSWkBwAug3uyXxG+I1+wqhS+8eGs1nKCewUichvijIIs6SPC5ASvh0OqPnb2GHgLHyllhdO/M/YWQ3SHbNhmuKgP3S6w6O+n4pC22nkbEnRZo2n4GNQ3tyVg4xaS81eUf95p/QBpD/EIeer9IbvqB7jEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657575; c=relaxed/simple;
	bh=umAKYkGw6Qh2FAI5WcUUghAsI5djPBhIsfyxFgp451E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fsz4abe9Ed1nl0s72OdVoxfa28odnXVSEXbCae8AkGvYvhkZSfZnsm633xzrknNkSfBps3E0h825J1O+5cOQaUqTmTJltG/TCqVNfrfwKR4JavZkNBQHye4p363RTrsXYlqz4MAlBn5ataDupzZ5WgzR75Rm7qW130+Xi47+BAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SdNm8TVL; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f25f87e58so822168e87.2
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2024 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714657571; x=1715262371; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KjbvBW6RdAEPTXQDkB746T8DtbLmBQp7aI+NR/HIMtA=;
        b=SdNm8TVLQzMNJD+AUbaVgzzoJlYQQeS9DAf05qP0IVyOzxGnMkoNhw2d6p3RTEomn6
         6S198zsONFGHsSc+Kla7zjIJ+ZfFKYz/PfYWiyQNw7oagI7h5+uoP0EmVimRphcGbNqo
         wZYlgK6zJ3EHlNeKxzBUZCOWPF76xEynfM/wg0U5Dm0kcGFQM24fs3maEqk1nMOlH1L0
         Sl4s/C9Xt30fT+G7S+z2mEuIhLTtCqR9QVtr8NTpCJorGlQzfAzcA7lK5P5imuvSk3Mb
         lHkjlg9FCexO3sOzGMTXccfg3qko9YObpOT7ZvZirYg/IbhyZngSjTyk6T1V5HZ/DBI7
         yi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657571; x=1715262371;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjbvBW6RdAEPTXQDkB746T8DtbLmBQp7aI+NR/HIMtA=;
        b=JGdVzMwE4zQPqqSP/Zujj+kf51Jq2XAokvesYdNpDrXLhDqu0Ep41OmxtrkeEH8MdG
         YCfhOjBlOyjf7SMLUKeWLB63QkfM48Q+DF1M/ZDzYc2TfoPs06e1Zy+RQUR/+Y0E0pVm
         P129MSevCRjijupf2C0EfWB5fFfP5J5IRS+Bbvf8huJOeHqWu/j39qSrWe/ujfj9g+S/
         O2dVnZJLaru5wieAaCzc0IUQz2hAjcQJaGXsrNMqHqOVg9hL/fRkd62eFM7Iw3ODDP0W
         5SIOYQEz6nnOHW2HTU4VBX3C7ZYYexLitWSVoo9HgJK7a/kKCOUuqqs9MqrcnWqzgZrT
         1M8A==
X-Gm-Message-State: AOJu0Yy3gAR7elUaMxdQJonBfqu91pU2/HeNwdIzwJgPYCFnUCp1ZDOA
	jR/4Dz8/UJSy8guxcPh13/h3CceKIs6lvMqnY7SmjeFvovpLzpZTneAhW7L6TcQ=
X-Google-Smtp-Source: AGHT+IFep4NL01L9Ttyd1vLDcDsr7A1IdG5IgCdv67mtSJhnn0nKGdEu7Tq10aLQKCI1NwgsUJdJ7w==
X-Received: by 2002:a05:6512:3083:b0:51a:a400:785e with SMTP id z3-20020a056512308300b0051aa400785emr5147210lfd.43.1714657571559;
        Thu, 02 May 2024 06:46:11 -0700 (PDT)
Received: from [127.0.1.1] ([79.87.205.120])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b0041bf3a716b9sm2014447wmq.34.2024.05.02.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:46:10 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Thu, 02 May 2024 15:46:03 +0200
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Check NULL ptr on
 lvts_data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-mtk-thermal-lvts-data-v1-1-65f1b0bfad37@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABqZM2YC/zWNwQrCMBBEf6Xs2YU0RFF/RTxsmtUE2yi7SymU/
 rup4PEx82ZWUJbCCtduBeG5aHnXBv2hgyFTfTKW1Bi888EdncfJXmiZZaIRx9kUExlhiP0ludO
 5NQI0N5IyRqE65N2uvBj+J/b8I/woy+/3dt+2L7gkdLaHAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714657570; l=935;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=umAKYkGw6Qh2FAI5WcUUghAsI5djPBhIsfyxFgp451E=;
 b=XsliQEKG1eu9+im+fcPyY5Bbcd0sVJkvx/RcjpKU1v7XxCLRK2GVF3ir4d6kad7e4Geja8X1n
 U9XUTA8WUMvBsVCV6f7yMC4aFi2H/666pKzVpdEoUoeX/0+JSCS+uxO
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

Verify that lvts_data is not NULL before using it.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
At probe, verify that lvts_data is not NULL before using it.
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 86b2f44355ac..20a64b68f9c0 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1271,6 +1271,8 @@ static int lvts_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	lvts_data = of_device_get_match_data(dev);
+	if (!lvts_data)
+		return -ENODEV;
 
 	lvts_td->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(lvts_td->clk))

---
base-commit: 9c6ecb3cb6e20c4fd7997047213ba0efcf9ada1a
change-id: 20240502-mtk-thermal-lvts-data-4b19d0685024

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


