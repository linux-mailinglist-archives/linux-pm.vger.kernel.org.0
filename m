Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32F2127F51
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 16:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfLTPbZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 10:31:25 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:32238 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfLTPbY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 10:31:24 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: FTCSFpRtgN7lXrlDsFDpdQV+UrKxCvj219yph4+nQ228/FAh47AcjPT6Rdvg/cbrvhUg/PsvyM
 LeoWRRi6HRiHeE0j9UlUkJz4HSXMBh4IVGfh4bkSJprSmt1dE1HO34QufT6f/gWcOayWKLzHSy
 mp2rJWkJYGeg3yBfUqLTNQFbykT3C/RNw6zT1DoDf5+tv0DrtFlYcdZ0xQJYyK2pUPCRVp5vpV
 +ZrimcMoGhbhYdyVP47Rwdmcf7UchOO2785/e+FQhuYwcKjK5bqLqZUKdpHTqkLAXS3eEiC4o7
 IdE=
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; 
   d="scan'208";a="58490660"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2019 08:31:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Dec 2019 08:31:27 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 20 Dec 2019 08:31:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <sre@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/2] at91-sama5d2_shdwc shutdown controller
Date:   Fri, 20 Dec 2019 17:31:16 +0200
Message-ID: <1576855878-13213-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

PMC master clock register offset is different b/w sam9x60 and
other SoCs. Since there is a need of this register offset in
shutdown procedure we need to have it per SoC. This is what
this series does.

Changes in v2:
- do not use r5 as intermediary registers in at91_poweroff 

Claudiu Beznea (2):
  power: reset: at91-poweroff: introduce struct shdwc_reg_config
  power: reset: at91-poweroff: use proper master clock register offset

 drivers/power/reset/at91-sama5d2_shdwc.c | 72 +++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 25 deletions(-)

-- 
2.7.4

