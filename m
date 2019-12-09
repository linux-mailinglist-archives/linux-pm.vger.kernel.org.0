Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0151165AD
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 04:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfLID5S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Dec 2019 22:57:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46410 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLID5R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Dec 2019 22:57:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so6398122pgb.13;
        Sun, 08 Dec 2019 19:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3b0Ff4l5EWpR1AKOGsi1ZTAFeOOljeGZ0Ba9az61bbo=;
        b=qOHIXbSag1W5InPqUdbn7d/Ikj1LLoCTAWrgTp9dtA91oPhVvxOG1InnSDm8o+8Hiv
         vLNMNp0OOoIN3ou/EYB0tl2SrEQ/m7VqCUoH619+5mQKayOjG9aG1CFq3OvQkXcVi88j
         x1FjvPeENgr4uGVQUUF2ldSmIqyst1osL5idJMvSHP/oheex/g1ZGdVrtTvFbUSk5b9e
         x+OZSFw5xW1wRpg/GE+b0d49ByNyrzl7QnntbSC5/9vR1XAAeqeQYrJBuGmibMB8DIs1
         zZrCxb/hQ38mCbLt3EydsyVl9bz60Wf0Epm9E09sSCmATZPd5v6UQvizOibFEe1JW3Mg
         OIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3b0Ff4l5EWpR1AKOGsi1ZTAFeOOljeGZ0Ba9az61bbo=;
        b=ppXKpkqXmu63aruGGvLe6nIJEjcy8q+Gm3lpEWJe/NFJmc8lpDlc2Txefs/K67SQzA
         4badDHqptkSUWoT5MjQUa4apMH8h3+gd/gj8l5AXYRhxvOuTqiLU6RVYoeKdHg71PCOi
         i9Z86qlOzbQ5Cp3uPY+b+UhPHHv2xyaSBpcBbjODlSs7owL6gUQUDfTz+cYmPi4qnKgR
         2b79LWe/8OpjgBXbKHi7WsMX0i62xjGUZwOiySnfQnk+ZeUOEdcO+gyE0RPv877iBDym
         qKGNHRk9aqxdEFqp3md/RIUK8HTXJGKZUnqKDqUN1KBuJrO6Oj04pam8PUnHKongXbx1
         4SAQ==
X-Gm-Message-State: APjAAAWSPNjcc2Fc2smHRC87sD2aobilGCEiX14fn9Tkk9F8BWmITOzc
        jfuWPBZp01GcRlUMidZGJsE=
X-Google-Smtp-Source: APXvYqzwJcQ6CzXEnTV64kS+M/i3elI5nznARvaPTCmJ0U1egyQPyJU5QX58hKsR7qHp1UYeBK1BoA==
X-Received: by 2002:a63:5d06:: with SMTP id r6mr16310502pgb.249.1575863836705;
        Sun, 08 Dec 2019 19:57:16 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b129sm24606111pfb.147.2019.12.08.19.57.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Dec 2019 19:57:16 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v3 1/5] dt-bindings: power: Introduce one property to describe the battery resistance with temperature changes
Date:   Mon,  9 Dec 2019 11:56:21 +0800
Message-Id: <d5024f1e017542c43d2f2f421a12daa9c2b9bf2c.1575863274.git.baolin.wang7@gmail.com>
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

Since the battery internal resistance can be changed as the temperature
changes, thus add one table to describe the battery resistance percent
in different temperatures to get a accurate battery internal resistance.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 .../devicetree/bindings/power/supply/battery.txt   |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 5c913d4c..3049cf8 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -35,6 +35,10 @@ Optional Properties:
    for each of the battery capacity lookup table. The first temperature value
    specifies the OCV table 0, and the second temperature value specifies the
    OCV table 1, and so on.
+ - resistance-temp-table: An array providing the temperature in degree Celsius
+   and corresponding battery internal resistance percent, which is used to look
+   up the resistance percent according to current temperature to get a accurate
+   batterty internal resistance in different temperatures.
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -61,6 +65,7 @@ Example:
 		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
 		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
 		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
+		resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
 	};
 
 	charger: charger@11 {
-- 
1.7.9.5

