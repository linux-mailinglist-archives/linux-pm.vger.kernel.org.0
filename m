Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988DD1EB27
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 11:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfEOJop (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 05:44:45 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36558 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfEOJop (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 05:44:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CD93E2000CC;
        Wed, 15 May 2019 11:44:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AEC19200175;
        Wed, 15 May 2019 11:44:39 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4811E4029A;
        Wed, 15 May 2019 17:44:34 +0800 (SGT)
From:   Yuantian Tang <andy.tang@nxp.com>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     robh+dt@kernel.org, daniel.lezcano@linaro.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] dt-bindings: thermal: Make cooling-maps property optional
Date:   Wed, 15 May 2019 17:36:47 +0800
Message-Id: <20190515093647.47656-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There may be no cooling device on system, or there are no enough
cooling devices for each thermal zone in multiple thermal zone
cases since cooling devices can't be shared.
So make this property optional to remove such limitations.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 .../devicetree/bindings/thermal/thermal.txt        |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index ca14ba9..694e834 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -142,11 +142,11 @@ Required properties:
 - trips:		A sub-node which is a container of only trip point nodes
   Type: sub-node	required to describe the thermal zone.
 
+
+Optional property:
 - cooling-maps:		A sub-node which is a container of only cooling device
   Type: sub-node	map nodes, used to describe the relation between trips
 			and cooling devices.
-
-Optional property:
 - coefficients:		An array of integers (one signed cell) containing
   Type: array		coefficients to compose a linear relation between
   Elem size: one cell	the sensors listed in the thermal-sensors property.
-- 
1.7.1

