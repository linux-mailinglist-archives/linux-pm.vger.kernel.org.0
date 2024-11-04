Return-Path: <linux-pm+bounces-16996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EC89BBD56
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D1B1C2146E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940D71CB9E9;
	Mon,  4 Nov 2024 18:35:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2531C4A2F
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745329; cv=none; b=jMEcTIYOXaoCkRll42EQ1BlXLlqUzga0sr5nEq8diK1RbBVdLhNXywgzjBwFr7KB8w7bzzZj3+0n8X7kHXApzpCzZYP78czXmMVMpZEiBgvBvHXAvym/E+xQM9B7E9GALaa/zXN++KOF1cgZn8bPtX6lOjAkhJvh9/2W6XEiX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745329; c=relaxed/simple;
	bh=0q8JDwWzDntd/aeV9gPiXXtsjosur55lq2xvMgVntdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMvS+6Qc/THRVwqUPZ/4oQb9gHAsIWM0bblMdtKrAGRdz9k1CX6mMMU+MmTZJvVR7CyPSBsvkgs417S8+IZJt6JEoIKKyr9QTVkrjzlSLp8hojLv8PmVl+50uxkUgjWGwUGwpNnR7er+Uvopr66hfXO2tnzknK437sgkl5RYQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so3614998b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 10:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730745327; x=1731350127;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5psdNGZt7yO/EGDxsF0O7Dn6TNWS1865Oba3g5L+Z4=;
        b=wT6yRX8mOM8ktojcZcWrZLbwFnB3asT2vh1Z/tgFUgUm4w9LMkAAJ91SrqYu2LkvWq
         J0v10mX3bp1pvydyxy+VE9Hcx0HbIk/8NisJ79PbveP3w35NDvHW9jEsrMTEXRAPakWm
         EGqB9VuuDBaXqiFRfHVO1ML73EpGL7UN5HTjLeSZNWSviRqeX0+w7zdwNdxEbB7uBeyw
         JG5p7jJvqhvauoIr7vB1R8l8TgqyjdXVBEShzxInP3v2kpCjOaMMmkjcFrgW3qaewBba
         uUUDPOkgKE3PztdvpT6n43gnK6col3JigstgGXXyBvcfRhBMCvv7s3V7U5Su1nI/6SVg
         qgBA==
X-Forwarded-Encrypted: i=1; AJvYcCXFqMLgMe6mLfvyW2sC5W8YkqbFpnxQWHs94Dn4PIvuLkJ3NvyqvNFUR2IiJAjwx+/hQ6+LGdp6sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykEqpjjudhxMu3YQmHMAjfMNdZcQELHv/yo9uKT8XFzhwh72B7
	uL8ke5iA8/uiIzDP000PgA/rVN1nIolp+VLEK6DIq0q7bq/7ReM8uPjfb4OIcqWMJeY2IYK+Orw
	BimE=
X-Google-Smtp-Source: AGHT+IFdG0hVRz4dPBfiFMJhFlY8swzM18DsMZV8IwIUprVfLFdN6Gv/FIxkJZSrzjoyHAC39n6arw==
X-Received: by 2002:a05:6a20:4389:b0:1d8:a3ab:720b with SMTP id adf61e73a8af0-1d9a83aeab7mr46788718637.9.1730745327258;
        Mon, 04 Nov 2024 10:35:27 -0800 (PST)
Received: from localhost ([97.126.177.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a0eae9sm7369576a12.84.2024.11.04.10.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:35:26 -0800 (PST)
From: Kevin Hilman <khilman@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>, rafael@kernel.org,
 viresh.kumar@linaro.org, zhipeng.wang_1@nxp.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix using cpufreq-dt as module
In-Reply-To: <20241103210251.762050-1-andreas@kemnade.info>
References: <20241103210251.762050-1-andreas@kemnade.info>
Date: Mon, 04 Nov 2024 10:35:26 -0800
Message-ID: <7httcmonip.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Kemnade <andreas@kemnade.info> writes:

> E.g. omap2plus_defconfig compiles cpufreq-dt as module. As there is no
> module alias nor a module_init(), cpufreq-dt-platdev will not be used and
> therefore on several omap platforms there is no cpufreq.
>
> Enforce builtin compile of cpufreq-dt-platdev to make it effective.
>
> Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

I'd much rather see this fixed to work as a module.  You already hinted
at the right way to do that, so please do that instead.

Kevin

