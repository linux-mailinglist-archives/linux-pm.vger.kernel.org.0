Return-Path: <linux-pm+bounces-35759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D7BBFD2F
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 02:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A53A4F301E
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 00:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58AF235358;
	Tue,  7 Oct 2025 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBHPjJGx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FA21ABDC
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795235; cv=none; b=pWFTjv+wyxbPNq67b5oPnPBdyYBlOjRzdX4P4zEs4RFd4PU1hkbzgi5oa0IJbSkNZYxMpU21tcZZLclu5Qiy0vVK2230Y4TnDl/Qkx5JM3X7GfnXqlNmGvGf4W/bfSclA+DJRs05pDRZtqm8f7V/1oKnhtm1QoDNFyr1B59c5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795235; c=relaxed/simple;
	bh=3SrGK00c6kBpKdfA0G1voXW98D3SN4/08oAWZGvB06s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l3djnkT9ZHzIDOZciiLJfb1F4ebV3iXO5tkGLGFmtG0/VMB+HerhRL3x3XICNQOTIl7i2kUpo2FILREPjgOpBTal3otgmRGlwlnR6b2pwlZWxuDopSDwhyxjIwCd00fWhKbr3H+VH14/BIO88kcZ0l1P9hrYbNMUvmu/ZTslZHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBHPjJGx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ec2211659so4631743a91.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795233; x=1760400033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNxgxN8i4WKNF9gjsgYvNaV1dKsUpnqQpccRNq6XLzk=;
        b=aBHPjJGxffZAo8gagTuh1Mkcbw6ke0uy17r0vs+k3Y9Cg79uPIyw+MNa2iZe/s1ZKC
         Xt9e0M5WWf+xdDuqktM7xH6KHrxOhT5ucIQCHNYAENlmejhA3jNsQdjzRILt7y13Kdjf
         bu7SeWxzKdLOGRluoRRmy3g3TFSlgEKsaQhIN8w83ysB2e8FRDD5PbAdOj703wiLR7XH
         xNH54IRQL/I7jJLUNedthCgtPD0F8Z0xHzrZpuc6LJxGXQ/Ia7fSVLWq2x7bZdmlllar
         0/HBsbW5Xddg9BhWOLjiAunsb4tRRAfvHlJ5W/6oD9cRMCCP6XLQumZzNQvChO+z3THI
         Ad+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795233; x=1760400033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bNxgxN8i4WKNF9gjsgYvNaV1dKsUpnqQpccRNq6XLzk=;
        b=veDvgW+7NgJkKRzkmRgs+shRiGJNm4TsRo1uLpqWRGIhBykLYB2X+i/7YZQdADVycj
         NSM7JQi71YjVm3Ponwrwmq14SE4vTUNyGsE21VIoCY9LlqBXRicaPFAIFF6YCj1SDWD4
         p9W4IMcEsHJRyn4j+aSf2/8hJnf/KehN+v9+aJaL55C6/zn+PlYS5RU8sSdPrFWApBg7
         /hGLrOp1XbseW9oMrY/M0S0SYmKpMz6K9H8Mvpd3DU5UW3hJiAJwLw7xSUiSDX3G7vmQ
         W/yTaucEHsoa9uTZBxVuGHvMXfC8Qbu6ARNIgPVlfzJf4J+uAiOviu72FkvtIblVPRn2
         gAMw==
X-Forwarded-Encrypted: i=1; AJvYcCU+CiWwSqwkWTqMWifYmL0mVKD8E/8h14vFGNHqJfVx3wyuadLarQi0J22g1SBOzwx8mqnDbrmLTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNvfoINYSjy1Q06qz0rqRtOsVH7VkxwMjLb+RPrqmWzmKIcVl
	W68xaWZq4qx4QmT4NuCYKUTtsfUgFtO/MXcfG7t/S/6rcLWM7IhPI7kRMaZ4EcwFxw5+4QGGq8G
	6RalEBA==
X-Google-Smtp-Source: AGHT+IHFgZJ+HkrSiYXPJMMiNLQI1F1cnVHsmDy7sKcZjdwP5IwvuIVt3bnCbD90DcU72hET3y58ZFjpk3E=
X-Received: from pjbbx13.prod.google.com ([2002:a17:90a:f48d:b0:330:72b8:fcc0])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b0e:b0:330:6d5e:f17e
 with SMTP id 98e67ed59e1d1-339c278eb63mr16986089a91.24.1759795233450; Mon, 06
 Oct 2025 17:00:33 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:00:06 +0000
In-Reply-To: <20251007000007.3724229-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007000007.3724229-6-jthies@google.com>
Subject: [PATCH 5/6] usb: typec: ucsi: psy: Set max current to zero when disconnected
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jthies@google.com, dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The ucsi_psy_get_current_max function defaults to 0.1A when it is not
clear how much current the partner device can support. But this does
not check the port is connected, and will report 0.1A max current when
nothing is connected. Update ucsi_psy_get_current_max to report 0A when
there is no connection.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/psy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 985a90d3f898..3a209de55c14 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -169,6 +169,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 {
 	u32 pdo;
 
+	if (!UCSI_CONSTAT(con, CONNECTED)) {
+		val->intval = 0;
+		return 0;
+	}
+
 	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
 		if (con->num_pdos > 0) {
-- 
2.51.0.618.g983fd99d29-goog


