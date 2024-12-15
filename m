Return-Path: <linux-pm+bounces-19259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5929F24F8
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 18:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08763188585B
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072AD1B218E;
	Sun, 15 Dec 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MakJlDUH"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48D199252
	for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283307; cv=none; b=uV/NhsqsuV8UYwP7Bl2Fhes62dLxDebYBp2K2syajlTZRFxzVNmkA9YIwehMigyL8RIvlOq9XrUG0lyF3XGxHk+7RIFvtl/B9TwH8AuYWKrJzjJUrM2PMrJeVoQcAZXEOdiyEvGmi+CxhjwTLHmJM0K6OfMPrYiIiMgjUCOmxr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283307; c=relaxed/simple;
	bh=K74D4NWgxmzqnKqHkj+Fvglt4iX9P7fMgSzMjGIT9lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uzcMgkmonM0IN/X+fqoo2Xf8NpG+AUW4AULOGLgmjO/GXLdkctADfqFk8fgyuLDPI5Q/a/JO/qOA7Rh1Wm56InvYr86/N4gXOJ7NsUIV2jJBEXNyjzxlxdN5bbrYt7Fd/EPbNrBh7qs3D+u80mlDqMWwZUk6ROdTpVfuGDGH6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MakJlDUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734283305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o9HigzFmA/maEFn4DAZCyJGyH27YHnzQEF8DOTMIUZU=;
	b=MakJlDUHn37CKi+ASFktzpR/cClPV/bfLTSEzH/RZmwXCb8hxX3V1Xvq8a1/AGoeqG2iZr
	1447Mh/6pPvfU1VPpbL0hYxKELr0g5rvs9JnpTjbivID6leZeGKOtky7aAVb4SnWI1FQZ7
	IK4fqNmzLF5NTSc/jb4+0/PxaBoFQBo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-dcoqO4ZtO1O2q3jX_tAZFA-1; Sun,
 15 Dec 2024 12:21:41 -0500
X-MC-Unique: dcoqO4ZtO1O2q3jX_tAZFA-1
X-Mimecast-MFC-AGG-ID: dcoqO4ZtO1O2q3jX_tAZFA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E28B91956058;
	Sun, 15 Dec 2024 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6654195605A;
	Sun, 15 Dec 2024 17:21:39 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/8] power: supply: Add adc-battery-helper lib and Intel Dollar Cove TI CC battery driver
Date: Sun, 15 Dec 2024 18:21:23 +0100
Message-ID: <20241215172133.178460-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi All,

Here is a patch-series which primary goal is to add support for
using the coulomb-counter in the Intel Dollar Cove TI PMIC as
battery power-supply class device.

This PMIC used on some Intel Bay/Cherry Trail systems has some builtin
fuel-gauge functionality which just like the UG3105 fuel-gauge is not
a full featured autonomous fuel-gauge.

To prepare for adding support for this, this series factors out the UG3105
capacity estimating code, generalized so that it can be re-used in other
drivers.

While working on this I also noticed several other small issues in the now
factored out adc-batter-helper code as well as in the ug3105 driver. These
issues are addressed in separate patches.

This series has been tested on an Asus ME176C tablet with UG3105 fuel-gauge
and on an Acer A1 840 tablet which uses the Intel Dollar Cove TI coulomb-
counter as fuel-gauge.

Regards,

Hans


Hans de Goede (8):
  power: supply: Use power_supply_external_power_changed() in
    __power_supply_changed_work()
  power: supply: Add adc-battery-helper
  power: supply: ug3105_battery: Let the core handle
    POWER_SUPPLY_PROP_TECHNOLOGY
  power: supply: ug3105_battery: Switch to adc-battery-helper
  power: supply: ug3105_battery: Put FG in standby on remove and
    shutdown
  power: supply: adc-battery-helper: Fix reporting capacity > 100%
  power: supply: adc-battery-helper: Add support for optional
    charge_finished GPIO
  power: supply: Add new Intel Dollar Cove TI battery driver

 drivers/power/supply/Kconfig               |  16 +
 drivers/power/supply/Makefile              |   2 +
 drivers/power/supply/adc-battery-helper.c  | 380 ++++++++++++++++++
 drivers/power/supply/adc-battery-helper.h  |  61 +++
 drivers/power/supply/intel_dc_ti_battery.c | 429 +++++++++++++++++++++
 drivers/power/supply/power_supply_core.c   |   6 +-
 drivers/power/supply/ug3105_battery.c      | 397 +++----------------
 7 files changed, 954 insertions(+), 337 deletions(-)
 create mode 100644 drivers/power/supply/adc-battery-helper.c
 create mode 100644 drivers/power/supply/adc-battery-helper.h
 create mode 100644 drivers/power/supply/intel_dc_ti_battery.c

-- 
2.47.1


