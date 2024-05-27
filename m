Return-Path: <linux-pm+bounces-8160-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B848D0037
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA72283EE8
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7515715E5B1;
	Mon, 27 May 2024 12:41:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623215E5A9
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813684; cv=none; b=Gv6k/ZR8/KpzWoKts4B3TZJHvX347BYyMnGuzGu3zv5vGUx38Hw/u0GwNuJqOKY0XczewUIvqRKvAFqCZPg5NzUUmHB8u2Ut4ICWvm6bD2BJhGTJ+SRDhr9Lml1Ki1/vpGpLsEOaO+rCTvZtRv7NxLTmOFr2Yf6vueTE/x6G4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813684; c=relaxed/simple;
	bh=EIepfrHfmhIc9MJ0QvPBLJEXp/OzidtfVr/2NHCOLWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+MB6k/wvJ/EPA492BdeUlFly8NxUKQFS5u1Cx/hf5J1q5BFqp5EHMaGJ2dHQ1qUoe6oSIah+udheZK42SlOQIO62RQVeR/6S4Js9FDl6u25o34ImrwkfORsBed7UENN9cFrTaFHP+kVLUQY/Oze7X0SMYUoEqzS8+grQmKFj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c993:5573:f894:7353])
	by laurent.telenet-ops.be with bizsmtp
	id UChF2C0022nC7mg01ChFPu; Mon, 27 May 2024 14:41:19 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sBZeD-00CfTe-4S;
	Mon, 27 May 2024 14:41:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sBZf8-003hdZ-Sf;
	Mon, 27 May 2024 14:41:14 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Peng Fan <peng.fan@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/3] earlycon: Export clock and PM Domain info from FDT
Date: Mon, 27 May 2024 14:41:11 +0200
Message-Id: <efd9397662ff743f95298ca6aad4efdfa0ba1962.1716811405.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716811405.git.geert+renesas@glider.be>
References: <cover.1716811405.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlycon relies on the serial port to be initialized by the firmware
and/or bootloader.  Linux is not aware of any hardware dependencies that
must be met to keep the port working, and thus cannot guarantee they
stay met, until the full serial driver takes over.

E.g. all unused clocks and unused PM Domains are disabled in a late
initcall.  As this happens after the full serial driver has taken over,
the serial port's clock and/or PM Domain are no longer deemed unused,
and this is typically not a problem.

However, if the serial port's clock or PM Domain is shared with another
device, and that other device is runtime-suspended before the full
serial driver has probed, the serial port's clock and/or PM Domain will
be disabled inadvertently.  Any subsequent serial console output will
cause a crash or system lock-up.

Provide a mechanism to let the clock and/or PM Domain subsystem or
drivers handle this, by exporting the clock and PM Domain dependencies
for the serial port, as available in the system's device tree.
Note that as this is done during early boot-up, the device_node
structure pointing to the earlycon console is not yet created, so this
has to resort to raw property data.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/earlycon.c | 14 +++++++++++++-
 include/linux/serial_core.h   | 10 ++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a5fbb6ed38aed681..abe4831d9685e2b8 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -250,11 +250,14 @@ early_param("earlycon", param_setup_earlycon);
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
+const __be32 *earlycon_clocks, *earlycon_power_domains;
+int earlycon_clocks_ncells, earlycon_power_domains_ncells;
+
 int __init of_setup_earlycon(const struct earlycon_id *match,
 			     unsigned long node,
 			     const char *options)
 {
-	int err;
+	int err, size;
 	struct uart_port *port = &early_console_dev.port;
 	const __be32 *val;
 	bool big_endian;
@@ -309,6 +312,15 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	if (val)
 		port->uartclk = be32_to_cpu(*val);
 
+	earlycon_clocks = of_get_flat_dt_prop(node, "clocks", &size);
+	if (earlycon_clocks)
+		earlycon_clocks_ncells = size / sizeof(u32);
+
+	earlycon_power_domains = of_get_flat_dt_prop(node, "power-domains",
+						     &size);
+	if (earlycon_power_domains)
+		earlycon_power_domains_ncells = size / sizeof(u32);
+
 	if (options) {
 		early_console_dev.baud = simple_strtoul(options, NULL, 0);
 		strscpy(early_console_dev.options, options,
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 8cb65f50e830c8d4..70689a3363951dac 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -954,6 +954,16 @@ static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
 static inline int setup_earlycon(char *buf) { return 0; }
 #endif
 
+#ifdef CONFIG_OF_EARLY_FLATTREE
+extern const __be32 *earlycon_clocks, *earlycon_power_domains;
+extern int earlycon_clocks_ncells, earlycon_power_domains_ncells;
+#else
+#define earlycon_clocks			NULL
+#define earlycon_clocks_ncells		0
+#define earlycon_power_domains		NULL
+#define earlycon_power_domains_ncells	0
+#endif
+
 /* Variant of uart_console_registered() when the console_list_lock is held. */
 static inline bool uart_console_registered_locked(struct uart_port *port)
 {
-- 
2.34.1


