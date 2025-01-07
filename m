Return-Path: <linux-pm+bounces-20024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883BCA03DD0
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36A0188139A
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCDC1DFE3D;
	Tue,  7 Jan 2025 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXzfroZI"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD119D8BE
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249634; cv=none; b=OC0GmacXlNGRnjWvjcDVCFs75heOJwcKx+SUIU7F5cOAoZRP6o/VV4e/flR95w7U6soFqR99IET/v5PS0iM52sNtkfLVXlJ/coOun/h4zeviHcesGvuf0jiCHduxc6ouTiVMYxzZfuhkwQZEZqBylXBEfv9TS7IWedgIFvYlTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249634; c=relaxed/simple;
	bh=SZysldKuxfKvm68VhZf2OLA34D6f9iECnk81NsNLTBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=idylgycyIj8wfoFrtcsOO15pRVOKGk+nent3lZN8itPF8t+/sZa5Tb4xJFebFR7Ls1rri0MxYEw4bW5r8Yz2Kher8bgqTGn2ucnapFmjBAb/6cVSLvlg741nDpOC5ppNgJbYcz/TB0g8RuP80CO1qQ4h5d5WiiqiERcjJ58OOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXzfroZI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736249632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sO3pqs7gRzdrKgyXIfv60mcUWZXDU8RgeyaJO+kHIYw=;
	b=cXzfroZI5LS+0JPS7x9PcTD8EJW3jkWd/F2J232PiRTPIcKocCJLvei5ODLzI9Dc8Cz3Mf
	gQ4eGUp8ljh5hnnnkG97llsNUKTqg0EZr3/xdooQuOFaibKduSzAIJTKCTnw9sBcXX/3Iq
	xbxlrRD8hpguDr4iIt5Gl1Tril+raIY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-1XuyEeoNNxe-vw4nfU2aCQ-1; Tue,
 07 Jan 2025 06:33:50 -0500
X-MC-Unique: 1XuyEeoNNxe-vw4nfU2aCQ-1
X-Mimecast-MFC-AGG-ID: 1XuyEeoNNxe-vw4nfU2aCQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66EDC1956057;
	Tue,  7 Jan 2025 11:33:49 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.144])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A8BB3000197;
	Tue,  7 Jan 2025 11:33:47 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/6] power: supply: Add adc-battery-helper lib and Intel Dollar Cove TI CC battery driver
Date: Tue,  7 Jan 2025 12:33:40 +0100
Message-ID: <20250107113346.170612-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Changes in v2:
- Drop the 2 already merged bug-fix patches
- Add missing MODULE_DESCRIPTION() to the new adc-battery-helper module

Regards,

Hans


Hans de Goede (6):
  power: supply: Add adc-battery-helper
  power: supply: ug3105_battery: Switch to adc-battery-helper
  power: supply: ug3105_battery: Put FG in standby on remove and
    shutdown
  power: supply: adc-battery-helper: Fix reporting capacity > 100%
  power: supply: adc-battery-helper: Add support for optional
    charge_finished GPIO
  power: supply: Add new Intel Dollar Cove TI battery driver

 drivers/power/supply/Kconfig               |  16 +
 drivers/power/supply/Makefile              |   2 +
 drivers/power/supply/adc-battery-helper.c  | 381 ++++++++++++++++++
 drivers/power/supply/adc-battery-helper.h  |  61 +++
 drivers/power/supply/intel_dc_ti_battery.c | 429 +++++++++++++++++++++
 drivers/power/supply/ug3105_battery.c      | 393 +++----------------
 6 files changed, 953 insertions(+), 329 deletions(-)
 create mode 100644 drivers/power/supply/adc-battery-helper.c
 create mode 100644 drivers/power/supply/adc-battery-helper.h
 create mode 100644 drivers/power/supply/intel_dc_ti_battery.c

-- 
2.47.1


