Return-Path: <linux-pm+bounces-35929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C7BCF310
	for <lists+linux-pm@lfdr.de>; Sat, 11 Oct 2025 11:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23BA19A151B
	for <lists+linux-pm@lfdr.de>; Sat, 11 Oct 2025 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A157123C8CD;
	Sat, 11 Oct 2025 09:38:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349920C004
	for <linux-pm@vger.kernel.org>; Sat, 11 Oct 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175509; cv=none; b=QfPSBQa1J/wNR77EjHO5g0FzPYceajVTqQQ5XF6xxyFgHnZo9il9sFYE7CecvYefjS2NfnP01OfpmOxL/ACTUrnWxvPA1SuIaGfDS3Mccux8RxXtqwFQmAz3ldPqhhsddRPP2VwWvS+1ENYjaUeivvL/lo2qs/u1KDOjrv5X3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175509; c=relaxed/simple;
	bh=x/IANdHnirSfy25Eg8bf+YmXVYic0ATSD6NoWbj+IUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EF0vmQNtw269qipb6xX52xUGXF1BFwbfLyLQPjsFLuiqEu8fYaoIJLn5Cu5jAj496DBVe9AuYhDTpOYKoeryp3czVn6xGo4or5FOBNzJ3B9DRbCqQNtLRoyvkn5tMUlahGxrfkZE9gpt+0Fl/D8VLd+AJpwo+JsZ16QwmrEBu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso2709269a91.0
        for <linux-pm@vger.kernel.org>; Sat, 11 Oct 2025 02:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760175503; x=1760780303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YU33It05OlNEOWRANGcDm5LAEtMKVzFh/5VL6Jq8yQ=;
        b=oUybqQvtbMLlMWtZnkjS7Ou/4GDLNymJbtKWn5IobzJJqR6JjGz67NNxQU6MngsBPI
         tPHC/OSSNarQEz+5oSCAdHePrMeVVOqSMgid1yaJf3mhs/6M5yn7jHaiLIY0YGd7Jf2S
         wg9/+zpRhwTNT8WywoLV1yZJQc5mgItAMCeeQkaT7gpNfpRfJknnde3+wrHhWORq7Ppp
         GUWYgkMHBxXxpWKOZ45GHwi/zVfPKSY0KdAuBOCCTTl8w6iqHSOp4S5WcN37boJrFxdg
         i48tBCu0N0xCCZNr4BSWnCIqE/VmFpxtWAHPve5VurjBmSq5/FJkbIAMCRnmqtRupcBp
         7QuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhqiOg1g3yKKeQBHUYhpXqOh2TRaKx9P5SJltOMjd+GchrJNvCLsk6+I+Pr2cEAf4ZyesX+xZO9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq5UjAdqAfUD7DLYXTvjTakq0FKBF+P5/6rCRmm3rikNVdmY6x
	G818OH2+ZMW5NVoBaBE9IruTe+H7xX5nLSFnNC/dIGI9rcC5+oePJ5uM
X-Gm-Gg: ASbGncsGTAHFdVWsTQ6edkB5L2ABHivD9ejkXwXa421SAECBDyGKE19PpV+heoHLlFN
	GXHifqTUnl20FsRrpwQx2x+ZdLYAzLOdKhIRWEMS0ZgD1UBUDGMc/Nl2S0Vd5EJSn8IZWD+3HdC
	Xukz/1NK8e97MO/WMvFS8EQq2J5g58c+HUq5dtsqd7F8/G6x9VW43MdTRDcRu+SSeSaf5SDCj73
	n2gyQ1sG/ir8u0xlVzn0a0ojweyBWcFdBV0RJryhNPpG4UsX0NEQsf94LSIJ1/QPibTL+kO6Ix9
	tHlHl56Ja9f9BEwsfJY+9rDCtVbfB2mqpJZK01ll2jnvID1LIfwoeDrOkbowfcDyxfRjxNyJdmH
	ZLXTsIzNH9imbSPYqcDdkA3U0eq40zTYmNFIZjGmJOH4OqpMoANiOPnMo8eG+JzdT
X-Google-Smtp-Source: AGHT+IGgH1yiJzi1hj2dSBqILgcFzc1H2Am1PfdYaYlo5dUsiGGN3A4V5FZLefX6yVx3VtZ1xQuf7Q==
X-Received: by 2002:a17:90b:3ecb:b0:336:9e78:c4c1 with SMTP id 98e67ed59e1d1-33b5111580emr22759105a91.15.1760175502983;
        Sat, 11 Oct 2025 02:38:22 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6262df70sm5663168a91.1.2025.10.11.02.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 02:38:22 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH RESEND v3 0/2] PM: hibernate: make compression threads configurable and support dynamic crc arrays
Date: Sat, 11 Oct 2025 17:38:06 +0800
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


