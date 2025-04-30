Return-Path: <linux-pm+bounces-26439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB070AA42CE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 08:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267D54E152B
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 06:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1021E5710;
	Wed, 30 Apr 2025 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/XTt/uV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497501D95A3;
	Wed, 30 Apr 2025 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992978; cv=none; b=crF7fOa519APrHjeWCiI/TE45W8j12rutlRax7dngqBFJXZo1HxflE5RJpRdEIjADshpD8eQci+Pu7csmzfspLWdYWaG9E0SbpHz4CX4dz8dw5n9+tvtURPzfb+LF7wcyuzqyWG/hFyeR2yF4rZOki/BByTXs0okjgS7hV7veGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992978; c=relaxed/simple;
	bh=DcmC5fvsp3jB7X0J6io2NASGT1X5p+c2Qvw+lvnC2aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCQL3LVTVa5JY/7iXzSp74A+Ct7u/Jw/bD4Uuc3wfHPOBbqb/KB/hvUttE7NYMod8uiEu+Nlz+QyJwJzpi644rjkZgeUoJcIhAVo1cp1nKmOyL7OPIG4faNS53fvdxG1iQpk8OzZ0x214G0mY690wmqwAkJd9Ru+Ttw/1XDagp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/XTt/uV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so3935483a12.0;
        Tue, 29 Apr 2025 23:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992975; x=1746597775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/qMoq+5b/8O/N2mOSCLRSKaChYojjrQQJrWWnq1Wts=;
        b=h/XTt/uV7oSo9J8V88Zg9fTZsp6HCDTvFRw6heMI/oOuiwzkoz2xjfI+joJjzm5Sbg
         +zUA2cH6qjflwKgg7zqXB/O6N02Rx9CoY8FFPiaLX1ASYGG+dYJcg3FVEyFje1fIvYvQ
         MDKPctUNwgVo32Ry416uA/ldKP+lgC+mz+5jnQSE2U89G45bm7DC3Wq2IiQQ1gfyh81P
         1TSDIEha/YqxHAuHreEMMBXrkXNzJELd1H9sAbRK5ZTaEHNRCHQzGAnu9iVIKJDARHPA
         adM06bxtMF46Beweymn3C8FXygR8xv7bIBHYt0CWW3H8ecjrdVM0/fmACOBKP3kVE1Cy
         Nx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992975; x=1746597775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/qMoq+5b/8O/N2mOSCLRSKaChYojjrQQJrWWnq1Wts=;
        b=CNuun1wOc9rba57x/5q5PlvpUzRNJWUu1Svvx4zXhf15L2ILw/7J7xHRNVfRNW3vOH
         eS2+ts+vpHA07HX8Q9cw4dpATD1bsD5wZ1YhapjJkrHjfQ3y+OzFFRaWEsnvvJAJe6vE
         1KguwaOOkfCc1OqUquQclZUT1iXkFJPdPL8+jaGvu/6931fUB/nbTNt1NJqVr7x3nu2Y
         lv4wD5PQ9vs0APbXccdmua4tCNi4EtGHvi/8znCVpJeM8nT+7sdShGEwxipBOIOovWK+
         qadKPRhQJ8p/mQh5WlDaPNKztJdtawgZHCjYd4x66LvYa6AGadkhqKkDeuRsk96LLqZ5
         olqg==
X-Forwarded-Encrypted: i=1; AJvYcCXhV9qfDzoYh+e0zPSThgwKkrtxjg9QJKVuyGR6b9LeIhaw+5s6WYUR9pnq8Rs+hWCVlGwSSjbYIJzNkqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbzxc5LPyi5oklUwiLuy5PC0RJYn85tX5U6Z+VAXntbDWUwjW
	5o4sRhfZUYVpjRBYv9FPdyZNBMBPXWyX6rySih+ieQjvsPwyISUm
X-Gm-Gg: ASbGncvvCA+zyd7vlwLkMCoKalPL63G0KYmgevBvj0Wfuat0vrKGVUm5LR4Rx8Xi0E4
	2j7Bcsepo6CvewUgZhcZYzsLopqzc3Gzls/gRjE93kOFu6N/fl2PKA1PSqZrfWalTYhj2V1Rp0H
	7MXPeSl7+LkWC9h062+6cHlZT2o4nJWT6ijgpGQiSpY135dJ9FTvZ/mgWlIlESOo58RGwC/rjC9
	JeIs0qr3gQhMbVJDK4KBJcHEi9hMLydtrAdh1YI8IzWG19Lhbr3U9ENS3zRBOiHihF0Mo5JGl23
	pUY/XHlD6YjZhchzrI2thFg6NM1hGF+a
X-Google-Smtp-Source: AGHT+IHADrqFXfmbEAjvm635/bwm4atJ0ecQRC8AvwSTuG77KGj1ApLC9n0A8rWQ+qfRcEzfGs5OQw==
X-Received: by 2002:a05:6402:28c4:b0:5e5:d9e5:c4d7 with SMTP id 4fb4d7f45d1cf-5f8af0bcb04mr905579a12.28.1745992975397;
        Tue, 29 Apr 2025 23:02:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f70354632bsm8206760a12.57.2025.04.29.23.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 23:02:55 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	Sebastian Reichel <sre@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] power: supply: max17040: adjust thermal channel scaling
Date: Wed, 30 Apr 2025 09:02:39 +0300
Message-ID: <20250430060239.12085-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250430060239.12085-1-clamor95@gmail.com>
References: <20250430060239.12085-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IIO thermal channel is in millidegree while power supply framework expects
decidegree values. Adjust scaling to get correct readings.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/max17040_battery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 51310f6e4803..c1640bc6accd 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -410,8 +410,9 @@ static int max17040_get_property(struct power_supply *psy,
 		if (!chip->channel_temp)
 			return -ENODATA;
 
-		iio_read_channel_processed_scale(chip->channel_temp,
-						 &val->intval, 10);
+		iio_read_channel_processed(chip->channel_temp, &val->intval);
+		val->intval /= 100; /* Convert from milli- to deci-degree */
+
 		break;
 	default:
 		return -EINVAL;
-- 
2.48.1


