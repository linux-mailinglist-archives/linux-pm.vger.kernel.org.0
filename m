Return-Path: <linux-pm+bounces-11743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4180F942B43
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6CE1F25AD9
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76118E031;
	Wed, 31 Jul 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YU+gU5OA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC03CF73;
	Wed, 31 Jul 2024 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419559; cv=none; b=QRKy7001tiBUiMXhUv6UJCc/QN6EHWb1MXvCEtUBPTcxZtlA+WBerCbAxUs2sc6nKekWIqPlXR4QgszrsoIO67nwCbmzR5OgVFrgkNXl8A9JtA0swRUt79pQwWMWOFN+sVl8QffFFK5UWhSKkIBx620VXx10D3njZi+hLCHywvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419559; c=relaxed/simple;
	bh=73bEQavjF+GaI6c7nkkNPr8lCt+cq5S3EgffHXve1xI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GcKEwSmjO4P79Dyw/MRUaBzWv0aoS75ROLuOM4A6bh3GytVLtN2IgHVUUKzKONe/aS9yj2E3QjxfMWAlRo53Gtk8x+LlRGTzluLCvm6auew59ZgjOKgwqQhHt5LnlrFRkd96udqyQE3Ctkw2ObXAojWX9VfSxSSXsKE7WoxI8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YU+gU5OA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722419558; x=1753955558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=73bEQavjF+GaI6c7nkkNPr8lCt+cq5S3EgffHXve1xI=;
  b=YU+gU5OAOVXwTpdsz0kZxZyA18YO4vHCNrwwvedPlF3K+8hiNxrSSnz1
   kTUpo174iRMsl9m7jkGbj7IRd2W9c9Z1AWVtL3j2xvrfJWb64eflIYb1v
   blKC9Fm4vna2r+qS1CRjW2mtpk62QXKZ4urFeyk5lgiMmIEj7MXm7fafu
   BA2Wiou7cecOKnei2kdj2OgUw/86zSEAG1/wOZXv7aNxpw44Iv6eH4JhK
   FFd1GVmn3vaw4tfBCG9oAbAvZc1KXpb+gS83QW/aEK/FqGYnGLqwhW+rx
   bmo2+OclleTQnyjkFur+n1IrsQdUtlLOfaY5NFcE7+tXYz/4DbxPzihQG
   g==;
X-CSE-ConnectionGUID: Z1R6HT3jR4ugH6tozkmFrQ==
X-CSE-MsgGUID: jgLqmNtsSreL1g1gI4ybyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="31678832"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31678832"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 02:52:37 -0700
X-CSE-ConnectionGUID: lJ95hGZOR2qYjAz+qXoaGQ==
X-CSE-MsgGUID: DEgwsBZpRmOqsIhq9traSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="58960823"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 02:52:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] docs: thermal: Remove extra parenthesis
Date: Wed, 31 Jul 2024 12:52:22 +0300
Message-Id: <20240731095223.2778-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

thermal_zone_device_register() prototype in the thermal zone device
interface documentation has double closing parenthesis. Remove one
of them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 Documentation/driver-api/thermal/sysfs-api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index 6c1175c6afba..63ed1801ac40 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -43,7 +43,7 @@ temperature) and throttle appropriate devices.
 				      int trips, int mask, void *devdata,
 				      struct thermal_zone_device_ops *ops,
 				      const struct thermal_zone_params *tzp,
-				      int passive_delay, int polling_delay))
+				      int passive_delay, int polling_delay)
 
     This interface function adds a new thermal zone device (sensor) to
     /sys/class/thermal folder as `thermal_zone[0-*]`. It tries to bind all the
-- 
2.39.2


