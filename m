Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589D12D13D9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 15:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLGOhM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 09:37:12 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:23838 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgLGOhM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 09:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607351660;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=YyL6nuGTcYJO+ZAkXbygs5J3f3HwjnZAYZkEkr63Dys=;
        b=rojPTJPToy0N1KRvCMYCdZW1PjdPal7DM/Ijh8qQZ1o6rthH8bsXRwRq+VNtTAcrrk
        TmDDwNWhDKrFgyvv1v2oW4U/vmL9IsN4d1uh3fWofK7DkVqtt/oVjCUGXJzaJHJFmWIS
        9B/wyYKHSC0Uc8LzUzLwGXsNEaSJAorIQS6OEqr1ckMDS1RJTudFo6vQe2L4bU+F2y8U
        LN8MTKjGonI0Qi1aEfsa2tNGjGuY15nI1m4MiCP6Cu/Pi0+zHeXKNleF0W5kERxJPMGB
        rga6afrHiqzVjlQhGuO864EUGKDGMNlbd599SaXlFUhgtOC4tynW+2mIxjYtLHPtXfnz
        TiMA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wB7ES5OVa
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 7 Dec 2020 15:28:05 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kmHUg-0001Sz-6i; Mon, 07 Dec 2020 15:28:02 +0100
Received: (nullmailer pid 17882 invoked by uid 502);
        Mon, 07 Dec 2020 14:28:02 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Klein <michael@fossekall.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] BPi M2 Zero poweroff support via new regulator-poweroff driver
Date:   Mon,  7 Dec 2020 15:27:53 +0100
Message-Id: <20201207142756.17819-1-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201128103958.q6glewhhch7vtczr@gilmour>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
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

Michael Klein (3):
  power: reset: new driver regulator-poweroff
  Documentation: DT: binding documentation for regulator-poweroff
  ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add poweroff node

 .../power/reset/regulator-poweroff.yaml       |  53 +++++++++
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    |   7 ++
 drivers/power/reset/Kconfig                   |   7 ++
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/regulator-poweroff.c      | 107 ++++++++++++++++++
 5 files changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
 create mode 100644 drivers/power/reset/regulator-poweroff.c

-- 
2.29.2

