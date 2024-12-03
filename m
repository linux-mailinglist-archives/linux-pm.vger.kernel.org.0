Return-Path: <linux-pm+bounces-18421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CA9E1557
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248132845D3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E018B470;
	Tue,  3 Dec 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nXk+UOKf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E392500C5
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213587; cv=none; b=KzlbLNGLq918MaDrTwNxpfKcC+XMV9VofKM3693tPt9OouQdwjs1gEEU20mn08sRLwtsTGQY/jBtmqjrNLMM0fZZHVoiWivIDBOqnjlYg+lodTNkzXUuofpJb00Tu/dOG4exUyTrziDApmbzh/84j+95Qxp/hLxywMpY7qAHQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213587; c=relaxed/simple;
	bh=JPWjaOiXTdN48AlM8t4R6LupUxYwEDP+YZ6zPJPUfc0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tu3fwqOitfoGD5FVthjigRiVKxwogP2MJWTGhKkfDNWNnphRNjbmrKX/8PhEO1q9ZJRhua43b5AJ3GpC3Pg7R0c98wiWfzVxOHrH+XGOslbq3zivL+VjEEkN5S4TwsUGGhsK8DHi8lr9gXFW1p0vyZZsZf8oHJk5T5uts2XA64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nXk+UOKf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso47821775e9.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 00:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733213584; x=1733818384; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gJyIINfAV+ZImwx5wS9nlG3+eJpCeDhmKh2hF5TMV9I=;
        b=nXk+UOKflcw8rsdaOvHwjME1QD42rllyHNfMvzYmiJ08Gihh2hARcj3nFnmNaRlk14
         JnvRqYvFV5lLevlsnJY4EBao/2v3hcUHDy91JpHrxtaAswgGaj16gkBo46vWzLTb64s7
         pXjB2w+19Lmq+xW4YmKDy3oehdp34qIzQ4SOmIVuia56DG+sKR65gKtk9e3eaqsnIsX3
         MeQj7h2voRl3zkOqiaof5Q3Mw+rP3Bh36HKLeermEb9Ayh3cW1d6KY9CCh+V14CU+bKG
         T8UYgAZF2rgqdOdASaG9gH45/GCgONu0LA3dyFGh7zLyR/2zVdFw1Mke19kTdVsUPX+U
         NBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733213584; x=1733818384;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJyIINfAV+ZImwx5wS9nlG3+eJpCeDhmKh2hF5TMV9I=;
        b=IQ6D/g3MBPNU2l6QaB38CzcvhJZipDM62909PwmaITjJw7OJSq94Rt3qB9iSKj23T9
         0FibRw009LPmtpsRwQwMRGB2qS2mRQdLMWQ6aeDU0UzJ2yKMUX8MnwjW2kLOgeUf6wPb
         9+CEQFuSncwKv5/NdQlGoXUP7Z3FfwrPKlVAKysG22aFrZ4XEaHwn0mNHtQdzFRNR9r+
         0iw4PACA1PvlwMNCrYqWKL3kzOQVsQtU7lvZ/lca5OacD+aZii8Znk5AopWiTrpJ5I8M
         sFU41MGX9MyLRKB1Ux89tpyLdqApIG0GKiG8wvXljMi0K2MGikZJEZ4+BfSiuUa9w7q2
         ZupQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvTb+b1gNQMeDXaB+CO8L6HwNAuZeCFCuoh2b8EnEUcpKWf/g9NERNlKWw0iRPmhSUlRnvnN5sNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0tFTB6XEtSr4nrvI6ujZIDRWJ6gIdd9+kzZu9mHnTCiX1XmW
	2C9xs5UeqtO9nUhCOaU43MvwfweVyXlRn3iMY5TNCkV4JczRrzdFOYBbkon2DzjJYaWQ0xGzeC8
	65J8=
X-Gm-Gg: ASbGnctUCpKjfxjMshxXHr1gmV9BBQfYHt0yEUGIIN8UjGI0l8zxLPOX4w6luGJ4R0E
	CAi50wKLSK+jYoHXKsapuOHT9RgwEFeALlSyC40uOqOEdQRzct36dwN4vr/QxJTw1fQRTHl7NlK
	Ky5JivXEnHliUQ1Z2n8fh1RNR77bIFLK2B+po8cDbFVzreviAzqUQqcKtfWX5GAMe854aJZlJea
	uyBXSpUMw7vMnXluJJvlmXVbmn3E9q/E+iwSpFVraDmQ93gT8NpzlhvJv1uIAPv+wW3was=
