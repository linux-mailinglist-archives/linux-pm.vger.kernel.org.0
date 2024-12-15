Return-Path: <linux-pm+bounces-19258-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066B9F24F9
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 18:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B347A10EC
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD919993D;
	Sun, 15 Dec 2024 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAtApgtZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328624C80
	for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2024 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283307; cv=none; b=uTukWCr4JJmMI+IfpERP4I9KBvgyyCfscsuxElKaiYA6ST0MMEJPHz/hn084JgkSDN/15YaqzxXcIA8lGtrFm9BlCGVq8dAD9vdHNI1ujlK65/Rd3pkDLhUtr6Bb21notQSMiIQXXhxsN4PJPlIW2hYcM88DZCknHSCmzuLBq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283307; c=relaxed/simple;
	bh=BLwC3WwoDUlLpGQKyzAtZQKR+rqkAQoUqDZK7nZ6UTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDJihlBp3ToYzORwNV1FbYfIfjPlLa7OOZhk7rEE5R1ZljcYFBTnfvjSR4UKDaI1BncdIXNiRCEPa1A7w/dH0fTubBCtpctlvbbupeApNSxDMLXfhoMiHI8cP+8o4Gk5XYHHwe0Qz1Ga1CyJE2Ur0JKW8MTtMRGTuJDhnqHuVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAtApgtZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734283305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYwhi850U32uEuTPC8+/nR1O8eC3/lakGHGU3/SHSFQ=;
	b=eAtApgtZ030HlOss23bkOg9MupoZbnEqUWLK85bYrgqmHgbU5qtelxPBc3H9kWZRRTPFJ/
	jhzPtsoYhQtT3eD5h2efCbe6J+/o8SP8d3Pqf9xcvUQZQpfNknqqcC55jYqSkDt+iy1vmA
	RdbsLGXVX2d+jH6my/WEwFyzx5gjOUc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-EoR1iIyJNNq5WEoku9wXRw-1; Sun,
 15 Dec 2024 12:21:43 -0500
X-MC-Unique: EoR1iIyJNNq5WEoku9wXRw-1
X-Mimecast-MFC-AGG-ID: EoR1iIyJNNq5WEoku9wXRw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B3551956086;
	Sun, 15 Dec 2024 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E5DC195605A;
	Sun, 15 Dec 2024 17:21:41 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/8] power: supply: Use power_supply_external_power_changed() in __power_supply_changed_work()
Date: Sun, 15 Dec 2024 18:21:24 +0100
Message-ID: <20241215172133.178460-2-hdegoede@redhat.com>
In-Reply-To: <20241215172133.178460-1-hdegoede@redhat.com>
References: <20241215172133.178460-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The power-supply core is designed so that power-supply driver callbacks
such as get_property() and external_power_changed() will not be called
until the power-supply's parent driver's probe() function has completed.

There is a race where power_supply_changed() can be called for a supplier
of a power-supply which is being probed after the device_add() in
__power_supply_register() but before the parent driver's probe() function
has completed. Hitting this race breaks the power-supply core's design
to not call power-supply driver callbacks before probe() completion.

This problem is caused by __power_supply_changed_work() calling
the external_power_changed() directly rather then going through
the power_supply_external_power_changed() helper which correcly checks
psy->use_cnt .

Switch to using power_supply_external_power_changed() to fix this race.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 76ebaef403ed..54ee4c83b32f 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -70,10 +70,8 @@ static int __power_supply_changed_work(struct power_supply *pst, void *data)
 {
 	struct power_supply *psy = data;
 
-	if (__power_supply_is_supplied_by(psy, pst)) {
-		if (pst->desc->external_power_changed)
-			pst->desc->external_power_changed(pst);
-	}
+	if (__power_supply_is_supplied_by(psy, pst))
+		power_supply_external_power_changed(pst);
 
 	return 0;
 }
-- 
2.47.1


