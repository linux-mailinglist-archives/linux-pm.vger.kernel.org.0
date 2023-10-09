Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAECC7BE1F8
	for <lists+linux-pm@lfdr.de>; Mon,  9 Oct 2023 15:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376895AbjJIN6m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Oct 2023 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376852AbjJIN6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2023 09:58:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D190A3
        for <linux-pm@vger.kernel.org>; Mon,  9 Oct 2023 06:58:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40566f8a093so42270585e9.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Oct 2023 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696859919; x=1697464719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7aAFQmtFZngidEZ+zvaFbvJXqmGzVQdu9SnwN3LMKA=;
        b=QAcU7i4364MPmGeglKjJ0Yo+S0aEIw4hPYY+BQukqL5kMXSNlz/i1wCVSgKy5fficy
         FPX7lfJ73gZ3nkG+h4Qiu0grBYfzzryPu1TphM0vM63Wavt+HdBtzaiviGBrJEP0b9Gq
         CQqgP/E5y3eL0teYFJ8OahM/R8BvGaLrQGQ/xePyFzEAPKl1msMmAA8Zebbzo9zO+iAk
         qu5zb+VV2JqYxqY6LW3IGKNK3s41QjspxOtLbLeXTql9/BBTnddSmGiKYXcs6vOEs/y1
         4vBA8o3oxrPxF2JaCqm2wzF8Tjuds2g0ItKlyHQCir7CqbgVQ8CbHEl1DWxGZU6HKNNe
         xn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696859919; x=1697464719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7aAFQmtFZngidEZ+zvaFbvJXqmGzVQdu9SnwN3LMKA=;
        b=KC68Ns2p0zmIHvNQbcTeN9sRZLfk450cv9fCyqNHpS5rqs0LhB/O687YpPCXLi+vf/
         zElknbOqMEdgBJfNlUGuI4gwhpSuuICt7CVXJdW/KCIpZ4s/aKzvEL9sIeB9hJSppILQ
         TZ+4R3/YfgPFey/vCqtrf+0bVw3bbpTLFcNqb0Ay28EiAWgiBCRJ5978lyMFDXu92o//
         oMdJSaunqIFAzTTrJm135HfnRVY1OmBDmzdIemRt247SmHj9DLNURKOAm1IdnJTfhULS
         TMoPdlK9FyOepI636qHIMyn9+91ACzsq1O5+R7ZLslMI9Oi/Hw00hOWhe547IwuNh6jc
         T+DA==
X-Gm-Message-State: AOJu0YzUS6DUSVj7skG5F/dlNy+Y1fS3dTIMjXyxl1Je7wTylRorjt1K
        UNVX5iveMHOIV5ElL8kmpXA=
X-Google-Smtp-Source: AGHT+IFafcmJH4Bnizt1oeh38NpJli8wyUInMQou89EMLcODMJkK95CzypgH0HoqqiErHwCe5BTudA==
X-Received: by 2002:a7b:cc8f:0:b0:401:dc7e:b688 with SMTP id p15-20020a7bcc8f000000b00401dc7eb688mr13471200wma.6.1696859918633;
        Mon, 09 Oct 2023 06:58:38 -0700 (PDT)
Received: from morpheus.home.roving-it.com.com (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681::1c8])
        by smtp.googlemail.com with ESMTPSA id l34-20020a05600c1d2200b003fef5e76f2csm6756826wms.0.2023.10.09.06.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 06:58:38 -0700 (PDT)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 2/3] power: reset: brcmstb: Depend on actual SoC dependencies
Date:   Mon,  9 Oct 2023 14:58:18 +0100
Message-ID: <20231009135833.17880-3-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009135833.17880-1-pbrobinson@gmail.com>
References: <20231009135833.17880-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Depend on the explicit SoC defines rather than generic
architectures like most of the rest of the HW drivers do.
This makes the drivers only available for the HW and for
compile testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 411e00b255d6..fece990af4a7 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -66,7 +66,7 @@ config POWER_RESET_BRCMKONA
 
 config POWER_RESET_BRCMSTB
 	bool "Broadcom STB reset driver"
-	depends on ARM || ARM64 || MIPS || COMPILE_TEST
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	depends on MFD_SYSCON
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
-- 
2.41.0

