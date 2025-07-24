Return-Path: <linux-pm+bounces-31359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8D3B1021B
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 09:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71705807C3
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA525BF15;
	Thu, 24 Jul 2025 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muIKNQxT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B32A1BB;
	Thu, 24 Jul 2025 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342901; cv=none; b=RYBWGxe7sXiC0cQIo6OOjETSvAfAlFqYQVfdq6HVdgYIrawjbNAjNSHu1YysacEmU7zt+WhI1uAw9BhpM3GNRHrWzf8zlgVSoYMiCXaLekQh9+Q0rjn8tq4/kA7SPSYTYtyMXjrumZsgkAcJ8seQlfXrWKTyBJzRLMzEo7cfJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342901; c=relaxed/simple;
	bh=15kiuH3ohjQJSoHhfQ8LHf28SKY6AQ3QsaNQSEmr6Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dYKdosxYzJdMJkIpnGh7hRjaO8HERMwIOEwOox0tXukB8OgqfZwzSNl0p2hFXxnIfo8VT2VUO6LR7beB9fr6gb9b+Ruvl2W8MVUKsKlVkRcJq5HsB5k2e7fIY5Zc0r00aPKfOMvxmwYRsKZNtZLcOLUiP4mKom/R6ittFqD60XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muIKNQxT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a524caf77eso102970f8f.3;
        Thu, 24 Jul 2025 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753342898; x=1753947698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPukqAQVodQ+f3FEJLymtMhVNsFtmLOaRlS57pNUN2Y=;
        b=muIKNQxTln0lbU6MB4LLXJCq7bKPxMVyC9f6v3wvyGiTQrn5MPtej/KbgWRAvsgpYa
         fr/3UTI8dZVSdlA/x9ZNzaS2YXlUy3JTjnviQqLA55ix//AMz6N+MsNDOFNa6APKT73+
         VoIB0HVV3yWZXCJpuuz/ufUP8aKNK71cK7Ycp546p9iB87X1ae6m9DSWRAhAvtwPo+rg
         ZuwVJzQQ8BS4dp7e/4JnDaVUf673+H2josZ1WAI8XUE4WTbRRKGH/cVADC0UT1+ssftc
         W7wIHZtgq8OtmWQWbSvwaRJn989PbeeOVPk/68Upqj+e2cA9C5rTzhihZAPG19tMl87E
         o1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342898; x=1753947698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPukqAQVodQ+f3FEJLymtMhVNsFtmLOaRlS57pNUN2Y=;
        b=HOoxUlGBdndhDYxK9fDj/6tc0pflEEBmldx6Q2KCBbUYa19sIroanDXtTDNyMbvNPG
         w3dpev4WOM0jvM0wwjDCnxff1VuBNgia0KtVntf4p7g/yjgFpp134ZjDblOyRgFutG6v
         ULPz5N1JF2gLLHsEq01spbip4P8GKfT5Km5hxBV2Jtoc0WLYxRG2YWBdJ/aCpG3EqwRl
         s2HSkvOIh63nmpM2KYohq7wCw3vKz0gZsW2mj+msRrFFbbIMpaKvqURRCLHPJQ/KaJnW
         BlmuFP8JMEfi35wO3tLUgQDYyslCLIEYpT791pwpPNA/fcdm5VU2WcmRWlcAkdJnwqOD
         zDYw==
X-Gm-Message-State: AOJu0YxLWld7z6fPbBcc9WGf4jLD6cYAEtxOExgMtRD1/9kZe3JlXWGh
	2CXJ9jmmronAYG/YjPsljlDSxSQBPXBTCtZYYE2J3gjOh2zw+9w7t79cCKfV1TzpoC0=
X-Gm-Gg: ASbGnctJl9uITqJcb+kEKmNFtnbDsv+eF2Gs/gctUN6u+og7Zj0FRNTiFZC5dM859U7
	ItyjQOJbbP9Zigicj3ruvOjJ9Y6vSQdH42flLB5wBusqbkqsutWqIN4GijmTSHLLGWZi+DvoTa5
	RuDQu67gnuCLJhY+Wy2Wt17IOMTguE34adRbfH1mLsg4/HeRy4DY+yzppLFsHtKg9rr/qsphgT4
	L1Px7DwCLw+pbSDEdgCrX0MOd488yNi+4d8hiKl9dqeQ8iWvDSi8cDq6x6zXmz8T8n1FC43JstX
	qiDCYLmt33iK4U3qQ9J/ngjG+XU9SAJEubh6L6jFITiWZgCLPEb83ek5B6sY1dF7KI2xzXc6phy
	/Ogti9vvTad7uuI7PR6pbiLJZp9PVpI99fwRKA7+2lZwn+1Oac+opW6MeubIzwcaHT/+8IDhUIg
	==
X-Google-Smtp-Source: AGHT+IGMqDgnd2dp69JMoacwHLJXu2KcSrmTFUlFcELvESQxSjQZDAcLUTBy/0JShke64012QJsI4g==
X-Received: by 2002:a05:600c:1c19:b0:453:c08:a1fa with SMTP id 5b1f17b1804b1-45868b337cemr20344165e9.0.1753342897979;
        Thu, 24 Jul 2025 00:41:37 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586ec63d29sm13108555e9.1.2025.07.24.00.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:41:37 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sre@kernel.org,
	pali@kernel.org,
	skhan@linuxfoundation.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH] power: supply: bq2415x: replace deprecated strcpy() with strscpy()
Date: Thu, 24 Jul 2025 09:41:33 +0200
Message-Id: <20250724074133.33637-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

strcpy() is deprecated for NUL-terminated strings. Replace it with
strscpy() for revstr (local fixed-size buffer).

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
 drivers/power/supply/bq2415x_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 9e3b9181ee76..fa66d6b74555 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1516,7 +1516,7 @@ static int bq2415x_power_supply_init(struct bq2415x_device *bq)
 
 	ret = bq2415x_detect_revision(bq);
 	if (ret < 0)
-		strcpy(revstr, "unknown");
+		strscpy(revstr, "unknown", sizeof(revstr));
 	else
 		sprintf(revstr, "1.%d", ret);
 
-- 
2.34.1


