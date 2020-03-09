Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A3817D8BA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 06:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCIFHy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 01:07:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33032 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIFHx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 01:07:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ABE431A0153;
        Mon,  9 Mar 2020 06:07:51 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C0F671A00E9;
        Mon,  9 Mar 2020 06:07:47 +0100 (CET)
Received: from titan.ap.freescale.net (titan.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AA5BB402C1;
        Mon,  9 Mar 2020 13:07:42 +0800 (SGT)
From:   andy.tang@nxp.com
To:     daniel.lezcano@linaro.org, edubezval@gmail.com, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] dt-bindings: thermal: make cooling-maps property optional
Date:   Mon,  9 Mar 2020 12:54:11 +0800
Message-Id: <20200309045411.21859-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

Cooling-maps doesn't have to be a required property because there may
be no cooling device on system, or there are no enough cooling devices for
each thermal zone in multiple thermal zone cases since cooling devices
can't be shared.
So make this property optional to remove such limitations.

For thermal zones with no cooling-maps, there could be critic trips
that can trigger CPU reset or shutdown. So they still can take actions.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index ca14ba959e0d..f78bec19ca35 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -142,11 +142,11 @@ Required properties:
 - trips:		A sub-node which is a container of only trip point nodes
   Type: sub-node	required to describe the thermal zone.
 
+Optional property:
 - cooling-maps:		A sub-node which is a container of only cooling device
   Type: sub-node	map nodes, used to describe the relation between trips
 			and cooling devices.
 
-Optional property:
 - coefficients:		An array of integers (one signed cell) containing
   Type: array		coefficients to compose a linear relation between
   Elem size: one cell	the sensors listed in the thermal-sensors property.
-- 
2.17.1

