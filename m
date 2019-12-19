Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8E112649D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 15:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfLSO2G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 09:28:06 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:55167 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLSO2G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 09:28:06 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: BjzMGNHgLHlMgecpf3LgkN2t6TBT0tWRHistvDcqmTy96ic0bJm8JJj4fxOlKD0FTBHcqMAArf
 ZHgPcRLMIVO15+DcQgjMm8aoEeoZ/X9o8iyzECCAVpSBRMvIm5IZlvgaP7AVitR1or+CxpJ98j
 1FCFT0QG6tjhjKYzcRsDYxyPdDEAl7DBImBND03w78KlR73okUied+ByOXyKoMj2pielpUXwmy
 vqhXd0eExOtrOwPkrT7KVmaX0o9IMsCy1MeODlOQLZ3Ig2wd6tf3uLiZbnbBuQOiQzBW9z8FQl
 k/A=
X-IronPort-AV: E=Sophos;i="5.69,332,1571727600"; 
   d="scan'208";a="60355274"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Dec 2019 07:28:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Dec 2019 07:28:04 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Thu, 19 Dec 2019 07:28:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <sre@kernel.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] at91-sama5d2_shdwc shutdown controller
Date:   Thu, 19 Dec 2019 16:27:52 +0200
Message-ID: <1576765674-22070-1-git-send-email-claudiu.beznea@microchip.com>
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

Claudiu Beznea (2):
  power: reset: at91-sama5d2_shdwc: introduce struct shdwc_reg_config
  power: reset: at91-sama5d2_shdwc: use proper master clock register
    offset

 drivers/power/reset/at91-sama5d2_shdwc.c | 75 +++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 26 deletions(-)

-- 
2.7.4

