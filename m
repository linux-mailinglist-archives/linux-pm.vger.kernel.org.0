Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279BF70A19
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 21:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfGVTxZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 15:53:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37679 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732331AbfGVTxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 15:53:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so36443931wme.2;
        Mon, 22 Jul 2019 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSlpALgO5S3R0TyDNNvgRiZnKC8+OxLqhsNNnaICjPw=;
        b=cFBQsyJHHatx3JSkJdhvrebXeVJ31a0VKFML6K3ScUwBUFuvBQ6L6CZbdJ2/GdtU2N
         vk4kUD4CMe45B+UAU5a7Gap5p2YnMl5BbFPB12440cHBuThu0mPoBlwJ2/ja+rayW6A5
         Z6jrzHt29FOd/FTRMTJuRYUn/GJMl6wf3Vl4TCGeoVStK8Tx9pthnP3b+9bAF5lAKWrg
         NvBzRlqP6pg/z2eZiPaQ3a9mby89HjX/sqnaedi5+odKcKymV4JWEJ7qbpRK9Cb4+0sV
         yJwcZzj3F807D9V9DkKi4/MLXbUWXm/mWvk87Pg+L6ue0SPJC0XB97/xXdX5uOhwyAHM
         ShSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSlpALgO5S3R0TyDNNvgRiZnKC8+OxLqhsNNnaICjPw=;
        b=l7F6IwWwIkEnZ9u5R4mN3oh5tUlE2GvXx/kel1HUbzID0P5n/s/Gq77MDenGPtHUlm
         9tzIsX5edoc9yu5dofh/uWUP0Qb+oLzos8btHIJyTknBCu3n5v915qZzbWuCwO/LZ4CT
         0rXFz1RFx1BFNV23rUUb3RHl1zqDB6I9/DckhEZYB1t3+ha2lJxrb8zrfntXuddYMW7N
         KrsDudkvV3CvS6XyGAMM9D1kClAB5PG+HWyvAUTZuZfK/0GpUzpXqeb639NJmb5o8egA
         HuMQNXVkpRAPTtRzBErw8p/nlfX3kPxvVaHGAQoTMvp4rZPyVqOG7YSajowCy4j0ujiF
         +BDw==
X-Gm-Message-State: APjAAAXhpBOMxbFcQ7TaCUCczfs9R2ct1QdQadDJrNO/nYY72Bn25rHX
        akfHvwNvqLmczpyKilgnQXU=
X-Google-Smtp-Source: APXvYqz85kfxUOA8R7vP4BPYFKPdWETr5bWy98ysJmybNus/vONpVvl7FJFmHS4slzONzL2fYE0sUg==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr67082094wml.77.1563825202676;
        Mon, 22 Jul 2019 12:53:22 -0700 (PDT)
Received: from localhost.localdomain (nat-113.starnet.cz. [178.255.168.113])
        by smtp.googlemail.com with ESMTPSA id c65sm37382975wma.44.2019.07.22.12.53.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:53:22 -0700 (PDT)
From:   Evgeny Kolesnikov <evgenyz@gmail.com>
Cc:     Evgeny Kolesnikov <evgenyz@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] power: reset: Add UART-based MCU restart DT bindings
Date:   Mon, 22 Jul 2019 21:53:02 +0200
Message-Id: <98b32aebe39a7b6b3ace1c2ef6f51428e8284946.1563822216.git.evgenyz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563822216.git.evgenyz@gmail.com>
References: <cover.1563822216.git.evgenyz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds device tree bindings of the restart driver
for power managing micro controller units that are connected
to a board via the UART interface.

Signed-off-by: Evgeny Kolesnikov <evgenyz@gmail.com>
---
 .../bindings/power/reset/uart-restart.txt     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/uart-restart.txt

diff --git a/Documentation/devicetree/bindings/power/reset/uart-restart.txt b/Documentation/devicetree/bindings/power/reset/uart-restart.txt
new file mode 100644
index 000000000000..bf831d9bdff8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/uart-restart.txt
@@ -0,0 +1,39 @@
+* UART-based PM MCU restart driver
+
+Some devices have a microcontroller controlling the main power
+supply. This microcontroller is connected to UART of the SoC.
+Sending a sequence of characters tells the MCU to reset the SoC
+and/or MCU itself.
+
+The length of the sequence, baud rate and the timeout to process
+the command may vary from device to device.
+
+This driver could be used for WD My Cloud (Marvell SoCs), QNAP
+(Kirkwood and Orion5x SoCs) and Synology NAS devices.
+
+Required properties:
+- compatible: Should be "uart-restart"
+- reg: Address and length of the register set for UART
+- clocks: The tclk clock
+- cmd: Array of bytes, the command to send to the MCU
+- baud: Baud rate [75..460800]
+
+Optional properties:
+- byte-delay: A delay after each byte of a command, could be useful
+              for sloppy MCUs [ms], default value is 5
+- timeout: A timeout to wait for the MCU to process the command [ms],
+           default value is 1000
+- override: Boolean flag that indicates if the driver should
+            prioritize itself over any existing restart driver,
+            default behaviour is not to interfere
+
+Example:
+	restart@12100 {
+		compatible = "uart-restart";
+		reg = <0x12100 0x100>;
+		clocks = <&coreclk 0>;
+		baud = <19200>;
+		cmd = [fa 03 03 02 00 00 fb];
+		override;
+		status = "okay";
+	};
-- 
2.21.0

