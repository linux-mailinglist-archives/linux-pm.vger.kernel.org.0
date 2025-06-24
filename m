Return-Path: <linux-pm+bounces-29439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F90AE68FE
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C934A063B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE6F2D5432;
	Tue, 24 Jun 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gfntUD1N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D281126C02
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775554; cv=none; b=VZgilfOtdwCE89oIWFOER11KgyKle2CZ15htV4yIpHd3Iz9n1/MfBAaUxx+YR7u+I8Deycxlk2XR9f2RG/8nbhJovGpRcYc1vHBH2wbnxnFyvgPGM251zXV6Ik97rFMPjgG5WKu4CtXYk6sNCteuYw46Lh2lOtnHbsnOppnxXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775554; c=relaxed/simple;
	bh=U3pCKeQXh5fWKdCNbSY0Rxi1y5sm9Avd5lYpt9VNji4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haK3Nm5uBrJbe+zfhmg/jwc3qf0ojr0DnN+7VFgrMxHLqT84CJ+SoOEEwgwW40yAXVsczzvj79U3qk84ay2LlAXsCxnqmVyH4r7ORZ9m9UEdgPBbtKcQORf3PeBllaocOFQiGcIQh84NxsAwEk5AZ79pnK2pSTZyS0Ixz3sDiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gfntUD1N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so4224925e9.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750775550; x=1751380350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVbEF9kewOwZre8oZmBAEAxpHXBpu+7cKLNa/Clhms0=;
        b=gfntUD1NxyMAnr1/8FpEG7i+eIdBCnXkjI3xKUfh7UoAUEguUt8fEF6LSNf5wo9N3j
         TCoOopXkv24Lvxl94wZ4Hv4sdIRHZZSt3ITrOOZfZ1DNTJ0Z0B0v/yx9yDYeO1mgefIY
         LEj9WH9cex8aVra0Tec6cGH7AYYuZGKrSgHFmHUCr8Z6ZclosDh/UxdxrTo/K0nKfigN
         ++KKdfS0JWNlowmsg1o6xcNE51zhwVZ7sMW7pq1wXEg9G7onQulMk5//4htJ7KwxznYR
         o3u5wFXpSG9NKlYdyj22/aS6JudAyuZ99ocQtvfRFDSedvMIZJLtwOgcmBwTI2orItqZ
         uMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775550; x=1751380350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVbEF9kewOwZre8oZmBAEAxpHXBpu+7cKLNa/Clhms0=;
        b=kCCeJH+CbS8Yx1WUr2WMpsuy3iM/qKU+YqNOeIhpUH5kZ81hesZyFjkrMVcE/PWjOz
         GMTRHsD2rzmDON///l9eHt1awfmeUdZIoQ3SD8/ISn2e5CTnZzo3hBfb8y3LroijrT5x
         ZSwT9VlsQcNXjGLu7hcTXq6o02wetim3RZ/iO9+aCgILDh3xPMHJkTt5eq6cxD3jlH4b
         veZzd6BKvYU3reg4V6ZZ9duvnl8HVk3SzGUGREhgzbLx2El9Ct2EReah6RwbmfjZ30l1
         edSg+1TJCKMKtAzTXkQDew56LmoEbdX4yTVqqUEWdLlWY5MB4ECj1Y4EI/euE1fCINCH
         ugNw==
X-Forwarded-Encrypted: i=1; AJvYcCWij2kCAOHh62imAzHOZiBgvZHvU9SaZ1/taNy8b8h0g59IaYaZywtEG7iD4nEYnB5wWHqPORERpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuDlumMQodlhAwLhCtrBc532Kr63dnUhwrTInrj/y6qytaxhc
	I4016F54FzvmBItIaAjorMcqMP0IYvccWjH/tEV/LHnYf7O4OzZE86wp3NflcOS5cnVXqmGVUZt
	iObzHLhY=
X-Gm-Gg: ASbGncvUbVmXUxxw6OEVxs7vIrp/h7kxDEd/oINuJDWA38fIrkEKEdeBFDt4d5BPKsg
	1MQyuyKBHNKSIInIQdaV0YVBBd/3LJV8Gn+UHLqq7Vh9g4ox5llLm1TRAWNSbMnbPxgKmZnZtJU
	bJrWO4ZsovQgtQvOrKm4wPAO2VQrOTHKHWA/qCS9teHqTTYj/qGvzbYtjpCKYuK0TwWNXZK6GUS
	McmaZreoY2ow4+JZ/zqHw/R4+duarq8jxtXseW9cfNDg4Wp79LZgcvEZuKUd9e0dr/5IcRg2j82
	vCEYw14eA4TR2BMzcNeXOH4QkEw2uAVBHEnj2roA8tKNZHMPLNa0hUM++UVVQdnbJOE=
