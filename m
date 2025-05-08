Return-Path: <linux-pm+bounces-26851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665ADAAF062
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 03:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1397468098
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 01:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9476136358;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3zHAlxl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9C28F4;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666155; cv=none; b=uEYxbuJqRx5iWmPrlH9JGSFYZGB18ukrJMvHvGJdWeBzegYpuYbdgQlTFn3JrzvQRfXs/5txId6ER9bmubChavk32vXJ+vQz3XAEryQFI58SDXHwxKyMFQpm3rh5BhHf5ZXRnJttWS4yRbMKpduH5sGqfumLAoG51FtwrOfinEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666155; c=relaxed/simple;
	bh=82zQ2CvBZVOxHNGr6D3/jsJpXis3IqM1RlJcYLFTOnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVXYfTXDRkDGh09zfo3zATyvxH1E4dQXu1q/rVsHpXPelFgkRlWzZEfJBedoCNNsk4QsuC7swb5//PgK1sX6tlvKD1dKUrxctTQd+BVgjJPeIFbc2D6p7ieKjzu66YrADaLIiKRoyadljSEqTBKnW++lXgdhIJFyV7s4SbfO5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3zHAlxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25016C4CEE8;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746666155;
	bh=82zQ2CvBZVOxHNGr6D3/jsJpXis3IqM1RlJcYLFTOnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i3zHAlxl6fa4U0YW7H9Rz8P8O4mAsEIUmsPbqF072HpKXzVFnCFx0FXPfXE8Bcfu2
	 GkJbZg1M5hXfoTpryIFYZXH/6dfGQiGsrDhiGDdjI4EMfEINNgrjeVcSmgHe5KGrz3
	 fa7dBMIpYnLXeIHP/zZuBOr8SAZc1y6GDi66DXUnjYi2OQj1hjACqWmDNbPWSxXm1I
	 vbI5O/idhHZUS6L3rol05LgaN1azgHpzvZXrpCn5YhgX410zgWlTVN0fVqZeze4tcx
	 pvLSmTxo6YC0baz6GR8XZziWaBP8Wmf1gNESR+oHPFgzhjY0w9Oc8QW7BSKur6U8w8
	 jVFWi03dXTLoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138F7C3ABC3;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 07 May 2025 18:00:22 -0700
Subject: [PATCH v2 1/5] dt-bindings: connector: extend ports property to
 model power connections
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-batt_ops-v2-1-8d06130bffe6@google.com>
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
In-Reply-To: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
 Pavel Machek <pavel@kernel.org>
Cc: Kyle Tso <kyletso@google.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-pm@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746666154; l=4228;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=gzckttDcjypwX3XJfOW+9CCJ+fMJ1rLKGVz78d8daH4=;
 b=nPp1lTueEhju1m5Sn4i9ftpiX0yNxkrNTExn3+TI2bSc6CCDa5b+PnGXV35Ik0pWDji4yb3lP
 dukbFeUi908AI9W+JaRxXkmXwwON4Wu5Do633UkqwdLTgVCYS6VGd0y
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Extend ports property to model power lines going between connector to
charger or battery/batteries. As an example, connector VBUS can supply
power in & out of the battery for a DRP.

Additionally, add ports property to maxim,max33359 controller example.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 .../bindings/connector/usb-connector.yaml          | 20 +++++++++++------
 .../devicetree/bindings/usb/maxim,max33359.yaml    | 25 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..706094f890026d324e6ece8b0c1e831d04d51eb7 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -181,16 +181,16 @@ properties:
 
   port:
     $ref: /schemas/graph.yaml#/properties/port
-    description: OF graph bindings modeling a data bus to the connector, e.g.
-      there is a single High Speed (HS) port present in this connector. If there
-      is more than one bus (several port, with 'reg' property), they can be grouped
-      under 'ports'.
+    description: OF graph binding to model a logical connection between a device
+      and connector. This connection may represent a data bus or power line. For
+      e.g. a High Speed (HS) data port present in this connector or VBUS line.
+      If there is more than one connection (several port, with 'reg' property),
+      they can be grouped under 'ports'.
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
-    description: OF graph bindings modeling any data bus to the connector
-      unless the bus is between parent node and the connector. Since a single
-      connector can have multiple data buses every bus has an assigned OF graph
+    description: OF graph bindings to model multiple "port". Since a connector
+      may have multiple logical connections each one has an assigned OF graph
       port number as described below.
 
     properties:
@@ -207,6 +207,12 @@ properties:
         description: Sideband Use (SBU), present in USB-C. This describes the
           alternate mode connection of which SBU is a part.
 
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: VBUS/VCHGIN present in USB-C connector to model power line
+          going in and/or out of the charger/battery. If there are multiple
+          batteries then this port should contain those many endpoints.
+
     required:
       - port@0
 
diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 3de4dc40b79192b60443421b557bd2fb18683bf7..730d5c1cc9ddf1ddeff055c00ee172745297633d 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -75,6 +75,31 @@ examples:
                                        PDO_FIXED(9000, 2000, 0)>;
                 sink-bc12-completion-time-ms = <500>;
                 pd-revision = /bits/ 8 <0x03 0x01 0x01 0x08>;
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+                        usbc0_orien_sw: endpoint {
+                            remote-endpoint = <&usbdrd31_phy_orien_switch>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+                        usbc0_role_sw: endpoint {
+                            remote-endpoint = <&usbdrd31_dwc3_role_switch>;
+                        };
+                    };
+
+                    port@3 {
+                        reg = <3>;
+                        vbus_batt: endpoint {
+                            remote-endpoint = <&max17201_fg>;
+                        };
+                    };
+                };
             };
         };
     };

-- 
2.49.0.987.g0cc8ee98dc-goog



