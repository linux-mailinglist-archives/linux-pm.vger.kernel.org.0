Return-Path: <linux-pm+bounces-37562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54819C3D512
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 21:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 464534E4A39
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780AC3AC39;
	Thu,  6 Nov 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPs9G8X9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83362C3258
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459286; cv=none; b=Wv8FCUt/lEYKCNLJE+yHjN3F4xWTlAJ4u25EYCJR7qtq6yHn7G5phee5Dwett5RhBweBnHPSq5Bax4Q9xU8A7vPc0TuI+9IenGeSNChFKwHqFaWgDJ9BubDXg7gIiRlwRGPqBjjCI6QJR/Kk/0eZmMZkD9T3b6/HNyn0hkLlwEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459286; c=relaxed/simple;
	bh=/RVfP0610YIt4L5/hYCpMwugXVmYG5GgiXajs25enfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu9CjFXZY7YZjEpE2Oj2fxRUwXNh0QUv9u7MfC5tV6EaEICpV0e7FpfMwday3gBzsE/rRkYjo2gJ2upf8Y1MFh4T12b6djyV+7KdF7PQOLY6kNkwGqC3gRIW3D3u+3hULEHQ7XDU3dNLCS+g6fJi6CgsBfC19gaXBZ+zduTY4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPs9G8X9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47754547a38so119435e9.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 12:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459283; x=1763064083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH7CiLaeHOxdySZSXu0AqoTXTbwIQUziIzU1/c2Rp0g=;
        b=nPs9G8X9xjKVQriunNoPgDRV1KOmORr4wKcQknYkVqo8mvKBn3XoRs239+oZyxWzNI
         7vrN8bEYCGMuaXRwkEh507gc0ljmFfRTs8mfUMRtNvRSqBDGZCTkftDedqdgpPtkbPkM
         JG6NyuwNsQ1iyVGtAKwYRutmNXmQGFbo4z2iuspsJpv5Wzd093zsH/DuR6deZqvohRL3
         NFKVs8mfe4LwYjIro8vMF8Q06iT33ffDl8wmH7JNUkuezALbAaWEMROWqTMDQxoeiqH+
         73Do8HNt41Jy//L3MrBVE89SzTcDOg9bJsKA1vNzFFnT2R4k8oC9/y9/ttLMvoruhD5u
         nZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459283; x=1763064083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GH7CiLaeHOxdySZSXu0AqoTXTbwIQUziIzU1/c2Rp0g=;
        b=IHXCpS7ZjUYJ7taB+LnJtsB1B/SnMy9vvT1LA07NX5REQFceBGiqsXUAl9uBwi8DJt
         mvY247iHmlkCTUmtXgeOk0rSYITxK9LYlEn92mryXBmQnHuWyRIz3IlBseoy2MKHF6W7
         vXcda/92OKxBI46G6RlSVBEKcywXmiYk7/9eM+XBIhrEf6JDpdTIy6mpLgjh2NlWZX0D
         XDnA8vmNtvg4FrrN/hvYWUoBj8QED8AhRQHHhLl2dZLpZNON2SVkXRuJW4SF2fpnMyYL
         yN89I8YDPa/ToywLBIBufoQdSNaS7/C/VcjCvLH9/ZBYB45YC7mklHWUWwjfqa4bsj/P
         PzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG/AMDx8UGHeWtoYLSmGt0ldE6JqMuZqz2JWFeU99qL9zHXwYLxsC/XrbGADcsiD893pcfMY0UIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYKNHGFtOw2QEg7drepTtiF7ZnhiKaffQelD8Y/ClHHklRxmWa
	gXSwpo9QtKxhyFj5L//FoUZXT7xCbnpixJyzsLhBsFTbNausdgI+h82L
X-Gm-Gg: ASbGnctidXEBqWdA+t18h9HB/poBllmg3SJTkIaVYfnfJDw/dT2yFyhwf7U/dusWKB9
	2FzkV1DiG2SJi0HR/P8kBfyOIi3kWuihQcM7RpX4lD7vjUjTaadZiEuZGqTMYAhGcoRD9Jc31P1
	BY2faZg1hmkAgnMErAQZAVAuaFGUEkE0jBgtCvCSQg3dSnWhTjfWyt6zNEIUUND76faNLHAW3WB
	hyJ1/ZhIgiUZZKsawR+t8OAX+nGx4OD/a5/Tn1++h0A1uEz+evAdIdh86JnmATVebWpNO0eak3W
	+3nHby89YRkZbQQLK7+hy91R0wWkKmOygRLCNAyc/fogHWuoKxfRZ++vaDXV/nDrv7BufAwKAbx
	T/TPvm7xafbGtHTJYIRVttgbZHnUb3CT9P9zlZkGZfJUi+RxtnNLs1F699yX1bLwn7rGxWf0n
X-Google-Smtp-Source: AGHT+IGI6Wr3SSGjm+C23YdiGLW8MqrqwbEkHb0h4+MRsQ1cm2FmVQjP33iSFpfhzOkuS8ZoRJh0Vw==
X-Received: by 2002:a05:600c:1d1b:b0:46e:2e93:589f with SMTP id 5b1f17b1804b1-4776bc96763mr4571145e9.14.1762459283077;
        Thu, 06 Nov 2025 12:01:23 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47763dd53ecsm25538385e9.1.2025.11.06.12.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 12:01:22 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: superm1@kernel.org
Cc: lenb@kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	pavel@kernel.org,
	rafael@kernel.org,
	safinaskar@gmail.com
Subject: Re: [PATCH 2/3] PM: hibernate: Use atomic64_t for compressed_size variable
Date: Thu,  6 Nov 2025 23:01:14 +0300
Message-ID: <20251106200114.8019-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106045158.3198061-3-superm1@kernel.org>
References: <20251106045158.3198061-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Mario Limonciello (AMD)" <superm1@kernel.org>:
> `compressed_size` can overflow, showing nonsensical values.
> Change from `atomic_t` to `atomic64_t` to prevent overflow.

This is bug fix, too. Please, add:

> Cc: <stable@vger.kernel.org>
> Fixes: a06c6f5d3cc9 ("PM: hibernate: Move to crypto APIs for LZO compression")

a06c6f5d3cc9 introduced variable "compressed_size".

(Yes, this commit responsible for both bugs.)

> -		atomic_set(&compressed_size, atomic_read(&compressed_size) + d->cmp_len);

So, we read atomic variable, then add something to it, and then write?
This looks like textbook parallel programming error. Very strange.
Anyway, you fixed this, Mario! Thank you!

-- 
Askar Safin

