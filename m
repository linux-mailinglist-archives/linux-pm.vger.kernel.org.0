Return-Path: <linux-pm+bounces-7707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CD88C20E7
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 11:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0C12821DF
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E516089A;
	Fri, 10 May 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1KWDMqE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E1160877
	for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333309; cv=none; b=YOGKz/byHgt4qSqLUoil8RWA5H6tG95x1ivqdBCZ+RrXujimzqRR77XVslSb5Xm/p6mCpw8xaxuoTFwfF7ywjprRiMYOOZmcmxbLQ3lbtUeStbcjtbrQWO9Je30j4zuZqoWgdbGgnyw/r7+LfLISmR23X6M3V90Bfe5pwHRWiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333309; c=relaxed/simple;
	bh=npkEZI4MXw4nJIcvLl+P2EYGWqMbLDMcOWgp259eNj0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fjFaBjhbfQgQd+o8ouLx2B/RMhrOt/4GOHz1Igy9flpi8A18Kh+jN6/VM0hVIGMI+McNho6L0CehUI7CsFflfIFvb4n/SA/y+PBNIMbFGo9VvVvQGKrF5fAGyfLR6k3j8758Ec4T2KmzGjhZ9V5X3gtiWbd9abb7rUpB9+gkd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z1KWDMqE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ffad2426eso3033255e9.3
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2024 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715333306; x=1715938106; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH7osSqVMbrj6VsQFgjVp/pbaHR3TYk56MkptLMlbMo=;
        b=Z1KWDMqEGTg05/IsaK+D13jdU9ATHxjCul6A4xYZBsEKWffNSjp78oaw3Nsu8HV0uP
         0PMsr0nx4SghSmGeCOQc+8OJ36lr9bX3WuEMprzaEdZ0xk/ru3A9A7qKq5T9Xoj1gjAc
         lNZeryYvwf2GIpAgB278Y5SfT/8/tRvPbmoy6jObEb5oc5L1EUWaYOu9zlqIFQ56dNn1
         4YF6B5x3BHU8oUalfb24IskQrxs+/wOiRJQVxXCqYKnRS7Z6LuGr2Jbdgj+Jz7yu8TfY
         6jCbWuumDIiceJt/dJ9jtXTTLejOTOzDdOmAqCQTTb8wBax2zoMR94x4C3fv+YMra33s
         a0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715333306; x=1715938106;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wH7osSqVMbrj6VsQFgjVp/pbaHR3TYk56MkptLMlbMo=;
        b=dDTR7QSANGp1oAn8QpfG4Gn+y8y4I/hQTVp5U/gupFaqIR7PJl2k7fVGGT4Ezvljme
         Z04iKunR7tycMeaZvkMeGz0Hoid54hiyFUd8oTdshujzqybJfTJgz7A3xmZnwKxLfHdT
         uiJAHDvmkl3lB4mMOu0U/gRwJQCO02uy2/fnr7ILRuYhzafZ8+8fULnL7xOyMLPc39VV
         RwMzZlh9n4khEn8jW2uu5Ddsgb3eQT4PS2fbXF56vD01koM95TUTj8rIvDlFXrXtC4O3
         8Ov55h7YxV2N2F/f3gdEG1U0So1kFP64HNm2GspMAXMs+UlhQXXeEDIw+n/e7q2PoCzV
         ldxg==
X-Forwarded-Encrypted: i=1; AJvYcCVNQpAqgHJHS0+LQNYDIO0lCmQeIuozX/3SKu7FEeIrvjibNEnSMPoEFVpz2HlYJpe8KvqGdYnIsOXRy7c+H1UTpbXgKLYr3rU=
X-Gm-Message-State: AOJu0YwAEp8NDv5LLhkVfkgY9l1evvyDaNZKsdT6tJbijwOIglHChxVH
	GZ0EWidV/pU7U2Gp8yh6AXmXLJA5/8vxi4uaODG9Fd6N6BgkeJRQVxD4SPx5Qjs=
X-Google-Smtp-Source: AGHT+IG/8TWcbU3oR2gbc1O+Jdy2h/xcTp99F0XzD8u9YQqAeOagcu6s3MA7ns0AfEWm4csQl3AdLg==
X-Received: by 2002:adf:fd0b:0:b0:346:1443:27ea with SMTP id ffacd0b85a97d-3504aa6886dmr1678726f8f.68.1715333306012;
        Fri, 10 May 2024 02:28:26 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41fcc6fd84bsm57306335e9.44.2024.05.10.02.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 02:28:25 -0700 (PDT)
Message-ID: <69f74548-147b-43e3-acaf-8b62c51f131d@linaro.org>
Date: Fri, 10 May 2024 11:28:22 +0200
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
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Stephen Boyd <swboyd@chromium.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers material for v6.10-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

please consider pulling the following changes since commit 
ddd9120983c3efbcaa3a4c7777da1440f8ce27d8:

   rust: time: doc: Add missing C header links (2024-05-01 00:04:47 +0200)

are available in the Git repository at:

   ssh://git@git.linaro.org/people/daniel.lezcano/linux.git 
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

