Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6D21B72A
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgGJNv7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgGJNv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 09:51:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DB6C08C5DD
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 06:51:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so4413623qtg.4
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2020 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAypbVKRAUehaDEHEafPSFVtTwjQwSh5L9nGPiVfRD4=;
        b=CA+9yDnhIZFhliXGonoDDI0Pf9kKnyIifhYylpMmd48sxLE/5QJhdQhzgxwXXehSW5
         nh9FivHzuKoQlzN+dUjKjAojbft8kvDn/DqULyapUt96chfxrscbtMpB93aaf5eJUYpe
         +lDuS2qx9lFQ5mtYpVJ4oLJWvMlTyU/UzM19OEnHYyPASya0N8rQ10rm6Wy7GYreh4g6
         7PQZ7gT43j8OAJRPj9hMPEJDfAd67UrD3xKgDWuznD1B5uPTU+xOx98azX8yltiW+IfW
         fVvsqNbtkmjaq+PLQE4/ioceYkTdHoXbK60++j3nY88E4OI2PQyH+uNFnN4kWHd167nu
         Ei1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAypbVKRAUehaDEHEafPSFVtTwjQwSh5L9nGPiVfRD4=;
        b=BgBOUSciQkWKzOHHVpoM/hxDhpZ3VingO88Tr7Zslm0Gg8lFuNqf2zjXzoCPpoqL0R
         qxp7yi5yc1t9e+Z0ZDs0ttAA3AW5IjrSXvRCpqjW9Twx8IuSHoZ9lXJF8kXTzJMgdHM2
         HrkvDS4rY7Fr4Ta/1PVjVW6Jq0GiyYHXCZVX+vPydecZXQSzW9hzOPtobKuj9s5Lpn6g
         3fGrBp0WWSj37BKVvuVsi+Gt0UWYbyJtw3+tYl9Zx8C2kiD4IqE/i8mH1HXKzzf3EZ08
         pGU+AJBUT7zxKiZgaGLiTo75aNn0hxio3A+3pagDdpy8vuntvMJ7S/qott5XZwZJz4Gv
         iGeA==
X-Gm-Message-State: AOAM531YyW+8C/bjNl9kYo5H+acltZMaHjLManV8lvNxow57egrbRkjj
        xqmAWfIrYzIk3xyRLQrL7hwYmg==
X-Google-Smtp-Source: ABdhPJxjko/N0W7GxdPu6x568somEgxZMk+NIAUEHbTXSf/x7x9RPUOFyVJJNAdeiBMsDJxtP/SznQ==
X-Received: by 2002:ac8:1a0f:: with SMTP id v15mr72490794qtj.136.1594389117114;
        Fri, 10 Jul 2020 06:51:57 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id h197sm7574059qke.51.2020.07.10.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:51:56 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] dt-bindings:thermal:Add cold trip point type
Date:   Fri, 10 Jul 2020 09:51:51 -0400
Message-Id: <20200710135154.181454-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710135154.181454-1-thara.gopinath@linaro.org>
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend thermal trip point type property to include "cold" trip type
indicating point in the temperature domain below which a warming action
must be intiated.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index f78bec19ca35..1689d9ba1471 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -87,6 +87,7 @@ Required properties:
 	"active":	A trip point to enable active cooling
 	"passive":	A trip point to enable passive cooling
 	"hot":		A trip point to notify emergency
+	"cold":		A trip point to enable warming
 	"critical":	Hardware not reliable.
   Type: string
 
-- 
2.25.1

