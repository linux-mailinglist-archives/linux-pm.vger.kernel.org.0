Return-Path: <linux-pm+bounces-39100-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5ABC9CC57
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 20:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E7A3A8FB4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 19:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DA62E093A;
	Tue,  2 Dec 2025 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="adyFRq/J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190892DFA25
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703904; cv=none; b=XmzyePynhcNsoTDMBf4vW0ZRSPVLQZiNsWnc1nmjuiB9dJunpGQc0XvTuGttd+3xfd6w96PW/ADrNfsXHqBGJWtEac+CLg1RRhxwT2O/Dk3vHtJIOgZmCks2WwIChl0s9CLlLkeqDzkByH3l3YIbR573BeJVx6AHES8EHmf0QXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703904; c=relaxed/simple;
	bh=MdGKNGY/WNxvsera4vzc/GxYr/TNLX77d0jQdVSW5rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jf2szN/wqrwXuJLEO+aTyLSXkYBgS5/t3VEREabAtn4HsWLiHMjQmCrDC0kDwExarsMewDnEqjWuFsxd0ha6x0+qcP0VYPM0cvwAQq0lT5cadEjORnrKRczqCYKy/R/C3sIVO99KDzcnOQPYHESlgKqZ2f5EHgguSSL698xTm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=adyFRq/J; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bd610f4425fso3460514a12.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 11:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764703902; x=1765308702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AVvEyvWC2fkEJL3PqyJSguhBu9IhDhFSy9YM6eVTZ8=;
        b=adyFRq/JEvEm8xytx5NtnMUC9YJ7nT+r/42YoGWYlvvz7PeTjg6LhwLj9EL2cxfY+q
         2wRyD6SV//tn31kjaZGYwzUZHzSnBFbMMx2EGXrcw/h5zwKof6jb9kInYQjU2fD2N0Ub
         6A4o9j7OQNof8UtSpBfk01BFsQ1YofpLAbgy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764703902; x=1765308702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AVvEyvWC2fkEJL3PqyJSguhBu9IhDhFSy9YM6eVTZ8=;
        b=iv7dpoxmZFXuFrrKw3A4HTGlUbVNNNpWQ2mGbJjDrKKtACJkBTjEYhaoDZlQ+3Q/rZ
         GCIq5BzsE5tEsG8WX1xaWrYeo99ru71UWk+YAcxkNzJe+TGzcNFmRZ0bqQ2eoTbKmqa/
         J8cm02Tp7944hMR1wlLeCZB2ho0RTkINlKhgVKNrRRO69RYGn4qrR/UPWX2t34JIsmTk
         T+bKjqWD/FftHNeUfuJokHX7is60njNW1R2ZWYLFXwgYEULNDzvvqec1b8tatrHRm+rP
         B/2rIv9KDywrBgj6Ypo2Q4TSRu9PoivezIgoujDRB8J2V1W5SxnBB+o5F1BQQkxLgMm4
         Vwng==
X-Forwarded-Encrypted: i=1; AJvYcCVjIJpnsr6HyPErEgCNfaxAmh6dBtBnSGy7WDN0GRkwez8TLa4iZ323D3ryehzbOhQIpGWsoPy4sA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3bwQ74BHy66LhJ6UQuFmMYtKFe7CDHQAgk5iK+3RPb/jZd1Ux
	nQ2k6y+qycTqj1G+mDBrrUzbDUWok9mbGp0u11+esgDaES17S1LktXU+3W2Polptxg==
X-Gm-Gg: ASbGnctpKOU8TQxQ732VVmxmaZ55vXnPX2ePmErYZtQBiL6Z5gkhTurB5GxpCbUs6Cp
	oUboe9vvXz4a9q9tMisrMbki//0Cb9Y0VOdoPkC2Q1/aiNcwzfi5EccaTDvdnOzv0Pe60x7A9Od
	pw94Og5B3OxA3CvpqGrFN6Q3YjD9LyyX3AuILk+LA244Lr0Z5YskY6UqbXCf8SCmPNY6QGvjPYP
	fbGGhqrdMZrzTO7c2z1GqINwaX6zBO5Oci6KnTBOTRiGaV6gBLiyYL7k/qxQhHQhYNI3IY+FTHa
	I2e3DCB7rIFSDgAqiJiYJQQ1gPcGlbxHhDiC42Op8HIF5SqjgTDm3zJyWOEa5q8hmUN6IeOE/lE
	zHber8RhuMQfq93NLINbKcQA7U6DXjPcxbgrz/C8MqX4osr1uF9wBn/wPihSUouo/4IY6mhIihs
	Z7xMJ+rgOVAOfgc3SeS4hLvgZDcTRtZ6C62Z4iwucIg7vcyyufGw==
X-Google-Smtp-Source: AGHT+IFlEs5RNDUI+Ae+Fm5enXUxDsZ/Kn0ynDmaIrBeKwQbRekMa0hOru8vRQqFZBYSBtOCQg82QA==
X-Received: by 2002:a05:7301:dd84:b0:2a4:8576:abf5 with SMTP id 5a478bee46e88-2a94174da37mr16919602eec.23.1764703902305;
        Tue, 02 Dec 2025 11:31:42 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:eb2b:1140:65a2:dd2e])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2a9655ceb04sm56575977eec.1.2025.12.02.11.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 11:31:41 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/3] coccinelle: Drop pm_runtime_barrier() error code checks
Date: Tue,  2 Dec 2025 11:30:26 -0800
Message-ID: <20251202193129.1411419-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
In-Reply-To: <20251202193129.1411419-1-briannorris@chromium.org>
References: <20251202193129.1411419-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function doesn't return anything any more, so the compiler would
notice any bad error handling before any cocci script would.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 scripts/coccinelle/api/pm_runtime.cocci | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
index 2c931e748dda..bf128ccae921 100644
--- a/scripts/coccinelle/api/pm_runtime.cocci
+++ b/scripts/coccinelle/api/pm_runtime.cocci
@@ -37,7 +37,6 @@ ret@p = \(pm_runtime_idle\|
 	pm_runtime_put_sync_autosuspend\|
 	pm_runtime_set_active\|
 	pm_schedule_suspend\|
-	pm_runtime_barrier\|
 	pm_generic_runtime_suspend\|
 	pm_generic_runtime_resume\)(...);
 ...
-- 
2.52.0.158.g65b55ccf14-goog


