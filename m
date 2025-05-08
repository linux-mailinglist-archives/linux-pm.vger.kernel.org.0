Return-Path: <linux-pm+bounces-26852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFEFAAF065
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 03:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696434680F5
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 01:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8A4156C62;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD24P9E4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDC101C8;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666155; cv=none; b=WcgZe4Vak+V8iiO2LjS6SOuyuZErsBdX30IxBrTWpiO5phU+FmBeJ5i0OzcEZ7Uim4KJF8cq+1als+9ZvKt0AmdzagKqxx1oQ6pN/UCiB3OJ1IevH+WE0lVaW4ijEwI4EbnRl0+PnFr6ZWPpUar/R+ODKZsprY71Dsee7N98y7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666155; c=relaxed/simple;
	bh=LRcV+pKioj0dnQiQ87GE22M3+IfV3Fs50YQalR4s3E0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WNXwY7ckSJAWcIuINyZSE2stdnAXpqPGjkElD9Vt1iQr+1Ejf7rXWeFG8EdDzh5WnNJRuDVrzHacc3hF1x/8uBOw0nMykxKS4wyR/+3Y74k1moDVYAT58wLd41wBzDLLzw9Wz3WstqOxCsbcqwdrcHQWk8EXJ/sl32WfPYqhh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD24P9E4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 113DDC4CEE2;
	Thu,  8 May 2025 01:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746666155;
	bh=LRcV+pKioj0dnQiQ87GE22M3+IfV3Fs50YQalR4s3E0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nD24P9E4YbvjSSPqzb70ZEJaC1oGg1pD+DnierwAI2obq/mDgkBDEKm7er5y4h6Rh
	 4gufBbGcbU7I9Qt9M+/hJv6m8DaEQIuTQ7X3nN3MjmdWm6jmqeTBd8dNppGcKyMdEl
	 lCW8Sm461hJFz929LlYSeOBVOki3IkL9b5Z/4pC3vUsgE435MKyYUQ/nAIMAMjEWZF
	 D5X72saPoOmh+bxqiSAjVGAfGvI/h+zvN7G1dJeQMacVOgefj3IojvXtsV4rcHqxHk
	 hl70hR5b0+GvI8KOAJXDU3nEDbg4nD18PQUrWESLfAhIh2Jz/VIr2PUJeqEfPyQ+2v
	 ub5HuKZ4zj/hA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001D4C3ABC0;
	Thu,  8 May 2025 01:02:34 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Subject: [PATCH v2 0/5] Add support for Battery Status & Battery Caps AMS
 in TCPM
Date: Wed, 07 May 2025 18:00:21 -0700
Message-Id: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUCHGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDY0ND3aTEkpL4/IJi3aRUw6QUc8PkRCNTEyWg8oKi1LTMCrBR0bG1tQD
 o5/1GWgAAAA==
X-Change-ID: 20250311-batt_ops-be1bd71ca254
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746666154; l=1861;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=LRcV+pKioj0dnQiQ87GE22M3+IfV3Fs50YQalR4s3E0=;
 b=3Id+Nk6+E6cUAu6NLSo6T6dh5n72Vz78BzucEQ2NbPWm4zzcW9Av99ytXVakATFYyAJxyWdry
 7zaAHUj5dYkBMJpnELQcs7AoFNoVeswI2MeGakLMn6l4h9X2ehao/qt
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
Changes in v2:
  - Instead of introducing new "fixed-batteries" property to pass
    reference to FG, use OF graph by extending "ports" property
    definition. (suggested by Krzysztof).
  - Demonstration of binding usage in gs101-oriole will be in a
    different patchset.

---
Amit Sunil Dhamne (5):
      dt-bindings: connector: extend ports property to model power connections
      power: supply: core: add helper to get power supply given a fwnode
      usb: typec: tcpm: Add support for Battery Status response message
      power: supply: core: add vendor and product id properties
      usb: typec: tcpm: Add support for Battery Cap response message

 Documentation/ABI/testing/sysfs-class-power        |  19 +-
 .../bindings/connector/usb-connector.yaml          |  20 +-
 .../devicetree/bindings/usb/maxim,max33359.yaml    |  25 +++
 Documentation/power/power_supply_class.rst         |  11 ++
 drivers/power/supply/power_supply_core.c           |  30 +++
 drivers/power/supply/power_supply_sysfs.c          |   2 +
 drivers/usb/typec/tcpm/tcpm.c                      | 208 ++++++++++++++++++++-
 include/linux/power_supply.h                       |   5 +
 include/linux/usb/pd.h                             |  65 +++++++
 9 files changed, 371 insertions(+), 14 deletions(-)
---
base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
change-id: 20250311-batt_ops-be1bd71ca254

Best regards,
-- 
Amit Sunil Dhamne <amitsd@google.com>



