Return-Path: <linux-pm+bounces-39668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6F9CC9C95
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 00:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF205303BE0A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Dec 2025 23:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F55330640;
	Wed, 17 Dec 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBaT4sxa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4184F32ED2F
	for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766013528; cv=none; b=MIoB7NNnAGkyVUMLySwI+qVgbA8r82Fm9McgRTb8WBjlulIm5uYH43rpSDjXrnqww+TldQI5Dhw97hEou+ZyHDBDKWpYz1ge9yagQDpBIoAN5Quqz769o5ULX1zCBOwrVoCwngLwkRJYCp1BCFz1PUgjKEjqesKOKHrQ3w0SRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766013528; c=relaxed/simple;
	bh=C1X5R0T9A6CrUnxpIm/QVXVuRULmzTp597QRk97zyjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OX2bq2e0Cn+5T4JfYY83/QUXoQU0tS86k8eY7YP5kd93XhDiLcqmAzEEYvvkn/oi5VbD0o1WxEj4zgqW3zxCzaNvklOdgH8hdlqbPOUHLNiPgnPpJQDvt62Y+UzznHFEmEfREZVPMvKBBco6pFZQh9aUpJ3cFDJXBTtG2sURikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBaT4sxa; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-596ba05aaecso29364e87.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2025 15:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766013524; x=1766618324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZvc3rVI0di0d/Re6Le5Bvc+vMvJtdhpmIxMnxjb6tA=;
        b=VBaT4sxaHFvfVHw/0PNR0mma9L9CQCE0t1LZsPF9klP2ecyZEgzKiX754iClqRnz0f
         GmmYZH9YBVrmYyy8S74MtCYaKuLLOE2twPEfhgrGbfkH8UXctcxVy2vj9OV5ntO4+YDt
         N24t/STd7wbl7G92s0Ny+GD1Htd8YjaiuuS7DGr+Iv8Q9IUwNUEXilozkJvTMnE86WQu
         MnZ+OnIJvOTufXzIWehEwX5Rn+kCV2O/NoVJ2bWPv2EgbMUdijMRcUlXoqnDdN/RqdV2
         qtSKWp2M81Sd6yvPFFJro9CHX/HMKbmz3BzLch4xdn6FHJrroyI4t4EVNBxfQxTI6t+V
         6rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766013524; x=1766618324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZvc3rVI0di0d/Re6Le5Bvc+vMvJtdhpmIxMnxjb6tA=;
        b=tI9Z3IjHJVUrZC20tAqtMoSoJKW986w2Nvv+6doFeRriuwEZJy3uonCFtwMFLD92tv
         b0QsfULHjkepqcwfGSeqAj1d9qww1RRaVonz8sTx8XY0bYk0BtYBA+G5Pi+t5Tc9owPq
         DVOWNcmKWM4kbtFBHXG5RnkSSHUoKpcvXEmV31dpi4mgokLGC4O7n9yXQEYuclBxEuxF
         7F9Z4cZppTbEHLBXx9y7UxrA14LWdyFpES+jkN19PaMEW3sxkEFlNyj2nr4qaFjNT2B9
         ywpwjVaWbFcWUYgqLz3lbN0ufC8DvSb+7yMj2tHByWz9ekJn+Q2FeH4moCVDXG+Av8OL
         etmg==
X-Forwarded-Encrypted: i=1; AJvYcCXCG9z6rK7e5iJF0Wgud4a1U7+zZv7yU0Lzzrv4nvdvuqNv7RhwMFKOLL99YY1jHp08UlZD0bmR+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTWInie9J8sM+lBPpCFrrQyTypncbqNxiqvXRRE0xnew5aiEX
	l5PYYFdYSdyJ1mDU3/Xxgguy04p+6KSoLgMHa0pcNHnM30s5V70AFsFo28YXGg==
X-Gm-Gg: AY/fxX44ODZERRUKjwTVAgPEWKGzTGTfeSB3ROKf+DT4Hp3Y8dh6Qw0LU5DpcPdH2wG
	s/EXf7cQ1AHv7nWl+Ys4eu7I8lH62XObIhm3a6SzypLM9m8nsOUoqxYrfxq3JYOBY+w7M4BwW9r
	OkhHDZR+QVQp+mieLj+wCBjjgCpHr3nMqBrYg+yOQ4lDuNKJGUd+KJE0XX5c5d5oWC+gqxr00ng
	wc/2Cxpp2jljC5QzUiTTQOCFune8lWa6XJqZZuNTSt3sOfyKc1Zne+a9LQhDky5R/9MkqEomdfm
	l2/lrVT7C75IlAn2XhYiePbq74oEc4QUfITMpN26AGkvBcIZ8jN4WFY2jYGJJt6DCpTUDP30wtK
	wgeWyjboTXikLkDWeF9sNXGFYLrS9goK+5A0/HKqNgtl54iiV5M3/PML+IFPf2DxI4saEAjt7N2
	3vGwNpv5aB
X-Google-Smtp-Source: AGHT+IFoFgIAi9PMNEfIKCxeozWxswujwd1S6MJvMAmdk00BzJYAqN7Mqo6fE4Jz6OZ88KHyEwKy2w==
X-Received: by 2002:a05:6512:3ba2:b0:598:edd4:d68 with SMTP id 2adb3069b0e04-598faa5a3bamr5789014e87.28.1766013524025;
        Wed, 17 Dec 2025 15:18:44 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-381134b5011sm2807821fa.3.2025.12.17.15.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 15:18:42 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	pavel@ucw.cz,
	rafael@kernel.org,
	gmazyland@gmail.com
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Thu, 18 Dec 2025 02:18:37 +0300
Message-ID: <20251217231837.157443-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b32d0701-4399-9c5d-ecc8-071162df97a7@redhat.com>
References: <b32d0701-4399-9c5d-ecc8-071162df97a7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mikulas Patocka <mpatocka@redhat.com>:
> Askar Safin requires swap and hibernation on the dm-integrity device mapper
> target because he needs to protect his data.

Hi, Mikulas, Milan and others.

I'm running swap on dm-integrity for 40 days.

It runs mostly without problems.

But yesterday my screen freezed for 4 minutes. And then continued to work
normally.

So, may I ask again a question: is swap on dm-integrity supposed to work
at all? (I. e. swap partition on top of dm-integrity partition on top of
actual disk partition.) (I'm talking about swap here, not about hibernation.)

Mikulas Patocka said here https://lore.kernel.org/all/3f3d871a-6a86-354f-f83d-a871793a4a47@redhat.com/ :

> Encrypted swap file is not supposed to work. It uses the loop device that 
> routes the requests to a filesystem and the filesystem needs to allocate 
> memory to process requests.

> So, this is what happened to you - the machine runs out of memory, it 
> needs to swap out some pages, dm-crypt encrypts the pages and generates 
> write bios, the write bios are directed to the loop device, the loop 
> device directs them to the filesystem, the filesystem attempts to allocate 
> more memory => deadlock.

Does the same apply to dm-integrity?

I. e. is it possible that write to dm-integrity will lead to allocation?

-- 
Askar Safin

