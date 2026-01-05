Return-Path: <linux-pm+bounces-40207-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C26CF4447
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 16:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D143110C16
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162502FFF88;
	Mon,  5 Jan 2026 14:38:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB32FFDEB
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623887; cv=none; b=a5f4swPbRgznKlMX6eppIEaPIZhf8nKh0JZfjvjjBjZ16Ce5RLmI3gOgNgRy285+w9IuhpProkjzHpACHoKihZDq8xQbxxRLCT+uDGITfH8OJxX4foW6jg6k5P+qP4MhTZQvXd80PtV6j7ZKPx9kz5DjzoxKIajX5MiL+bsc3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623887; c=relaxed/simple;
	bh=EgqfnMAoPGWhLBVhAoLfeMBJwoOFv6bI5z8l8X4Bz74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hwB7GSwfI5VooTXhi6Nqd0NVvPeiOfwc+xsZPxHkzh95riIdxyxRkML79g6+mRqBmhqaeFyKuREL1gZyy/2d1NeUE45SAyeYkVkdTfhGUK+BWDDST6ct+KWcsHxTxZLR6Rrpe67+94DCaE36v6reec5UH1BKNm3yX4CSpBH5Lys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-455749af2e1so1270829b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 06:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767623885; x=1768228685;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn4kG7cRLRHpkbtqApNn0XGtaN/UaczC4cghICEqmkE=;
        b=QbDjEP/e05OErfL1n811qSO5UIA8cr28fRRhU5Q5kbDZ5YGteuLwKm8TADP6CfcLA1
         /u5FsKl/X0/KELFyEi6VfZEawn1H9DuQ7OeE9whd3o02bE+S8tb4kRH0BbEPfQK21m1A
         AeRsIzJ0lfEUXU8ZankcsRF9aSTFpeT9jQDsZsTH9PkQe1zhz/kFh8BYAGH4h1RD+1Mf
         lofHdfZF4qHK1LmKZmppV8ORCTqrNevqv9u6Fgtnmle7yJOh7u1YnBgAGNzRc0qRlZKe
         vZanbwkeD2hX2WSeDfTs3ehdkza3/HrveQeY4ANqiAr412AN3hgrtJoUNp+2caePqBLF
         lyow==
X-Gm-Message-State: AOJu0Yww/+/E+TXWoM7tniU8/mmTXvJVGCla3GAvzxnGdZnnDkfvIUAg
	I9XzbwSip2iyPHqdBmybupgqptOuM5UPOgXGTGQpMYlWbTV4wx+mUpxJLFzo/0ow
X-Gm-Gg: AY/fxX4FrGXGADLcMU/6qEyJINfUf+w4QYMsf2QEYlaYoE9ZGJQwm82ccwINAX+MNbw
	1puDPanaZNtiZ89BGNq5PK2Bg2fc4NkAulzJ8ts72ipTEBCKdO0tY1KzSF/gx4tBF/QpNV99sEU
	EylAuJhmZDzoZbPa9vzIvBFXexVYU797wlbOyHuSy4lBP+LXmrR/QvaDdphWjnXgQjm5dRYaNO3
	AJf8lzcVP3kZxYkuf47BfUYa/6V+ymjOqRS4gc5W72/L2p7okdvdAz5Ad8FFjfHl/Gjg5tfn+mA
	56KT+AkDFaeX5yPY1zu4/cQcCMMxcgn3KZ8Uv9p8fOA3uNuz3FTUPUYanKgK/bajRpj+DATkANB
	LnjsdIqhLh4OApQeIhEmLWWEpR3mbt1AeE9eNqKViydq0IMd7hNnZJsfMjJ25P9JoMUOOUgVYQD
	rjZAC2IHt7pRLXhg==
X-Google-Smtp-Source: AGHT+IG/XegTidvFOyjeUcFaNOiOOvFs6wokeor9um8bxZwQnxVREMwftI3YifmDmsL/WZv1FsEh5g==
X-Received: by 2002:a05:6808:c2ab:b0:45a:4ef5:b1a3 with SMTP id 5614622812f47-45a55fe7589mr519371b6e.26.1767623884695;
        Mon, 05 Jan 2026 06:38:04 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3edb41fsm22514028b6e.18.2026.01.05.06.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:38:04 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 05 Jan 2026 06:37:06 -0800
