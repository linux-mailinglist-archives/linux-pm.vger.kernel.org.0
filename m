Return-Path: <linux-pm+bounces-34232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7957B4AAAA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 12:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB81635F5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 10:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0831815D;
	Tue,  9 Sep 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZh306tf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF1317709
	for <linux-pm@vger.kernel.org>; Tue,  9 Sep 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413797; cv=none; b=feB0NXYwr5Gais+XdtTXdt6N96uhSJ/OGRi4XCgYSUPWytNIM0zIi6klvbRlW07KBtcxI487XRDMEK3ijW9mKIdK7ABOZmCtkURXdL9JCy5I0Ogou9stwZuZW0W++2mpTiHHfFbdVfF8LXzTi9cFnSoDyOKq9Jqb71rrSlaa1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413797; c=relaxed/simple;
	bh=IqiYlfOVbQa/zh50FAoJsm1nVp//uGooPnZlzF1wXek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q1qSkjomLz3+IpSo14LIenD+w5NKjx/krMwGegKc7+tXjCTjmYVa4FiDttXGogWgNaCL/6CZ0ZpNZU6ZYJ10FwDOwJEUhuQj66Odu/uJnaJCpzCpkrusd4MJNWcvps0pZqrc38JNjjv2vD/qZlI0Mq1URv0mIChNp30hnqtDK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gZh306tf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e249a4d605so4357479f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2025 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757413794; x=1758018594; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6DLuZEXjLVaECtCo3C0mHyLZL5DvcGRCHNBQ9l3dvw=;
        b=gZh306tfVI/Vb6F1+ICCiJ9FJjx0eiFQXdGI4DoGVqLhUwulNgja9VOsQU7+uZfJ9u
         fzVbWmAW9b2zEVSBiBsYOo7N4R1FpzA60DV6aAVjL3mdXZstwfuZFgUW8spzERjZujH2
         Y0eRPRLXTc2ftk8i1o/Icd8PncFZ1Jci6cO/626B3PX1BZAMsFj7DISE7mNdFWWdwJSM
         xOV3b/CmNs77mYv5a5zqtEjo26F+3AkpIuv9Z+renrVnoMS0HTVsre+suwZcpgHMJFuT
         hgjqSdnFN4ZmoIfcRBwfKsciUqWYSNeoe9OOAxtpSq9X12eu34zZKpB1O4SKAca4vcie
         ikdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413794; x=1758018594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6DLuZEXjLVaECtCo3C0mHyLZL5DvcGRCHNBQ9l3dvw=;
        b=vEzFAP5syXCcywNJkX0TpJ7RvjQzmsvO56L3HisdM6T+MzE28vfjup/qYkkT1Y48OA
         bBfCk6/lxci5sfhoOmSE7nAhFYzBgw1zbazvfru0q/JGmYImBjvHPNn/70n3/PXBcuq6
         wwYj4M20qd1EB7v5jhon2n2+2my6G1fPEK4QGQUCZVDB7vMdH8wusJJ17xqoTC4qc/BK
         c+DdjCiF19qFsSIfd7ya0TgScFI4Kd8ahC0c7mhOL7CdOk21pMWs6ItmCBPqFDQDpUfF
         8WEQaVewwGuT04qtyh6fRaJF1FqNiPK7snEXDUjd8LWDLbz+sYWiHIIrXn7ZuhK1l1aj
         F6Og==
X-Forwarded-Encrypted: i=1; AJvYcCXIBCzj8ClI6InjwaZX1la0JQvLEXkkHHnNZw/jTRAEoH2/QMYeKeuILeisqpEctbx52PgUitnwIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tgcBPI1wBe6Zx8DomvKXE1XFEOalBxiAVQUUG4pAibbXJwNS
	3SGvE54Me5YO71CjoG8PSFP+8lTdqzwnN+vTUR/ofw91pEhzoiubSCrUyRjHvkvw019b6QH2URd
	BnXwk
X-Gm-Gg: ASbGncucrwDVandvrA1WDFe0j1CH1zFDniAJqSO354kMqxS4fqyTqAlLnLwUoytg5LO
	YY059+n5uVCZo6HS8n4b56lhmvpF41KvEve/ahthoRwKBQDLylrCW1/TGggsOfOYhsN1Ty22Q8F
	f+w614+3AfZyIh30mJOUJHkEvcmGQRWnFVu1DdvlWdScFwPU2Z/chqkbRU+yxEp1jSGR+53JuM0
	eHm5u1mnO3RSWUpTOwbxyb+s5irO+GKP4/CeJUWyJr1jgkX0iIMBa5eKWfTiK1tt2+w4FZR0+sH
	fdO+9lgeooRFtZcDHVduACwDCIvGuOrwI7kzRmI66wLihTnOor9bVwiZ3cK+7cSgZGFzXCw/eDT
	HhMc+EC66sjtNacmnw3ZM2XZpDKY=
X-Google-Smtp-Source: AGHT+IFdlL+stSgluJu4iHh99463lMmfzZUp75gWa4DtFMccsEMf3Hiqt7K4aEcp6FbjhSixFYzjGg==
X-Received: by 2002:a05:6000:612:b0:3e7:484a:741b with SMTP id ffacd0b85a97d-3e7484a77efmr5916594f8f.41.1757413793883;
        Tue, 09 Sep 2025 03:29:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45cb5693921sm289899335e9.0.2025.09.09.03.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:29:53 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:29:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] PM / devfreq: Fix double free in
 devfreq_event_add_edev()
Message-ID: <aMABnic3SVnYMvGc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The put_device() function calls devfreq_event_release_edev() which frees
"evdev".  Calling kfree() again is a double free.

Fixes: 430a1845c804 ("PM / devfreq: Fix memory leak in devfreq_event_add_edev()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/devfreq/devfreq-event.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 34406c52b845..70219099c604 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -328,7 +328,6 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 	ret = device_register(&edev->dev);
 	if (ret < 0) {
 		put_device(&edev->dev);
-		kfree(edev);
 		return ERR_PTR(ret);
 	}
 	dev_set_drvdata(&edev->dev, edev);
-- 
2.47.2


