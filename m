Return-Path: <linux-pm+bounces-30269-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7459AFB12E
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287CF17F3F3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2394295DBF;
	Mon,  7 Jul 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNZKposv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E107291C28
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884038; cv=none; b=WfgjHqqRkA4HoOHSDF6NGOg81+WLIIjzgGFhEtBlkCPgz2rnEaBNlH5gRgpH2HGGN+puuVheUIxaddz/all8f/7+znYsn5YMAQwG82eFWU6C0umxkEWFIbpplWoPLANeObCSiGeZ5/gDLXMAbxvHXoRfJyax4sTYMTzy5+EpVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884038; c=relaxed/simple;
	bh=xFUNUc5m5ajWoG/fAc3PfI2ibizJRteLWpJOojk196U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hDctKDa1alOqJZlLk1jrmvf9D75yyOc1Rw6CkcDdZgAaZqCv0Rm7yKOFPPRHDR3qLtyvZia585JOTt2ByWGL5E2xWUKgwgITmNL2hR96zETq60Bui1BY1CGhd7PIpSzaFEheb2tVwfyknZ6tbA8XAXBhsGXxltHSJ4sP0fRD6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YNZKposv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2363616a1a6so25612105ad.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751884036; x=1752488836; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrCguQvMCX0qN0EKrycpjflp0FRWcgp0pAKxoev4M7U=;
        b=YNZKposvjQSErj8F+ZstHuGLurQsHkaiIGNtvQi3GI2HkLtEGEvEH0XLxc8HXLpBb1
         stx3ecuLmfejyyHVBhb8llXyxE8CCGYPkudOLGJ10/10lgSlfb2+hgttYmKH4fkk9agn
         XMKKQL3b5qAYN7w4CPqpZ2tYSSSvIqyc1iySg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751884036; x=1752488836;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrCguQvMCX0qN0EKrycpjflp0FRWcgp0pAKxoev4M7U=;
        b=cnOjhdx2rxBaihKD/jU3Z4h6PHH+ckrmWk/4vb2vCVVvRZ4+4sBoEaAyLcumXAbmnS
         9AAWfokJuk0yb/1pUl8WuxRWrXU7izBaPWcl/J6ZaBWepvx50FMKk9zmeCKUyyS/sAf5
         S9wen7opvrN1HZHLM8kB/77mtP6GZDQ+GfIimQUooiF6pdHeUSvU3QntFn3hlsg0nroi
         UvPmX14wijsCR26BiL7Xf70Pt1t3ENqg/f+3TvxVuAMPnVQMQKFrDFUNC4STvKUrEr+C
         AdLT9AWg5lAWy3f2cFr8xAD4GmXPnwYLp1qsTqzzMP+tMHS69KquwCNuS0QTqaYXKBag
         Y96Q==
X-Gm-Message-State: AOJu0Yx+EF65RHOK0BtD4CNTyfnsocomJIbva5Wchoak9fa3k7u5T6B5
	V0grkbaHgRQbqBjqkfxay76LkNu6a5bp2J7Dam8tmQalb9uMgmoNx0ixkLJSnpv0hg==
X-Gm-Gg: ASbGncuX+72EixSr6v3VeesAg2uzeIMlVvXqbgo/5TOnsQZ2n82h2vJTW5IBBhF/U/3
	i4P3LSxhRdnAGnr133YMsBxb6FbZqq0ZQjTvP7nNe1mpAc//Nxr5l7Evu2/zrs18B5waDTLLoAn
	VuZFKkwsDqWnjbM9n6DDS7jXDrOFUC3nwyv3NTxJJpNgqEwsBY41rAoqoaLuZ1wiy2b/yjxjD9u
	YnctL3U9kmZSgUFU5Q3QWiHEk8+KBmUqnGGSozDqFkzb/iHra8cXA/G8zCXd99ionu/HXQmzo89
	1IesFSkoNYUe1Ds3qwDhUFbvMlveEfHLeoDNpDSE1KwaVjih2kQrJIX6KXCZXwezB0gHEX18UV/
	AHmLNpY4jDK6GLU9Wmdlreh8FeS1j9IU=
X-Google-Smtp-Source: AGHT+IFDfxeN+onnny+B6L+7wHiiEtPBfsMaJLUeKdhihyzBWk863pmDXzSYrNTM3um5yiBK4Jo6vQ==
X-Received: by 2002:a17:903:138a:b0:235:eb71:a386 with SMTP id d9443c01a7336-23c875e8180mr142789935ad.50.1751884036508;
        Mon, 07 Jul 2025 03:27:16 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:53d3:893:10bb:1dc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8434f0d8sm82986895ad.82.2025.07.07.03.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 03:27:16 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Mon, 07 Jul 2025 18:27:10 +0800
Subject: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org>
X-B4-Tracking: v=1; b=H4sIAP2ga2gC/x3MPQqAMAxA4atIZiO1/gS9ijiIjZqlllREKN7d4
 vgN7yWIrMIRxiKB8i1RTp9RlwWsx+J3RnHZYI3tDBnCSyVgOMVfSI1beNjcsFILOQjKmzz/bIK
 +6mF+3w8zmkmzYQAAAA==
X-Change-ID: 20250707-trip-point-73dae9fd9c74
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-2a633

After commit 725f31f300e3 ("thermal/of: support thermal zones w/o trips
subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
("thermal/of: support thermal zones w/o trips subnode"), thermal zones
w/o trips subnode still fail to register since `mask` argument is not
set correctly. When number of trips subnode is 0, `mask` must be 0 to
pass the check in `thermal_zone_device_register_with_trips()`.

Set `mask` to 0 when there's no trips subnode.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 drivers/thermal/thermal_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512dd744725121ec7fd0d9 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
 
-	mask = GENMASK_ULL((ntrips) - 1, 0);
+	mask = ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;
 
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
 						     mask, data, of_ops, &tzp,

---
base-commit: a5df3a702b2cba82bcfb066fa9f5e4a349c33924
change-id: 20250707-trip-point-73dae9fd9c74

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


