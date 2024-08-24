Return-Path: <linux-pm+bounces-12849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E7395DC2E
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2024 08:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998611F22AFD
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2024 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6714EC51;
	Sat, 24 Aug 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vyuq0/+s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03E257D
	for <linux-pm@vger.kernel.org>; Sat, 24 Aug 2024 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724480404; cv=none; b=Zl2MfJhjDutdTS134hjDU+KkKLr43vG+5Zucp/bjOY95443mnowZ87zWbdwNb0IlTozNv+WwIBUjCwbXaRxAbwG+2+A1U2aTShBu2WPpt1sNohnLpS8dmggvb0rgivixjy9q/SGGeNPNBzEjkdJxW4HMp34LwPsWYXVNXFQDJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724480404; c=relaxed/simple;
	bh=EeMk6zR8S2c0ximx6O7l/79gXOXg6MjS86f9TPZU0hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGWaQfnUCG86F5Ol4CDEmemPHK/b+87sOrtunSaFTz7gC0iq+9HE31mbInJxFrjSLLa5Trc/TYLeUXgGOFTeP8tXg4hFjXpubn8Unav5fYdtgWN/WAde6GTioPjts/iHFVgrk93Ie9WAddnLuuG1ikUixKvlwrqDHOVszHa17W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vyuq0/+s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428243f928fso28057745e9.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724480401; x=1725085201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNXzmFzt8zwRKXkUvUv1Oo5DyxyzWekXdqMAP1X0YnY=;
        b=vyuq0/+s/VxY81poWvHcJ+I12K3f0z0S8cYgrrVQdwL+7JihImdoNh9MQUIEkA7AmT
         umbrnn7s05B0lsx/8NgQbasMKjzLHOny1ZKvQgLVHZqQ+m+ZT1RlJgX6kTymSmb8HgmU
         oOSSKitFywc94+2oJKz9Q35ESN8XDUshMPUToGCqEO3fBL8EOY1kUyYKZIqUZuoGfjk3
         lP/1VBOAX+8Z7Jbb7GCQM+KkMrkZ6BVmLpm2Z7wzCVLdlOmlrlMAKw+fr6SIaWyquRca
         zush1NeAHWGpueuiXeTs5gJqGcQRQZIKTyYX9P9midOin0hSbvkJWXSeVeFts9HzkR8C
         4Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724480401; x=1725085201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNXzmFzt8zwRKXkUvUv1Oo5DyxyzWekXdqMAP1X0YnY=;
        b=lvvw1dnJ/VAa+YCZ7rwOdFXOSgSij0sEZGUxaSqqR8/wlmnyeZNfiZDJLJ2edNiizC
         Icej5djjR9528rotW+IO0rmeKyGynaxMBfAigDhzJYgYHE5h2bjChA9021GkGJjC4bNV
         FUKWkUcPgf3uNXQ2YAclxlJFeVlAwrIXusS6tOetzYLgs5JPCClPuIZDBsw+qDnE8k5q
         3NxVtQa+QQY759LhRwAjgnMZ0TGpFdZLK5QnQVle4AvRgm1H6cQ19TvNlDpsovtTsntX
         AamN8VPQWX0j05c35KvoOQRsGbBjEtGRezvUmSQ2f1gzbnuhrPxhvVWfxP5e9OWnn7PN
         u5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVo5yUPAOld3a5eqyMl5YONbx+RNIE2ULydDvWRlDezE5Ljt+Ur7eEoHdhNmtKffNJz7A6EkaQ3ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB4h+JpLJWIE7pHHNwYc0IwgwTH6p8YhSBy8azKy1rVYcwjEA+
	zXdpZVWAwE7AJ3XtruEwyNevzN+D8egyozGzMxtlB8/1BpWcloIfE2qHYxrQDmE=
X-Google-Smtp-Source: AGHT+IEHTvJLq/5LKA55HZM/YAnrjvBb6HymsfRGOHL84SLuE1MlZTEN3b7J7xWlo3QZTaSu6XyRtQ==
X-Received: by 2002:a05:600c:1c01:b0:426:6ed5:fcb with SMTP id 5b1f17b1804b1-42acd5403admr36758795e9.4.1724480400199;
        Fri, 23 Aug 2024 23:20:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:191f:3b0b:a64d:436d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821a8bcsm5734817f8f.90.2024.08.23.23.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 23:19:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: qcom-wcn: set the wlan-enable GPIO to output
Date: Sat, 24 Aug 2024 08:19:58 +0200
Message-ID: <172448036345.5702.13190366872471191686.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823115500.37280-1-brgl@bgdev.pl>
References: <20240823115500.37280-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 23 Aug 2024 13:55:00 +0200, Bartosz Golaszewski wrote:
> Commit a9aaf1ff88a8 ("power: sequencing: request the WLAN enable GPIO
> as-is") broke WLAN on boards on which the wlan-enable GPIO enabling the
> wifi module isn't in output mode by default. We need to set direction to
> output while retaining the value that was already set to keep the ath
> module on if it's already started.
> 
> 
> [...]

I'll be OoO next week and don't want to leave it broken in next so I'm
applying it fast.

[1/1] power: sequencing: qcom-wcn: set the wlan-enable GPIO to output
      commit: 06802616488c980a63084e53f401cfc8a65672a7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

