Return-Path: <linux-pm+bounces-38241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA168C71A0D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 01:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBBAD4E2EC2
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 00:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F6C2343C0;
	Thu, 20 Nov 2025 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PN5ITh+b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA19224B15
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600336; cv=none; b=YXMohdqbBfAOeOMyEZpsc2Xy3HfEwEtDDLl5+aG4Nmn45sXrMJyR7MncOcXzWJOViCs90nreuDt2YZhMBc9kjMxhH40HNYSsIFrUs469nCbEex6cCn8otaBJ+i4GCPZN+G1rQAv2gg4PTiQXY7watdqjuu3YCPG25lqdXrelLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600336; c=relaxed/simple;
	bh=YGYYtyuUfrK0SwI1E9iUg9eZJECJnWmTxyWkjucWhTM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s8r70PxjDgB7Ew+s9LXh7WggsIRQxmhoVw7wCVBBjpycrptH6qLckLzfDgKgN1l18F34vP97UYCsHN97yGvt3HnLKf/0mDfxlttA5Y8HKzDrfSZWhWS9mRyzw8N67oTG63vQIwFyJMfXA4c72h1+fAacoDOXjpXmYmSserj5bn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PN5ITh+b; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3434700be69so372390a91.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 16:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763600330; x=1764205130; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zoaedeC6E1uRMkSRTrCixwFlzzzNdvlZDAw7NVsyHy8=;
        b=PN5ITh+bZN+fes1kQe3i74GiKr8A8LcuNnSQoacyu7tTSCGHHNhv7FWesdeJibIcNg
         8ISj1JsvqcA5ehGUg55891g2+xvmg+OAHLlytZQKXponOSxTgGfEzEkEyKYEqqZ21FIU
         MQbOJBBOIyj9UDyCbmqOaEbcHk1KqLYzq8DOFJZto96LbfQ6+qsZ5+/ie9nvy0IhsTu+
         MTyEa4bDbgOMGRjNsc7PTFAmQaYdSnMNp1XvE5N14qoeNn05bItTJa4ojN5pmkvxcKBd
         CVfof78mMlr1RlhlWARVUe8SNRTmYHeAwKUYc2OgUoAYsPTQSaPwLz3tm1mgJ70xyA58
         70KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763600330; x=1764205130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoaedeC6E1uRMkSRTrCixwFlzzzNdvlZDAw7NVsyHy8=;
        b=bLeX+sdlzOlaozzK0OUrf1vgprYs/Q1IgTyP/IwYbsyxv/DsBa0abPXI0jHXGjNzEq
         iph6G3krv6Gd4JpnumKWpBdgXKWSpc3zB1FnoaEf9q1Cq2+kDl2Ce/w7VdsLU7wa+YLK
         SpXMyCzr+S8vsRf7gjIOwcUeoOo2fQlzYnsSKfh9soqJSwlL5P1iuYLfIPuGRm5uMVWt
         D3HBitY9TLYcria+bjVGGHRwu9YERJSZDWIFEWs5YkkcKLx086rz5sfuqeuB7TLUk5+U
         t3L11bKdngU/WFZvRZOPejn8m1uP0VAARHinltWMwME0UXtNjcQ573sL3+r4BKfSrm+Z
         8cPA==
X-Forwarded-Encrypted: i=1; AJvYcCXtSKdGVlv5CReUKOXlkyxvfwbrE6hxyUuwhOlSVO7cWvJOJDZXISdMUkmWo5Lb9G+WJNyLiIQdoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRybjxDT9LH5jqTa3kHtE9rW6g1q75I9of5NeZxUBauXOdf1YL
	jqaBrwC8dn3iHIqJc+A0au1p+eAOiSlq+SDVA4beWhOCoBgjK/qmVtWU9Yogh/Rtn4Q=
X-Gm-Gg: ASbGnculJhJmH7oL5U1ihRx3PfgExZWuE6mpgKTHs30/6iaPRPb2NaXY4gVVWvco+xL
	CyMSHyfwgufc/v8wGzy7tr00/o5kKjgyE5aPyT8jDhvJNbdflcRv6/nyoHHpDwlOVtD+jpTUJsi
	tUJgqJsZJuvQiuh5SCQp7rOLd+YEvKvY1YmETEYG1FN4CPyn5z477yf6zw0o19i6kuRd9p4DnX/
	hlL6czBxD2u5AV70hsTAdDUDc5oq++9XIwG7esR/gLgAsXlw8jpulHy2eTb+ZVTzHtbjAmP1WAp
	UKT90oVKYOxYL4jz2nl+4C9SS0SI/C7AmiGbMPkwy3OLcs5SgtQqtcbfTkTMLr/cfBk5+6BvCpu
	nw8pz0VXGFibQ7K2D+iSp21Oa9Jbrmj6p3EVM7y6AdtXCxmbuKR1AuVCOoUt9yOOGtuvVygCqHl
	RvAdeDTOfA+0cU8rC9e4g=
X-Google-Smtp-Source: AGHT+IHmgam06BdlOZJs+A3jKgIDnHuKB38s7Ap3EY07NNQjGJ0FckJr3nuf10G3kW5DVuQhWdwlPQ==
X-Received: by 2002:a17:90b:3bc4:b0:340:f422:fc76 with SMTP id 98e67ed59e1d1-34727a43cfamr1228358a91.0.1763600329913;
        Wed, 19 Nov 2025 16:58:49 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727be2320sm515183a91.5.2025.11.19.16.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:58:49 -0800 (PST)
