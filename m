Return-Path: <linux-pm+bounces-5926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6C089863A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 13:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65101C25A61
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 11:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9CB83CC9;
	Thu,  4 Apr 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY/+Q+La"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680871B47;
	Thu,  4 Apr 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230913; cv=none; b=kpZFlu0acBXDL+0HoPW931nN70J92peYi8b5VkDOI4M1cXS5P4vRlolLcTGgJ1srG0XB2V176cB3J5dHDt5pX3E0zlsCq8rZj4iBB6aDzded9RJXzo3qM5DBnsDLtI+15izSS6pRivuYOiLfcgJGZU8ZtglP8iKEGVtgXvyVQ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230913; c=relaxed/simple;
	bh=wbLHdB0d+HXduGQLLJgYCbTVvjOgORf/7382OFlZBAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=APbzJAEe+nTtsrxmpgKRj/AbfGG3DAWMk25ZrDjZYW+1KXjrCkstiWFEnXDusUJSKZt4zk0QgplkkHFXJ0ARwlppjbYKpobQg0sx/g4nElfaMVKOs1ab7NKg/CZGqM9VqVbVuHXtBRm9cyL+z4GuQrIOguVuZThsikHscAiEZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY/+Q+La; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69934c71837so1334056d6.1;
        Thu, 04 Apr 2024 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712230910; x=1712835710; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8Owr0or+AdoIkTbflM/l3HUGPKiSZWX+u4/vmxgnsA=;
        b=CY/+Q+LadhpB4SPfCPy31Ft91vpuwWrE2rLm1cnJ64UAovQmsdIs+wdpmLftXKKE6E
         ty6Ju1gsc6ow2DW9toJhZYb+TA1QY6GmbgoR/fI4+tuNGClWYu2t2HPHl0jYmgSc5pqW
         C9XlpPX8CuFetlchOeltWQXUQr9T1vW5aa2zcHna3eHS7KbP17F4SQGM1j6gaoNk3+oT
         WiVinVdSYKsNBLYZ/RVBV6T7MIrG6CSxYIWrnTDotbB1gcxF7z3eaJJ6SwiNhSuCgFFr
         wW21EHkiyXoj87Bq7g3lfBct2ZCDIhtp7eMntm50bMCTIQNipVKSssxWAPMmTO0HNyTy
         ULtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230910; x=1712835710;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8Owr0or+AdoIkTbflM/l3HUGPKiSZWX+u4/vmxgnsA=;
        b=l0nWz9ZjkcxVGC68vi2srJWc3OXaIYvMQ6yX8HvImUxyQKWfbbo5oVClR5cuw0SLOj
         la9uODLK9GN4bdFzvYfzAwX47tWxgd/2ZlHBnjEbN24UimTko4CemJ1SwAMJRCKS+SjW
         7LXsGQNY/8IhYEIGWVzGdqbO+O/Z7gskaE3PlKwQ6L7ETc6XC2XlQY9wWhXd5OMHJHxh
         BP8CXN+Akj+autZ+0cIpQr5+xq+kuakoIMfi7hWXVZaKxiNIbqTrByHEq7By/3emRyUz
         CfNWhIIXz+Q5hh+sh8WCp9wJHZExJRQQjkLSjSzDeeQC5KVJDbvc7E3BAqRovoQD1UB4
         wtvA==
X-Forwarded-Encrypted: i=1; AJvYcCWp2zxeDAqOcOGSCXe6uOHtnDPr1KnzEfBmkAmojvu0QnXo0N1cILGYR0mhE7031wF5Rdcr5D1ljmRiYROyXMWLKXUleN1CbwPutHIH67giC4x0NjqC4DD13R93EJUcSbmyycHnd14g3QACHLTr
X-Gm-Message-State: AOJu0YzvXG1cfWcZNMOkmy+36W9F6ScR+h04/hf+EGznB1YdmgWUZ+FQ
	riWYfjdpzNVTI4Mcbnb7k3PGpePIgV2vAJ95soH3yf8g8+r0W2Vl
X-Google-Smtp-Source: AGHT+IHkbSV+iIyYHcIhcXZJ945mwkOlynV2lV7pTcnSk0fUDh1bTmRwvwBNpEgrlpbOHfygAtQvWA==
X-Received: by 2002:a05:620a:4710:b0:78d:3b13:f5ab with SMTP id bs16-20020a05620a471000b0078d3b13f5abmr2586944qkb.0.1712230910498;
        Thu, 04 Apr 2024 04:41:50 -0700 (PDT)
Received: from davidm-laptop (hlfxns018gw-134-41-63-216.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.63.216])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a146f00b00788481cdf4csm5823803qkl.111.2024.04.04.04.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:41:50 -0700 (PDT)
From: David McFarland <corngood@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: David McFarland <corngood@gmail.com>,  linux-pm@vger.kernel.org,  Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,  "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>,  Enrik Berkhan <Enrik.Berkhan@inka.de>
Subject: [PATCH v2] platform/x86/intel/hid: Don't wake on 5-button releases
In-Reply-To: <ed891842-a86f-4ca8-af29-f7921a259146@redhat.com> (Hans de
	Goede's message of "Tue, 2 Apr 2024 13:36:42 +0200")
References: <20240318191153.6978-1-corngood@gmail.com>
	<20240318191153.6978-2-corngood@gmail.com>
	<ed891842-a86f-4ca8-af29-f7921a259146@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 04 Apr 2024 08:41:45 -0300
Message-ID: <878r1tpd6u.fsf_-_@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

If, for example, the power button is configured to suspend, holding it
and releasing it after the machine has suspended, will wake the machine.

Also on some machines, power button release events are sent during
hibernation, even if the button wasn't used to hibernate the machine.
This causes hibernation to be aborted.

Fixes: 0c4cae1bc00d ("PM: hibernate: Avoid missing wakeup events during hibernation")
Signed-off-by: David McFarland <corngood@gmail.com>
Tested-by: Enrik Berkhan <Enrik.Berkhan@inka.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2: Added tags and fixed whitespace, as requested by Hans.

 drivers/platform/x86/intel/hid.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 7457ca2b27a6..9ffbdc988fe5 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -504,6 +504,7 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	struct platform_device *device = context;
 	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
 	unsigned long long ev_index;
+	struct key_entry *ke;
 	int err;
 
 	/*
@@ -545,11 +546,15 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 		if (event == 0xc0 || !priv->array)
 			return;
 
-		if (!sparse_keymap_entry_from_scancode(priv->array, event)) {
+		ke = sparse_keymap_entry_from_scancode(priv->array, event);
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

