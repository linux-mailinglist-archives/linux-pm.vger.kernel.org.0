Return-Path: <linux-pm+bounces-13870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92399970967
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 21:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129F81F2148D
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E81779AE;
	Sun,  8 Sep 2024 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alWiw+cW"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7F339A8
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823404; cv=none; b=QtrcUAdfVMqNW5PKdh3kqUXyzEGdqyr1YQNrKyML+omPanWmS/6wgIQ71CzzPqNZOpkacpKAmfJSuIm7opnArNiuZ6Anfa+6JqMsxFFWCtwMFO12jW/jtEwnbC/83GOin+pu/BBJNby+nhWcpnvP5lTQJVWxb+P0LVIA1OZCscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823404; c=relaxed/simple;
	bh=rbUTVXr//EFKlNZW8DAZvwLdtxGXiItJd4LHPQliKA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpVrJAp//6ytpDZCeAHuY5LtMY5eccphXKYbqr3mQh8s1Exqh32IjVKMLK8Q1Yw7UTrooOoozUzDdAjjSQHhCdTdcTVHKssvU66DopfE8kWp0ml40IrQJKQQMPFA6R1H4eCukcK/niCY60V90jSwbZLUbAU3xkb24Uwfy24Uf04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alWiw+cW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725823401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGy/wW8uLcjNCFQkOuHAl3snZx20JyErraXQTbII30U=;
	b=alWiw+cWT6DcC4XxaZpHDWOovYQaIXQtCnXf/n+cHw53DQJ9okzoG3/GKizKfA580U83T/
	029JVe1Qe5Db0e6O58F0mahnX7kVSs3B45TWHzpscMZaZhiLLVmg+/3rIDAEc1VClW4FYU
	kREaUz6YFxJHFnWW13ZEeWBIbKBm0Fc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-QGlbV_VWPsS5L92EB-w0Lw-1; Sun,
 08 Sep 2024 15:23:18 -0400
X-MC-Unique: QGlbV_VWPsS5L92EB-w0Lw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5869B19560A2;
	Sun,  8 Sep 2024 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E4AE195608A;
	Sun,  8 Sep 2024 19:23:15 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/4] power: supply: sysfs: Make power_supply_show_enum_with_available() deal with labels with a space
Date: Sun,  8 Sep 2024 21:23:00 +0200
Message-ID: <20240908192303.151562-2-hdegoede@redhat.com>
In-Reply-To: <20240908192303.151562-1-hdegoede@redhat.com>
References: <20240908192303.151562-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Some enum style power-supply properties have text-values / labels for some
of the enum values containing a space, e.g. "Long Life" for
POWER_SUPPLY_CHARGE_TYPE_LONGLIFE.

Make power_supply_show_enum_with_available() surround these label with ""
when the label is not for the active enum value to make it clear that this
is a single label and not 2 different labels for 2 different enum values.

After this the output for a battery which support "Long Life" will be e.g.:

Fast [Standard] "Long Life"

or:

Fast Standard [Long Life]

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 16b3c5880cd8..ac42784eab11 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -253,7 +253,10 @@ static ssize_t power_supply_show_enum_with_available(
 			count += sysfs_emit_at(buf, count, "[%s] ", labels[i]);
 			match = true;
 		} else if (available) {
-			count += sysfs_emit_at(buf, count, "%s ", labels[i]);
+			if (strchr(labels[i], ' '))
+				count += sysfs_emit_at(buf, count, "\"%s\" ", labels[i]);
+			else
+				count += sysfs_emit_at(buf, count, "%s ", labels[i]);
 		}
 	}
 
-- 
2.46.0


