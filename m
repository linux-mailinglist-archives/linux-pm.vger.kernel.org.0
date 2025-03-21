Return-Path: <linux-pm+bounces-24378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57224A6BD0A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0007A7A8704
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB06B1D5166;
	Fri, 21 Mar 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUmRVEEP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216A1D6DDA
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567656; cv=none; b=CZF39nC97DgkP+JBfpR6rBv0c+z7dgx6C0lvLzpdVaF2cP7gMwyvjyr3xYrtyUeqPYsdHj3mCQxTZV2foUcI+xYdGJbPKAPLVmOM6yQ+oNkRerKo1kE3s3IvXiLWwngPn+cc7MG3gnQjajJd4gChcH9tT7oa0LUKNAx40QYIOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567656; c=relaxed/simple;
	bh=6MoXFu4CLfosp+15aOYuT+yR51crnXpBLzFRutHhie8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VyEZ5/bW7PkVrX/2a+ByZmok7nEBjk+JbZvhNtKKCWkbCDKJq7O4aP6vcF5uqudUkOQ6yEaJXl7DhCuqxrILOI8zwMr+V06V8J4TVBnnYgwQmwnZ2K4LoXJfFdNmzh6sUe6ummWcyr+5QZaOP0bdfBYpHBp77qWxXyIvVaW2Wv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUmRVEEP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39133f709f5so1119915f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567653; x=1743172453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kqVdYeLxFWfGG4ab3N4AIVapOQ8iQyK3/JzY3rIwWk=;
        b=gUmRVEEPhIr9cMyEt9TTnQUDVTF6Y4fYxaJtt6CpdVuuPkcVNKGpOtuihXBBJiCGp/
         dKjmlXbJENFSZ+XKYLNCULG7J82lE2nzQTOwbCiQe4P2tfTKgP2UBT37YzsieV2eDt26
         fwyRdLoZv8eI0wMeIKJJxaCTb9OaD8XvNn8ufDRaHZzX59//FezpkUnRDUIpht4gJg2r
         3d0CQYXEBD/VKUBED2fUAOEVHoxgoXp594PNsTpddcDxKfh0/ErDwf0ake0tfd7NdnPA
         g4wiJazFluguLgv8v7JoWXGu5DYNytca4Ept4C6fLUyuPgwo7wGtndW3PzjPIZgQd6h8
         eMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567653; x=1743172453;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kqVdYeLxFWfGG4ab3N4AIVapOQ8iQyK3/JzY3rIwWk=;
        b=Rxl55V4E9dIgqfpEu2xkZIu/JrqBlnPPiPE+vnPVDf0BSr6AtejG8TTAxEHplzgT06
         /YP7nTCQZKzuY+sjwjGyNyV+5lapXlwocgTbUD25c8cb0c8Yei0kDZqRJpElvQw0U0oj
         XFiMSm85ZWd1pxKglZqF9k7lqgnrkB9hnov8vgVZ1DRphYzoOSNLV+Zq2TMYefw21YG/
         NjlL2zcbvyE8JrdC5Dz8pXLJ8nhfXLaNk9ujB4AyG24M1m5Cuk0qfnz55hoz1OEYkf3p
         TSTi/PeTZ18ahawGW3HIzACmkjmKcoc19Sb0Fxk7bSWdJmAs4OhwjkGkyzPz7QbW7Xrj
         3/7g==
X-Forwarded-Encrypted: i=1; AJvYcCUsiWHhkmGMDz0k9oK1VsYgWuR6if8vcCK3koEmoZVT5luqK5VZpIDvr6eCkZvjZvBk9j9xtQgAMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0jk2RDtkN/lXwB4w0C42DGwjbEOsK4T4neXPOVvcHD1ez2ld
	pLbfrUUS3f9xq+bI8xq2a87WXZBXDqkD0PfCcsrOSeXgMzvCw+gvvB6SZjIbxGE=
X-Gm-Gg: ASbGncscy0CQZt/pokHhhLWs01qG72k6kq2yoY1358oWAWvUvr/B3cBXMlhXKmyQlg+
	4EFufAcxBcxSwwbA6EDfYEYC8SRSpDUWayNHoNNS7vAbXtfK7V9PsnhTHkhzJXK01SEL6F2HkJe
	mpgPZLmNEOsbibv9YTOJtATvJxoHvO7PcU+eJfpm8/PgVBJc/MOFJc0riTQdONLFWHVSVgewCCi
	+Ui4EsDksbuug9ye8FZnf0a8RbFR6QmX3Uh3WPLHm/UcBSkBRoBfbCPXKxwyZzkCy5rRzc8gTso
	1q2egCvgWF27Kak71WLlAwhd60Xg98lqGKWQm+2sG3MPdtCujQ==
X-Google-Smtp-Source: AGHT+IH3J7mR0ItKLtQh/BfAHr2Qv0TD83WieWbRHva+BSl455obiV7i95/cpX3n3cQBcn7spSf0kw==
X-Received: by 2002:a05:6000:18a2:b0:390:f9d0:5e4 with SMTP id ffacd0b85a97d-3997f8fafb1mr3799744f8f.21.1742567653378;
        Fri, 21 Mar 2025 07:34:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f99540bsm2503365f8f.2.2025.03.21.07.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:34:13 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:34:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: supply: max77705: Fix error code in
 max77705_get_health()
Message-ID: <0ea50e87-2b63-4062-8c2a-17537495f481@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f55158-1776-4f2f-9296-e307e83d569a@stanley.mountain>

Return -EINVAL if the health is bad.  Don't return success.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/power/supply/max77705_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 329b430d0e50..0e347353c41e 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -285,7 +285,7 @@ static int max77705_get_health(struct max77705_charger_data *charger, int *val)
 	if (is_online) {
 		ret = max77705_get_vbus_state(regmap, val);
 		if (ret || (*val != POWER_SUPPLY_HEALTH_GOOD))
-			return ret;
+			return -EINVAL;
 	}
 	return max77705_get_battery_health(charger, val);
 }
-- 
2.47.2