X-Google-Smtp-Source: AGHT+IGqsN8V2Kqq4ukhS8ZiL+K2QB+8bClwqfh0d/aBfYgnP752Jp9v7Ul1nPRg7YWzqlJ9R0sP7w==
X-Received: by 2002:a05:600c:468e:b0:442:d5dd:5b4b with SMTP id 5b1f17b1804b1-453656bab67mr174529765e9.31.1750775549662;
        Tue, 24 Jun 2025 07:32:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:34d2:109c:3293:19e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2a84sm178512935e9.32.2025.06.24.07.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:32:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 24 Jun 2025 16:32:19 +0200
Subject: [PATCH 2/5] pwrseq: extend build coverage for pwrseq drivers with
 COMPILE_TEST=y
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-pwrseq-match-defines-v1-2-a59d90a951f1@linaro.org>
References: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
In-Reply-To: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=2ehPYsnzhfIr+Sl5KtygAfKZml3wCVfX6aGvffUmSwc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoWrb5/ZD6cGNe0SODQu8G6MTV2TyemaIWJGr8n
 IbX+Krmp36JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaFq2+QAKCRARpy6gFHHX
 cnh4D/0eF9mZsgltwhV+c03clkM4zPTtNKVX04B9cuU4X5DVbI0KgJvcPhVe6Z+gnMMDNlUlWkW
 v3r86iHn4p+K9ChVY/FfX7chS7YFtby/vtXUUaD4Ktefsyi05sD+gd1HoVKfGlZ8e5AnXrPvPIW
 c/6JzP64+G7QUnMKONgwaPVAhCAv9Rx/ty4eoj5WZokPtwhxAYxG2BqkKUMpOq0wRVRLx7M9vYb
 rOPr5v8vQBIacA9NxL/nQpr+6J1YMSBsIGbcASAf6EwdhZ4IgwsN1jvuIVm+IHsN/jy7DbpHys+
 B0ZIwglXIdg+432uOpCtZyS5twVOHuM512PaIhGWsJuFemzx2DAO2gixScYleFb322TqpVg8wxz
 /WcQCk8ojYAM2AICYS6E/YKWUvPjuQtJFpQKGTk1HX1PMcqjp1DkIvvBQRmfOTS/KxsROJcFutJ
 CrJVNlzROukJYtbFWCKqBNvG0MHBRhmSIdyLZdVnqj8Rz2dWYxnxZsMxJBlKz3olyZL21dNHYtR
 mIBQywymAMf7dYb1RrNaN10rF464jtFrMvoVaJ8haulYyjKw77wMRY91WreQLs0LMVKPsuhID0b
 DS7Aa5GzGBI1qsnh4zmgeDUqOxLcw9hgbytxNMlSH88ooZpYC8gIsnIRSwCm3lv8up+Eh7m4pmC
 lvBl8uUD1T+K8Vw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable building the pwrseq drivers with COMPILE_TEST enabled. This makes
it easier to build-test them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 0f118d57c1ceddc03954c006f99b5990acf546d4..280f92beb5d0ed524e67a28d1c5dd264bbd6c87e 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -16,7 +16,7 @@ if POWER_SEQUENCING
 config POWER_SEQUENCING_QCOM_WCN
 	tristate "Qualcomm WCN family PMU driver"
 	default m if ARCH_QCOM
-	depends on OF
+	depends on OF || COMPILE_TEST
 	help
 	  Say Y here to enable the power sequencing driver for Qualcomm
 	  WCN Bluetooth/WLAN chipsets.
@@ -29,7 +29,7 @@ config POWER_SEQUENCING_QCOM_WCN
 
 config POWER_SEQUENCING_TH1520_GPU
 	tristate "T-HEAD TH1520 GPU power sequencing driver"
-	depends on ARCH_THEAD && AUXILIARY_BUS
+	depends on (ARCH_THEAD && AUXILIARY_BUS) || COMPILE_TEST
 	help
 	  Say Y here to enable the power sequencing driver for the TH1520 SoC
 	  GPU. This driver handles the complex clock and reset sequence

-- 
2.48.1


