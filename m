Return-Path: <linux-pm+bounces-30848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1654B05008
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089184A7487
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1AF2D94BF;
	Tue, 15 Jul 2025 04:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6O04kvv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F6C2D63F4;
	Tue, 15 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552232; cv=none; b=SD+WCEnSaQEThHiHzPRG171gEQSNPK9ih9Smi9M88gj68J6ZSUq+PMVJNjyjSD0T/67jELTzFFhVYjEBaJ8di12CNk3wrVLqZ0Bho2q8FUQb8G/SylZNWEA9EWyRi8QOXZd1qqAei6sfENLHz8ENB3KVMX4a7KtO+8ni7OIoQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552232; c=relaxed/simple;
	bh=htHW6rtHg7NSjIcI/4lWhbhWmP6UNSBw9fjzNoVOG+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CswJ26wJc+h2/3Y74HKXyCCo/+2u1pqvRTshXQBrpWHZz0L+dUGrA9CjK/AyHFqWv8n8sBcJ13CoLSKmhHvnfgzWa2cjm3lLXdGNIXWNg5+v+h+kOh9HHTk5ZvHo0Ip98JFs2SKFH+/gnOVx9pqiOFoGGwmnUvWBiTe6tbssu7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6O04kvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D593FC4AF52;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552232;
	bh=htHW6rtHg7NSjIcI/4lWhbhWmP6UNSBw9fjzNoVOG+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F6O04kvvIj2entXcpHjijwWVFKNbId5Ft7+2xkar8HPtwglWLAu3b62JxMSlHwvi4
	 zA3rR33pp+21x37MHL7RkNQJ1oFYUb6dMdO3TV1qebXQBqbcFZq4+bS9gnkzvdHvJg
	 MJFR8T5Dxoier5Q5BYDKb48TcCQRUb+k2+C5ux4V4pfkaPsTjHZ8cLFNtYpJYeLnhc
	 9QstN6ruwurdg9vK5u5h6MuH3Hks6QTCq+/7sAUIVdQfwEonZQKr5jez8ZXV60QpAc
	 c42tgrRMpCrn6xaXDmnWkXXrjhJo2fLQ/UJU+IjrYEuEIKipEwfyrUpK2xRB/N4pDT
	 +0cg5Obh6xFmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C405BC83F2D;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:47 -0500
Subject: [PATCH 04/17] dt-bindings: usb: tegra-xudc: Document Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-4-e3f5f7de5dce@gmail.com>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
In-Reply-To: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nagarjuna Kristam <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=1146;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Jyy45qLdZDq9DiQVnsxM/Qp0gR79KFt6neXymT4FCWQ=;
 b=TcCa6TVpGjZW7jzTH8gjJ6dgjSh/2EdBKGUTbaM2ZDtD0kBy23zs1eI/CDye8JwKO2xOUgB31
 lQDc77DFvRuA+nPAP4zJoCewfmgWm9F49iS26kbUgAvOq9BDkIfHDPO
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Extend the Tegra XUSB controller device tree binding with Tegra210B01
support.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
index c6e661e8915ca4d3e905331299d981f4d3964314..4574e66e7c1d3d3c918991920bbf4f3ea0ee6ab2 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
@@ -20,6 +20,7 @@ properties:
     items:
       - enum:
           - nvidia,tegra210-xudc # For Tegra210
+          - nvidia,tegra210b01-xudc # For Tegra210B01
           - nvidia,tegra186-xudc # For Tegra186
           - nvidia,tegra194-xudc # For Tegra194
           - nvidia,tegra234-xudc # For Tegra234
@@ -130,6 +131,7 @@ allOf:
           contains:
             enum:
               - nvidia,tegra210-xudc
+              - nvidia,tegra210b01-xudc
     then:
       properties:
         reg:

-- 
2.50.0



