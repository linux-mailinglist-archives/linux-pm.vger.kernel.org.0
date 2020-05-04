Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075351C4742
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 21:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgEDTrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 15:47:51 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:11554 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgEDTrv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 15:47:51 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GD0h51GbzxG;
        Mon,  4 May 2020 21:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588621668; bh=s1HXUgdptDiILL4CHASaCVMVwp8zJDwtvmtc4X9Z27M=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=domxx5yjMhpAYJy4SELZqPSdXKV/RtsW2NFICgsxNZFoLFqExgNYZ0tzqKIOZ/G04
         0HvSqll7LkhlALoMU9wJkg2uMR8sSHiiXEL1oG12/BLHWc7NdJYotwowv46n76WIu6
         sOOjE/+kenxKIHaCqSbW92FrR3OxItqNKPzVJgRBDMEpojfG+bI+tl8X1NYCbxSTmD
         luPdQkJw2ElkXRHvr8WMxLEQ9Jnc5gkl4HKcmJ/HGQkNGXs1I5c6ndSo/+NGbMliA5
         zwzocNpXje+44WWj5lufPSii4UB9sbMsL3QuVL2bXoozTbeQsbeFPz4T9RHwYXV+i1
         wfvi6ZMiJNZyA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:47:48 +0200
Message-Id: <7bf8bb5654bf67e14b59c5f94d024ac6ef5ff0ce.1588621247.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 8/8] power: bq25890: document IBAT compensation DT
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Angus Ainslie <angus@akkea.ca>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document newly introduced IBAT compensation settings.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: initial version
---
 Documentation/devicetree/bindings/power/supply/bq25890.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
index dc9c8f76e06c..bd214945d9dc 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
@@ -32,6 +32,10 @@ Optional properties:
 - ti,thermal-regulation-threshold: integer, temperature above which the charge
     current is lowered, to avoid overheating (in degrees Celsius). If omitted,
     the default setting will be used (120 degrees);
+- ti,ibatcomp-resistance: integer, value of a resistor in series with
+    the battery (in uOhm);
+- ti,ibatcomp-clamp-voltage: integer, maximum charging voltage adjustment due
+    to expected voltage drop on in-series resistor (in uV);
 
 Example:
 
-- 
2.20.1

