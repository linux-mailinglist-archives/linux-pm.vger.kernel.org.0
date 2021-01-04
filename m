Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3702E9662
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhADNvZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 08:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbhADNvY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 08:51:24 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6988BC061794
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 05:50:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q75so19383357wme.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uq26Gc5w+gqD65K8bo/iG2wfGwF0w57n87eHtRp+qh0=;
        b=Y/NvzpVH7Z4+H4ta1a9zHQflIqnMjEZI24Fk6TRQuVKVdpwLubG8RLV4kbcT7i/fLE
         12lVZpp+70ldwZly5P25mZjhb41Io2C/27+GyYRt4CwT60GlJGOeV46+h6YQB28pikuK
         dOWUneGFKLqoflxoSiYT1JwsTquy88JX7hYNFzJoPV29S4kml/XJ5UxgqQeF1fC9Tmlh
         KsMghX1QXTSdSZwXFEiXIk/3hANi2CIngRHy69q8KpC+uskOAnYb0oYebP8Mds63O6Xo
         m5DbytI2FVdmxYXCCEZnUcpxR7inutp8OOdEiA1DZaEkQRIPiHoM6ewB2KrXC3uN3JBm
         d2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uq26Gc5w+gqD65K8bo/iG2wfGwF0w57n87eHtRp+qh0=;
        b=m1mPIlDOpL3fb+pYkKyFGALSp+Z0SGs1H9+M4FueveMZSmtrmJJi86rykOr3xb3DEk
         RcY0etzeFDagZeLLxbdzQt+sKsd2Km/RxlH1nPxIGapyrF5zPY9zbOJQYy99Iu2D76YM
         Aqg94y8LIb0Ckpvg/yblEmxN3xeElhxkxfw4BJQBYsuhbHp+odM20SsPzi4p0SdPhRg1
         jayNHjjJRQYaHWA43733VeugVsaBUyay6ix4aIbhpWt2qb4u0WuTszUlvTcSK/MHSAhX
         4jEOP0kIQNUyk6QarnEQUL8DobwoMDUCwjjv+3SbJOoBOTvnSnTYa7Cwn/PUX1LbWyoi
         q6vA==
X-Gm-Message-State: AOAM533Nls4EzeMnLaSakfrpzXqz+xwDM1L/d7L7xGALFNMqLYBJa/Yn
        RDStnJAPeV7zW+iRlkpwTsWvnFkL99HDmA==
X-Google-Smtp-Source: ABdhPJyPzUg9YuWft7Ethb7RktUR0dmf+AuCAu6BJoPfosCEjYUCcSgihfEVEN4I3FHwnURzwSmCxw==
X-Received: by 2002:a7b:c930:: with SMTP id h16mr27039173wml.175.1609768242948;
        Mon, 04 Jan 2021 05:50:42 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 67sm36316421wmb.47.2021.01.04.05.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 05:50:42 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH] MAINTAINERS: Update Georgi's email address
Date:   Mon,  4 Jan 2021 15:50:43 +0200
Message-Id: <20210104135043.31262-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use my kernel.org email as main address to make things a bit easier
for me to handle.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..a15e306123ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9240,7 +9240,7 @@ F:	tools/testing/selftests/sgx/*
 K:	\bSGX_
 
 INTERCONNECT API
-M:	Georgi Djakov <georgi.djakov@linaro.org>
+M:	Georgi Djakov <djakov@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/interconnect/
