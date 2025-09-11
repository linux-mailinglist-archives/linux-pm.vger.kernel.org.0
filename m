Return-Path: <linux-pm+bounces-34441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 715C6B52B3A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EAB1C21C6F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CBB2D661A;
	Thu, 11 Sep 2025 08:10:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E42D543E;
	Thu, 11 Sep 2025 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578209; cv=none; b=mQoNIy4FXnzMoQgHm2CGMGYUPKcSrkVGUGk/J3TXDjaKSe+6v2mPefZ4/9Ay/YnCwPlaqtrUSK3IFKC5RrquYm0KtlrFJzHJvf+F5e+qQKx62HtZB2QphHvRBpq1cb+dnnXCvVNK5g50JE/5h4NGjlm7+2Xz34dE9XBq66SDwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578209; c=relaxed/simple;
	bh=4FX1V7mcXU6dg4/N3U7ZWrFANJaLVs5Bvh/bY8S/p7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WUrIfTqLF6wI+iIdyh9AWXcg99fN8Ln2AGjdAdm15Kp/TfMBWKQUxqS29eReCnoSACU1nIK+r5n1ONdoAPGLFTq2rwM0/67ugWGehrwljVfBeS/dU+CDin1GYyaTrRAkaBe08M1+gMXH8DKi8HRZU8dd2iRiTHMglJanErpj+XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-24c89867a17so3999415ad.1;
        Thu, 11 Sep 2025 01:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757578207; x=1758183007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J51ozOV+yFTScIbZgd7BkHzsTIFy4zOy031kpl4J1Jg=;
        b=p7BfOj3PYanXgy7upWafPzNjVrVxzsW5HHFof+58EyQMq0Yr5pSioCXEbj8nT6MvdO
         6XvCKSeBZjBfxsqyG10F6r4aPH7edwHNNsEpYjRc+02x2Yd0OQHIM8W9zOyBnwpCaELX
         CEcyRYDC0ukB6x7oIluJnen+9LodS2LQ/06eXc91xGpidI4CrTZfBUf5uWXsmnIF5p7x
         6DttMOWBoPeLgUmx+C7cV8gd9Eezf6wO0p9JIGczYqah7CMv0KpU3QNCieMYIPl7x4Fg
         32JK7g4t1qohZ/4j7SN3yFXoGQii2hbVgg9gpiGt47J0VR9Z1DAscmonY2UR+uLBL20Q
         BEtg==
X-Forwarded-Encrypted: i=1; AJvYcCWi6xKhHO1OC9ggpEEVQ9eJ4D8TUblwCNEnN75wcvIDYP0XiME6dpD7Ohzy7NoBUBz+Vl/yUzEM1VUynhw=@vger.kernel.org, AJvYcCXkhewKWyJmLuJiN6DZwdgzCKPbEh1jr2WirHbftawprt8hWeE59wHO/gu6TPv1u8CJBiWcCUXrxKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4DPm4SvuWY6QTzdFFjwKlbge//sf91/XpC8oIElxgIqz0Ybl
	+sMFMqdv/NsSOiz2n7y9ikU5B4/CRetv2Meon4HtSnLwQ7Jj3piIyaukD0JTc07nOYg=
X-Gm-Gg: ASbGncsg8qqdmYTfi1hfqJCvW7tdomOYxeEPVDpMvTu4IL5hMWX0BirOuV0IxlOojOH
	aPOGoQpeVM5SlhkKp0nE9KWQGbEw75LPkcT1doCHMXNi1VuyBAtrcAmJGvV5kPY/3QTdJ/EduVI
	JdG28Eaxb34ALjLbnbxrPMGffJ/nDPk9CVswnB6n7df2oaULXmpTQiravHCufa2wnC755W2E4GD
	Ov2sRDPa410Q0DYDMiJzZgWhsN8J55FlBzErhpEtW4CHPm+bVZRHSrk/ByBkG7/sMpsMdQKq6V2
	bswvP3LHiRqY0vsZCDcyv7PDzFsyZu8yP+Ko+Lv6rMeAFN4tVZudfSHmgqFOkF9kmjZHU8GVSry
	DpttxqAZ0Crv3av93wJYHiHJtwtbmGmQf4ok6xR4pxu8AQg==
X-Google-Smtp-Source: AGHT+IEdqwJ7mCmZefSuQJdsuKM3hZAxtpkKwNjBnKye700Irz4TolMgdXYfy1R8r4fjyPSQ5nP/Pw==
X-Received: by 2002:a17:903:3d06:b0:258:2476:77db with SMTP id d9443c01a7336-25824767953mr142304455ad.42.1757578206683;
        Thu, 11 Sep 2025 01:10:06 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc5671sm11129925ad.22.2025.09.11.01.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 01:10:06 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2 0/2] PM: hibernate: make compression threads configurable and support dynamic crc arrays
Date: Thu, 11 Sep 2025 16:09:49 +0800
Message-ID: <cover.1757575365.git.luoxueqin@kylinos.cn>
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

This is v2 of the series to make hibernate compression/decompression
threads configurable and improve scalability.

Changes since v1:
 - Added a new patch to dynamically allocate crc->unc_len/unc based on
   the number of threads selected at runtime. This removes the compile-
   time limit (CMP_THREADS) and enables support for arbitrary thread
   counts.
 - Enhanced the commit message of patch 1 to include more background
   information and performance numbers showing resume latency
   improvements when increasing compression threads.


In our measurements (averaged over 10 runs), increasing compression
threads from 3 to 5–6 improves resume latency by ~12% . Allowing
runtime configurability enables integrators to tune performance across
different hardware without recompiling the kernel. Dynamic allocation
further removes the compile-time limit and supports arbitrary thread
counts.	

Xueqin Luo (2):
  PM: hibernate: dynamically allocate crc->unc_len/unc for configurable
    threads
  PM: hibernate: make compression threads configurable

 kernel/power/swap.c | 66 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 7 deletions(-)

-- 
2.43.0


