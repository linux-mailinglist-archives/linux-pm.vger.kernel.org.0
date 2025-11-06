Return-Path: <linux-pm+bounces-37491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E6C38ACC
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 02:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279B73AB964
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 01:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676C1EA7DF;
	Thu,  6 Nov 2025 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mg6b+Jal"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA01D61A3
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391692; cv=none; b=R3YAy4cboz767/KFqJpWB07jKXy4h7k5Ulb3561C0rnLAAytzqOoC9v8/SajiD7XZbhFOIigiHF/K+UuXGybH4OkSdFkA9CBpwozXRqKUfMJK7s+jb7DsutQ998XzNtM50AGqvzivWS93t03ux6VXDzOUB/P5LicsL7STwD8fy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391692; c=relaxed/simple;
	bh=GqiSEFjJpS60vknr4o7YkvEXtHCaMxx+InwVSzChCtY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JAfBP545or282kuZDNCuNzhNqw5Ors3901dAbS2+9D3MDXzrEsRwRfRWf0RYeoOP/A5VpQHEW8ai1o8B+k33dMngIq1XIRtN7yAScfWiCaX5fSjX0o45Q4Y09kw0RukTkOVLSTHYlsMZV+yQZBAd3Q1lEJ+cWJiFuIn42LkxZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mg6b+Jal; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a26485fc5dso623866b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 17:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762391690; x=1762996490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=39ivioua6pnMjSf3oDat2VB6KzK+NMcakhy3huJbtbA=;
        b=Mg6b+JalVoK55gYj7KWr+vHIEhRFW2jczU3YZQZolgfaOLStelq/+gu4wcgCvewRXm
         F00O6SsG9rH8E938T3kWelwnzji4ohv5qywMuVeSzwLfC/kzvngQrh34NB7C+PQ++WJP
         i5zSY88fIhyUaqwc3HzZ56TIywyegbbl7ixUqOAE9nN+SZkqUsP/WnSAvF/50yoSnD/r
         2KotY7vI62JCNhWUZ25mSoJs/MKvB10jV7JF3OnurzNPSRtdkZB1q/7417zGh9E2yyIm
         6XKGFNUMmLdrJIh2fcWdcjhX+EYJ5VMJoZDh6uBHr2Mx6BfWTb1xrTBn3NvdVVrVN4kS
         JIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391690; x=1762996490;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39ivioua6pnMjSf3oDat2VB6KzK+NMcakhy3huJbtbA=;
        b=oxmO3a0Dcyx6CqURmgmJR+xMobh862ZB8CQyyaEO9rFPs5j0hqyjziwHdr+VOYQDiQ
         kUWfbj0vgtaQpcOCwTH49MEHGlY1+l4DBWvvUuDRQJ0OQoTllKsSz9ftXgZwkQPnT5ZD
         /P7B9U72hCzpdPW3UIIvVJvhAg8mqgOWs5iGP/mNC/P5ylajaP8wX6JZl99APyWLgjZP
         b4Ke2Khn+OmN2XbjZhXtjb5CfZ8LVKLcBRMM+WGUO3SJ5kCRFLOMbuDdk/sI+OlucYUA
         9q3ksWmWN2Nu5p/ksqePeCHyL8PHZuhDp2M/hGW6Yj6fkE190tKvJRr+LofdpjB54UGE
         4wuA==
X-Forwarded-Encrypted: i=1; AJvYcCXakzNS3PXhCSy3tFetG+C+439eEsCUCvREKklq54TAM7iXky61eubd+KCZ+7mR6o71YyLn3Q1YVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZmBWfQGPUaNrEbz4zvwObQ/2CAuhEt+UHwsdNKuuE/ml4K3V
	Gyo3AqBnAA4JFpDhl16gDMuOuqwwmMtgTEaMGjxA2pazSwQ3Kyck/1aphx5O2p6XH0G1+LwGMOg
	sl6+NOg==
X-Google-Smtp-Source: AGHT+IGHknY9aqu1w+W4IBmjhbnbPVtNg3MS81ewEb5IJ6RCNy2Yl/JqwF6vF+FFSuv2t1tS8YOwfKaj34E=
X-Received: from dlbqc8.prod.google.com ([2002:a05:7023:a88:b0:119:49ca:6ba4])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8e:b0:343:68f2:3728
 with SMTP id adf61e73a8af0-34f83f06e42mr7119443637.15.1762391689940; Wed, 05
 Nov 2025 17:14:49 -0800 (PST)
Date: Thu,  6 Nov 2025 01:14:46 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106011446.2052583-1-jthies@google.com>
Subject: [PATCH v3] usb: typec: ucsi: psy: Set max current to zero when disconnected
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, kenny@panix.com, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

The ucsi_psy_get_current_max function defaults to 0.1A when it is not
clear how much current the partner device can support. But this does
not check the port is connected, and will report 0.1A max current when
nothing is connected. Update ucsi_psy_get_current_max to report 0A when
there is no connection.

Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default")
Cc: stable@vger.kernel.org
Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
---

v3 changes:
- change log moved under "--"

v2 changes:
 - added cc stable tag to commit message

 drivers/usb/typec/ucsi/psy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 2b0225821502..3abe9370ffaa 100644
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

base-commit: 18514fd70ea4ca9de137bb3bceeac1bac4bcad75
-- 
2.51.2.1041.gc1ab5b90ca-goog


