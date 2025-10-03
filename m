Return-Path: <linux-pm+bounces-35685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29882BB65DE
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 11:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35D4F4EAADB
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254072C21DF;
	Fri,  3 Oct 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yui/FdC/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4740B28C841
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483779; cv=none; b=uCDd/iVxNTXZR1uAYhsMd8OcBosvsDG39cxINWg6o4YLaPBHH7Zm3tioztGw5KvqxfTOsGa1uHqY1PKqplSFmxKeuGnxyw4dLtOC3AK3ebuGYebuAngAfIJKeb8LYn6boGSttoG9SqfRJG6mh7CbeBhbcI3F9eKQvicOwgq3nd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483779; c=relaxed/simple;
	bh=+vdEmMVTHZadaETHiL90NT3fUNKGtrfQcPtzSKVtkLg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wya7JnF2r6WkN/aMfLyf5P6YsqVKKQK6AJ37NKtZXhoLrh3Xx7nyIeNw96h5RFL+ZeH9RjknBnFMJwktJnXYXNllXBIAKvRItLtrz1JQ709HcA6BMzLN5D5BcWVrzzOi8IIPBWHJqgUdqEkRdYBN0FFnAvnfhsMSwzO5UWJRWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yui/FdC/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso25554505e9.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759483775; x=1760088575; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mrdVcJnH0ez8wntENTM0uG2XQe2LXopmlQUtIl/gs2g=;
        b=yui/FdC/d8hgGYvQPlc1DfSmXawI1bxx08nHGYm2+n8ZWgG5qg1W535jwmx/1W25B0
         pSwnkCE2fS4TxpTHiyhIs/4CW4jXiq1BofZzs81sG2a75ZZF/KGXYNlbxh9OFxoBboSC
         ATNJR9s7K8ohq3LhjthY7BI5RRnrcX+jdYPNmNgggU7YVcO8QRPn5c+RWFxoKHARs4EZ
         vSJoO/53S5XkRmH6jz2I/ttZE/lVToeB62ziIKFbNf5HXLWqinJIKy+r+JyPEGOickyg
         EgnMJzMv8i7uJafMX8H15SnCNrfIs12n1jYSmb4+kPW3+PT9ZgK83Fm5qm6vz5gU73DE
         7UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483775; x=1760088575;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrdVcJnH0ez8wntENTM0uG2XQe2LXopmlQUtIl/gs2g=;
        b=KYHlR23gFMczIxFRm+hg+gmtbQ1biloII2IjHpjFU8mE+brlLDrUAqaaDXK2sfsufw
         z3S5xfNRYKnE9OYXY/SJYhuzSaUml+BTl4HVfq2u4L1XBEOGycJ37KtHKEi2hlZx0XqJ
         U0ZcveVUtJR1R5GwdXQdeDXosh52vAGHcCWKG5XifVheQQ99Xcc1XFBOnQBlhv1Krxft
         fyJFwDqxKCKr9rpoG+0Lry2HkR08upIWKx/sEW8JdgNx9RS9qtuvG6kyVHxhi2fZLtVO
         Cc5aOfj/A1aGqEGL3NdKduG8aGnoqX5VdDz1S6xzmvfpQnEiEAIUmAPFmdj3zTBM4xKF
         bfLw==
X-Forwarded-Encrypted: i=1; AJvYcCXo0OGGYlLCFSy60IjXgKMXZ5MbHIkyCmOrJBaP1BesBGV70Y/9xuwiI8o43toeocP4QG7zI1Wmqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYacexLdE63M8a0gP8ONqUZIXGc3RsQjzzIQZFlwSL31cuatV6
	StivOmPmvdmUGooklYGR59rDnYrBf2HJdSWcALd/Z849Aiif5bY3+PswIvd1K2jF0do=
X-Gm-Gg: ASbGncvnREN6XZFDrHweAYzfbZAy06icIeJPOJ3ZRBWwkTS6jp0k7h3gzPQPMnugmS0
	eVY89rk+rDXzIwA6FEalE521U1Ebi/6osPm/zCxjXvkq3HSNzNEqb9qrq/6V+w04xl2TFdujLdC
	JLyTIXN6NLxWyZN0pAcrPxLhEgwXjygDJ+YsRjwsdP+LtN5xGksLmnna24XQJr/hB+moBjZnOYy
	WgzXwMz12iHal5ZmRN2BYaj7B/CIlWk47c6rVh5Rkzlq35HoYqA0VyedrnvKDm8t2ylkGQ3dm4D
	njdFDZkOFaVeLu76LkL6JwfNEdAgs2m5nBRiWaF54tVJT60Zxmjx1fgs+wmu5UEWbeHuc1417qS
	ylRUfNJl5KlU+1E4mJVpUdqnoVWdq78YamWk8nTYEM0Qj5N1LKLojlLkR
X-Google-Smtp-Source: AGHT+IG6tX4ZZBiVIKE1UgKL2V7cxAUZvSbg/e0yGhSGsaSkg/4tX6nLO26JEwdqDcT0Cju2Zjht+w==
X-Received: by 2002:a05:600c:354a:b0:46e:1a07:7bd5 with SMTP id 5b1f17b1804b1-46e7114e5aamr15201675e9.29.1759483775243;
        Fri, 03 Oct 2025 02:29:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e72359e2bsm23175955e9.13.2025.10.03.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:29:34 -0700 (PDT)
Date: Fri, 3 Oct 2025 12:29:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] PM: runtime: Fix error checking for
 kunit_device_register()
Message-ID: <aN-Xe4lgox1cCAaR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kunit_device_register() function never returns NULL, it returns
error pointers.  Update the assertions to use
KUNIT_ASSERT_NOT_ERR_OR_NULL() instead of checking for NULL.

Fixes: 7f7acd193ba8 ("PM: runtime: Add basic kunit tests for API contracts")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/base/power/runtime-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index eca9885e807d..477feca804c7 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -14,7 +14,7 @@ static void pm_runtime_depth_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	pm_runtime_enable(dev);
 
@@ -32,7 +32,7 @@ static void pm_runtime_already_suspended_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	pm_runtime_enable(dev);
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
@@ -70,7 +70,7 @@ static void pm_runtime_idle_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	pm_runtime_enable(dev);
 
@@ -91,7 +91,7 @@ static void pm_runtime_disabled_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	/* Never called pm_runtime_enable() */
 	KUNIT_EXPECT_FALSE(test, pm_runtime_enabled(dev));
@@ -131,7 +131,7 @@ static void pm_runtime_error_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	pm_runtime_enable(dev);
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
@@ -214,7 +214,7 @@ static void pm_runtime_probe_active_test(struct kunit *test)
 {
 	struct device *dev = kunit_device_register(test, DEVICE_NAME);
 
-	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
 	KUNIT_EXPECT_TRUE(test, pm_runtime_status_suspended(dev));
 
-- 
2.51.0


