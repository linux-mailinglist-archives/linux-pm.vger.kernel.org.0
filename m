Return-Path: <linux-pm+bounces-5070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B9A87F03E
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 20:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201EF2845B7
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1060756467;
	Mon, 18 Mar 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYmyQFKU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758F56466
	for <linux-pm@vger.kernel.org>; Mon, 18 Mar 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789133; cv=none; b=g/x5jgqexnvnYU6IiwoL2d0kETkKjPJq21Ca79GF1xglIZ3IrBNM35GbdhCcSMslFzoN7BxdCbpg9qzUf/NWRgrsP23fGCF1KWUJETMiWx/0EFnrkJnHVmgeqEWWlxbl9kjVziaodS9HiUEaXc9KiSlQGKpCxUBuS8VszN1T8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789133; c=relaxed/simple;
	bh=WkfycN4hdxZOvEibtqDRyTzK+XeTSoRPFWy0aizuHTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfUfHj4UpB3qGH9b6LltGathF94eeLLcXgAJKvqE5V58B/LQ7phy+acFccZoBz5QApWaWalkCfbNZdSZO6XsvBFeZbuaHb4WdoBFcZ0riJPNAuPGzotth43bLwVVHehpEbqs6UVRJfG1v0SvBDvTdnZpjic9U0WXLkdh/YHFgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYmyQFKU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e694337fffso1182646b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Mar 2024 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710789130; x=1711393930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMO7iuuuQH99KzwJHPUmXijIQINiAK77BmgXlkFjNck=;
        b=NYmyQFKUdzCz4Uy2W9/wY689RqWUeyXle8BqsPwEwAc/z8tUUaSo8nuI6A9dhBFCIC
         z38O0kOPgH2jFkQLEJ868RGna4MAaXwlaLnZrCu6Cj/3P+42VL0/mxoevygaS/+8Bm7o
         FgbfMQMSgKh5OHGAJ6Z8r5OqJM6h4ujUGsRDB+e8Xn618AFuCTkd3oN8sq1IcVHmFw/c
         wD70QaBQHcRJbJspYFs6DIyKY85ffmnxYPsxVC3IPiKpWX1S7tG6Y/LD7trIUdhLwInF
         ntItH+rtXYI5gQ9sDK8SWdVUlRcGPpwxMbgArO7i/pCvIz7bv7iZv3TjESEVWTAIgmzi
         /Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710789130; x=1711393930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMO7iuuuQH99KzwJHPUmXijIQINiAK77BmgXlkFjNck=;
        b=CamOH94C5Y88+4zO1sQbPVGRRVw4OuyDTqB+AZ3pliuwd4TJ/zzCvwXlNsS8qx40Ey
         MpsZUS1MbgEIo+VwG3yLVlFwWYu4w1KbqOBtCiOgtatZKTzkZz4JnSYkrlF6XxgMqcQj
         9Ns74/Qx/Mp6/QgZPjmpRQgpAFKxez8uizKfkGPh86w3bUxdZyIC9pETnJckSMawAFWs
         CJZkD2dZzbVFHae3kT4YHt2CAywmPHrbjgAjAWjMRhogs32/BDhBGqcmgQfBXJpkFADK
         wj+EstmN0UPMRP7FSLoBKLGDcyyvG4cruajZ4R7YFQXDoNsTZIvj+oUBLmTNyN45GWZT
         xNag==
X-Gm-Message-State: AOJu0YyvR2vxkDf+zIAOe2wpdmWZLLM3ESJYsQjb/iB9ZJ+bwKd/PvzY
	sNdm7EaABnzthtENnU+2rU1+doxHKdyasb/W0t3VdCeIo7WRrpamvRW+yrRM
X-Google-Smtp-Source: AGHT+IF8e+nIbIxZSrEn7WLZMZybyAh48y1Wa3Di28rub8nOU7idRkl0WoV9yPGosvTdDAdkRl8SNA==
X-Received: by 2002:a05:6a00:2d86:b0:6e7:3119:9cb5 with SMTP id fb6-20020a056a002d8600b006e731199cb5mr2525223pfb.2.1710789130189;
        Mon, 18 Mar 2024 12:12:10 -0700 (PDT)
Received: from davidm-laptop.gv.shawcable.net ([2604:3d08:1582:d200:257:cb41:7a1b:52ac])
        by smtp.gmail.com with ESMTPSA id a14-20020aa7864e000000b006e566b4872asm8249635pfo.113.2024.03.18.12.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:12:09 -0700 (PDT)
From: David McFarland <corngood@gmail.com>
To: linux-pm@vger.kernel.org
Cc: David McFarland <corngood@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/1] platform/x86/intel/hid: Don't wake on 5-button releases
Date: Mon, 18 Mar 2024 16:11:52 -0300
Message-ID: <20240318191153.6978-2-corngood@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318191153.6978-1-corngood@gmail.com>
References: <20240318191153.6978-1-corngood@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If, for example, the power button is configured to suspend, holding it
and releasing it after the machine has suspended, will wake the machine.

Also on some machines, power button release events are sent during
hibernation, even if the button wasn't used to hibernate the machine.
This causes hibernation to be aborted.

Signed-off-by: David McFarland <corngood@gmail.com>
---
 drivers/platform/x86/intel/hid.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 7457ca2b27a6..707de9895965 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -504,6 +504,7 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	struct platform_device *device = context;
 	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
 	unsigned long long ev_index;
+	struct key_entry *ke;
 	int err;
 
 	/*
@@ -545,11 +546,16 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 		if (event == 0xc0 || !priv->array)
 			return;
 
-		if (!sparse_keymap_entry_from_scancode(priv->array, event)) {
+		ke = sparse_keymap_entry_from_scancode(priv->array, event);
+
+		if (!ke) {
 			dev_info(&device->dev, "unknown event 0x%x\n", event);
 			return;
 		}
 
+		if (ke->type == KE_IGNORE)
+			return;
+
 wakeup:
 		pm_wakeup_hard_event(&device->dev);
 
-- 
2.42.0


