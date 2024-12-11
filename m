Return-Path: <linux-pm+bounces-19045-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7B89ED3E3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 18:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA61C280F93
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375051FECDD;
	Wed, 11 Dec 2024 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAgZmhTq"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DB17C9E8
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939112; cv=none; b=uc61rfzKkv630QQFBCQ5rgAxtLaSyhpMSXwgs6t2b+SwKeWccIeCOeRHB3V7LDYoQ7qix46Sfj+z8YfOPPcRPU1LT4ZEZbq/eablqQrpp1gI/7pT1hFfpJW5bcDw5/zOxt58ko9U6VvB3KzGLjiegweRuZ1vTUJdv1K1HE2sVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939112; c=relaxed/simple;
	bh=ogfxiy5/1Ml4bliRo9psQ8ACtIEK3Ryx3cq5+ibFHA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iR7PAr4J9ncHlhysJuGcpKyIY3+9ZU+fMbHZiafmi8GXb0chQUy+xHrMzRjAG+8YOPs+UlKKCbELXQJMsgV7huPdjiS1gZmqnlXijfNiayXL7Qabh0LzLeWgZtReAA/RsFSRGPCBv0pLrq0iBpUAiHu45bpGq6rjia50kGSBI+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAgZmhTq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733939109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NZRdxMMj0qoD4phpqiew3gmZ33v7YOvxkGD414PQfOw=;
	b=YAgZmhTqbV5R0C4Gk2/1uhA4nNBpEUkcE0Qg30NQQr7LkFm+C3BSa9iM9mYk/y4CeFkOA7
	unj9AS+JBqInW5LA5FyIg+XJWhroBUhmO2sGYM72ItnWISHrovJLPtk9F2P52qRDo+hsPR
	bMZO7IqJCdpotDBmdog7a3y+SnQGiVI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-i0lyNwaINHOQt0w0TIhXWQ-1; Wed,
 11 Dec 2024 12:45:06 -0500
X-MC-Unique: i0lyNwaINHOQt0w0TIhXWQ-1
X-Mimecast-MFC-AGG-ID: i0lyNwaINHOQt0w0TIhXWQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5C411955D4B;
	Wed, 11 Dec 2024 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.61])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8211B1956048;
	Wed, 11 Dec 2024 17:45:00 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 0/4] power: supply: Add new "charge_types" property
Date: Wed, 11 Dec 2024 18:44:47 +0100
Message-ID: <20241211174451.355421-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi,

As first discussed here:
https://lore.kernel.org/linux-pm/49993a42-aa91-46bf-acef-4a089db4c2db@redhat.com/

Some power_supply devices have a writable charge_type property, but
userspace cannot know which charge_type values are valid to write.

This series adds a new "charge_types" property, which is identical to
"charge_type" but reading returns a list of supported charge-types with
the currently active type surrounded by square brackets, e.g.:

Fast [Standard] Long_Life

this allows userspace to find out which charge-types are supported.

Patch 1/4 does some prep work and patch 2/4 is the core implementation
of "charge_types" property support.

Patch 3/4 is a standard psy-driver user of the new "charge_types"
property support. Patch 4/4 shows an ACPI battery extension driver
with support for this property using the new show()/store() helpers.

Changes in v4:
- Rebase on top of latest sre/linux-power-supply.git/for-next
- Only print current value in uevent using new uevent flag passed to
  power_supply_format_property()
- Put new POWER_SUPPLY_PROP_CHARGE_TYPES enum power_supply_property entry
  directly after the existing POWER_SUPPLY_PROP_CHARGE_TYPE entry

Changes in v3:
- Rebase on top of v6.13-rc1

Changes in v2:
- Replace spaces with '_' instead of surrounding the text-value by ""
- Add "Check charge_types to get the values supported by the battery."
  to Documentation/ABI/testing/sysfs-class-power
- Add a note about labels with spaces having these replaced by '_'
  in charge_types output to Documentation/ABI/testing/sysfs-class-power
- Use power_supply_match_string() in power_supply_charge_types_parse()

Regards,

Hans


Hans de Goede (4):
  power: supply: power_supply_show_enum_with_available(): Replace spaces
    with '_'
  power: supply: core: Add new "charge_types" property
  power: supply: bq24190_charger: Add support for "charge_types"
    property
  platform/x86: dell-laptop: Use power_supply_charge_types_show/_parse()
    helpers

 Documentation/ABI/testing/sysfs-class-power | 20 ++++++
 drivers/platform/x86/dell/dell-laptop.c     | 54 +++++++--------
 drivers/power/supply/bq24190_charger.c      |  7 ++
 drivers/power/supply/power_supply_sysfs.c   | 73 +++++++++++++++++++--
 include/linux/power_supply.h                | 23 ++++++-
 5 files changed, 143 insertions(+), 34 deletions(-)

-- 
2.47.1


