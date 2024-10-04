Return-Path: <linux-pm+bounces-15175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98939991175
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 23:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4087B1F228C2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA691448E0;
	Fri,  4 Oct 2024 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qb0NHHuw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFB83CC7
	for <linux-pm@vger.kernel.org>; Fri,  4 Oct 2024 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077294; cv=none; b=HfGxlfEhnB0+nU4oJT/ftXGb/9v346tUInk2Hjj0rORLSC8dxbTGu8y9gu/uaU3YoCVaQ+wptNZ4SoO5M3EdDNt+KV/xfLKjGcUuPiUmPgdutHS/OiGaxV/wmzK/IOMFu8z4cIxQXsQdA0e/Cb9AqpKrrMHZkXcQWYMaXRaSGCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077294; c=relaxed/simple;
	bh=wyXY5FEitn8Viv/NzZB0ort+vq2QX60jHpSPvoMT3G8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EsnC2AJjrnJEzv9CFHCTsuWiiR/WwvXgGyGHF6NxNk6VO16Ttkqrbw7jlwKLUlVhH51APeRD5dKpircaoCrPhA1aRGO7XnaNGmHzYyWeNFGsbSLf7LmOy4K9Dfz2pE8I2RjBPMU611gJBAyxAeY3qO2EHH5eEYNq2g0Z5jdRMig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qb0NHHuw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20bb610be6aso28909985ad.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2024 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728077291; x=1728682091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VEEGg3N3Qrjipl8PNYwMGtQtQRxCMWX35YbNuo4oZw=;
        b=qb0NHHuwebOfoKzRTnrJlULSA+JEmvGUChz9gUNZzY9eLG1m715DGSExiAXmodAlfe
         2YrNgrZeHWZawjeF4YG3vOA7GeAbZ0/OHJU5ewC3ss4m+iLLPuUGOglf9zeWQRgfWFSw
         ftGRwokKf57Fi9DvBKdsyxilIbIZgRu8vrbXa6d2cu7cqPk/qiL7wXlZRfdmi8LcZ6y7
         jG5T7PqGDpwsD398P+W6MaLNyNOmmYtqDeVgltkNm3TOMdrqtkfSuw1Mh0CbgHe+tzfw
         sTh9ssMXqPwiGOkrV2Jq3RTzvQaPCqvt3kWmHYzRGevauZ7VLqRTyjPHOrpdOUl9eqPU
         8tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728077291; x=1728682091;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VEEGg3N3Qrjipl8PNYwMGtQtQRxCMWX35YbNuo4oZw=;
        b=DMchej/K+DFPoOszgHkERWKdSVHNcy7xDaAZBUnHdHVuvxMTjzApUTwbkBb1+IWTM1
         3BeVfzqMOfHmY9Rbv7ODZcR+BAX8JuNXvlzQrDH9o7KfRY+r7yukKew6M+MkgRSI4KfT
         ClLdmh49YApPCqqCF3lMGJnoV/xerSJeuFnZqPwZNZZyvxdrwGJCP2qH2fO1GJmIxyt+
         lqNQyAtUtrrsoIpjwoj7+vIcPNxVgdjGGX0jsw06CdI5SMYPiWmcjYorKitr8O7Z7MpS
         +oGQk2cdHGRnqZ1RKvIpKabIgFiXK33duBqgWhZNdsmfhOgVr9SzL7UqktQEQDxJrFIZ
         PUUw==
X-Forwarded-Encrypted: i=1; AJvYcCXHgwahEsBdLkwaffat7w9OQeYQrBmVA99gjmOSWtjOZQEpNwIEAweg2b9R4jZg4psGhctqRBGXZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlzxUo9SSOVU6LVpyLDbMrBAThEdaBfufbmktKX/Dr2YtOwYbd
	Hbv5SK/Ic7nEoBcYj0NjJZ57vTvbUVpnniAv4beRW08i34NM5/cquVH4fuiIqup6od7Qh9Msad3
	n
X-Google-Smtp-Source: AGHT+IF0hJd7SYbUWczI5l6I/MfOAJbNlwZRQdThPGRXqq9xwYSJ4HmjE/ZsZ1AjgkCq+ayFrviUBw==
X-Received: by 2002:a17:903:2350:b0:20b:6d8c:463 with SMTP id d9443c01a7336-20bfe073becmr52987585ad.35.1728077291333;
        Fri, 04 Oct 2024 14:28:11 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138b0f10sm2940465ad.37.2024.10.04.14.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:28:10 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: nm@ti.com, ssantosh@kernel.org, khilman@ti.com, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240912034147.3014213-1-ruanjinjie@huawei.com>
References: <20240912034147.3014213-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH] soc: ti: smartreflex: Use IRQF_NO_AUTOEN flag in
 request_irq()
Message-Id: <172807729065.791992.2029295043317624218.b4-ty@baylibre.com>
Date: Fri, 04 Oct 2024 14:28:10 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cb14d


On Thu, 12 Sep 2024 11:41:47 +0800, Jinjie Ruan wrote:
> If request_irq() fails in sr_late_init(), there is no need to enable
> the irq, and if it succeeds, disable_irq() after request_irq() still has
> a time gap in which interrupts can come.
> 
> request_irq() with IRQF_NO_AUTOEN flag will disable IRQ auto-enable when
> request IRQ.
> 
> [...]

Applied, thanks!

[1/1] soc: ti: smartreflex: Use IRQF_NO_AUTOEN flag in request_irq()
      commit: 16a0a69244240cfa32c525c021c40f85e090557a

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