From: "Kevin Hilman (TI.com)" <khilman@baylibre.com>
Subject: [PATCH RFC v4 0/2] pmdomain: core: add support for domain
 hierarchies in DT
Date: Wed, 19 Nov 2025 16:58:44 -0800
Message-Id: <20251119-pmdomain-hierarchy-onecell-v4-0-f25a1d5022f8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMRnHmkC/43RzUrEMBAH8FcpOTuS76Q9CYIP4FX2ME1SG2ibm
 tZiWfbdjVVQRGSPMwO/Gf5zJkvIMSykqc4khy0uMU2lkDcVcT1OzwGiLzXhlCuquIV59GnEOEE
 fQ8bs+h3SFFwYBkCpO/TSeKsUKcCcQxffDvyJPD7ck1Np9nFZU96PhRs7RtfYGwMGVjFjqaHUa
 XvX4j7ENodbl8ZD3vj1GgcKxlqFQaqgaveHJr41zcS/miiacsZQbXTngvmlXT6zyOHlteS7fgX
 S4hKgzMe4NpVAqzW15SRRd4i+lR1D7b3hTjBTO+Y7pY015OdfmurjOsZYDWuao4NhHiF1MOIMZ
 U3GEjRsGpgF1ExKI7lA75oS++lyeQeJeRdZ+wEAAA==
X-Change-ID: 20250528-pmdomain-hierarchy-onecell-a46fad47d855
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=YGYYtyuUfrK0SwI1E9iUg9eZJECJnWmTxyWkjucWhTM=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpHmfIj5cqLVaqvpK9D58aKNxP6PFYM7JT/PaDK
 QctMF5hVQWJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaR5nyAAKCRBZNxia0/vG
 Zd16D/46icwvwB9UC8kndo9NjbznCdELQtW/0bZwplNDPUcQrrLLaeqQpob+UJgV1KPmhhc4l0q
 MoJjIs07xJ6J+XZOA+h+p1F/F3MxKsdVOtm0ikjmIPxLTWvmHvJ+OYRQahvaTeEjxn50jMJW6AG
 8Rg9iGb4kt9Z8cug6TcUb3Ouq20npQOpyXdgrFMxzoRgynFG1K16qbF6qHkSxW1dF7j3O30xmRU
 hlk1Yo1Ta/cqnZ422Ifixh6YbUPAznDUfD3W545eItd3fqG5L1raPqIdjIFBxGA5Ahcp93fmEf/
 fe+pDZ/lQVeAXZIQxEAQEKaH3S5aWb2Wx4X9U63EJvza3Z/QIYKcBhFeXRXmFIYcF30kyUy5ojQ
 mTM7HBFXy6IUaHPDmcOGo7B47v8hqGUsIL9qATODGaw0baCV7oo2MzBNKlkif+an9FkUPPlsRd0
 wD4xfW4nSpV0EzTS4S2h42mmtvoOkK9krih3pxcqLbFFqE9yUem7ZfG98uxIQQ7M4MJYAm4mU3b
 r6TayMuRJUYXldbfP5JHEZbFtJ1mu/Q6b9VaCamTbF91XhHB/VPj9gZuK+REb5XqW0EO/C79PS+
 S5kVBG8LGkMHmTHzX7VjKVktMq3ipW2B6PsAm8n13ti2KnKP3ec4TxCzl9VJBKslWSF+6PAT5Mr
 xhBsX/uuVQ1Je3g==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Currently, PM domains can only support hierarchy for simple
providers (e.g. ones with #power-domain-cells = 0).

Add more generic support by creating an of_genpd helper which can
parse a nexus node map, and create domain hierarchy.

described in section 2.5.1 of the DT spec.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Changes in v4:
- use new OF iterator for parsing map. See:
  https://lore.kernel.org/r/20251119-topic-lpm-of-map-iterator-v6-18-v1-1-1f0075d771a3@baylibre.com
- instead of mapping on probe, create of_genpd helper to be called by providers
- Link to v3: https://lore.kernel.org/r/20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com

Changes in v3:
- use of_parse_phandle_with_args_map() instead of custom parsing
- probe when device is attatched to PM domain
- Link to v2: https://lore.kernel.org/r/20250528-pmdomain-hierarchy-onecell-v2-0-7885ae45e59c@baylibre.com

Changes in v2:
- Use nexus map instead of creating new property as suggested by Rob H.
- Link to v1: https://lore.kernel.org/r/20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com

---
Kevin Hilman (TI.com) (2):
      pmdomain: core: support domain hierarchy via power-domain-map
      pmdomain: arm_scmi: add support for domain hierarchies

 drivers/pmdomain/arm/scmi_pm_domain.c | 11 ++++--
 drivers/pmdomain/core.c               | 64 ++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h             |  9 +++++
 3 files changed, 82 insertions(+), 2 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250528-pmdomain-hierarchy-onecell-a46fad47d855
prerequisite-change-id: 20251119-topic-lpm-of-map-iterator-v6-18-a61447423adc:v1
prerequisite-patch-id: e2c4a8c727d0f172166cfa622e60d97048a97b26

Best regards,
--  
Kevin Hilman (TI.com) <khilman@baylibre.com>


