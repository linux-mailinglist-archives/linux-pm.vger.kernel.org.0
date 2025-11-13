Return-Path: <linux-pm+bounces-37891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89774C54E1B
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 01:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54A5B4E0F22
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 00:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F13137C52;
	Thu, 13 Nov 2025 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+34FNMk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaKbi++R"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681135CBC1
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992920; cv=none; b=VGdJC3zEb7u5FVtlybIizhkDdqC7e+ADPFkZb2KhSvR9YcQODBRv1IPHHrGy561+/9+iZGUJTdsSPaCJz3XjiqeXnPTYEU4xMRhiNb8jNIxY0MmgyMn3YLlu/U/4mtbIJ3QRxnziOsTGy6m1bkOsn48ooLN7Fgtt3XmArqfTHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992920; c=relaxed/simple;
	bh=ydcwlK/oAd5xKfTx+JL5DKXX5NzldMKD7eXI7AFie1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5iI9ODXgFPoJD2K3OdjzADSoqNmzBOZkfkV6Pqk5gLIASSMC1THC9siSZnSdcKXlczg3XG8TyZpBFcuJjq8aUs4O9I/8UFaxWp3ezLvaC7/wdLjySt+HMZK+09eL0MvB69zdU6xjAebaV6JdLnP4b1h7r3WSahfWDKZvt2IdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+34FNMk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaKbi++R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762992917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDL7LoYP5gq9XMI4WP3Ykdi7uKdtvjM1bMJQ7leEYXw=;
	b=K+34FNMktdluipXabuCgWUJDAUoyHncbv/r+RD8nKNfEhXAmpdRBSd0dnOZ+Mu4rGBH5vK
	TZ3bcC87yaFcHQr9jcQRvQKywNemk0ujqw9Jk/nHo/ZPCWiAc8DvhsiPh782xUZeH2bS9U
	O3SGtKwEsFThjhFeXitWiE4qD+K2W5k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-g11W9jPzOamyyf2ZcGVWGw-1; Wed, 12 Nov 2025 19:15:16 -0500
X-MC-Unique: g11W9jPzOamyyf2ZcGVWGw-1
X-Mimecast-MFC-AGG-ID: g11W9jPzOamyyf2ZcGVWGw_1762992915
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4777a022d1fso2147875e9.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 16:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762992915; x=1763597715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDL7LoYP5gq9XMI4WP3Ykdi7uKdtvjM1bMJQ7leEYXw=;
        b=HaKbi++R60K0/KueJmIxlS7t/IVYai39FyTNO31Wdao9i8mHLOSIOZJgB9s20IfBr0
         Trasm41BzoJooztcYlb8PJQbwkAi1tAjk51oFzZYmjxCbw1ymLaqYE1iUYsp9kp8Qx6l
         KxD5NkPRjrWTbY6XSY/3XExgtb+TDvv7TS/++1uxrZLwiiNm6JHXgoLd/rMI+oZTZn+K
         sdi27i3LYccA+XFdb4/UPzH8Ixpkqgu0Ty2sSJR1bdHyczMlajPDyiCB0WkpVZTa4uEv
         2cWNbbkQDx9gnn3/P7fjBajFeQjQVwBQvxRFosazcuLM2hsSMhjDNRm5d7+m+pgsmbvv
         oKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762992915; x=1763597715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TDL7LoYP5gq9XMI4WP3Ykdi7uKdtvjM1bMJQ7leEYXw=;
        b=wEI7H+rpI6Dxq8Ie5mYzqaeeRSeIWC5/3R0G5UZlv7mJWWRBdXmcZCDKRzSFo31Rge
         En2ODGcSX00karE2wdn0/9AsWNdyvwogUh0iNdhiS1TC3XdufFLQhXxyJ7347ItIWXzx
         u1mAN5QgWaGsUoYXKd75w+6Ue43F/GzpWr3ERMUUK1SYNKaEdZQS5dVxQeWxFDFxKt3p
         Nn+6+cSSchOnjIVN6dOIqDpmyrhh2ZQIRVhBqURIdl1DGZ9Q98t0N0pzTxEXcaceeLC0
         0BmkjGAvNq8+P53cp/1Q1A2a+Ljw53LvOfPsieAVq/gPCY10eqOXoWF/00OVXzqB5XgP
         voOg==
