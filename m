Return-Path: <linux-pm+bounces-34612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E269EB56E3F
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 04:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB54D189A3EC
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 02:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615351F9EC0;
	Mon, 15 Sep 2025 02:21:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60502F2E
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902895; cv=none; b=kFW342FY9vaawVN1KSn8NsiHTAt/W1aceqZTWheitEi9Pk0rnhZQ+CWoEiglPqdOuvTVFCkOI7Hbg/wjW805ZlxG8ZF9+VBdKDGpIcN5MWyiss99FcPMEw1zM3HUBmnwulNX0+Gz2dUs/WZ9uQcI1oxMHQO7uKWl7J60MdQkU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902895; c=relaxed/simple;
	bh=x/IANdHnirSfy25Eg8bf+YmXVYic0ATSD6NoWbj+IUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PDlFcy+/+Z+Pbmp2JIbRgmIzWmei1zXjXF37AOnvievoH5fOdWm77cBMSHgaY/SV0p8hYXOpIoHBtBvPE9fhnPX6p51YHarHBMc2Xe5962efL9TCk5OMjqHTT5Z8d/yDYIIQFaTiGTux7js3JEKwIARslw3XGIGTn7EO6SZp+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b4d4881897cso2333862a12.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Sep 2025 19:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757902893; x=1758507693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YU33It05OlNEOWRANGcDm5LAEtMKVzFh/5VL6Jq8yQ=;
        b=Cr0QvrebRUIpddAwiv2F7B6VYYIDzfZXh7MND5pkr6SmCzQ/HSNPjBzD4AYmpKxtEF
         /jrDzNZ9SqRo8UeHgJDbDDW/hSzcW6pPaHg9MKHfqkig1rYqsR++ClvsWM9dv0cZ8zJW
         iG5d1uMMPA5j7zyMt6QFs4sLw58Azz3j3EouCSeBcjpneXfE3+hUuik8gH05shnYj9cX
         RlOoEoilGz76rDdncQauvEuLXdH7G4+zAocxfQV4tdlpKt7HMA2jKhtDUbAYHT9z+PkK
         hiq9RGv0YUJM/FTHSg5SakBRbEViGQr1chtGTMXj/7oi80rX4kOSNN7vBLOYsMD32Rab
         vW/g==
X-Forwarded-Encrypted: i=1; AJvYcCWdu+Oau2Pbm8D8VNx0E99bDtrt5o/zlQeu2yrJuUQ3PDVlRASRyQhtFGyQO7Fc07ujZi5smtaMBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcXMlV72iLgw5nkCwzKNL/ZIkY+iO6jtIUa304DrkAY5UBNVGc
	sMDFVoShYD2q4DgcB5aCP4CwH8S/sRApCXK20wWIU3rFkw9VTI4NPOXA
X-Gm-Gg: ASbGncssCmM5XWFUqQOHezIK15BaOdmXMxq0vFUp0z7QuqcwwknqUkpdT99FcndxUMP
	KBpDCCx+7TaSTPzJpjetWfR0hn1H6Qk+Voe8aPCWOeg+QsLcCODPoFX0yGU9wAeqHXjvuKUiI3w
	+Pg2naxtXGskNesem8G+pkhiNu5CFAbY76suywsRD8G7ibMfzXLHS0kUVLmB/t+4wqVePLZucds
	Beb5R4cZ8/AJvstVu5vDKKW87FB8zDU+lkwCCtIu4DbgRx2c54qY/1jmVclvdRfmRuGX6Y3+kZ5
	+rhaGhxj7Zi5q9Z56Ad2JUvPmE2DyBPCU3QgEfzrEpmAb5/eL/+tOIuaQteHoYtyZadVZrzRbXv
	II90KvzuUHZRZITodZdeYKmTTwEXn+pyieStK9KmKVYSH
X-Google-Smtp-Source: AGHT+IGoDBrZTOWfaO19a8IWNyoVcq8K2UvZOhAA3snYtgNnKlHO6QRhX3OoNjwAJ0wg7EP17ym+LA==
X-Received: by 2002:a17:903:11c3:b0:23f:f96d:7579 with SMTP id d9443c01a7336-25d260795c7mr112469885ad.37.1757902892939;
        Sun, 14 Sep 2025 19:21:32 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([39.144.194.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32e37005a82sm2969607a91.16.2025.09.14.19.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 19:21:32 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v3 0/2] PM: hibernate: make compression threads configurable and support dynamic crc arrays
Date: Mon, 15 Sep 2025 10:21:23 +0800
Message-ID: <cover.1757680816.git.luoxueqin@kylinos.cn>
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

Changes since v2:
- Reworded commit message to avoid "this patch".
- Introduced helper functions alloc_crc_data() and free_crc_data() to
  avoid code duplication for allocation/freeing in both save and load
  paths(patch1).

Xueqin Luo (2):
  PM: hibernate: dynamically allocate crc->unc_len/unc for configurable
    threads
  PM: hibernate: make compression threads configurable

 kernel/power/swap.c | 82 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 18 deletions(-)

-- 
2.43.0


