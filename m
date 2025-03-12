Return-Path: <linux-pm+bounces-23940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C457A5E886
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 00:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801B416F038
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 23:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707F1F152E;
	Wed, 12 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI/+Y0Rm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C216FF44;
	Wed, 12 Mar 2025 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823000; cv=none; b=b+FKpwsPtk8RchsZtq+14RauSHlxtRsBR9G0srYjg9bRQJDGYNDyEJZFbb33ggps6A7PexUHQKfxKO0ee9IyeHncbKiKxgvd1KPIOE7EVErztrfPpeZfIYckNlBC6BW2OcNVVuXA7/99/d8cqUtAC90GwNkqyaTO5QMh0jx2rCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823000; c=relaxed/simple;
	bh=90OuS2yk7g7bxyQlFmmSVP8LGE/eGIxU1ogAteq6FsQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nxAcf3IJw4luKgJH5iWdD84B6ZnMRRSU1+Un0GzwcgHTGYB3gcVU1g/iNSPyEaAjJqN42ASXPpb0iobGp1eqJ2xj6eAnYPLQ0Z+K6W/OiqIGAxmHEXl0db1WA1P+KETnqdrtOhYY9ftS0zcVNo4aqjfyeLhnvugBUgrlZ8bUt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI/+Y0Rm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2C84C4CEDD;
	Wed, 12 Mar 2025 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741822999;
	bh=90OuS2yk7g7bxyQlFmmSVP8LGE/eGIxU1ogAteq6FsQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mI/+Y0RmOaATux9zeDo++JTMjWuaeRloH5h2gCsaolGdo1Z15JAi0c8/eXiVt6du4
	 ZEAsEKKJqX/o3+DXqkmRtwul5TWZoxXY/vFoHHf4+CjHgli/AgUt1RmrNkA3BXAZxH
	 nM+iM7Be60fa0grJQav3bvRrVAg9flHTvZN0qFlvVQjuYNMDy7ZCX1HjmNPfMYgmrk
	 DM/gqN4a/7+Kqo0Ms2n7CB/5ssaIeaWm95Y35aV+W73mm5NGQcrWkZkqOZmfeeIXOH
	 Xr0EM24l1VX29vUNfYtGVLX9b+sTlhIAjzoFxbXHzopbAuFKzUcOOmEtAyY1Viwq6f
	 cE+ZvO72K4sng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E5AC28B2E;
	Wed, 12 Mar 2025 23:43:19 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH 0/5] Add support for Battery Status & Battery Caps AMS in
 TCPM
Date: Wed, 12 Mar 2025 16:42:00 -0700
Message-Id: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMkb0mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0ND3aTEkpL4/IJi3aRUw6QUc8PkRCNTEyWg8oKi1LTMCrBR0bG1tQD
 JEMecWgAAAA==
X-Change-ID: 20250311-batt_ops-be1bd71ca254
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741822998; l=1546;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=90OuS2yk7g7bxyQlFmmSVP8LGE/eGIxU1ogAteq6FsQ=;
 b=zsL7hGB9X2//AJOcUw5HcZ2DY008IsSVM3aNDnOjpwzKN60kqxUEfHb8ORIW8KJMzcJ3L8fXH
 vDkHVUwomUuBDN/ZOODp4w5hu8fKuyQuPPptydVvvtFxZjCiyYDtYO5
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

Support for Battery Status & Battery Caps messages in response to
Get_Battery_Status & Get_Battery_Cap request is required by USB PD devices
powered by battery, as per "USB PD R3.1 V1.8 Spec", "6.13 Message
Applicability" section. This patchset adds support for these AMSes
to achieve greater compliance with the spec.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
Amit Sunil Dhamne (5):
      dt-bindings: connector: add fixed-batteries property
      power: supply: core: add function to get supplies from fwnode
      usb: typec: tcpm: Add support for Battery Status response message
      power: supply: core: add vendor and product id properties
      usb: typec: tcpm: Add support for Battery Cap response message

 Documentation/ABI/testing/sysfs-class-power        |  20 ++
 .../bindings/connector/usb-connector.yaml          |   8 +
 .../devicetree/bindings/usb/maxim,max33359.yaml    |   1 +
 Documentation/power/power_supply_class.rst         |  11 ++
 drivers/power/supply/power_supply_core.c           |  60 ++++++
 drivers/power/supply/power_supply_sysfs.c          |   2 +
 drivers/usb/typec/tcpm/tcpm.c                      | 217 ++++++++++++++++++++-
 include/linux/power_supply.h                       |   7 +
 include/linux/usb/pd.h                             |  65 ++++++
 9 files changed, 388 insertions(+), 3 deletions(-)
---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250311-batt_ops-be1bd71ca254

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



