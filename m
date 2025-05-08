Return-Path: <linux-pm+bounces-26868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20007AAF2A1
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 07:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096241BA5262
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 05:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08932214222;
	Thu,  8 May 2025 05:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+zmygIz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF320F081
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 05:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681103; cv=none; b=TXjP5+r8B+J5xIhyhr/SmfKddlM5JvUhJ+E6p6GATJMRadtvY0Gb69noT8bClh8mDdXItE7BTvPleoTLvm+X76XN6soEBLMwarRuSBORPS3p8jHVgKu02y0y1oprETQ5KZ+qjemb2CgwzPNlWchMCpGSZ/zORzqT0zJsb21Unqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681103; c=relaxed/simple;
	bh=w2+W2tZnQfiMOlFUaZpvMdhzpNLFFWuvCuO5WujfTCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nzpkuqt+CNIfZ4nR51LF5pVe4EY+1bQniWJdJj2OWKhwidk7gkTxx0acq4anQi/UUBNq8JSl3CGPG0sBymKeTXDrxU8lqV9CiFvtClhNdY4Q5OeQnvOPHivXpssLwiTOEOXVrm85qIm/6jZoPKlJ40a0AD+1eBTCxWRJ7j5DXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+zmygIz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--amitsd.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b0f807421c9so362557a12.0
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 22:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746681101; x=1747285901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+xYDH8ZA1ujcqXzLdWECgpqE3X7iFSqlkU9E1XnNX4=;
        b=J+zmygIzvwNHJ4AuQAoLB7l3duT8ogfQpAADKkV8lZrjiEYB1a84YN0tXF05rUrHBL
         aqYwG56TAeitPi4JnQJNNItn9iDg2Otu2WA1uvYNCUv4vqmTYAMpy5JYFFpFzsIdXE3P
         c5jzqkYgaucbC0+QTY35WD9m4RDUBiOsAw8Ih325YKExV9u1W7/GMWVz4PlX6/57mk4m
         7cb2j22q845bpluUOxlg7wdvd9VJ8WDkgQRssQ6vcse5wOaMpVyk2QU5HmBU/DRm415w
         BnrZ028u2LxxadlrDMupoV9tUVTMaLyTjZerwVwokbdtBtg/g1NzXRLnWtSiJ3DQBPVZ
         XyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746681101; x=1747285901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+xYDH8ZA1ujcqXzLdWECgpqE3X7iFSqlkU9E1XnNX4=;
        b=tCJfvHNi/66w7Y4zoe23O5F/2qc0eqDqEg3xhqcUNt1xSWPf2N545oe7vfHpDeH8tE
         ha8knCmoaeooH7NpQXlZADxNri+DI5Jh5U6O2dpcqP2c03rKym7D+qY2BUDdFe8Q1Kk6
         XBuH23kVikd7nYNhRCHB+EWSwv3ovfgGz8umclJIMSdoxUV2amU/xXR6Ogl8npbvI3Hs
         CuGd6b60VMZpUzOdo/frPWxzjZG52H5B72aTK7a4V1KzkVBthJ7TXmIviFiNHZaoE4s2
         xWDACPZja9a1utO6IT0HKbKeoxlA9ycFu3xMRdGvvIvC80WQFHD2oRmd0+A39UdgordU
         fsLw==
X-Forwarded-Encrypted: i=1; AJvYcCWJmb0SxpfU9x4ms43kAfeJC5JH2caiV86qMF3b2+/Bwq9YGuf9/0nEBtvRPkXbFassEK5/7JpHmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJb75Hm643ATOubXozKdkZ7xPLaoMlm84olxOi/H7e4t+mjet
	bsrX1MoGwn0Iss5oOPcVu65378ZEAhTQmqn2jhnC+WzL27CnEZ48roLnoX55Y0zq/dOgolPHe0G
	zlQ==
X-Google-Smtp-Source: AGHT+IERIVcMryduPU+3ecKegN+A1vCg/pfEbS6Jj0XrVd99pcxtEPjMwKwdWRUuqmNGdI0hOKLRwX5lI5w=
X-Received: from pgac18.prod.google.com ([2002:a05:6a02:2952:b0:b1f:ddf9:da49])
 (user=amitsd job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:158d:b0:1f5:7c6f:6c8a
 with SMTP id adf61e73a8af0-2148d332422mr10163138637.35.1746681101676; Wed, 07
 May 2025 22:11:41 -0700 (PDT)
Date: Wed,  7 May 2025 22:08:51 -0700
In-Reply-To: <20250508050856.674782-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508050856.674782-1-amitsd@google.com>
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Message-ID: <20250508050856.674782-2-amitsd@google.com>
Subject: [PATCH v1 1/2] dt-bindings: power: supply: max17201: add port property
From: Amit Sunil Dhamne <amitsd@google.com>
To: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	peter.griffin@linaro.org
Cc: andre.draszik@linaro.org, badhri@google.com, tudor.ambarus@linaro.org, 
	alim.akhtar@samsung.com, dima.fedrau@gmail.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"

Add port binding to represent an endpoint that connects the power line
from the battery to the Type-C port connector

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 .../devicetree/bindings/power/supply/maxim,max17201.yaml     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
index 4823021ff16b..50c2d672cabf 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
@@ -32,6 +32,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: OF graph endpoint representing power line (VBUS) connecting
+      with the Type-C port connector.
+
 required:
   - compatible
   - reg
-- 
2.49.0.987.g0cc8ee98dc-goog