Subject: [PATCH] cpuidle: menu: Remove incorrect unlikely() annotation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-annotated_idle-v1-1-10ddf0771b58@debian.org>
X-B4-Tracking: v=1; b=H4sIAJLMW2kC/yXMQQrCMBAF0KsMf91AEmyEXEVE0syoI5JKkopQe
 nepLt/mrWhSVRoirajy1qZzQSQ3EPI9lZsYZUSCtz5YZ0eTSpl76sIX5acYDlNwB8ns7RED4VX
 lqp9feDr/3ZbpIbnvC7btC/aevQVyAAAA
X-Change-ID: 20260105-annotated_idle-d6b614ecd207
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=leitao@debian.org;
 h=from:subject:message-id; bh=EgqfnMAoPGWhLBVhAoLfeMBJwoOFv6bI5z8l8X4Bz74=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpW8zLu9wz3KfLtF+DWr+p79FTKuHUN6FzS6JcR
 dMcEVp2+L+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVvMywAKCRA1o5Of/Hh3
 bXkfD/9wlbw6PH9vuV4DgzCYCGRtTZnGQVlEaxZ+jmAlqbWgijQpsKbS4ZifsldxHyVsgwzNG1m
 9POKdC0vl/n+rGh8PHSvMPbdH8EUJcCgTBCFf9S5caYzqzReSvwRSXX0cK7QsoqG94R5TMXajr4
 QOts876A4vTnqc4JU6ksUwifyTiCpcRN/34D9GQ3RA8LngbiaLRWZpHQTWw9oPPiB0KSUASeIpM
 +1irWwpJSeo0+SeEOHQIz2my+jO9c40Kj70YMsLraJatPyNVKq59VeRMYIOXU5kuQTNT27cul1Y
 tfBWAxxW8iUdY5u0iwiVvIMGLjOwFXhvHPSVtO78FIHCzxvSAFTh3Bw0sH3Rc3MnM7O+JNx/hvB
 +wDgAf7eGBptOq1gHdDKTV5aZ615FBArjMlhLPHKib8IkO4FaK6HWd6DQNnwuj1rqDo1VSzwC3v
 Lj80kvitpomuyFyngLtfHOh9SdyDnLHjZ5kdHlbMp9plwvTYTU2uxv4CapQP19FFLrFn+ah+LjG
 H81o9wD5u51FSQj59RnIkmzQkSbs2armTHm6gY8/HbpD5G3YnCv8BwVOCdzmp6YVi47FSFVZI4o
 3xRjDfGdRfYZNI38tBWMo6rh/ghODEDOqaJVYXaa6hTZBIv1zkgxvY5Yg1MRiMa/hr4jGTyN11O
 Gn0xBb8q/ZI0kkg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The unlikely() annotation on the early-return condition in menu_select()
is incorrect on systems with only one idle state (e.g., ARM64 servers
with a single ACPI LPI state). Branch profiling shows 100% misprediction
on such systems since drv->state_count <= 1 is always true.

On platforms where only state0 is available, this path is the common
case, not an unlikely edge case. Remove the misleading annotation to
let the branch predictor learn the actual behavior.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/cpuidle/governors/menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 64d6f7a1c776..ef9c5a84643e 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -271,7 +271,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		data->bucket = BUCKETS - 1;
 	}
 
-	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
+	if (drv->state_count <= 1 || latency_req == 0 ||
 	    ((data->next_timer_ns < drv->states[1].target_residency_ns ||
 	      latency_req < drv->states[1].exit_latency_ns) &&
 	     !dev->states_usage[0].disable)) {

---
base-commit: 34aa263125b6732375abcb908d73d98169154bb5
change-id: 20260105-annotated_idle-d6b614ecd207

Best regards,
--  
Breno Leitao <leitao@debian.org>


