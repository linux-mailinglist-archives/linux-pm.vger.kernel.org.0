Return-Path: <linux-pm+bounces-30248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C6AFADF6
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 10:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039A4188B27A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C331528A1FB;
	Mon,  7 Jul 2025 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X9Ev8Ni8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC3275867
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875403; cv=none; b=AaB6wNWsvlsrnD6qZeQMns3tZYGgU84pqMtYT0ZrvKhaeCZ8ofCPpoi2UukMheyWAJcOd7uRGCzoE/Ff6gV4/X4MGzMTdkG+oKUHMSorEC49EcdYpbQyQsIhkCSnT8dmrHDAvyeKE8aw69nTynbiVjLHkMbM8jIcekNEDwKqAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875403; c=relaxed/simple;
	bh=WQE2kv3HQ0gTQZ4sJoK5QnluNwdWhUSE4VaZEjb6gBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BW1HNpbfQTH4LyjXB5aQWK0El1kbw3KrBIcCptqDTsrSVGuGFW6inL28ytfIa3aFJTrQphhsqiQZKciWwtVi8ZNe/j+qwDh6rCfkDKr13dWMha+t7b7eNmS8xocbtWEaklE2bCmdxdUVnOO/mGn09zeF0prR1UYkpN+h/VwDl2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X9Ev8Ni8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2731450f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751875400; x=1752480200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8ER9RiwBf3a0PNuzWR+wHPlPKYNVAx60ODVLZpCr8E=;
        b=X9Ev8Ni8VR+vXSZ17LvHTTqKiBx58SkM/ADlXFfNLgkbZ252vTGdrnC5PhAyDlzmPq
         tbVIe35BJ8G75QMDg4Ya6L5jTbqbXqTugWaS+uCqUhkVe9Y8CJxIroW5zT9DiuxhS8aT
         i5GIP0TUhNzpooMwpVK2UZCsyUULoymVSO/Jd8cWYLl7FMOyZAqKOPuNSHMMYSr0o10L
         SjhEfnlidBHMSmmZr9Aa07r3cnzzL4lo4wdBO1vAx+IzqKrx0h+9Mh78LGTIdCfz8gNf
         KO3ykplQ709pTXgmxOfDu3x2D/KedTxBSHJsVktTfDMbNTKtVfS3jw2X9hZPc84xszpi
         oSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751875400; x=1752480200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8ER9RiwBf3a0PNuzWR+wHPlPKYNVAx60ODVLZpCr8E=;
        b=wUI8CGSKZf0+hXsdzDB7p1Lo0cga4Uzdtx0UD19/STthAFPuZ0ny02wKef8P0isaPu
         WApy8ejjhbVgXin8KTArUxhW+/lfkUQFKC4/rxQ8ZPyU7jIY+owgFxzTR8S0GpHwdG1z
         CNdcUE4DQ4UUmNANST+dq0NSizfnib/yxBAK+3sQ+MaiCQTDBa73xyR/2T5vpEGIX2n8
         wkUZJB867JBjTkJhLZ48KP6DBRxErOsMP+TKNg5n0p7ELWEsdw/ldxFo3neCQfT8mekD
         zXp3A0v6hgdeN0ygIAOcR9YzgY0FwXggGjw/Krbvm5nqDXel2qWJlGQ/gJvA1BzJQQSZ
         v/mg==
X-Gm-Message-State: AOJu0YzqjZb4FSNs66majG5bZloEtMsZXVXNWvkPAwBTFiKTmi7T6xRl
	9Z7llZwVtBtiVIfBOHI64yl2YaHcDlTfWgP/gJtCoAOCSkbvn2kIpKu6u1eabZw1MabjXrQzCWh
	Y46xSvpM=
X-Gm-Gg: ASbGncuXrWMSm3qHx5tFNYRNTRqZG0kmrwhcWWkSVcaOP44cj/mE2Sd6W5hSl7H2+eB
	pVolSL/w4t40ScnZ0ozKDp5HRXT2ECz8ss0fd//46ct6ZbnuM3YWHsMLcLtFodHSa8dDXyo2JoE
	GOs5KdJhddik6tNy+0YrgBi21y4oJMITcKzZGM+Rwfq77kLy3Mfo7wtVlmPW8emlw/2lhwZw55O
	1TULVHH7TEqjJa2nzl0mXAMotieS1dtbHLwczf23lxNHXZjnCDLW9eOKnmNi9WxMA7ARJIiRWeJ
	acMStEmeQ6V9ghJEGjDUtoC0pyFhObuwMJbISM8zro2o7oP+TDFQVYVsV4Q6iuw=
X-Google-Smtp-Source: AGHT+IEuKhwyI5Z+SjqvtbsXi6ZzIS1X4CZuWomS6qhOy+fAEFEaFFSGiYj31JlHRtL0PKXI2U00Ng==
X-Received: by 2002:a5d:64c9:0:b0:3b1:9259:3ead with SMTP id ffacd0b85a97d-3b49aa73e31mr5001650f8f.28.1751875399847;
        Mon, 07 Jul 2025 01:03:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3cf3:a61f:85ed:69db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997e367sm130980235e9.15.2025.07.07.01.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:03:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: (subset) [PATCH 00/80] treewide: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon,  7 Jul 2025 10:03:18 +0200
Message-ID: <175187539072.14957.12381640890960188309.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 04 Jul 2025 10:52:25 +0300, Sakari Ailus wrote:
> Late last year I posted a set to switch to __pm_runtime_mark_last_busy()
> and gradually get rid of explicit pm_runtime_mark_last_busy() calls in
> drivers, embedding them in the appropriate pm_runtime_*autosuspend*()
> calls. The overall feedback I got at the time was that this is an
> unnecessary intermediate step, and removing the
> pm_runtime_mark_last_busy() calls can be done after adding them to the
> relevant Runtime PM autosuspend related functions. The latter part has
> been done and is present in Rafael's tree at the moment, also see
> <URL:https://lore.kernel.org/linux-pm/CAJZ5v0g7-8UWp6ATOy+=oGdxDaCnfKHBG_+kbiTr+VeuXZsUFQ@mail.gmail.com/>:
> 
> [...]

Applied, thanks!

[15/80] gpio: arizona: Remove redundant pm_runtime_mark_last_busy() calls
        https://git.kernel.org/brgl/linux/c/2fd13c8e5be15369d157da3277ac7407fa73f90a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

