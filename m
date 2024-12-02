Return-Path: <linux-pm+bounces-18368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1F09E095E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 18:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA69168456
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAFD1D9A6D;
	Mon,  2 Dec 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MhZ/Ckf3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5B1D9A54
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158651; cv=none; b=dM9AtNeALsBb6APM2IgJIqiqqxvR17f1cKDT4QEuKQ9nw3Pqm8hnFjbxYvHIxJmRg0n0QE3UW0zcjwe406xVusE2LcrQyDi4yuY1nPPYqs753NzKSpJcp1X/KlUQxSqTxjeaNnsVzoO/iUptOsap0iIjEPJQTtPW4trWYPP+IsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158651; c=relaxed/simple;
	bh=hZmHmXhaPxYapkmazSBTQYJSOtR6grcSKudIxSa5uys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FTVwqv7draskgdHTHfnbZCwbjkDbvoQANghYSaHeUq0QJmUicE2tl1xBA0Pon7ObL/qyRfDR6S2iCB2LGxx43Khf0D0VmOq10c/0PMVbtGTV0vmGs97T7Eh7R8oPuzQZlj7nWLkmVl36UvnJ9rmgenTIezmgbPn6SaAI9Le1l0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MhZ/Ckf3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e5db74d3so1579638f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2024 08:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733158647; x=1733763447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItGaUx4mMjWP305q8FK6zTYZIbWY/yA/nNMSXXpCvDA=;
        b=MhZ/Ckf3wygfCFAb2aIoeL0RQQpcfH78/4o7b9xf7DEpAxOj0k9p58m7boAPz7lWcL
         QsnIsSwHqEeQgmrTm/3uxDGf7A7RF+dq7/kuS0ieHqnOMRizTVZV62QCf38BXTNm+LoP
         V3lmDO2oSkIhlQZlI4t+zHDY+62kj8KtUvI9p2ko4z8r2PVSt70PLcgPIKZhYQc9Dfww
         X0LJKkDn0LlV9Uusb4QrSEvy4pcq7L7gm/pZalGn3LsLJhmevFVq5/hEZhffBGNxRHG4
         Xets/dKUjNnqivUYxYbc7Ra5zUcjEl66KQZ/DJ0wta1lhSvZQUqkdXnXhlmmUhcl5NI6
         tdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733158647; x=1733763447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItGaUx4mMjWP305q8FK6zTYZIbWY/yA/nNMSXXpCvDA=;
        b=g5yn9tXuDZZQzeK/xU6Iqx9NKD6CypW5NXFrn9sYnlKvyFJnVPDpdqmAvRfCQpLG9a
         lRVhGVcgWEqX6F0jiM/fJI3cKX7Da8cDS+vd8pDkNO4pPmLf4yiu++OR32uQQF11Ki1N
         azTXLrYA0K0qUUdv5tvjiskXdtRQlYK1u3/lunvmJagD9+e5AVTt7BwrjGH3pSnBz24b
         gv85Ggn/66xCUgfFDEjgXwzvIWff28RNv9fz4DdMxTX+etwsbAdrp/S9gaROye27lSvF
         tV7g9W1vtyPrfuKkmjO6t78bW8rK2N2+knlZniUpG06VWjxzu3P0Lc37e81oQ1hds3CK
         MBNA==
X-Gm-Message-State: AOJu0YwLWGcfD8mT0aP6SEPlAx+TD0UrHS7Oh8bO1ONfX4kpEFWZigSr
	eE+22chAQEx8j6y34gidUCFSgsB6+6vv5E0QwVJzzzrWtRhg9fa34DWfycetQrA=
X-Gm-Gg: ASbGncsxJsaH7Zf8sk9/zcXKWH1K975Is2j+9vKYdtIWk7XcC/RD3OXhDxXicpd3oDo
	BDAdGFjGovqTB6jlmu5qnf8uF0ylvf54VqGcC9f+VMx0s/JX75i+8kTynTL0TrOdn9ZBACnMGuo
	AlrdDJMWsgGaM8YF0X5uohnVHGBhDdR1kmMAjKm7yLunFvBpx8WcCGkaPq7orkKVEnDQxuruBju
	7Er7kc3ixI07Bd6+N2Z/xbIzp0qu6QJSgGYevlxTeiyq4FGdd86KtcY1FtPj9ASqm0O
X-Google-Smtp-Source: AGHT+IFkc0FoA8n/kEZkWOw5oBoZq+a4ojllKECjH/Lm6zucKJGPEHanSq+59uPtKp/9i2UQfGBW4w==
X-Received: by 2002:a05:6000:2d12:b0:385:e013:b852 with SMTP id ffacd0b85a97d-385e013b918mr9226081f8f.35.1733158647431;
        Mon, 02 Dec 2024 08:57:27 -0800 (PST)
Received: from brgl-uxlite.. (150.46.205.77.rev.sfr.net. [77.205.46.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385df69feaasm10111106f8f.5.2024.12.02.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:57:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Georgi Djakov <djakov@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] interconnect: icc-clk: check return values of devm_kasprintf()
Date: Mon,  2 Dec 2024 17:57:23 +0100
Message-ID: <20241202165723.17292-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

devm_kasprintf() can fail and return NULL, add missing return value
checks.

Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/interconnect/icc-clk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index b956e4050f381..88f311c110207 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -116,6 +116,11 @@ struct icc_provider *icc_clk_register(struct device *dev,
 		}
 
 		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_master", data[i].name);
+		if (!node->name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
 		node->data = &qp->clocks[i];
 		icc_node_add(node, provider);
 		/* link to the next node, slave */
@@ -129,6 +134,11 @@ struct icc_provider *icc_clk_register(struct device *dev,
 		}
 
 		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_slave", data[i].name);
+		if (!node->name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
 		/* no data for slave node */
 		icc_node_add(node, provider);
 		onecell->nodes[j++] = node;
-- 
2.45.2


