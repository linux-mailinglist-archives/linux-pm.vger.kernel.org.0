Return-Path: <linux-pm+bounces-12407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F8695651C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 10:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205771C21701
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA25156C4B;
	Mon, 19 Aug 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RL1Gq41J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F313E03E
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054558; cv=none; b=lPQYCpSjDMgrtnFmVK92znJ4aELct+QDEKemK7LCvqIsWi0Dl5ownAZfCpaWAuPjfVqQnYLAHjEBV4vrjvIXGjdqo8x3aTLqKELvEyybonPQ5j+i+hLDvmX6efJNWA9F8oTAaz3E9FsMmDTbPpOwL/uMkwLeSVC9Ays97ie2ETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054558; c=relaxed/simple;
	bh=i8oXK0fvpmZXknbnibQ+WCebbasipGB5r7Us8D8gpEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnl53gXBhj9RXWgZ8f20Gj4qMnmtdjZhk8MjrNcnpB1EJJ2W0623Nl/fEF/Wo6dUGLKUmYgVHCkQsvRLZZ9JBZK0PiHAkdnONo6xcCoWhu988pwBORK9AyBDllmhnuNxMhM23z0XjLWxIqml9FQJk76ZRJedP8EI9xkXqBD6gZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RL1Gq41J; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-429e29933aaso30033225e9.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724054554; x=1724659354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn+c4xl/H+XtHBqzPPIFIOhNM7W/L3SniDM6+u9XTjk=;
        b=RL1Gq41JuyWEhtVwegeDsJLcLHuRiMtzhuH+I0f7G592g7R7XXOupo++BqT+iu+hVZ
         OQbsDCqoL4GtjAko/95gyvgqPiyWxogsJTG1c8EIKpl7mVQh3gxazxLZJVYk/8xrbFR9
         HyQWvBCd5bVKvo4GSyDhmOQBwuFuEJD16QeoEZVpzar7zEMkiTVxwvBoD80HdUc7OtaO
         eiCDoIk9fVnYAajqYvFDVxpmTGzlFUtz1M57nSt53ZUmkiB8RcmIAY97fhsErUyEStwg
         PqSJ1FJlGJDji5zphT2tA8VYoyzrwwfcYLESrngVi5VD5QB25QETtvezgrG+51m8hImS
         tMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054554; x=1724659354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gn+c4xl/H+XtHBqzPPIFIOhNM7W/L3SniDM6+u9XTjk=;
        b=ES5LD0yWMLtQabWdS5tBWppTg2FWmLFBzjHF2SDTtJzIL8XChbmJU+B2YSNaIAmcHa
         XygF+zSWJ8TagCY6dmpHJaYFdoAGyF1XQO4RBMr0xH5t557plzKtl6CNbq30HulcvYqa
         AURrG+0TjICuWgGNHziTID12lmnFWsRfOHd82r5K45safoxgfViHJRSo3bVCueRL5um+
         OJnNHYPUi7jvrj+nFjzJuINlhMzbe1V56AMyXoDOcTT8/urtsDObVZln9XeEUgr4WoE9
         0Bob4lU7JFFZnh9WoSp8bw5l7hSjtSPMQCUzdewH0g322m4lzxpK9WYkykjqX/B+dhw9
         +lIQ==
X-Gm-Message-State: AOJu0YwaudBP7efr8sX0UXnmEY7gYjBZQwxQrhcozNRnRksP5ILT6CeL
	Xwf8/ppElOEIsVaWCzY+Pl8qiSOB11w1b3DQjcukhMD7smQpN8CEO0IfQ3mHKEULb9WFeJMtj2p
	raIE=
X-Google-Smtp-Source: AGHT+IEvipa+RywM3tU9SDyH80HLQd2DTGCibO+/FhKCCygpXcdXwctwQWTkb+wkyD2R4lWa9fEP7w==
X-Received: by 2002:a05:600c:3ca6:b0:428:abd:1df1 with SMTP id 5b1f17b1804b1-429ed7baa1emr76166085e9.9.1724054553864;
        Mon, 19 Aug 2024 01:02:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7b55:8f70:3ecb:b4ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650759sm98728865e9.14.2024.08.19.01.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:02:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH] power: sequencing: request the WLAN enable GPIO as-is
Date: Mon, 19 Aug 2024 10:02:32 +0200
Message-ID: <172405416113.8149.10468299124149125846.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813190751.155035-1-brgl@bgdev.pl>
References: <20240813190751.155035-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 13 Aug 2024 21:07:50 +0200, Bartosz Golaszewski wrote:
> If the WCN module is powered up before linux boots and the ath11k driver
> probes at the same time as the power sequencing driver, we may end up
> driving the wlan-enable GPIO low in the latter, breaking the start-up of
> the WLAN module. Request the wlan-enable GPIO as-is so that if the WLAN
> module is already starting/started, we leave it alone.
> 
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: request the WLAN enable GPIO as-is
      https://git.kernel.org/brgl/linux/c/a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

