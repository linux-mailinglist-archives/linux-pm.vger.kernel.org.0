Return-Path: <linux-pm+bounces-7708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B80D8C20F1
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 11:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536391C21B9D
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6858161936;
	Fri, 10 May 2024 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFwaHIaZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9D160781
	for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333480; cv=none; b=Gcr9VrFq7j7QRqPykV81tGddYvMwABxcXUb6k+5/FdIOOfxlrCSBtUpcEEj73j/z1AJM4iX4JCxJOKd9wIc/w0MmbFl2chL9hEJS4JGbxKo8Vl8PYniyAvjvPR9gcruuLZRGpAdKepNbtZ6xIcjNPeLvC4Yn6VF3SjVErZVNiqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333480; c=relaxed/simple;
	bh=1ehQiSaLFczQ3C6ndSykL9Q3gPDGYGKLOk6Q+lqp86A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ps2GJ7rxN/1XfovmvgngLVQf0nyblOeJNYJG7b7YSNjwBU4w0snBHETagbiisMYJ4HSAHMqmRNyK8axnym5X1x6FG5spCkI5GrCetJJ5W6cNRGgNHbWmPAVdrym7MAAD+GaePC+2g8Vfx5uOMM8BOy6GVEO/pJb7Y712L426Jvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFwaHIaZ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2db13ca0363so26762991fa.3
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 02:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715333476; x=1715938276; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ip9PXkybLaEQBt70OiQvM7t2Y6c0e0LYBsAJfrulXVg=;
        b=kFwaHIaZXlJni+jFnwmsDmenwTvoGQE4QjtOfXqJCOu9sT1vKjheN4//UTMPCGVFap
         NXZ4CdkZLcOtv0ExoioaHd/SSBM/8UfAVzM49hK4+TvdxaWKPH2YZxescCYVPac7cuxR
         SWj8btGXUarmMG9upY/cZUrwWBU/fDC7Vft6+NxVsm08wDw5ShjpgsEtJ3BlycaTl8v1
         pCESfXzqARAVw8WOsekkHi2CR2vUcZuCQ7kSkdtYIlhA3isH55si5q2V9PqpKQPA04vL
         FTUOtSYfx0qW6pdCFOxXy7Fp/mV3sqh54sP6nMjgDXKTFSF9Ld4i90fQAGj6ouTWFWvD
         mxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715333476; x=1715938276;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ip9PXkybLaEQBt70OiQvM7t2Y6c0e0LYBsAJfrulXVg=;
        b=vIG2f3/UGegNLSLTXDf7VEETVmqOM5/ArGVSDJvBseRo3hWchOYZ0q1zzq36ECnAHA
         EiMCLf3PbpX6Kp0+BWaOaL8VBAGUzgCtuTsCcBoXn1BUiVONWkLibIG8cqxGmgRv5oH1
         3XRPpPDpJPDJYfkwFMm9m4ZCXgWGo+2TDDLtcBE3iCw4bCwF5Umry9NTfpU+47c8P36Q
         kup5o7YeyAfQ6m5F3vz4c5O2rBhNfkHm3oOW85m55Eztg/JN1p6yPyw0O0bzDhQD+mPj
         9Y2wwpJ+lTLEEVKKbK7iuCiRenOWTKk2mK2yZys/OmhFawrlaKDTMMbtDceq1C1kGll8
         OJaw==
X-Forwarded-Encrypted: i=1; AJvYcCUZmCobGcufzUWFrODrp0GfEr1zDhc/cB2EbAD9Orv9ND9Fb2PD3DqXDN7qGMoray58gbeMR5AP1nClp7a3AYH7AqzWYqLQc/I=
X-Gm-Message-State: AOJu0YwzKvckYBDgPKulkHoDqwICLnD2yVokBRprTJkk62APAE4dF4RB
	C08SPBC/pG24gs8ccEQ8Y58xyhpc7xJMJ1BqHjMyhm0KjKtEWuIQDM5wShBZVV17fHeOjXl/o+4
	H
X-Google-Smtp-Source: AGHT+IEZZ3gctK+UwoQfw400JNbhCfb08v2O49Hv9AYMy0UQAMPf+n7QDhJV7nrN9/3uu7FCqeg62A==
X-Received: by 2002:a05:651c:149:b0:2e2:9842:a9d3 with SMTP id 38308e7fff4ca-2e52039dc3emr15242551fa.46.1715333475863;
        Fri, 10 May 2024 02:31:15 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41fccee92c7sm58720425e9.34.2024.05.10.02.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 02:31:15 -0700 (PDT)
Message-ID: <7ca1c46a-93e6-4f67-bee3-623cb56764fa@linaro.org>
Date: Fri, 10 May 2024 11:31:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Stephen Boyd <swboyd@chromium.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v6.10-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

Please consider the following changes since commit 
ddd9120983c3efbcaa3a4c7777da1440f8ce27d8:

   rust: time: doc: Add missing C header links (2024-05-01 00:04:47 +0200)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v6.10-rc1

for you to fetch changes up to 2030a7e11f161b4067bd4eadd984cdb36446fcca:

   clocksource/drivers/arm_arch_timer: Mark hisi_161010101_oem_info 
const (2024-05-10 10:43:21 +0200)

----------------------------------------------------------------
- Add the R9A09G057 compatible bindings in the DT documentation and
   add specific code to deal with the probe routine being called twice
   (Geert Uytterhoeven)

- Remove unused field in the struct dmtimer in the TI driver
   (Christophe JAILLET)

- Constify the hisi_161010101_oem_info variable in the ARM arch timer
   (Stephen Boyd)

----------------------------------------------------------------
Christophe JAILLET (1):
       clocksource/drivers/timer-ti-dm: Remove an unused field in struct 
dmtimer

Geert Uytterhoeven (1):
       clocksource/drivers/renesas-ostm: Avoid reprobe after successful 
early probe

Lad Prabhakar (2):
       dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2H(P) SoC
       clocksource/drivers/renesas-ostm: Allow OSTM driver to reprobe 
for RZ/V2H(P) SoC

Stephen Boyd (1):
       clocksource/drivers/arm_arch_timer: Mark hisi_161010101_oem_info 
const

  Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 ++
  drivers/clocksource/arm_arch_timer.c                      | 2 +-
  drivers/clocksource/renesas-ostm.c                        | 3 ++-
  drivers/clocksource/timer-ti-dm.c                         | 1 -
  4 files changed, 5 insertions(+), 3 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

