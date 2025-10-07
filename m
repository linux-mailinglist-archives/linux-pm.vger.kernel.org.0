Return-Path: <linux-pm+bounces-35754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B54BBFCF9
	for <lists+linux-pm@lfdr.de>; Tue, 07 Oct 2025 02:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BE2E4F3014
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5671F7098;
	Tue,  7 Oct 2025 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edCKTMf0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCEE19DF66
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795218; cv=none; b=sUkhQPFLRGv6mNsQdwcP+erlLghy8exs1t0DNpNmELTVc2dnzkVHX1kQlY4Wz/iHWUGUYQ1dzIeWTQXs2QTgj9KzMt+ObeMNXKMRyM4BmS6Ox/Q+IavltW5j7ov6u6GLfj5foIfP4+ouJU9aGSO9/vLi4Qhoe7VCQ4MOVW3XIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795218; c=relaxed/simple;
	bh=to8ZWOjc1qRZt8n0R8qXpM+PoKIHqL7arvS09ExzgFw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qoxiIo9N+KAOrtq5Uc1tVjvgsiBgp3VNrKob3CEU5ZX1i0OTMXGvfJx9Y8LKnQLsepiNqu1K1lL1qksHLrSx7xKaxbpRDHGp+H1noV6Su1l8vTQiBP/nYZ9veYc5JRHqPVkwYbdTlNbaP8HOEqvDMqzNDhyfpvw/d3XdUzRx08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=edCKTMf0; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-36da4d67ed6so1304521fac.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 17:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759795216; x=1760400016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VdUfU2fJjBvhSwhaS5KHCRYOzfyetIIk6dhbjwg8+94=;
        b=edCKTMf0Qy0V25pa6/c0PiJ9u9c3u0nSkEOaq2a1YWvP5HXaoZEBJenAeYLF1iBG6h
         f1bKMYvXe8kYw4GbyGxgwgy9PX1zebMz7omyTJzYqyC4SzqMWRTxDlpxdMuR92Jm9BC8
         mIg8YgPz5Vn2V0wuHM5Jfq+PezXpFYkO2hzFmz9b6g2VMY399vInSda0YFS0VciiK6sJ
         YIPShrNMJSki9IrGNs9hzjBAxMfq/LtFNPMHBtagpHDf1eKZtClhGP72jTP4Ai8pi9UJ
         Wl54+UttB1+RW1pmgffxrZrxAIAEa887S9lHr59wKQxY45IoddF9bieUyem506SYd+XU
         XZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795216; x=1760400016;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdUfU2fJjBvhSwhaS5KHCRYOzfyetIIk6dhbjwg8+94=;
        b=hbLNgCQtU3TmJZKtliLjdUOdRkzKwfoZDmlvnrlC0LMJgmzWU89yIyHA0WFr2VEy11
         M8pShITcGVzo7pLOtZGISEN8a1B96SIb95H5oZ/Dkesp5haHrI2trX54+70vU1J3lFKU
         1aQ1/W00J/N/cU7W/EHQOBzUXYp5qCOw4Few430yNkf5OwUvw3UvJfZO7HEWKLpum1l6
         49sruDolKJwxU60KAVPczA+HVD9TnKDz9m+3wdnPaz6/pbeAP6hrZdat2iDtViIEGG+8
         l6GsnXiY/G8Xs2OizTqjRnWsG6vngNYyqC+sfoT2/MqJZf2VLjYvsotA+c0PnokQyA6M
         QCSw==
X-Forwarded-Encrypted: i=1; AJvYcCVtMXs5NnvP/d4WrhdXCzJYftJErMwVz8T7IgOV/DpcgPvtZ2xFeUWD3WxkSW01UXsLxTGTb5BhsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweFi1k5f+MLs7rBPmTexPmfixX4JWcos9bVB4vh7j0iiAkmYSL
	rJT04acyu3yRm12W2XzPODFf++PQO6kkNXBGNgVG599KPTx/IToUQZW2ChpjOAQGOquIwZIzuGG
	s1NkvWQ==
X-Google-Smtp-Source: AGHT+IHYTY6i4NJKEU6ncAOcwWLhE/UwFop1zK10OHZEI577ZI6tq5DlnfgX5+BnVTSvZd0L+fjUk7r1wHA=
X-Received: from oanw9.prod.google.com ([2002:a05:6871:609:b0:327:5a14:f7f2])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:2393:b0:332:ea8d:b4d2
 with SMTP id 586e51a60fabf-3b0f49f5aa9mr6400301fac.11.1759795215703; Mon, 06
 Oct 2025 17:00:15 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:00:01 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007000007.3724229-1-jthies@google.com>
Subject: [PATCH 0/6] UCSI Power Supply Updates and Bug Fixes
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jthies@google.com, dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series includes the following minor changes to power supply
handling by the UCSI driver.

1) Adds the "Status" property to power supplies registered by the UCSI
driver.
2) Reports power supply USB type as "DRP" when the port partner is a
DRP.
3) Updates ucsi.c to report a power supply change all power opmode
changes. Currently this only gets reported when opmode is PD.
4) Updates ucsi.c to report a power supply change when the PPM signals
a sink path change.
5) Set max current to 0 when no device is connected. Currently this
defaults to 0.1A.
6) Updates connector status after initiating a PR swap. Following the
UCSI spec, there is no reported change following a successful SET_PDR
command. This results in the stored connector status being outdated.

Abhishek Pandit-Subedi (1):
  usb: typec: ucsi: pr_swap should check connector_status

Jameson Thies (5):
  usb: typec: ucsi: psy: Add power supply status
  usb: typec: ucsi: psy: Add support for DRP USB type
  usb: typec: ucsi: Report power supply changes on power opmode changes
  usb: typec: ucsi: Report power supply change on sink path change
  usb: typec: ucsi: psy: Set max current to zero when disconnected

 drivers/usb/typec/ucsi/psy.c  | 41 ++++++++++++++++++++++++++++++++++-
 drivers/usb/typec/ucsi/ucsi.c | 35 +++++++++++++++++++++++++-----
 drivers/usb/typec/ucsi/ucsi.h |  4 ++++
 3 files changed, 73 insertions(+), 7 deletions(-)


base-commit: e40b984b6c4ce3f80814f39f86f87b2a48f2e662
-- 
2.51.0.618.g983fd99d29-goog


