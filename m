Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F862D4C79
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 22:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgLIVGp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 16:06:45 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:27895 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgLIVGp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 16:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607547832;
        s=strato-dkim-0002; d=fossekall.de;
        h=Message-Id:Date:Subject:Cc:To:From:From:Subject:Sender;
        bh=Yv3BisX3VSbCqFQLA4ar1BwG3T8m1Bk8ItATVLb6B/A=;
        b=isEvdXqRuahkZiE4PEREE3/32hxkwMb9MkEqXaf7S4lag83P4e87iiDlwJQezhPUKy
        aU+yW7ljxQQurJuu9c/BRFfRbJFPXmky6YXKc3Vr4EfaQyfC1hiAK8tEjrMT9XBRh+8t
        sNs0qqkn6A/ZfsVycn9s+YTMEzydy9RDcS8bv7X/7l5YoZRMNId3cy2fZtYByUhvMq38
        INdF+z3paYVrclIO8HK21clF8lKspYs2vJ0FeUcTMNWOSiUchqGq97DOxi5pf4Rg9sVs
        D62jtM/b1siQoQWWWKq6vaMStP2pVD2twhtav1z/C8Jc4tFy7RE0U2+07etaMB9fNJbH
        BtXg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.6.2 AUTH)
        with ESMTPSA id e07b38wB9L3mB1V
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 22:03:48 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kn6cj-0008CT-7V; Wed, 09 Dec 2020 22:03:45 +0100
Received: (nullmailer pid 385332 invoked by uid 502);
        Wed, 09 Dec 2020 21:03:45 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/3] BPi M2 Zero poweroff support via new regulator-poweroff driver
Date:   Wed,  9 Dec 2020 22:02:18 +0100
Message-Id: <20201209210221.385188-1-michael@fossekall.de>
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

Michael Klein (3):
  power: reset: new driver regulator-poweroff
  Documentation: DT: binding documentation for regulator-poweroff
  ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add poweroff node

 .../power/reset/regulator-poweroff.yaml       | 37 ++++++++
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    |  5 ++
 drivers/power/reset/Kconfig                   |  7 ++
 drivers/power/reset/Makefile                  |  1 +
 drivers/power/reset/regulator-poweroff.c      | 86 +++++++++++++++++++
 5 files changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
 create mode 100644 drivers/power/reset/regulator-poweroff.c

-- 
2.29.2

