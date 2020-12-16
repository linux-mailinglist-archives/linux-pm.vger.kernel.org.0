Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4CF2DC091
	for <lists+linux-pm@lfdr.de>; Wed, 16 Dec 2020 13:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgLPM67 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Dec 2020 07:58:59 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49093 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgLPM67 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2020 07:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1608123539; x=1639659539;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=akJW3I7vRgRB4W1/bFstfYQ3qkdKGHBntLgOB7XPEEg=;
  b=aSZrEQ3fZconFva9VYtJdnEFoaohW+/pZ5ziczQrB3G5zCIjumxF4QPm
   BkkqXJOPrd37E0KnTKziIpFcugz8wIIW+dsIw7PVzb2VBX04NeZXlnYi5
   rguznNP3JNcmMtpf5G96ex0XExdo/CNFcj8qZdNCs5A0gd6GSOi2DAO4y
   X2elSkggBFhyfACXn++ojK2CPDvieqV7ow1N56ZcVXF3e0QYgjhELagYy
   nQnMFQGCDje6WlqGzLUvH36neQlBPgFZCMLkOQvsXNQ+YVt2fuDLOkeCX
   2vpXjU+BUzkoGjn05vCN7CP5KWYx4MG6tiIgNRRQ525soZ+/7hE8MMvwZ
   A==;
IronPort-SDR: 5zNVxEj16DJcwg5rnze6LbvvtGRz2l3fda2dMmQms8S/ZbbA51WVVfLPoieeRDJN4A+sjqvfJT
 27Vx3jEWnLSrM7soWfKzUR2GhBA1zpbC0XfGvBSt3yIufWgucm8Q3RGw6GANyTHtrGHlNuhGq0
 e2QB5LEic+Dys0k7sDi1bc0gY1qn6XGN4QxboEomWLYllwMJw/e63gqtC3dSuip1In1EaA18rE
 l7pQIbnp+NMG9T3IxvDJ4MGUzEfN4rtoWD7vQf9m35Pyrh/TgJdzhCzdeK6Bc+ls47vO/ggCMo
 yfY=
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="102424408"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2020 05:57:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Dec 2020 05:57:42 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 16 Dec 2020 05:57:40 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] power: reset: at91-sama5d2_shdwc: add support for SAMA7G5
Date:   Wed, 16 Dec 2020 14:57:30 +0200
Message-ID: <1608123453-1423-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This series adds support for SAMA7G5 shutdown controller.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  power: reset: at91-sama5d2_shdwc: fix wkupdbc mask
  dt-bindings: atmel-sysreg: add microchip,sama7g5-shdwc
  power: reset: at91-sama5d2_shdwc: add support for sama7g5

 .../devicetree/bindings/arm/atmel-sysregs.txt      |  5 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           | 74 ++++++++++++++++------
 2 files changed, 58 insertions(+), 21 deletions(-)

-- 
2.7.4

