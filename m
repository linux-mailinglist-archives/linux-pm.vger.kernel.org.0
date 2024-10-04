Return-Path: <linux-pm+bounces-15176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520A99117F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 23:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2C6284B91
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F31AE001;
	Fri,  4 Oct 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WUlDdGX6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0CF1411DE
	for <linux-pm@vger.kernel.org>; Fri,  4 Oct 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077897; cv=none; b=e9WZKi6Gj8gCIWmxhet/F4PudFhhKjIAPZyS4FLoldmsi5ZTOIQESaPUoUHwJnA1zi0e1SCpeOVdHJM/z018ABxyAAXTvbDOAYUSg9aaU3oB74eDtoiZ296OsTHkqwWbkH6d0fR5Xg6h2yplExh4B/pAL4noAOq7rWb34VFA6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077897; c=relaxed/simple;
	bh=xL6oYs7txqJE5TKT/Uno4YPofgUAfebhf5IadXGF0yc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=av8CTjW2QpsXtCYzvnkcdKTY9OhwkJ8YJYn59n330Ffsn4CJsCnHNQUdAQ/3hDEdjmFSVHd4o8Rkc7jVMIUM/UnM4w+udPtnNdfDyS+nVfOmGgQ5yLttosFuhpGAT8CF4PT/Rn3baS9PPKoFT5op9UpgJBaLgEM4TagcmviDD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WUlDdGX6; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e2855479so2161761b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2024 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728077895; x=1728682695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gYgjsDPjP7HrNwnpk8YBK3/LqbS1xGGqsLZX+Agvmc=;
        b=WUlDdGX6+XcJE/mP5jK/wmuYy024E6vuUU9wzY30uH/94+FtS5lxNwkfRXGjbnue+4
         Kfwak8DMVu4dOOdqItc/6WfiQmgzZpKFSDPck3n5/4EmUaylGNyAnSNmidwIL6SCihXW
         B/7OPjiBdRj6kiiDbDjE4viJ1tSR+wHvkZRPTok8DAUyuHY7mYrloCEGnx0TUn0P7Kfr
         NtYZ0FGCodfTmxwyM2bIsIIJoyZtNcrxBxjqmvJabvmq/+lD5Zg4w9dAq1itAiexWDV0
         ExeEdI7D4VLLUjAguTQlhs1M0E9303mSGAzH9KlPvKDhDLUjPNwuTQXVzKUo8n0q+cpE
         DQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728077895; x=1728682695;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gYgjsDPjP7HrNwnpk8YBK3/LqbS1xGGqsLZX+Agvmc=;
        b=CdQLxWUwld24wTldRx7CR0/SYNH7AA7OfGERqz7FN5GwiCbv65Wou4f+qlD0lJtI7R
         SWflx1D/dl66ixAjqAfbVx0por/3uVBYLZdURPa/gBcQsbhmuG7YppOR8Vpuh9u18TEb
         Hf5rkGUQIL3SCAMXhu12HD9+FmEHTLtqgv1GdXpu26sJ0RYAeTm2+IJXddbZaH4EBKSm
         MPC1VEiEMvSx7hNVQVO5aEWRF40vCesnloGC9iHFjftjfU6jE+FSGYu8fufxpUyEUxuP
         98E+sSU3cUk3MAEajNwCd0ye/o1QqM7qwEcW36wn0TFrErGLTY1qbg34mvIwurMpGhCC
         3KGA==
X-Gm-Message-State: AOJu0YzLJIkNcfjZZrofK3oXeMj9UwKJaEqOoFF793F+wFr7tZwF8uwN
	czAntV20g44XBqks7Srmu4hUbFoh6le+ILyczJqV+l7W69Zy+EBqWH16hJSQ/WU=
X-Google-Smtp-Source: AGHT+IH3L/srL/M09LlQZunlLjeQulGlZd5i2/4jd/ZSLaq2ZBDuaJvJcMPXaGd40sqB8zTBbVklhA==
X-Received: by 2002:a05:6a00:1ad3:b0:717:839c:6822 with SMTP id d2e1a72fcca58-71de245154dmr6642242b3a.17.1728077895176;
        Fri, 04 Oct 2024 14:38:15 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d46312sm327900b3a.121.2024.10.04.14.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:38:14 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Andrew Kreimer <algonell@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Matthew Wilcox <willy@infradead.org>
In-Reply-To: <20240913093713.12376-1-algonell@gmail.com>
References: <20240913093713.12376-1-algonell@gmail.com>
Subject: Re: [PATCH] thermal/ti-soc-thermal: Fix typos
Message-Id: <172807789446.805985.12207310389436873259.b4-ty@baylibre.com>
Date: Fri, 04 Oct 2024 14:38:14 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cb14d


On Fri, 13 Sep 2024 12:37:05 +0300, Andrew Kreimer wrote:
> Fix typos in comments.
> 
> 

Applied, thanks!

[1/1] thermal/ti-soc-thermal: Fix typos
      commit: d8ee46b226ace0110f82233ba4c06ff1742ae443

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


