Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DEC2EA88E
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 11:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbhAEKXu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 05:23:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16875 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbhAEKXt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 05:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1609842228; x=1641378228;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Hkq9Fwje5+PfX7EUjvA17my8iHwo8jNIb8URrp0sN64=;
  b=fVMvPz403XyDiWm3MHWB+6h+KMz0a8yYRLuRctDXKCSEd8+OO3gyYX7y
   eJlSkn4TgmBs+mMMIRTrDV16QkPJVYeLFClUiH55ryGWWZZgpJM/qCpUS
   dnS0kLm79CZ7nUzGFhCtzhRx2nPJyDl9w00qjjSgEaMUp56PAhEFGbPQZ
   ykPup78r1yS5bxZZADjzUQlErHWfGHj6128dlfk+tAciCw+hZAwB2yark
   4rP+/nZRA6X/f+iH1E9i88A7UY0V1rg1masZHuQL++8ZoDuqXq9E8iXne
   VC56s+aC1fw3A7ClKcKXBMwJj3qu41RhtP6HWQQfTNyciAeP0YXADuJuT
   Q==;
IronPort-SDR: uuQx6/QlC7K8+eVFrX3SEi3SEAM2C3EVR/WcmpYwoSRpliYH0HmOp5YdaoeugvK3KZZ4JhkLig
 Qneo/htWieBAj9LJSjcP5GimFqUD9K7j9uXTlmnyxSie9YjyWSRqee9BHzOL0g1+WFVHHq50j1
 scH8QkvHoW29Xm5QPvZthlcN6V6cv86V6g0prseppv3G87UHHTdK8evP0lwhSp2sMz0OiBx5Ks
 VHBgufPSK1FZy4TaXfIKyH0UYuT+2+V3NVZDRrNd9Tju63vLVUX0eWlSVWwEoA58juI9CJbr3f
 kDU=
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="99023594"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jan 2021 03:22:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 5 Jan 2021 03:22:32 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 5 Jan 2021 03:22:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] cpufreq: sama7g5: add support for sama7g5
Date:   Tue, 5 Jan 2021 12:22:24 +0200
Message-ID: <1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

SAMA7G5 supports run-time changes of CPU frequency. This is done by
changing CPU's PLL. The block diagram explaining the relation b/w
CPU clock and its PLL is as follows:

                         +--------------> cpuck
                         |
               +------+  |    +-----+
  cpupllck --> | pres |--+--> | div |---> mck
               +------+       +-----+

where cpuck is the CPU's clock and mck is the system master clock 0
that feeds some other IPs. All the IPs feed by mck are glich free 
aware.

Because MCK is also feed by cpuplllk the CPUFreq driver needs also
to handle this clock to avoid its under/over clocking: every
time the CPUFreq's .target_index API is called:
- the mck frequency is adjusted to avoid its overclocking/underclocking
- then the cpuck frequency is increased/lowered
- then mck frequency is adjusted to keep the initial 200MHz frequency

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  dt-bindings: cpufreq: sama7g5-cpufreq: add dt bindings documentation
  cpufreq: sama7g5: add cpufreq driver
  MAINTAINERS: add sama7g5 cpufreq

 .../bindings/cpufreq/cpufreq-sama7g5.yaml          |  80 +++++
 MAINTAINERS                                        |   6 +
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   2 +
 drivers/cpufreq/sama7g5-cpufreq.c                  | 371 +++++++++++++++++++++
 6 files changed, 469 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-sama7g5.yaml
 create mode 100644 drivers/cpufreq/sama7g5-cpufreq.c

-- 
2.7.4

