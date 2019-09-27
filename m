Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3CEEC0587
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfI0MsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 08:48:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35682 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfI0MsD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 08:48:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id y21so6059417wmi.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HzQhDkqVyohi8147rI3+BgZwRO47r6m1rOvI8gEcCVQ=;
        b=oi7neAwW2LPL3XABbjq079ydlG5AqDgyurTggZMicVjKIV5UMxxiyLM+baxNYU7LMn
         KX0awqzp3ut3v6fG74urUYMNC7Us0TNh9cFPafo8aX6keUN84SNN8/13CiS2mOaNYVXW
         51GjVuPtTereISnJig7mP/IpoNpIQPIiC9dIHozWqZj8wKaFul+FMr0+2WVtMfP9Pit0
         iwshl1qVi1DzPPokQOFhT608amsRwajCmDibnhxZ2uNGfJGVClCLRHl2oTzSMrGuU6BL
         VMNsZeZHCwXRvn8wMc3M95Xc8gy4zBAopdQdfa29TD3KYqD7aefu+UKji02tx/K8JHiL
         3p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HzQhDkqVyohi8147rI3+BgZwRO47r6m1rOvI8gEcCVQ=;
        b=ODiUCN1T4GeNU2ENm3F1iXIOh/2ThKjykBOmC8WUTwVjwrRamOHRyPECxuPYUeJ9C6
         FjqOqP5wTRH86r7lfhM/vnmIatTN227vzG3Tqg5pXGqnDHC/aDQQrih9+jY95KPKzHKj
         wKi+9Zpe4WTpCuzQ2WBKNm+TkuIpx8XyR2JVEFPmTmBOcBNg0tIdv7/19LFWVnuXsP9q
         Y1KWU71pYqWMmPZu9CYzBEciQCpl6NaTA71RM3oTZCTCV6ZT43PT9ytfbrpWW0iHhWnl
         05P1i4Uf/zTUyY8AOs+jlqgHQzRW01RkLlRSe1epYXpW/ridnCwP7Mf2peEqbTQoQpHD
         whQg==
X-Gm-Message-State: APjAAAUpBpbrPymHHLmV0VpUMQ/tpmnubiI6NSajWtq8+yZZmXvxNQQB
        TzIsTf5A991/uzEUvkbCKITN/w==
X-Google-Smtp-Source: APXvYqy/1/MJyl2yq0JNJ1lJAbS7sXpETew3r6arHgnR/Bo+YJC+IXAdeOl3m8wFVO8i1kW5vfviIg==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr7418209wmb.93.1569588481463;
        Fri, 27 Sep 2019 05:48:01 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm2985564wrv.30.2019.09.27.05.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:48:00 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v5 7/7] MAINTAINERS: add entry for Amlogic Thermal driver
Date:   Fri, 27 Sep 2019 14:47:50 +0200
Message-Id: <20190927124750.12467-10-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927124750.12467-1-glaroque@baylibre.com>
References: <20190927124750.12467-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add myself as maintainer for Amlogic Thermal driver.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 390c3194ee93..bdc30d740342 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15932,6 +15932,15 @@ F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
 F:	drivers/thermal/cpu_cooling.c
 F:	include/linux/cpu_cooling.h
 
+THERMAL DRIVER FOR AMLOGIC SOCS
+M:	Guillaume La Roque <glaroque@baylibre.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
+W:	http://linux-meson.com/
+S:	Supported
+F:	drivers/thermal/amlogic_thermal.c
+F:	Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+
 THINKPAD ACPI EXTRAS DRIVER
 M:	Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
 L:	ibm-acpi-devel@lists.sourceforge.net
-- 
2.17.1

