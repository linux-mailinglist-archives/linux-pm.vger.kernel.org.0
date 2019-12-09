Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2E21165B4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 04:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLID53 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Dec 2019 22:57:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46014 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfLID53 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Dec 2019 22:57:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so6014917pgk.12;
        Sun, 08 Dec 2019 19:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WvZp1SE31U0tt/atYOk2/QylIK+izOWm2BYL5+FBcUA=;
        b=Mw2JAZcoEUqf6EGy1zg/hy/E3EVf3xrOZkrP18byG7HswI9cbt6V8g9qnoqnc+c2j2
         r8Ob0Q95DglnMkXLXp8DFaPmxXx7jyUo/CLWykXn8k84Nj2FrF9YRVlXXDv2+bmRzD7K
         TL7a9zJWbEgqsOkcI9HppyabDb7x/9GgE5YFT3y7IGuYoFFa7HDzmCU9U+NRjDWeeat6
         caUxSMBTs2rh7C1OFjmGAF944EwGRwMhnkLhdsAgTO+V+Yj018MtlGx8zf61e5cgyWeE
         pawWJEbnH3JvxDzdGSgW3m5cfT1yAuVhvoUW7XyXs2pZPeVYlcGbQCKqWKliOYfqWvCU
         JRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WvZp1SE31U0tt/atYOk2/QylIK+izOWm2BYL5+FBcUA=;
        b=FMTNustypwCpOmS3qkynHScmLQirzolhA4mOw2WHETnzVHvUl2ATktZaQ/s6iOjnxf
         ZQWQou/5uZOqgs4uxX/xvrR/zZf7xyZTqBeVXZ5yodkViYejroI7tk4SVj0LCz+IhYjz
         lFwtYkj9PHJnhclu5krq60qZ/5HqmvqYbLJppoik2JB/aqD8JVHNBX2OyHUqskKvKr03
         ndyzVN7X+I6jCHjvAGB5grwiLoxkdOoEjcQNmm/mb4Qf3W0HiZCdhjVsA9NNvrUtEYDL
         gd4+gtqB9WEei10K8EX7R83/vdYb87F2fqcI0026G8WT4twTjwH3R5ZdnM3d55wVkeEq
         /0jw==
X-Gm-Message-State: APjAAAWWgeTrtHq74RWfqhhwN67XyGro7vOYZ3mvgbE62bONR4vkfYSN
        NCZzFG+Gxclnkhi+NoZLQV4=
X-Google-Smtp-Source: APXvYqxlaM/m4kdUox5LXGauDISDAHsVCxARSeYYLIO0fv5KX44dImjVv1G8ciykxTwZoARRTE2qrw==
X-Received: by 2002:a63:5062:: with SMTP id q34mr16590505pgl.378.1575863848339;
        Sun, 08 Dec 2019 19:57:28 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b129sm24606111pfb.147.2019.12.08.19.57.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Dec 2019 19:57:27 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v3 4/5] dt-bindings: power: sc27xx: Add a new property to describe the real resistance of coulomb counter chip
Date:   Mon,  9 Dec 2019 11:56:24 +0800
Message-Id: <a77ea15e8f637256d0c9e2338b712bc33e03edfb.1575863274.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1575863274.git.baolin.wang7@gmail.com>
References: <cover.1575863274.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1575863274.git.baolin.wang7@gmail.com>
References: <cover.1575863274.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Add a new property to describe the real resistance of coulomb counter chip,
which is used to calibrate the accuracy of the coulomb counter chip.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
index 0a5705b..b6359b5 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
@@ -13,6 +13,8 @@ Required properties:
 - io-channel-names: Should be "bat-temp" or "charge-vol".
 - nvmem-cells: A phandle to the calibration cells provided by eFuse device.
 - nvmem-cell-names: Should be "fgu_calib".
+- sprd,calib-resistance-micro-ohms: Specify the real resistance of coulomb counter
+  chip in micro Ohms.
 - monitored-battery: Phandle of battery characteristics devicetree node.
   See Documentation/devicetree/bindings/power/supply/battery.txt
 
@@ -52,5 +54,6 @@ Example:
 			nvmem-cells = <&fgu_calib>;
 			nvmem-cell-names = "fgu_calib";
 			monitored-battery = <&bat>;
+			sprd,calib-resistance-micro-ohms = <21500>;
 		};
 	};
-- 
1.7.9.5