X-Forwarded-Encrypted: i=1; AJvYcCX8gQjbFogA03nB3raJd/40om97XThRJrEHaqpgkWGn0zDPja0Pvx8IP+GbaGCi/od3cseQjWYVqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4j7Wm5YMEEt90Yefy69svC1ywyxak0DPFltZRi+W6SBZe+Gxe
	0Rb9WnY3PXtJL+mtjyris8JIopjxLp69g5hDfXYeULuVlJ+m4R0d8u0PPjbTtKgC6jdiSlCvbRi
	JiB3KB60PeBX+Pwphy/pHmMiDaiORmwLAo7+pMXn6OpbFRFYSwh6LYc8vzr68
X-Gm-Gg: ASbGncs5vQcke//lx3XurQt1a7/QiW4ojQ3eKg55TpvY/ADqR9D4PxsGzu7AWslfdgE
	CigKNYtrmPaOugXoq90lxJzRTFIlCpgayMLGwdh1vB0wKoTnx0iJqr+tRDH5x0h9HzyeOuN5BlZ
	NNNSa1YnnSdiZ2mj0Jt1WJ+5QguuedFRfewEjS08ndCTCgAlyjidmO05IpmvulqoAKGmwCwsyZw
	WcLcGv4BUR+YVVNnGHr8uaaLZNYwzsn+wOIvYQPfkU6f/Uw/i5bx/UqR34lCaoP99o6dccZ7v7v
	qc6gQk3KlDyFqjdYVGL6XKIHYmVVvYBaHYqUehkYSIjZ5XmDG5E3BPetidNbpGDmDL+ZrZ5as/H
	FqlbI1B7TEZop5w==
X-Received: by 2002:a05:600c:1ca5:b0:477:c37:2ea7 with SMTP id 5b1f17b1804b1-47787093944mr51874545e9.21.1762992915197;
        Wed, 12 Nov 2025 16:15:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH44t5VADhoiFQdYlbkmvZ6vHu5ra7JAo9+e2PeUxapHpCteCkYYf67077+vK51LHvqgAh/8w==
X-Received: by 2002:a05:600c:1ca5:b0:477:c37:2ea7 with SMTP id 5b1f17b1804b1-47787093944mr51874445e9.21.1762992914844;
        Wed, 12 Nov 2025 16:15:14 -0800 (PST)
Received: from sissix.lzampier.com ([2a06:5900:814a:ab00:3725:2991:6cf3:b3aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b589sm432983f8f.23.2025.11.12.16.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 16:15:14 -0800 (PST)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 1/3] HID: input: Introduce struct hid_battery
Date: Thu, 13 Nov 2025 00:15:03 +0000
Message-ID: <20251113001508.713574-2-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113001508.713574-1-lzampier@redhat.com>
References: <20251113001508.713574-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add struct hid_battery to encapsulate battery state per HID device.
This structure will allow tracking individual battery properties
including capacity, min/max values, report information, and status.

The structure includes a list node to enable support for multiple
batteries per device in subsequent patches.

This is a preparation step for transitioning from direct power_supply
access to a more flexible battery management system.

Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 include/linux/hid.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index a4ddb94e3ee5..63422130de20 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -634,6 +634,36 @@ enum hid_battery_status {
 	HID_BATTERY_REPORTED,		/* Device sent unsolicited battery strength report */
 };
 
+/**
+ * struct hid_battery - represents a single battery power supply
+ * @list: list node for linking into hid_device's battery list
+ * @dev: pointer to the parent hid_device
+ * @ps: the power supply device
+ * @capacity: current battery capacity
+ * @min: minimum battery value
+ * @max: maximum battery value
+ * @report_type: type of report (HID_INPUT_REPORT, HID_FEATURE_REPORT)
+ * @report_id: report ID for this battery
+ * @charge_status: current charge status
+ * @status: battery status (unknown, queried, reported)
+ * @avoid_query: if true, don't query battery (wait for device reports)
+ * @ratelimit_time: time for rate limiting battery updates
+ */
+struct hid_battery {
+	struct list_head list;
+	struct hid_device *dev;
+	struct power_supply *ps;
+	__s32 capacity;
+	__s32 min;
+	__s32 max;
+	__s32 report_type;
+	__s32 report_id;
+	__s32 charge_status;
+	enum hid_battery_status status;
+	bool avoid_query;
+	ktime_t ratelimit_time;
+};
+
 struct hid_driver;
 struct hid_ll_driver;
 
-- 
2.51.1