X-Google-Smtp-Source: AGHT+IH78vk0FG472+7ptfW6hoK4YGYgu6q4kkC08/1jLlOIeo+45IkzUfjAxkmFwPXUB1HPyVz/JQ==
X-Received: by 2002:a05:600c:4f87:b0:42c:b5f1:44ff with SMTP id 5b1f17b1804b1-434d0a07e55mr12085565e9.24.1733213583590;
        Tue, 03 Dec 2024 00:13:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f2c7sm215212575e9.2.2024.12.03.00.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 00:13:03 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/2] OPP: fix buffer overflow in indexed freq and
 bandwidth reads
Date: Tue, 03 Dec 2024 09:12:58 +0100
Message-Id: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIq9TmcC/5XNQQ6CMBAF0KuQrh1TCgK68h7GRTsdYKKhTUsIh
 nB3Cyvd6fJP5r+/iEiBKYpLtohAE0d2QwrFIRPY66EjYJuyUFKVea4aGJ1nBOc9tDyDjqk/Ag+
 WZsCe8AFtWbV0wgJro0VifKD0uU/c7in3HEcXXvvilG/XP/ApBwloGmNLlEUt6frkQQd3dKETm
 z6pT/H8g6iSWDSVURaNOevqS1zX9Q3loRu+IwEAAA==
X-Change-ID: 20241128-topic-opp-fix-assert-index-check-f46fe5c3c7ba
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JPWjaOiXTdN48AlM8t4R6LupUxYwEDP+YZ6zPJPUfc0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnTr2Ni0nQV+PINxWjxBzwU9Go/nhgIbqH5/4ZxWHe
 Vf1R6i2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ069jQAKCRB33NvayMhJ0U5oEA
 DNPn7CeMPzfL6ZXHPYodOMsJYjyYj8Nm0JxzFDSRLcspYmr58reMZUWFJ1CtgGxz4gLt8Uv1L7/BK4
 8HnR868KC2WjndYNw7T2b/UULkTQv70JM5/dSgE2PzTUm7ReuOFXeZmZrFgaN0zuWKLtNnAwYBUMI3
 eL7V5OZliV16oYT4qACf2Ack/NXVE8hhYcvyKHtn2TAVF1x0HbJYQR4U346a9xjcLOWtz5RXqWCWjc
 W3K1jFJhl3PG6yQLBe58seA5yDn09UMHNlPUN9SyCUGZRn+R3+2RRFDX+TIG22CfOkhB+AioWI2Dv7
 5OiBR5vcHtUg1furEgdR2u8oet0YCBN0e7st/1lxv+x/dwRRvh9BEEuQCoO5T0jWXAE9ys4Bdr0Hji
 YPZaNjcrsf9dAPls8Yb/+7mSkJ8NJEUpbjVYXvwL1n+3UqPvngCgmpIlsCTPGShEKpUm5XvG9/LtMC
 icfoRRZPKWlzn+4f6kfbRENrFkMaCRY0MfsNs5wx2n4rUvCUBXN4IPOTr7y6Bqn32k5CDF+EEbmaJ6
 NKIAK7MuhvYIzJ7NIq5rWQcXVv2y3bHG0PgovBC3mSREVSekUHRb7CO/3TTFLO/p5p+GB5/pg/Dp7R
 EfsCmn0imSq95tMFoGNFS0ymqGMqQj2dTxUxiABQHVgLmQ1aW4Z+HiTsa39g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

While fixing a crash when calling dev_pm_opp_find_bw_ceil()
because the bandwdith table wasn't initialized, it happens
the index is not checked aswell for indexed freq finds.

In order to properly fix that, pass the index to the assert
function and add a specialized assert function for freq
and bandwidth.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Use unsigned int for index on assert callback
- Link to v2: https://lore.kernel.org/r/20241129-topic-opp-fix-assert-index-check-v2-0-386b2dcbb9a6@linaro.org

Changes in v2:
- keep existing check for non indexed find functions
- use assert_clk_index only for indexed find functions
- fixup commit messages
- Link to v1: https://lore.kernel.org/r/20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org

---
Neil Armstrong (2):
      OPP: add index check to assert to avoid buffer overflow in _read_freq()
      OPP: fix dev_pm_opp_find_bw_*() when bandwidth table not initialized

 drivers/opp/core.c | 57 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 17 deletions(-)
---
base-commit: d5557b27fefccf1942ae0f4a5734aba6751b03bc
change-id: 20241128-topic-opp-fix-assert-index-check-f46fe5c3c7ba

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


