Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31264196E71
	for <lists+linux-pm@lfdr.de>; Sun, 29 Mar 2020 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgC2QZv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 12:25:51 -0400
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:52668 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgC2QZv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Mar 2020 12:25:51 -0400
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 3A33A24975;
        Sun, 29 Mar 2020 18:16:25 +0200 (CEST)
From:   David Heidelberg <david@ixit.cz>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 0/9] Summit SMB3xx driver & device-tree
Date:   Sun, 29 Mar 2020 18:15:43 +0200
Message-Id: <20200329161552.215075-1-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We gathered existing patches, fixed and improved what we could and
final result is an working charging driver with device-tree support for
Nexus 7.

At this moment charging works with:
 - Nexus 7 2012 (grouper and tilapia)
 - Nexus 7 2013 (flo and deb)
 - ... and there is more devices equiped with these chargers.

David Heidelberg (7):
  power: supply: smb347-charger: Add delay before getting IRQSTAT
  power: supply: smb347-charger: Use resource-managed API
  dt-bindings: power: supply: Add device-tree binding for Summit SMB3xx
  power: supply: smb347-charger: Implement device-tree support
  power: supply: smb347-charger: Support SMB345 and SMB358
  power: supply: smb347-charger: Remove virtual smb347-battery
  arm: dts: qcom: apq8064-nexus7: Add smb345 charger node

Dmitry Osipenko (2):
  power: supply: smb347-charger: IRQSTAT_D is volatile
  power: supply: smb347-charger: Replace mutex with IRQ disable/enable

 .../power/supply/summit,smb347-charger.yaml   | 224 ++++++++
 .../boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  22 +-
 drivers/power/supply/Kconfig                  |   6 +-
 drivers/power/supply/smb347-charger.c         | 510 +++++++++---------
 .../dt-bindings/power/summit,smb347-charger.h |  19 +
 5 files changed, 526 insertions(+), 255 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml
 create mode 100644 include/dt-bindings/power/summit,smb347-charger.h

-- 
2.25.0

