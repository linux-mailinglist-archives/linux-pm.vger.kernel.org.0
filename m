Return-Path: <linux-pm+bounces-333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26AE7FB25B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 08:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DADA281D21
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D711726;
	Tue, 28 Nov 2023 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrkX1gFF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF754197
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 23:09:14 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58db7d8f2ebso31711eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 23:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701155354; x=1701760154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DfVtya4RBsfO21aPZQimz87Ty2xKQDd/O6zJS+ytuc=;
        b=BrkX1gFFbVKElH0gabTl1nw2cvkPGbYPoO0dTp39wLntPiyY/Xi1yew3opTJe5gQSl
         prN3QNlqBWAv1rPjoVsFHKS6Oqvn6ttSfEvsN0zN6fomGBRdulnfGHcYuc7Sr+xGpscN
         H5siQDf6kJ5YQa3D1VXRlpNs8hGc+kv7Q7wn2UGmI1P8opQWUtZNi1pqHh0KfCrJnzE/
         JDhmQa6gKg/UczkneuvHC80zEjF3gQIWTRI71N7oa+ADOEDbC4WyjqiY92ipLUpoVllh
         lQZ/YGVUBECVbtItcf8g1I0F88rtK8t6Z9Wb8GyjH7Vpku7U4wqZGW6De/jHUariA5+q
         vQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701155354; x=1701760154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DfVtya4RBsfO21aPZQimz87Ty2xKQDd/O6zJS+ytuc=;
        b=hs8g/FlGdRlmitmXet6Zdr5o2UZxpVe7KB13sxDw8XdP6cwe1oMN6mXhEs/ChctHkk
         u5KiLQnroZQlQzAdWZM110frvRibAUP3/2fMlhCj1i6vTHalq/qdeHxY+90y9MqD7JH6
         iQHQSzWSieHn4/NklJV3WWwoJ3PA/6yEvHlHyhhZH2N8RCbKy7D4ri1z0D+ymD9kBO7T
         FRzoeVsky3UxdNVt55c6tYxxvIE1op0GHFRBMDwSNMEA0WnlP5fKEakwu02AbzUbgETc
         WDD3szJRcDS9u0WS9fz4f2SyggyLSMU3QAFo1f11CFneT7pYV5x1sbK644aOc5/gVJpt
         ekMA==
X-Gm-Message-State: AOJu0YwVTyH+3stY2YnpH5DSSCOWwPFeYprwEcRFB09lSvYO2g/Gb/Dq
	uKtk87h0NEJ9j395zCE2KRL5zg==
X-Google-Smtp-Source: AGHT+IH7FQgKd0fBaTnW20DKZfN/lO92e7D73F9a16o4SUVO0itFXdjiYg1ryLnRHh7o+XxouhfCAg==
X-Received: by 2002:a05:6820:60a:b0:58d:9c58:428e with SMTP id e10-20020a056820060a00b0058d9c58428emr4726750oow.5.1701155353956;
        Mon, 27 Nov 2023 23:09:13 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id o18-20020a63e352000000b005b1bf3a200fsm9070147pgj.1.2023.11.27.23.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:09:13 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Check for invalid OPP in dev_pm_opp_find_level_ceil()
Date: Tue, 28 Nov 2023 12:39:06 +0530
Message-Id: <51b7d5dec3d4f3a677b355b12fac9dcac63828cf.1701155328.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

_find_key_ceil() may return an error and that must be checked before
passing the same to dev_pm_opp_put().

Fixes: 41907aa4ae37 ("OPP: Level zero is valid")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4f1ca84d9ed0..c022d548067d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -808,6 +808,8 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 	struct dev_pm_opp *opp;
 
 	opp = _find_key_ceil(dev, &temp, 0, true, _read_level, NULL);
+	if (IS_ERR(opp))
+		return opp;
 
 	/* False match */
 	if (temp == OPP_LEVEL_UNSET) {
-- 
2.31.1.272.g89b43f80a514


