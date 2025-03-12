Return-Path: <linux-pm+bounces-23941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4E2A5E888
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 00:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D867F3B85DA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 23:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919DF1F1931;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDl7urbm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7521E5B7D;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823000; cv=none; b=LH+x9hLLYli8CgMCmMbmHZUZ8f6Z2l38zRfeZ8Zn/CLq/u89KCHxdCzaS7oxKCIpg+jrQy5fVNNz5mOtAx+4WtF+YX019urNgfl+LnrGkkzSslnxFY7E3BWmOsxJ8g9mmlasxjNXwZsDNT5703XNt/IZgl3NpofZz+IVonnUJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823000; c=relaxed/simple;
	bh=oNHEqFnHlfFcftIEwL+ZSyzQY3I5krbjajiCBWj4zhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HO1CKS+6sS31O8utfcVgQyF/jZ74M+OEYMOM7LypqJQ4/7NeSfBQlV2kkB5mnPvUZtobkmNP+UJmqH6kPDcqIV1TpU0IlelqADCvTRsFzTCedWwBbCfFxKvt8XK1ns5ram1nmaobwbNZ2tW22vSgwh/KGA/29E5NGIyTqV3gMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDl7urbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBD70C4CEEB;
	Wed, 12 Mar 2025 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741822999;
	bh=oNHEqFnHlfFcftIEwL+ZSyzQY3I5krbjajiCBWj4zhM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bDl7urbmpwbzxmuEqxaqwGE8H7Lq9MZCpqwL6sro/WrWsitPY1b4+TDe8t8N2N+OO
	 io4R5xzQ9gB+WhwgmhkXD6XyjM+ShWV1GG1Q9Zlj5XBkbKv2FdYLxCHg3oBLRnoayS
	 YiV2jP3oFIUls2OqzQNC6K9N+nldd9+226Tm8SCLEPvcKWbAZKZFMPZQXCHTaqvzQL
	 MSw+tzCrit9SVgy67O/AQCAhs7GPQdQLYcQHv0b9sZfxeR60M3BjMLW0DNRng/UUoL
	 VGgOdqqdqvHjw4/4FjasCZBevllr2yRg6qQm/8pyjfMVrigpSykgUKvsiL556y69Iu
	 n6pv1PgQ6g0Cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66CFC35FF1;
	Wed, 12 Mar 2025 23:43:19 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 12 Mar 2025 16:42:01 -0700
Subject: [PATCH 1/5] dt-bindings: connector: add fixed-batteries property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-batt_ops-v1-1-88e0bb3129fd@google.com>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
In-Reply-To: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
 Pavel Machek <pavel@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741822998; l=2148;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=lqB7hbM4siiws9pIh8thUf/I8+c5fiz+QxbzSuLaKTI=;
 b=hsUx8+UVc88upFK9cm+h8BLvCbfLdOUWzajlTp2MMm6mhFBleKWb8+HpA/plfvmMQYjbZ68zu
 p4UeoLFlbZaDKPMCwtoPQDgTMN7r+riaPZLxj73hm2hWzkwoq23N1HT
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add a new "fixed-batteries" DT property to connector class. This
property is populated with nodes associated with battery type power
supplies powering the USB PD connector. This is needed by the Type-C
Port Manager (TCPM) to query psy properties which are used to feed
Battery_Status & Battery_Capacity AMS.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 Documentation/devicetree/bindings/connector/usb-connector.yaml | 8 ++++++++
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..5e15bc060f5a2cfce842f83de738f1e8bae3ce2d 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -300,6 +300,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     maxItems: 4
 
+  fixed-batteries:
+    description: Contains references to nodes associated with battery type power
+      supplies powering the USB PD device. These batteries are fixed type and
+      not hot swappable.
+    minItems: 1
+    maxItems: 4
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
 dependencies:
   sink-vdos-v1: [ sink-vdos ]
   sink-vdos: [ sink-vdos-v1 ]
diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 3de4dc40b79192b60443421b557bd2fb18683bf7..66c99f0131f074f1c08e31d7481f555647e3b2f8 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -75,6 +75,7 @@ examples:
                                        PDO_FIXED(9000, 2000, 0)>;
                 sink-bc12-completion-time-ms = <500>;
                 pd-revision = /bits/ 8 <0x03 0x01 0x01 0x08>;
+                fixed-batteries = <&batt1 &batt2>;
             };
         };
     };

-- 
2.49.0.rc0.332.g42c0ae87b1-goog



