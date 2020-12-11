Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048662D7910
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406632AbgLKPTh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 10:19:37 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:13540 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437682AbgLKPTG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 10:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607699768;
        s=strato-dkim-0002; d=fossekall.de;
        h=Message-Id:Date:Subject:Cc:To:From:From:Subject:Sender;
        bh=NCsW77FbQ1B3gPrsvuKFRFGs+rTfq3kJjuPpOkHykKY=;
        b=gHyX06VEezUlEoSxYyFkmFgQUQHCJYgBv7j/3d7dVuMiUJEXXKKRutgaGZjt5zKls1
        vQYmXRWZadJzAqym7HWtE01SoG9+ct8XuXK4do99Z3Z69EY6VxgWxF0DHDD2+7voHAbA
        sRBiyr5pAd8dU78v1QoLjihWyugK0eYmUzXRro+a3jyszjG8tEVRkwSq9SUOy9lPr7c2
        DPb2xnb6/SpprfzmthLkkgAwjULxreFzUKkBRnHXuqldzYzrl9KYgV6WFO9QRKB5fliQ
        eq046dfsHCm+KHBDQ5e/3J7eZvyVPDIzVtYtHsWTsacsKDC1jptVH6my+tK4bJku6OGp
        ZOVA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.7.1 AUTH)
        with ESMTPSA id L0a6acwBBFG61AH
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 11 Dec 2020 16:16:06 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1knk8G-0005RX-4w; Fri, 11 Dec 2020 16:14:56 +0100
Received: (nullmailer pid 116008 invoked by uid 502);
        Fri, 11 Dec 2020 15:14:56 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/3] BPi M2 Zero poweroff support via new regulator-poweroff driver
Date:   Fri, 11 Dec 2020 16:14:42 +0100
Message-Id: <20201211151445.115943-1-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v2:
  - rename DT node

Changes in v3:
  - add regulator-poweroff driver
  - use regulator-poweroff driver instead of gpio-poweroff

Changes in v4:
  - hardcode poweroff timeout to 3000ms, not configurable any more
  - remove support for multiple regulators
  - fix Documentation issues

Changes in v5:
  - rename DT property 'power-supply' -> 'cpu-supply'

Michael Klein (3):
  power: reset: new driver regulator-poweroff
  Documentation: DT: binding documentation for regulator-poweroff
  ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add poweroff node

 .../power/reset/regulator-poweroff.yaml       | 37 +++++++++
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    |  5 ++
 drivers/power/reset/Kconfig                   |  7 ++
 drivers/power/reset/Makefile                  |  1 +
 drivers/power/reset/regulator-poweroff.c      | 82 +++++++++++++++++++
 5 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
 create mode 100644 drivers/power/reset/regulator-poweroff.c

-- 
2.29.2

