Return-Path: <linux-pm+bounces-20027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F02A03DD3
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122581882141
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934641E9B12;
	Tue,  7 Jan 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJZF42bm"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007501DFD83
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249640; cv=none; b=nfChQx5mhVXg+NjrzrZ18fPwHZglaeG4n1Xh+FsIGRAATNQ9WPC/zJygRWTOxU2Vbiw2HmYMkG5qJI1lCgeL65Le7z8Kbt1lmLpKK1izs5BGkj6EabeYY//RzcA714mhqYFg8SYtHtZS619JtQPiKDbxlx0La3AwK9yfOGGkT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249640; c=relaxed/simple;
	bh=FiV/ZuFImTrqTHapITSZqL4+GK1rpTFj9SEW4OW8Tb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqrLMeqbJQishrjgMiAjXVmT623yD2YF9NFe5JRvDU38Kho2uDbVOQpwVTYidb7U5wmvWgmsvMJzZ5krdAGYCkUepoe0jnR/mdk6gcEbZz7VWln+TTMZgexAEND+/o1A5CG3rwWEuoEn80Yw+mGNi4X7FY+A+17gLyF/Gl5MkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJZF42bm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736249638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7DZmgTPNoj6PSGzKxL+tnUIAhI5Qohrd49vV833GF8=;
	b=RJZF42bmG2uczJjvPQaIgLpHSWf6chA08kUSvuQBj7qVP6fHYAGbB4HHvxjgUK8WdV3AfK
	CWr4IdHpyyuuHaaGpstSUREbTcVtkMmmTtag4A7/vKZRxr2e/18uAv4h9hqQTfjlrq5Hmo
	BUrTpICp6Ddu8BOsk/OKdY5YjbKwRVc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-3cvqQ1p1MVuK2aR6FGrk0g-1; Tue,
 07 Jan 2025 06:33:54 -0500
X-MC-Unique: 3cvqQ1p1MVuK2aR6FGrk0g-1
X-Mimecast-MFC-AGG-ID: 3cvqQ1p1MVuK2aR6FGrk0g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F34071955F3C;
	Tue,  7 Jan 2025 11:33:53 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.144])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D22033000197;
	Tue,  7 Jan 2025 11:33:52 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 3/6] power: supply: ug3105_battery: Put FG in standby on remove and shutdown
Date: Tue,  7 Jan 2025 12:33:43 +0100
Message-ID: <20250107113346.170612-4-hdegoede@redhat.com>
In-Reply-To: <20250107113346.170612-1-hdegoede@redhat.com>
References: <20250107113346.170612-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Put the fuel-gauge in standby mode when the driver is unbound and on
system shutdown.

This avoids unnecessary battery drain when the system is off.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/ug3105_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index 3cd0c6944750..8d4ee8c12db9 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -206,6 +206,8 @@ static struct i2c_driver ug3105_i2c_driver = {
 		.pm = &ug3105_pm_ops,
 	},
 	.probe = ug3105_probe,
+	.remove = ug3105_stop,
+	.shutdown = ug3105_stop,
 	.id_table = ug3105_id,
 };
 module_i2c_driver(ug3105_i2c_driver);
-- 
2.47.1


