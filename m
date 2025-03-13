Return-Path: <linux-pm+bounces-23972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1CCA5EF4C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 10:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 267D67ACAA6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B292264A9B;
	Thu, 13 Mar 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqQpr28b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F1263C9B
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857253; cv=none; b=bl8z3lli6NCFrg1i5gnquVkMO8ix7Mcn3URmmNWj/QUhdcJE3wKQnjnXGhC7tfYgXYv0irxWa3DsDeBl7Mpq7rnQJVHmf07CSJTlk4B7Yigro9FCNsgLWLT9ZFbtwusXnkJoByHRZik0YbSgnhbLX4ciEQ1G6HCT5hprxfrgQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857253; c=relaxed/simple;
	bh=LKuINLvR9AokwKtQ0i0k3u46oD1MBrKVji5Ygd0Sbao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iwl/Gso7C5yLMRXD9POvLiKOXexCWL/BYwlyViil5Qc7RHYWp+AtMUpuD7e9B3tS//Qf3yb+PHEUmmdoLmF/xQ/6pUQEBoAK9UrBS4uGmEISS6ddqCp1N8rfQiNRqt3RBCR0fhEBRID0Y0Mx0s7o6Vkh++4YocVsyspUBIjPaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CqQpr28b; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7098af6fdso9493066b.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 02:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741857248; x=1742462048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5PkfWYyLQ7CmSIcBpOb+fP0/u9MUfqLHtzcFlzAIW3I=;
        b=CqQpr28buO5sfcUflDxdAuZB5SHl0BboxR+vgT18PrFpX09ljzkEnnGVFK9fpi3aLU
         kdsl/1gm7lGLAc9yPAi/uygWY9+m64x2gdmtDBEb6QI50Kpxj+kpdvcMqm8LGqr3ebnt
         syrsjIYc0SialSMQ5QsCKbfWxqmLN3TXtRvvhv7FKIw006zhsABHVFaXEFYgpiqewLjZ
         MbJdSJvWd8/T/HXpTqIFqOwsCYsRXE9ZxsoNWxonaRHzzbJMS+l5CkmIdTsAUdG81HiM
         o2DSuVyz8HOd3YsNbI7OnCvrkA7dYvGa3hs0Ru8tUStm4mEVhLzwfbAVjLAX/I23rOPh
         yzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741857248; x=1742462048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PkfWYyLQ7CmSIcBpOb+fP0/u9MUfqLHtzcFlzAIW3I=;
        b=egqzLwaL8B3UW5ZCHwJVUFuvltoYJGrZb0oXYtaC0N4pxS44GKOyr9+lVApLz8wBKv
         P7rYBea2aiO9sBhJq8L4y4YMXIDj3XDvtf99P7Aouz5oLF/4qjB0pk8x7w5Bvz991btC
         qI/tQ4fiGXdbOnGUK3V8makv1vhQNyl9oCbbZL5pSvNm1HJsWWAVTbccvsO+NA4yKgQn
         Z5EGcCAQ/oZsXSKnl+cxqKV+g/N7WKAoFKNrNvcUBW2jjKXqO75muSItG7/b57um0QjT
         zyD0B9xehHUpRK3ylYZCU/AA1bQQbcV4ckVirGIJBd12i3jnn0wfaPE4IeSUWsw420VY
         8nDA==
X-Forwarded-Encrypted: i=1; AJvYcCXv8ivQt3AQLrgo3PbJCC8oF/0hd8h17l7aLIEeNG4rTlkj+3hM8jpXFQJf0oo4MkjcApBiLolGmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NmG15xobKb2BkKxZrBeCP/AlTR46HGI3w1v2LzwQDdx38PQD
	cf0TZDJRRrcXN3UKp+VuRzFlohKrC/YU+ZJ5ksEDeYRZucZA0caM4J9KTZ9IvwE=
X-Gm-Gg: ASbGnctwV/EypWXX1SdWxJoHfLZzDmkkBv8/fuYmD0oEA9nlc3J01mxdeoK6WSRwqNa
	6MUszWESFQPPT83aQ3u4kw4j+DvAa21bxPBN6cJhGqwOcwDAzR7bkwV+RQnJDEE1+H6NSIIUcE9
	/bB63ONrYzV/YWBLH2DwDCyxJRXupYj+5WflAlsfie5bJptiUoDFu2uxP6a7p+SSvYt9C1ppQ5W
	/lIKBhm+xyhl/QFnfI6BREVe7Kp0+WOV6/aNykHR93kpGY2EQmbJT56ZIjXChdgWbQ/wGOVamx9
	YheqU1DIrLTfaEv+OLsMlRtNgAaVRErnrBQSog2I261//eSmK+HcvL+qgg==
X-Google-Smtp-Source: AGHT+IEqYE3xmRAC+FrB/kFJGQaFpMK3ddVVqQK87lG/Lu5OOCAf0iOzDDllrv0hIcMtoiZEWlJkjw==
X-Received: by 2002:a17:907:60c8:b0:abe:9c69:a7ce with SMTP id a640c23a62f3a-ac271317c2emr869358866b.1.1741857247978;
        Thu, 13 Mar 2025 02:14:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9ab1sm57803466b.52.2025.03.13.02.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:14:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Len Brown <lenb@kernel.org>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH] PM: MAINTAINERS: Drop Len Brown
Date: Thu, 13 Mar 2025 10:14:03 +0100
Message-ID: <20250313091403.50077-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emails to Len Brown bounce with:

"If it is importnat that I see your e-mail, please let me know via
instant message."

While I fully sympathize with above statement, I do not have Len's
instant message details to ask about patches and unfortunately email is
the preferred form of reviewing contributions to kernel.

Last email from Len was in September 2023.

Cc: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Or entry should be changed to @kernel.org? Not sure, I assume it's Len's
intention to use that one specific email in maintainers file.
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67bfd9109535..68819df8e398 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23125,7 +23125,6 @@ F:	drivers/sh/
 
 SUSPEND TO RAM
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Len Brown <len.brown@intel.com>
 M:	Pavel Machek <pavel@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
-- 
2.43.0


