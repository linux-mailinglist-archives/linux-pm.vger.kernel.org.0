Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2999370A16
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 21:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfGVTxW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 15:53:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35044 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbfGVTxV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 15:53:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so36444668wmg.0;
        Mon, 22 Jul 2019 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6o0P2aAvSBeZTbjnVSOrNVsoOphy6FmgNYN1/PGj4ik=;
        b=RYJlh3p8fH+hfwgDEY+vxzFwtIPT13Vk+vYhoVp2cx4akbniuYF/sHg06H2km4eg42
         hq2jLVNwm0Q78N5rzgbt1rhHqc+YMm0aiX6pDaHypW1QkGAGK51gvoPrR9OxdFFlqEbH
         qrZUe5RmXEkabw+4WwiJzZ+T+oxYxRaLFCX7bE2eAnr7H0Ksz6ujHjFm3wzMBw0Plt4P
         y+IpyCpKKtj5hz/YF/6vohKDWY7emzFLpfqDemLIcsxumFMnBf5dALIG5tfoCWe41K4c
         xCIm3Sy3hIYGRsyxuQie/W8ZjdpRq8AlzkowsgZoi1qrf76v7L7irr8yWYK0L7Vxid90
         EpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6o0P2aAvSBeZTbjnVSOrNVsoOphy6FmgNYN1/PGj4ik=;
        b=R5rDX7o9ZzXoCDlyUW3cTN6N3gYAvZMs1UsC9LFYxWiMExxikW5bHsvd4evJLn+G1p
         wluZCJIsYuVHC1i0HKgOLTcrdtjdEZf6AiMvOPPg0K6Rv9DU6bqDCCuLH3V+D8PEqijX
         YKFbb/Z0+S0GibhfCPcEeSn5gh15mXB+5UV4vn7WjrUWQ7JHTbSjBwrPvXrYqw/VXL/a
         s61B5H4dC9rIwNVddP1LegswTgvQ1kxyx9V1oqy2ezZxgOBlt4JNVZ6XmnPjqaClvlzN
         4wt3wkDwhcVaykMlukxpxLnIlBb/hnE0DJbYixVv8c/a7V9ImP0g9TVTeSnzQ/QpvCvA
         +LrQ==
X-Gm-Message-State: APjAAAVwEGHGVjaJO/LRZYpIPoeqvv8KYCKIC4m0S051cJDZ98H6bxXE
        60IDhhp8mjIKPkJxUSsPM28=
X-Google-Smtp-Source: APXvYqxAcn/w0rck6qGmO9csw5Ep2yDM/kQvtSot8bn2yHnCKiH0cCssbRkIhRUVc9mWwBVceVrXFQ==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr61730407wmk.36.1563825199664;
        Mon, 22 Jul 2019 12:53:19 -0700 (PDT)
Received: from localhost.localdomain (nat-113.starnet.cz. [178.255.168.113])
        by smtp.googlemail.com with ESMTPSA id c65sm37382975wma.44.2019.07.22.12.53.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:53:19 -0700 (PDT)
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
Subject: [PATCH 1/5] power: reset: Add UART-based MCU poweroff DT bindings
Date:   Mon, 22 Jul 2019 21:53:01 +0200
Message-Id: <cda16032dc5679a557230cbdb63702b105782b3b.1563822216.git.evgenyz@gmail.com>
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

This adds device tree bindings of the poweroff driver
for power managing micro controller units that are connected
to a board via the UART interface.

Signed-off-by: Evgeny Kolesnikov <evgenyz@gmail.com>
---
 .../bindings/power/reset/uart-poweroff.txt    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/uart-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/uart-poweroff.txt b/Documentation/devicetree/bindings/power/reset/uart-poweroff.txt
new file mode 100644
index 000000000000..86d036271b51
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/uart-poweroff.txt
@@ -0,0 +1,38 @@
+* UART-based PM MCU power off driver
+
+Some devices have a microcontroller controlling the main power
+supply. This microcontroller is connected to UART of the SoC.
+Sending a sequence of characters tells the MCU to turn
+the power off.
+
+The length of the sequence, baud rate and the timeout to process
+the command may vary from device to device.
+
+This driver could be used for WD My Cloud (Marvell SoCs), QNAP
+(Kirkwood and Orion5x SoCs) and Synology NAS devices.
+
+Required properties:
+- compatible: Should be "uart-poweroff"
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
+            prioritize itself over any existing power off driver,
+            default behaviour is not to interfere
+
+Example:
+	poweroff@12100 {
+		compatible = "uart-poweroff";
+		reg = <0x12100 0x100>;
+		clocks = <&coreclk 0>;
+		baud = <19200>;
+		cmd = [fa 03 03 01 00 00 fb];
+		status = "okay";
+	};
-- 
2.21.0

