Return-Path: <linux-pm+bounces-35758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C506BBBFD29
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 02:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEE024F36D7
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 00:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D6B2264CC;
	Tue,  7 Oct 2025 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q03rbH0Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D12227EA4
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795233; cv=none; b=hxYbSia8CSxrBptt6MsTYxehsjG267igLZL1bhWvFKk/crXSmJj/mvpc0JnFLFjj6p9cUbdgAs2c39NIPI7btUg26PR1bmQAfJ1syg71Og1Bml4yCNjPMoYeIRZ4aOlQfULHw1BTisAGtroTBpIHxXHetyIeCq7VA/88ybZJXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795233; c=relaxed/simple;
	bh=D+MRKxpRY+FzYsdPeIj4rxTE/97xCVi92Ne0tdfRG9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uhcgxE9u60rbNrFBAtf1NmIzrMouzRiwXoOnTZh1YPWu5rFkBVLehGyzf1hB6fT9Z31S2UrV+Du71BXKaXhZOimDv2lJdkbHPxu9d/AO9rFOgk705nIrnrNFUmLbwhg2cEx2Exl8CMl2wnoGoycQ/bHIQ8sq0bH2yWq4PPqfhF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q03rbH0Z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso4748982a91.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795230; x=1760400030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HBzYAbkVeiCWYgmKOO6DMAiS3ySiT/Utkjit0D80cV8=;
        b=Q03rbH0ZOciiKXEGIka8M5SIgkmvzw6ZHsDsOkSYyUmLRCd8v3zg1PCTWsjgf205cE
         fju8msKsEasSW/0kkBl6H10HqfnMZm4EgbfVOvofsXBgSWUacfO4/3ZUHCeyqPwoLs3o
         nIsHdRVAqLeBDmEyt3nHaAAjywJdKopVZ3J4A/nYfXQPISH5PH7d1/oOWzBJ592wkSgH
         m1SAQEkRXRW0CSkcAD2PNVa6uOgy0xfcj1sV/HquWem0LmSUERRwbzcY3Wlmp+bBTDtL
         BMk32ivDpxNgdFKmcAAIG+Jw47DFOQCdpSYvns7wogtXrvL2kE6hgLgyfiY5lga0U23m
         Pn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795230; x=1760400030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBzYAbkVeiCWYgmKOO6DMAiS3ySiT/Utkjit0D80cV8=;
        b=iLFhnT9ZWwgotM2iWFmAe5O8O0E8F7ES+HVfgUbxX1bTaysxhI9GEKP+T+NUNQUl8J
         JMj6fZrajRrionCczSX+jmr4dsUS1JU8UcnVmzlamv0UvHqM2P9TJPTSyaFRRKbpfj8z
         xNspQjxK/2jv57ak5KzOnjzU9TvYHa1JT8k2slVZnwi8q1Bx+9ACiTVBUzje0J1a6rYJ
         /mTTgixCHamSeMRgUTAryUHfYXcUC7nGRpyLOFSx82pucIFelBkJdx8g3CySPHQD8V0B
         dBS2NPtNhlyi2N3vJ2HXYX8Rer2GGg8/mXSpjhHUa4Z/HN4RWIbi6l2n3EggPYjjCbNe
         3g8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQmrSnQGmR3ewunXZlnLg/5+c8W/zyYQ3Z8w2onq4BrEk8ps/327ukNPWwm0MNabKYVE8L4f6KYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20Vj+WBsPIlCCDvUX3H2LbRKaveAlHGNoc/7pyTi6BtQtGS7t
	iEgIVJY2cPIIQX37ShW6Zgo+Wksdm+dOtgAsXnxCjU2zaWYq1EmWKccWiaUEUI5MmysaAH15laL
	h7qO4zw==
X-Google-Smtp-Source: AGHT+IFxQ/0APQQH/w8k8aOg6BAF8kp00klr4bjh7buOd+uTq0PuqSjd8xU2TYekqWlGFdbE0f7oM3ZZQgc=
X-Received: from plek20.prod.google.com ([2002:a17:903:4514:b0:274:e523:6f5a])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f04:b0:269:8d85:2249
 with SMTP id d9443c01a7336-28e9a5689f6mr144152565ad.22.1759795230224; Mon, 06
 Oct 2025 17:00:30 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:00:05 +0000
In-Reply-To: <20251007000007.3724229-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007000007.3724229-5-jthies@google.com>
Subject: [PATCH 4/6] usb: typec: ucsi: Report power supply change on sink path change
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jthies@google.com, dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update the UCSI interface driver to report a power supply change when
the PPM sets the Sink Path Change bit.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 2 +-
 drivers/usb/typec/ucsi/ucsi.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 7b718049d0d1..1a7d850b11ea 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1293,7 +1293,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (change & UCSI_CONSTAT_CAM_CHANGE)
 		ucsi_partner_task(con, ucsi_check_altmodes, 1, HZ);
 
-	if (change & UCSI_CONSTAT_BC_CHANGE)
+	if (change & UCSI_CONSTAT_BC_CHANGE || change & UCSI_CONSTAT_SINK_PATH_CHANGE)
 		ucsi_port_psy_changed(con);
 
 	if (con->ucsi->version >= UCSI_VERSION_2_1 &&
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index cce93af7461b..35993bc34d4d 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -382,6 +382,7 @@ struct ucsi_cable_property {
 #define UCSI_CONSTAT_BC_CHANGE			BIT(9)
 #define UCSI_CONSTAT_PARTNER_CHANGE		BIT(11)
 #define UCSI_CONSTAT_POWER_DIR_CHANGE		BIT(12)
+#define UCSI_CONSTAT_SINK_PATH_CHANGE		BIT(13)
 #define UCSI_CONSTAT_CONNECT_CHANGE		BIT(14)
 #define UCSI_CONSTAT_ERROR			BIT(15)
 
-- 
2.51.0.618.g983fd99d29-goog


