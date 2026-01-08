Return-Path: <linux-pm+bounces-40504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B0D0602D
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 21:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE3D6301E210
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA8428C5B1;
	Thu,  8 Jan 2026 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OuJyDc1N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2F27F75F
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767903361; cv=none; b=WqUOSI8zshbv9VRThN+LPA66CrLqAer2pWpcIy1ODt3khbwpvS1FSNekg9bj69qbRgOB9J771V5NoAHNVXYAOhgqRXKVT7Aosoy+/N2FmkL2HDKyiBHFsqwcMSY/v+4+6p2ZVYPCuBBpbh/36FIuHjzoG+mhxsdt2D5FrxPqsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767903361; c=relaxed/simple;
	bh=a/+cPvIJX94uGRv1+YvfPX7h8IidmOsGYVouQwyP1U8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a24McQWtqxC9x5WqKQ8zGO4u/A5XNYi8TRwJNS59j5ctajkCbx8t+kv27pxP1Z6vi3yR+W9QB4w5AUG8jPE62JrdVkL6CHp5k0b6GVSEQiVRVnxr9v8DEUztVep3/YC1f1YorxrHFeM/aASBG8Asl4VbAwprJSVKc4d5irgbZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OuJyDc1N; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so1927313b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 12:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767903359; x=1768508159; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/+cPvIJX94uGRv1+YvfPX7h8IidmOsGYVouQwyP1U8=;
        b=OuJyDc1N2F9gbm3/SdbtD5d0Jn73k06UKtJNYrEtRKjYTRvmwjABfexecr0eFMawMl
         E/+THkbDVaw4XCftwSQG5hNs8nb2/QrCamN0GAs9yTx/bNwDyBquML2dWIdbnw1wDGmE
         jlpQ6EivyFSU+K/eqw3Ui6n1ALolnZUDhO39T1oDs57jAaBwc2rjqfIDfXvSca7OzLD5
         atmXOhJskVVRqrQuPpm4HnFBOMrm1Fh6FSBkmPZjO2o2hOEEOSIg8oQROeikjmWP6pWM
         mINxZvnEnMYxsNgeknmi9mA6xwF0npTYt+snnpwDlGyM7DLUxwK/79Nr6ddpwGGfI0nT
         6F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767903359; x=1768508159;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/+cPvIJX94uGRv1+YvfPX7h8IidmOsGYVouQwyP1U8=;
        b=oZAhQ7fb9ueabZkeB01vD9yR6D5BS8c98MX3UTZJEZGPhbX6xvLy0oAFqE8Kzs6pLy
         6fpQoXgT3qET7Fq75PhRx2/i7JwFk4UZu0lIIEZp0Bm9xoASY7iGbo+0kHpryqFnZ4SL
         5pj88utUHZ7gH4CxWVWzOrEs+ziPG1jGrUQNbZc9WT3HPUauuPYAIWYoL2hAA0z+Kpuj
         6u4Bs9MRB9pi6OFAC/s1jpy6VOjeh2VRo8FB935g0lctNg84okLFSgWfgftQ7OMUp/l8
         vcjZHl/JSX7uOyhA+56XyaUbJ8XVHS27tgT649Nf9q9xWKDUMJWKdR6wCYnzqfdIj6yi
         vEhg==
X-Forwarded-Encrypted: i=1; AJvYcCWYHEHzRIwEfK9VhL1v7HpN33tx1T/8K8N4Kg1asbAi9456VPP7tNjtnuiwwqouagS5eY8+3Ve1ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQlCzMR6Dw1Cmgo36nn+ogoXCw8uZH7u6E3m2w0cLYS7s2P6f
	1Q25mYzjzuzLe+fJKoNqTkDSVQw4isytnrcYwYbasnoy8ZAwxng36PExaDja7j6JqbHR+p/rd0Z
	y5KZE
X-Gm-Gg: AY/fxX73cRmFqiJ/25kZr7WeSLtRb/9fcdIQID4FEYa0bp1tJca9NzFwqFWLXIunFc9
	UgBLwRh++zJro/IpFiwC+OeWyaaBwMdhxERYJGArsKPhKd3aEyI5lVnMdQ6JdLhOTB9iwlnWY8q
	g/C+1TufIbu11LLrlI/Bik6Qr66iyAYsNDAOzYGJ+1/zd1XllssIGvHt+gRB+T9mBnBz7LxT+XN
	IXpGYRuxMfWVAegdFbBuhTz72K7Wnj7+sx2k9uG5lxaadQhTRigAD76Mst1bXwLSHWsLCSqhzVJ
	DOhSAozMO0+jm81ekx2yZEjtJI9h/iU0dWhDDFMqfg5+7OLUTfb6KLnyiEE0VR6jqwt7GjcHvW1
	Zbygn3emqFlPrdhLWdNORNoCxF1R0uwyciUI/0xndQxooFIuXAJ2TnWGx7V5etdX2brq+CilssT
	mZ8sr+pTuc
X-Google-Smtp-Source: AGHT+IGEyNFxCYg+mz/nYXiyeR6SQHeALYFtxCcsGh7BEUBtCA+13vI7tMziVphvGhB+YDfWmtgivw==
X-Received: by 2002:a05:6a00:2c85:b0:7e8:4398:b352 with SMTP id d2e1a72fcca58-81b7f7e28abmr5865999b3a.37.1767903358688;
        Thu, 08 Jan 2026 12:15:58 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f90c0sm8425980b3a.41.2026.01.08.12.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:15:57 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Andreas Kemnade <andreas@kemnade.info>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Roger
 Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] cpufreq: omap: remove driver
In-Reply-To: <20260108-omap-cpufreq-removal-v1-0-8fe42f130f48@kemnade.info>
References: <20260108-omap-cpufreq-removal-v1-0-8fe42f130f48@kemnade.info>
Date: Thu, 08 Jan 2026 12:15:57 -0800
Message-ID: <7hcy3j6ete.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Kemnade <andreas@kemnade.info> writes:

> The driver is not useable since 10 years, and the affected
> platforms have alternative drivers, so remove it.
>
> To: Rafael J. Wysocki <rafael@kernel.org>
> To: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Andreas Kemnade <andreas@kemnade.info>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Viresh, this is/was technically maintained by me, but feel free to take
this via your tree, or let me know if you want me to queue it up.

Kevin

