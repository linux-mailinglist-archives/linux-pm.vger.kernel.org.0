Return-Path: <linux-pm+bounces-41781-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFFmB+C0fGm7OQIAu9opvQ
	(envelope-from <linux-pm+bounces-41781-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 14:40:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8CBB3B5
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 14:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5004E3004DC2
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9B630BBA0;
	Fri, 30 Jan 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoFJX6i2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F072DFF04
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780441; cv=none; b=QRPlVYTEnw1veIEEBuWBG3t1WKk5PEdppZbWaWEEUJDlyaj81hwP1QFVIWweVmy2G7iBOmcstjGI63DcT1+SqxFJ31+Xs1r6s6L7jB/H898sldOjq8vOGU468MyiK7Tzf7cbksYNLmrD3xkrwovEXZjRbC3t3uuTjo/vuV9nMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780441; c=relaxed/simple;
	bh=3/VKG5VfTqAMqvbMjOT0nIzf3Pu5Y9mcWf3O5q6vcuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qebirEtdMaaGTMEi8zcQGO/CRtCrkSpDEIsMvqxoXjmxzGQto2bTLLeiQtOFhmjAQlYDTIqgxZNj9BheHfW5ySYzzGkr0JrGbvfLNo01rizEt3/S6rGTVshsK3ZU001bR2UFayCUbB7PZLW/20Zrv1iP7VA1JQCXNASX4HXlzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoFJX6i2; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4806bf03573so11696425e9.2
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769780439; x=1770385239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OYwugTIJLc3eRCqiWoe8oZZ3VXR4XqUFabNpPOLivpg=;
        b=DoFJX6i23Ij2tOxEakJOONpGKulA6w4V/fXTeWy3tgfhV15raDFNux+r0a8QX98F3a
         fOkl4pD+4Ol4RikSvpeYSk/croAL7nHI+v0i2jT6B0mF4Kt97eYX0PLUEClU2umbOk3X
         vXlsOKKxVPn20oRhGIBzgGGDdAy5TwCJGdOGEN1UdYQjdQMEQGO5Fu62aBCqRQ2gYQMa
         yYCimEeSkA5BL7cld6+cNTiVFv5wIHqIA0+bXvCiORX7zN2hUX8+IzX+zJ+wVVXlhXqN
         hMTggCaJa6v7bQskZg/3hUTstuN092FojkqUOQfJJOcfINFJdxUAoKrSrRp9EOfa7tc7
         3FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769780439; x=1770385239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYwugTIJLc3eRCqiWoe8oZZ3VXR4XqUFabNpPOLivpg=;
        b=RhHzIq045OHkECZRhsp8NOzy6IrjH4xMq921Zj47dWXZmVMRlQG3FShJoQGgkqVdu0
         U/GKop3QoB9XmrWr+Mg3G59+P1ZH8ayDtYisik1nGHsRK2qVv1HFuJqO1zdG7U3r3rbH
         2f8WAJC5hA5wnwNnyRK1KkX3gTJQv39+Z4+ONclun8WqsHNPh2hyy+ykjm+/EsniAReJ
         Zmtj7F3xYnu35nOwxly+pX3fdWob9uQViBffWKlbBsX6y6Wlgyooy4Jd+hh3t86zX9uR
         df9Pf8iDlWQLA1p+USmIvLbrPRM+B1aY5QrLFl/nSMAVjkdSSkG1n3n4+GkR/44HZXqf
         pjRg==
X-Gm-Message-State: AOJu0YzPoj3NXWhQ28AAIbnBCuCX1GYQpOvFCMBhQTOUc+jlKHKkRO73
	Iv7eraCfSHCvdBm74rgBtvALYrVFN7GNTgFFXADy15BC6sBc0bh0vK4K
X-Gm-Gg: AZuq6aKmw/TkmxATXR2oLIY5SMi2UNoRhNuoioR1sSA9MI9kgM2+2KKDa1nr+JQwokI
	gygoQHVx4IX6Wp3qLZGBWfhRVOyDhQFC3NZfG9UpnfaPxsKUfCpYDGuTjPYgAuwkOb4a4xmyHSH
	TvDzD5nIQGPnOsxvkI38A8xCBD48SxZN+71kUO2mzeG22GxcmkG/ij7ejXlNzw2eS1sasDb5WB3
	bMsmEOSrSPy8FTz0JxkHuieYChT7zRp4liRgqijzYKpKZ5NCzJdUxyUGtkWA4dtDglK1UmLh5gr
	250tC2mOy6CKvgIwAXpPv8HSA6fmQDXsbYaoTzRSIjc6v/yqJuSt1ZLiwQPyQPZXEcK5R5fFiVz
	J5AQAiDtLWaJlAgT69vrUULAxJn33oJyudjHixVWc5S/Rr7icXptkI3shype0xkTvpE2K8fCyJC
	W4
X-Received: by 2002:a05:600c:4f09:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-482db45257amr36147095e9.1.1769780438670;
        Fri, 30 Jan 2026 05:40:38 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cd8fadfsm199106075e9.0.2026.01.30.05.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 05:40:38 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] power: supply: cpcap-battery: pass static battery cell data from device tree
Date: Fri, 30 Jan 2026 15:40:19 +0200
Message-ID: <20260130134021.353688-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,atomide.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41781-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3D8CBB3B5
X-Rspamd-Action: no action

Add an option to populate battery cell properties from the device tree if
the driver cannot access the battery's NVMEM.

Svyatoslav Ryhel (2):
  dt-bindings: power: supply: cpcap-battery: document monitored-battery
    property
  power: supply: cpcap-battery: pass static battery cell data from
    device tree

 .../bindings/power/supply/cpcap-battery.yaml  |  1 +
 drivers/power/supply/cpcap-battery.c          | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+)

-- 
2.51.0


