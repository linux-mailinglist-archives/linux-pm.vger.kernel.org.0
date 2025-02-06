Return-Path: <linux-pm+bounces-21450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7263DA2A33C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 09:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCD87A2A63
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E2225403;
	Thu,  6 Feb 2025 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJeCzxv9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55E155744;
	Thu,  6 Feb 2025 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830853; cv=none; b=J1+OtKslBPXHF2LN64A4wc89l/lOsCR8UtP5V5gI6hsOc6T/5y36k6tdukQKZsf+WtWqZbh0Y37yI5vNXQ6HRQE1+uBycLp8nalSNBbJS2MOWsO7SF3fgNyH+3MCxBpNdRztpvPzNSJ/+v5K87KB4VAVFV6yvK2C5vEQ4VzuPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830853; c=relaxed/simple;
	bh=EsWpPxpAOGFLvStOxAhL1M5zaj7cdVeBzDGre8Tkkds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eii/P6TOwR3maDxCF/d4BxKbpdHUgahRC5OOmq+7Jdi70HQ757XBsCJituFKCYijuNu5ibbxepZQF4O4jlg1VKZqF5PeQ89TCdE0BZgE4C6R7OOqHqpFmgLtx6QM/cZP+X9rTQZNFbmE+PmDq1xau07JEYxugeuivFHV33qqBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJeCzxv9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab751a7f67bso88735766b.1;
        Thu, 06 Feb 2025 00:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738830850; x=1739435650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeZFt1rArRFB+N1bmGi/tEoDVNsfzDRgwCe0uabyFSo=;
        b=NJeCzxv984SgeiLprurkfeTeHbQCeXM3S/GbT6vGBelh+AC1JQWHy+BoyVDpebjyd9
         bcDvNx/RRPEvohMYwOjLkri5HZSFT/gAgEdPH96+s/JqdHHdn1U11x4zDArB6ll+8L4f
         GFOXf41dULbukTz1ywM7ORYGyXvzvzAjtGpfr+sT+Yv4o9V0adFqQOvidrtL/pIPYtlj
         cUH6BOxJxSz0nvO+PkX75pS0AIEMCvo4sI2JABfPMhs5pm1IjvAK/wTzESo9ih3SAENU
         Zd6xdjSckVVojR0+oQgfcDTs5IXX9XvWD7J6cgQvrDVpl5bUWl4VkhILroVod+1TrtO7
         hw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830850; x=1739435650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeZFt1rArRFB+N1bmGi/tEoDVNsfzDRgwCe0uabyFSo=;
        b=Dq6eYvOM87VTKwzUE3Cj0uSScFEfI9ooZCX3+tAAXHXhsX/asAOFtXqI0LVpP4TMLd
         oA3Ef7hvcBi6+nv9S5S6imx+Om+siAKY0oDCYQd75eivTeSKoJ1KXWssDdgvwat2hogE
         pPrrwms0WSfWI3bOdDWzmHbMvmE1kpRi/8NGcDoKN/nqzKFVu4DPhMUrkZHvWg3QyeCE
         /Vt50l16zAsij4WanHOqXAnkFvCSohm5teqmKF75pN3LVZUYr6CWnUPodVwTAAMA3Suk
         qMh1G86aoiRNdmZjzEaKy+MPWY4cgHuNCDwFivDnWVHZOe3OA0wLUyHWduDtb769Kf0Y
         pb9w==
X-Forwarded-Encrypted: i=1; AJvYcCWEAOdHp+Rk1UbfhjtxvLyhttVsW4hK0dQxFKU+jBhEPJRigIfh/ftSsCRe/JV0C7IDSccBtX3YFZmo+RNa@vger.kernel.org, AJvYcCXY/HpT0nI2V4ZhU+Xrf0B3QtmX5PO/8k5WtaztFXxvckadZv6tu5m6KKqgL3t7cnMxcQ4Iji1UGU35RbhvGsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwtH1LYO0LB4n0qvsLK4kMKyO5GNCc/Ig4bskZGunscsEFGmB
	aG3Y1BX3bQ2wFzBah5Hb8misJ1/H1FECc2SYlD51GheMQ2+MdDdU
X-Gm-Gg: ASbGncv51dfAHh/v2qL5Hyy6y2+8DULkHnVguG2PLiqi83dnj4LDq1+DqvTCNqE5HkR
	B1gApnLrdPvZxQeUBQE5f5W3TKkSZwTyVV92rmLj0OHzcdrLBs2rdXAM2RqJ7VY/UHi075W4Ix1
	cYlC5za59dgRutXNYL1oGZRGhR/wet5BTYsTCI2WEDBoxI1pT4wQjKiwpB3FmIfb6lGPWTeIXEe
	yRdTA5sHQPK4HhmMnGEj6BZxduN93NfxJKr/Rii3M6q0Net1Z0zi7bsSscpRk6otxOU3WZiDxxV
	t8EbkYVb8k1gDFmD
X-Google-Smtp-Source: AGHT+IHjAFLAgoaw34EAPH1Yfd7rJf09sgjORniG26A+IbYzuQhQj3t/kiLKn825AlAU87fIkOZI+w==
X-Received: by 2002:a17:907:940f:b0:ab3:4b0c:ea44 with SMTP id a640c23a62f3a-ab75e221e8bmr661752166b.9.1738830850096;
        Thu, 06 Feb 2025 00:34:10 -0800 (PST)
Received: from void.cudy.net ([46.210.137.151])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b7adf4sm492050a12.26.2025.02.06.00.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 00:34:09 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] power: supply: axp20x_usb_power: Fix typo in dev_warn message
Date: Thu,  6 Feb 2025 10:33:47 +0200
Message-ID: <20250206083405.10286-1-algonell@gmail.com>
X-Mailer: git-send-email 2.48.1.220.gbc204b7427
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a typo in a dev_warn message:
 - reqested -> requested

Fix it via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 9722912268fe..1c30851054ae 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -492,7 +492,7 @@ static int axp717_usb_power_set_input_current_limit(struct axp20x_usb_power *pow
 
 	if (power->max_input_cur && (intval > power->max_input_cur)) {
 		dev_warn(power->dev,
-			 "reqested current %d clamped to max current %d\n",
+			 "requested current %d clamped to max current %d\n",
 			 intval, power->max_input_cur);
 		intval = power->max_input_cur;
 	}
-- 
2.48.1.220.gbc204b7427


