Return-Path: <linux-pm+bounces-18196-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B68B9DB45F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 09:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CD7161FA8
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 08:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC781509A0;
	Thu, 28 Nov 2024 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUTbWFlT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2ED13FD86;
	Thu, 28 Nov 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784318; cv=none; b=W+pgdyAxn4u2jqi1CWp/ceidob/l0RqvJA8G6oiXUTZ1Nc1dL4Rr3ge3F5283ODxWX5snll7EKZazgT/P1+qLx/a1BBt32RJz4XpFvKsHwPPVM+/W0r5qbv/X/6OmbKD/Wa+trSfLdwSX0QyxPD0nQCW0W5mHpm6Y6xG1g/MN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784318; c=relaxed/simple;
	bh=k2iME7HouJc74G/E9AO5kalsveNLSqm5MuWCHIdywjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQBuQff0CoW3AbqhBX5qp9+0v0zcuIRngkMi+61HA4byiAgZAcbkorm+xYX6lAI4f0eRiiiLc6I1kXYUBlRTpNgab75jjbg0yMsdCLRgPEJSjAkBNTZR6hKvccBobwmWmNu1JoJjOaNIO4lRsM5GAYYalm+gnxlnBU7rUX5gZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUTbWFlT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3823f1ed492so948936f8f.1;
        Thu, 28 Nov 2024 00:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732784315; x=1733389115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jx5AuFTjUhWGf0wjTdzGiWCjolL2YHEohVfa5lHg8ME=;
        b=SUTbWFlTZiOWCjS+j5eoW4QgOVYA70AglBU8Hy2BkVM6Q6HBoKc80gGJuHodRyZzBV
         8uUOKBt7I2/ISBfdoEX+nXEJioPOVkt09OpGH2/rHAISOBM8/WRpSvR62kPbytZoiNo/
         O37Q/NzebA2ZjHhP3o9jM+EWkf/xGjKUM7J7O7EiRe7yIFzyZiQ6Csoh+UUskJzYihjE
         3dxLwyEurdVDH6VLwDWOTkUplj8BfnVOuU3opVp7MJikpqXERl23a5tgfT+Nrfb//GA6
         Ily3ZwKNAfEs7HHMteqf/PMGbOisYLGUsD3QBwuJVcsjbLjDnjWG85LLfTX+AGN8y+i3
         A0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784315; x=1733389115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jx5AuFTjUhWGf0wjTdzGiWCjolL2YHEohVfa5lHg8ME=;
        b=KHXwU4yzBbvxK2uoUVjWi2e26kDowjUzTOq7s2+PD3HRGJyZuRjcL+QEGzAL2uFAbI
         IG+Jt2i0dEkgJB78Fd1WLzgODcii5rbHKGGXEXRskBFh7F7v6z1grEiuFdOuYhGBwmch
         5f3oPQHLEBjDAcLanbHnrnqkpOU+ghOtsx+k+R4GRwStsprPT6bH6QT0PDXoOTGjZcd+
         VfAc36kvyI7U+Lbg2Jv/ofEcbIKH9Y1xEOo8FYqabWLzWaN92LUTesLhoXBBpbgMlgeU
         vC4s8VOGejpkM1jBJdprDg1MJOoKRTtJNQyb9pGdXo4D3cZDaitk9hSIFA38BDH+tWaY
         S03w==
X-Forwarded-Encrypted: i=1; AJvYcCWLMPzhqtLUzTyHHkT1dCS3MiaX7gu1GopqBbpOwYJiyV2PiuORY0AVYWdLWZXy/4TWarpL2JfA8I69wkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWzwsJFtKNv7P5XBGMGAM5p7oJVfPMBaoyUZ+PMy07yJy7zR3
	yrbT13UpeDFbGW8yhsvWumgBUQy0wZITpLfSgbutotrS5UqA2h6j0wgeBrF0
X-Gm-Gg: ASbGncuOOEz/V3qb8rJJnAdbi95kdoLve+SChsOvw/WCrfnCzQspBr3r//v2YhYjIqk
	4l0SKhPYbXtmDIkad25p1e+ebzB1whSXTlsDkDGFMlyUMoL2y0746eSTlGrM87NXmuFCPHNCtF1
	cEIu4HKTpsROBP6BBoY2Mtij/4guLXIluWiT4niaCNH4+t2/vlJoRjPZJ91DDax2CUwkvUuQVQY
	z5Tfg5PcUCokQhufmtMuM7EAzDXCTM/njOtubxkQtSFvsc2dA==
X-Google-Smtp-Source: AGHT+IEpAZpCmKQtxxZT2vAJJ7hS8Bdoh08VJBHdSGFM1QP+wcZVJE6vIIhxcGw5dMqqZECiLztOTg==
X-Received: by 2002:a5d:648f:0:b0:37e:eee5:80dc with SMTP id ffacd0b85a97d-385cbd8a0b6mr2120005f8f.28.1732784315349;
        Thu, 28 Nov 2024 00:58:35 -0800 (PST)
Received: from tpt440p.. ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ce3f934bsm442261f8f.30.2024.11.28.00.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:58:34 -0800 (PST)
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
To: linux-pm@vger.kernel.org
Cc: pali@kernel.org,
	sre@kernel.org,
	linux-kernel@vger.kernel.org,
	maemo-leste@lists.dyne.org,
	"Sicelo A. Mhlongo" <absicsz@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/2] power: supply: bq2415x_charger: Immediately queue delayed work on supply change events
Date: Thu, 28 Nov 2024 10:57:27 +0200
Message-ID: <20241128085759.11840-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bq2415x_notifier_call is called asynchronously, when a change is notified
from the external notify device. Therefore, reschedule the work item to
run as soon as possible thereafter.

Suggested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq2415x_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 25e28dac900d..1a02195769a3 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -839,7 +839,7 @@ static int bq2415x_notifier_call(struct notifier_block *nb,
 	if (bq->automode < 1)
 		return NOTIFY_OK;
 
-	schedule_delayed_work(&bq->work, 0);
+	mod_delayed_work(system_wq, &bq->work, 0);
 
 	return NOTIFY_OK;
 }
-- 
2.45.2


