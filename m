Return-Path: <linux-pm+bounces-13869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B0970968
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 21:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBC5B21327
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 19:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63193171099;
	Sun,  8 Sep 2024 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJpUP1Qj"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA7339A8
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823401; cv=none; b=NK20TcQsT7R0peMihCW0/7F0vlfieCbA1gYleZIDgNlvZPXb+Uu5/GzVeFptX8lVt9RT7XDX2un4HrJ51liSupYKsruwmTtSlu2R0EuUgYcwawZjBBZHHDyQ0jECjit5i0Dl4m7cggHHxGiy8E/9Zsi8nO29zkRqMNA7TWCJ3HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823401; c=relaxed/simple;
	bh=puu9aM6Fhb2qm4QiXRv8LB6OuFvNpYFZA2R9OXhhkPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHFRnviTIcoWpzP7W4vQ6dmf20lD1jR71YKTdIe41qctiMpXlU8+K8UCcMymI+BB1QHwo5ixI2h/Cg1LHR5frp6AvToQekIy2tF/2nCNDI4tMjeFN6lF29hUDFiJSiOG1PeoBf/5bWywh5cMNrxkmfEsPvUcwQmbmo6OHSN8W2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJpUP1Qj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725823398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Uc1eR7xkFcDXPB9yPki+ppg9D6ufwAFv7UwW6Mkg4w=;
	b=eJpUP1QjlcIlcbNjhBvdrS8ePuxLSxSMpUXEKVTnteAdatCaVFN+Nu9NGSWn9KhCTpLrKZ
	jFLhc7pLUdn8c6Qx14+dXIV3nzWQkB6MgmfiKMXlRxu+znjjEz/KO89FLvT7+gpy/C3CZg
	zW7PAWDYdBgS+OH/ApLDof9am/aUb/Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-2xRkjkvEPV6K1Zp5rVlLJQ-1; Sun,
 08 Sep 2024 15:23:16 -0400
X-MC-Unique: 2xRkjkvEPV6K1Zp5rVlLJQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 217951953945;
	Sun,  8 Sep 2024 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7698B1956086;
	Sun,  8 Sep 2024 19:23:12 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/4] power: supply: Add new "charge_types" property
Date: Sun,  8 Sep 2024 21:22:59 +0200
Message-ID: <20240908192303.151562-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi,

As first discussed here:
https://lore.kernel.org/linux-pm/49993a42-aa91-46bf-acef-4a089db4c2db@redhat.com/

Some power_supply devices have a writable charge_type property, but
userspace cannot know which charge_type values are valid to write.

This series adds a new "charge_types" property, which is identical to
"charge_type" but reading returns a list of supported charge-types with
the currently active type surrounded by square brackets, e.g.:

Fast [Standard] "Long Life"

this allows userspace to find out which charge-types are supported.

Patch 1/4 does some prep work and patch 2/4 is the core implementation
of "charge_types" property support.

Patch 3/4 is a standard psy-driver user of the new "charge_types"
property support. Patch 4/4 shows an ACPI battery extension driver
with support for this property using the new show()/store() helpers.

Note patch 4/4 depends on patches from platform-drivers-x86/for-next
and is marked as RFC because of this. This can be applied later.

This series is based on top of linux-power-supply/for-next.

Regards,

Hans


Hans de Goede (4):
  power: supply: sysfs: Make power_supply_show_enum_with_available()
    deal with labels with a space
  power: supply: core: Add new "charge_types" property
  power: supply: bq24190_charger: Add support for "charge_types"
    property
  platform/x86: dell-laptop: Use power_supply_charge_types_show/_parse()
    helpers

 Documentation/ABI/testing/sysfs-class-power | 15 ++++++
 drivers/platform/x86/dell/dell-laptop.c     | 54 ++++++++++-----------
 drivers/power/supply/bq24190_charger.c      |  7 +++
 drivers/power/supply/power_supply_sysfs.c   | 37 +++++++++++++-
 include/linux/power_supply.h                | 23 ++++++++-
 5 files changed, 105 insertions(+), 31 deletions(-)

-- 
2.46.0


