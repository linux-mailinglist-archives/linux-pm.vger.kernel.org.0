Return-Path: <linux-pm+bounces-36559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 063B1BF616C
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 13:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 051F84EFDE7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F4032E6A0;
	Tue, 21 Oct 2025 11:37:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6A32E72B
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761046660; cv=none; b=VW0g9nmfqmfOPAgsGDJ/GfpabXb+J8dOjddThvsmW791Ju7e4joFCB25QBYoy7k/sh/FitgZNbiO+nDjYb98/xHMaLGAwDil73X89g63evnX7UoAkODF1Yd46lKsDajLYJl+cNASc0Ex7Yn1QYi4NlBCo4rNZXo68wjkFoY/t/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761046660; c=relaxed/simple;
	bh=Ijgb6iMq/DZ+DUhiylBadDDJTGa9uu0g2H5s/TyLZFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QowhTVXobt3Dhhd9WCH34hfhsD2FkG8wvm8WmEailSzQGacz5lw+XJWVocOKgY6z66/VX3WQI9EkxAiJPCv9SJvy7RPvAYFVuyk32c1hfD9llXHL6o2DWP3grV8e5DL+dcbw6afysBSxt3gNGWiUPcO8NxeSJh7tbYixMJSljic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7835321bc98so4819624b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 04:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761046658; x=1761651458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzDoe8AqtxQPez8ItP/+HDboB9VhrpktF3X/hsuGf0A=;
        b=ZqBPhd870ManFsOPopIM83+/YzV1kho7daFj+75XvnyvdAharyjTsRIaZhOOU99ksm
         vDBPTfz6J7ebz6OV0XyAaQ3hcfft1x7ft/Z58Aod6DODwBP+SlpyV0CsxI27EoGwONN7
         trbpJo9MkuO/fxKfXHasFq6GE2TGEfv5Xqi9ajwd4q1m26PRbhlINe0VjdhWSvxnf4JI
         TDLvYGfHEhMdy5Yaz6rSZTtVZNUB/V1ajMWEIy37TTxmXo78QgkJUiMg0O0fdqcX3DIT
         4fvrg2Nki186jswNdLcuzesZdqGC/a+tSxH5Y0y1zAzEvjFA/wsKxn5wtYZC6vgy90OT
         a6kw==
X-Forwarded-Encrypted: i=1; AJvYcCXor/5zjo4S2D7TRPDaqGmR/cAj5Q+UAhb476FUDBXwRM0UJEsqcKB4gnTj0eJoBhOBhl2MXi1Zig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdddygFo26+npQUKalipF+j04FyDStxYX9RJqAkoWbGLvLsulB
	nTJdMscUZQJjyjxAVoKQfMBee3HAsC9QwObD2hUQbDBvRsE7uJW2jjoD
X-Gm-Gg: ASbGncvXO6uG2dB0gu1e+qDC+aS5CbmIDasrGtCFi8/Db6yBzEYDE6dK2N010yaiK0q
	q1uVVp8D5YIc1yv/wnQjTZrFUZypcJkV5cCU1iGh65wxW90meQVKtCTgM1NDTaky1/UOcR9Qzgl
	RhpoIEHHmjJTPkEIXeY2YbR51nsyCTK+PaWNlLbElFqcYWRTz8f6ouFeV3TGgObn15Ch6kdfSkQ
	E+7TvVbwm5dLNiTkXHLbegrUVQGVyhcuB4IbnA9/bmFTKrJkW+nPkTrIa4Bp0VgKowAvwLrEEJB
	5pmri4dtPfVjZBAt79GIvblYwTacpRpjVRwvN8iQi1xiPGv+ku9EMHzezssCWvcix4BZRNGqD5E
	6lTgNq+NnGCf2LMgJCnMSesjp8GuwLg98Hg3GrqXRBvvmXCUwB0i6EcmbiNyX68vy7i83ekDntp
	7s7z80fupYcWAjFGpCw0otKJY=
X-Google-Smtp-Source: AGHT+IFGSR+9yVfw+btCGauwEkmAa+SrLHe/0GkwK6TCZ+ywFx7tlUppzWqtd2QyHRtgHWrC3Efn2Q==
X-Received: by 2002:a17:903:46c7:b0:27c:56af:88ea with SMTP id d9443c01a7336-290cba50c27mr179773045ad.60.1761046658207;
        Tue, 21 Oct 2025 04:37:38 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5874sm107138825ad.54.2025.10.21.04.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:37:37 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v5 0/3] PM: hibernate: make compression threads configurable and support dynamic crc arrays 
Date: Tue, 21 Oct 2025 19:37:25 +0800
Message-ID: <cover.1761046167.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is v5 of the series to make hibernate compression/decompression
threads configurable and improve scalability.

Following feedback from previous versions:

- Patch 2 (`PM: hibernate: make compression threads configurable`) has been updated
  to rename the GRUB/kernel command line parameter from `cmp_threads` to
  `hibernate_compression_threads`, making its purpose clearer and more
  self-explanatory.

- Patch 3 (`PM: hibernate: add sysfs interface for hibernate_compression_threads`)
  has been added to provide a runtime interface under
  `/sys/power/hibernate_compression_threads`. This allows users and
  system integrators to tune the number of compression/decompression
  threads dynamically without rebooting the system.

- Corresponding documentation updates have been added:
  - `Documentation/admin-guide/kernel-parameters.txt` now documents
    `hibernate_compression_threads=` GRUB parameter.
  - `Documentation/ABI/testing/sysfs-power` describes the new sysfs interface.

This series ensures that both boot-time and runtime configuration of
hibernate compression threads are supported, improving flexibility
and scalability on multi-core systems.

Xueqin Luo (3):
  PM: hibernate: dynamically allocate crc->unc_len/unc for configurable
    threads
  PM: hibernate: make compression threads configurable
  PM: hibernate: add sysfs interface for hibernate_compression_threads

 Documentation/ABI/testing/sysfs-power         |  16 +++
 .../admin-guide/kernel-parameters.txt         |  10 ++
 kernel/power/swap.c                           | 121 +++++++++++++++---
 3 files changed, 129 insertions(+), 18 deletions(-)

-- 
2.43.0


