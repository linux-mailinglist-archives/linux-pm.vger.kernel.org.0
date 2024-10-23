Return-Path: <linux-pm+bounces-16317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 607749AD442
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 20:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EDCB227C6
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF6E1D1F46;
	Wed, 23 Oct 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQrawWHt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95715EFA0
	for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709427; cv=none; b=GaeDFDFTrpUvjGUOSR3z38fzsAhep69oEUkJbvSJ5qbLzK+rH0sor+7Y8G9X++grIFzdo4olepN+MQoKqQ4y8y/MOn2Yb5rd6qLWEFUN5j6Zyp8rhYHNcqbG3hM7CdTEEGxkKHzF6Ob1474yW3gvnhMXEopEjqgH0sHSSCr4NLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709427; c=relaxed/simple;
	bh=EZ36TFWeJgK0ws9qiUQOnHb2LB3oOSjPiPxK6expIR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gjbrnh5BmBTPyZ8tmLzQr0ljVuC4JH2ed+5Mx4dY9KhFwYm40tMT/pp7L051DtBIOD+qtOfYL2V4MkJJzCfcEnKXYelHmV0XRNIEU2MTBUaFPW6RZlFZBBPtMo90e8GWADWfY9qFhfEwr9Zs9OW1qrpIxtkyCbXSGFDHBYJ4oMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQrawWHt; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-288a90e4190so126482fac.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2024 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729709425; x=1730314225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6esCLq/lmrfypTM2amXFxr5M2sMWSlra9KQU1o4cO0Y=;
        b=DQrawWHttN/lfUTi/5yQC+OaxZBqZMqSXp3B8hqBdOU7S9Zs+aL0KCOnPsdu+NOzck
         IDCI5gVVuMaijCfAcZVJu2E7evWBrINJtcPledbUgYkmXyeRPF9hWEpssyoUdmAw+WTs
         QPRG7kpJ2QhAMSvXxOVMMsL529YDefMkiv7GxcwY2FAThBfWTtO/buExiTUrnB2IsCeD
         heRgTgJkoMnkm5WfzUhB1terZjLfMy473uTYQ1SQNnuTIjGaZyucXG0PCflZZ/Mvk7/b
         4T2lCGpwUP8NPm60BrQMirM32WdTRt3Kw3YVFLtSrdydk9MN2IycmyphiS7kEVZPhHZ8
         b6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709425; x=1730314225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6esCLq/lmrfypTM2amXFxr5M2sMWSlra9KQU1o4cO0Y=;
        b=FwQ4Bl9SnFuvczroyjheXm7oVM3h57h7KVEYfELrE+aMcFa8wmPpUjhgyNod++dCEr
         eVqnrOWPu6a9vxy6dQIsldKS0H+uh7JrRkZSKghYZ//F2UB48nPoaLKG8CXR5a5nhS8B
         znBRhRujIT06LKbGwLjI4Bukc1SPzMXQkxGVTQe+MymiBwyxxwHH5ZwDJEdSEycMNFMW
         IrJg9IME5wOJT+1V+tSg2AS79l0cbJ9n4PV97x09G9OkmKdC0AyhFPigdfPizHu2KGOD
         EIFp8cNsYW7V4Gn8h0VOEGTYtwh+d4gIrTHF86SnAiGIGhJQFlJBEshrobFpsvJDxj7M
         loGA==
X-Gm-Message-State: AOJu0YyTHP+SfobfDd5t5+h5nWL81wgcHCnllRTr0hp/szeQ90YETNP7
	7SkIAZgBvqVwL90t3uNFQFzfA1x/CLDczy/GvbKYcl2BRgVrVS8UcASuWw==
X-Google-Smtp-Source: AGHT+IEd5ojgaGW6C4g5KVJfYksWzcHEzqCewzgtwMyXrfPAsPp7MXbkZCuYQxEjj6Ymot6uk8p4Qw==
X-Received: by 2002:a05:6871:206:b0:260:ebf7:d0e7 with SMTP id 586e51a60fabf-28ccb7f155amr3964405fac.15.1729709424966;
        Wed, 23 Oct 2024 11:50:24 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182eb52609sm1860667a34.40.2024.10.23.11.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:50:24 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: wens@csie.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/2] Change axp20x power drivers to use iio scaled
Date: Wed, 23 Oct 2024 13:47:58 -0500
Message-ID: <20241023184800.109376-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Simplify the axp20x_battery and axp20x_usb_power to use
iio_read_channel_processed_scale() instead of reading the channel and
then applying the scaling factor in an additional step.

Chris Morgan (2):
  power: supply: axp20x_usb_power: Use scaled iio_read_channel
  power: supply: axp20x_battery: Use scaled iio_read_channel

 drivers/power/supply/axp20x_battery.c   | 33 +++++++++++++------------
 drivers/power/supply/axp20x_usb_power.c | 33 +++++++++++--------------
 2 files changed, 32 insertions(+), 34 deletions(-)

-- 
2.43.0


