Return-Path: <linux-pm+bounces-41329-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKzMHkp8cmmklQAAu9opvQ
	(envelope-from <linux-pm+bounces-41329-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:36:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6986D189
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1E37300EE9B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED70338905;
	Thu, 22 Jan 2026 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZGaNzFD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D043921DD
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110492; cv=none; b=poqlmSpLdYKqTKqMwGjTiZi9hgwyt5D5h8XK4a3B9MMhXbFvGffUXv89hgDC5fY4qkUOYi2EW+xGNynCrBMLNiI+Cudxl8ioK2h27692o+ovT3fe4ra5NqZhpRibZYacEr3lVqAsSx74Q8fKZAnVTRQD5aXjDK6x5OAvVO1C/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110492; c=relaxed/simple;
	bh=X6qHzd8lT8x0AErfaNBQf+vdTTGsxDiQSJb4vl7S558=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Usc2NpxVqd4VGOVqnKkAIxUJiEl5FCgJd+vQVIxodKeLib1xRRC9Zd8nJrOFQY5IUc4uZvZt5dNLTvWrsyjvmFT83JlIp64LGOi4YOfaxPGa9l4gi3uhBZhUo+z5IEDlyM7jy4+1rLzxNV9ciBkR3asvntbjIkoZj0S0nxXk/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZGaNzFD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so15610305e9.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 11:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769110473; x=1769715273; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r19cOw46wdNPFNu3JtRNNQTGlWmZYB5Ebmc5Kt/KBwU=;
        b=PZGaNzFDBu/Ss1WEZH1MN99BA0XBHEadvePWq3IMKOeeikFrPbPm7r23t2umXEPXg0
         1BcqWdg3V7RFpaPaSNYLnbkUtWf/4ZPSqe9PaUXMtlWzk6ZdVuqlucllK8e49d4p/kgO
         onf50nSUT8Lp9l2vlxDoWygh+NELdghAtBBva5D+jfzJqvPB8sujf8jZN9RsrJW2rkCv
         DK/uzsnEAgtvNRncvBedQ5GSqpljLvauO8KbP88g2U74yTBXWzQE9LcpxMl7UkR926e5
         lirC1xFaQrxRa+MseRSz1aTa95gnVCYhZg9GA1NoerrNSLPgE1ZxEwNhlze7nicuWc2C
         ZsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110473; x=1769715273;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r19cOw46wdNPFNu3JtRNNQTGlWmZYB5Ebmc5Kt/KBwU=;
        b=jd1AdvIp6Ktmc04iAVIDh/klm0eyhq19IQMRylqeZrl78jEPozoGEmgpCPLik9IzKF
         o/Ryoo+brGChvTrV6ddamxfakBlIn8BOHqCH/t+jkQt7jgR+TJ5jjnPChgZvkqUmkGJ/
         423S7JnZj5V5YMq3iFczAQc6gcHGOpZVYaDn59DepRPDKqZrQaoi3vFPORRvGi8XIKr6
         Apxlj/NMK3fDcBttZYhagP3rKxBnjYXwzazgcaGdnUYcr/WZxWiP7MdYuRxHVxkWG3EG
         B2axRZfbGy2C0AB9HcCcvC6ZLreCQa/N934DlU5+qE+tOT0POix+25khk+GY9RkqqCnf
         2hnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDSdWmgVAUUyEqPO2zgrjuiSDCjK6ZwKF6mMBCufNuu/ETyiEWoA7thzLv8qwGJr9yYWCUensRog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwASxOsx+Qdb56bryHsJQ4wY1q6wt/Eg6G3ubu6zVIZgCGP35nH
	DFbgGg7Pt1CBYY6522DcKJXtxqzfxrK8zt+FKD8XlIxvMWJsmw6Iq0Fh
X-Gm-Gg: AZuq6aLd1hBm5j7xHqi/lXSi0rtR6tq9uefKAsGVd299tumdl0JzGjxvLdipuPt1gZR
	nOSImgu5bUB0VoSq4+I/ghtxd3VMxKh1hoMqELiSxNJxE4Q4sOvD3YpqgtsRIsflUSFym/892B5
	Ef1f7OGrYaXEJGdjPZPmsT4gId9zgU8JWl9JPnOCQoFL7Wrq4G80so03bQWEFoxd4LoNd98sp3u
	IHw9nV3uhTcc8c45jKZs/zyDVGhU2Hs8cjtXN6wlbWIr7h5H/12psR4vrNmDjcSFlrhhq5Ur6cg
	q7ohY6xxVuaycjqUS29VIuaYfE82XgU4WCYSFaOorSNvKHTahibChNO4riEhzoviHqPuYQKXBEB
	378EzRuSY+uVC8hy8FMegRa7xLv/jFaS81uDNf116K22W8Dmkm6whSl02898ELQkqgnPFjWH7hp
	p5w87RA9AfzQXNzll9RIi36Y01GKyZa+24GQWzWSgb
X-Received: by 2002:a05:600c:8b84:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4804c95cac1mr12610375e9.12.1769110472800;
        Thu, 22 Jan 2026 11:34:32 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-435b1c02dd4sm853240f8f.5.2026.01.22.11.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:34:32 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/2] interconnect: qcom: remove some duplicated defines
Date: Thu, 22 Jan 2026 20:34:21 +0100
Message-Id: <20260122-icc-qcom-dupe-defines-v1-0-eea876c2d98f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL17cmkC/x2MSQqAMAwAvyI5G0iLuH1FPEgTNQertiiC9O8Wj
 8Mw80KUoBKhL14IcmvU3WcwZQFunfwiqJwZLNmaDBlU5/B0+4Z8HYIss3qJaLvGcE1VSxNDbo+
 QxfN/hzGlDx3acaRnAAAA
X-Change-ID: 20260101-icc-qcom-dupe-defines-2971d60480ad
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-41329-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j4g8y7@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F6986D189
X-Rspamd-Action: no action

The series consist of two small patches to remove some duplicated
defines from the 'smd-rpm' and the 'msm8974' drivers.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Gabor Juhos (2):
      interconnect: qcom: smd-rpm: drop duplicated QCOM_RPM_SMD_KEY_RATE define
      interconnect: qcom: msm8974: drop duplicated RPM_BUS_{MASTER,SLAVE}_REQ defines

 drivers/interconnect/qcom/msm8974.c | 3 ---
 drivers/interconnect/qcom/smd-rpm.c | 1 -
 2 files changed, 4 deletions(-)
---
base-commit: cd796ca8b83be6bcab7610e420078539fe67ea03
change-id: 20260101-icc-qcom-dupe-defines-2971d60480ad

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


