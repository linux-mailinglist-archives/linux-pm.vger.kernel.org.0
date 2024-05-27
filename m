Return-Path: <linux-pm+bounces-8164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172528D0066
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3901C2230D
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F26815ECC6;
	Mon, 27 May 2024 12:50:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697724D5A2
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814207; cv=none; b=T5u4e25xQFioYOKwy07Hwv5dkosaltCdQVadqlli8+EkeVj9cDkvXtHkMeecMacSjMloNscRGt/KXmmI1ZQAu/Fp9d0qrUdD3/mlJnIyh9S6JgVVx8vUMTlEya3Wc1+/Mej/pOUNR5b9JMdIVOvvxxz1ENxG64PqFtYnHVTOp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814207; c=relaxed/simple;
	bh=8hdldazWVA2zqxn3teJVpbzPafUsFkhaXGXuAlZegCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K6fSMRnRKHEKNEKilljG+0UxIU/KB+qIogOBP+flwphmpREksG2r1Tj7I12zQMGXzNTlrzqQDQT2Wf5SuYU9ft4fJ/+meiOyUKRv6pm6D5Z3BymWMqlz90ATsQPwXbgMdHrStNDa4FvlH+8nBZO7hR2365XAtqOGubKNtn/nDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4VnwHq2Drmz4x7kb
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 14:41:27 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c993:5573:f894:7353])
	by andre.telenet-ops.be with bizsmtp
	id UChF2C0032nC7mg01ChF7d; Mon, 27 May 2024 14:41:19 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sBZeD-00CfTd-4Q;
	Mon, 27 May 2024 14:41:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sBZf8-003hdW-RS;
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
Subject: [PATCH/RFC 0/3] pmdomain: renesas: rmobile-sysc: Remove serial console handling
Date: Mon, 27 May 2024 14:41:10 +0200
Message-Id: <cover.1716811405.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

Since commit a47cf07f60dcb02d ("serial: core: Call
device_set_awake_path() for console port"), the serial driver properly
handles the case where the serial console is part of the awake path, and
it looked like we could start removing special serial console handling
from PM Domain drivers like the R-Mobile SYSC PM Domain driver.
Unfortunately the devil is in the details, as usual...

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
cause a crash or system lock-up.  E.g. on R/SH-Mobile SoCs, the serial
ports share their PM Domain with several other I/O devices.  After the
use of pwm (Armadillo-800-EVA) or i2c (KZM-A9-GT) during early boot,
before the full serial driver takes over, the PM Domain containing the
early serial port is powered down, causing a lock-up when booted with
"earlycon".

This RFC patch series aims to provide a mechanism for handling this, and
to fix it for the PM Domain case:
  1. The first patch provides a mechanism to let the clock and/or PM
     Domain subsystem or drivers handle this, by exporting the clock and
     PM Domain dependencies for the serial port, as available in the
     system's device tree,
  2. The second patch introduces a new flag to handle a PM domain that
     must be kept powered-on during early boot, and by setting this flag
     if the PM Domain contains the serial console (originally I handled
     this inside rmobile-sysc, but it turned out to be easy to
     generalize this to other platforms in the core PM Domain code).
  3. The third patch removes the no longer needed special console
     handling from the R-Mobile SYSC PM Domain driver.

I did not fix the similar clock issue, as it is more complex (there can
be multiple clocks, and each clock provider can have its own value of
#clock-cells), and I do not need it for Renesas ARM platforms.

This has been tested on the APE6-EVM, Armadillo-800-EVA, and KZM-A9-GT
development boards, with and without earlycon, including s2ram with and
without no_console_suspend.

Notes:
  - This should not be needed on RZ/G3S, where each serial port device
    has its own PM Domain,
  - drivers/clk/imx/clk.c and drivers/pmdomain/imx/scu-pd.c have special
    handling for the of_stdout device, but is probably not affected, as
    each serial port seems to share its PM Domain only with the serial
    port's clock controller.

Thanks for your comments!

Geert Uytterhoeven (3):
  earlycon: Export clock and PM Domain info from FDT
  pmdomain: core: Avoid earlycon power-down
  pmdomain: renesas: rmobile-sysc: Remove serial console handling

 drivers/pmdomain/core.c                 | 24 ++++++++++++++++--
 drivers/pmdomain/renesas/rmobile-sysc.c | 33 +------------------------
 drivers/tty/serial/earlycon.c           | 14 ++++++++++-
 include/linux/pm_domain.h               |  4 +++
 include/linux/serial_core.h             | 10 ++++++++
 5 files changed, 50 insertions(+), 35 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

