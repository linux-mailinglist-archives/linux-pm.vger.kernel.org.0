Return-Path: <linux-pm+bounces-14146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA65977F2B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 14:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6601FB22F2E
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6611DA2F0;
	Fri, 13 Sep 2024 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSW6/JPd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F001DA2E6
	for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228961; cv=none; b=aisRGGpc4x4JRrsUHRne9/DX/pBW7Up4OwudiHRRFx/Ln0ZPndWIty6nPTWfWAZIh5HFFjb3l9VTZLOHu7izOHBkyRhhDGI4G1WNVuVbVK+Vpa28oBLXOtgpiEd7TuAC5f0lOx4BU7o0i2c7UT9TBT0pnmX7uFLclevKwrHBs8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228961; c=relaxed/simple;
	bh=WJGCx6i8v72/tO4OLrJlpsz+OdDbw91LWPJWIc7jdh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZRemIKpc5+VsNY9A9rZ8r6jIGaJAijCMytMvzUIPpv4FoUmGxIqL52EjpBPDqHsCg2jp78ciilJSo3ennLa8qsrj3RLSHeLWcgz0JfnmIRgE24uFcdpvZHFcXbZ8tm4Gsq39WKmhOBVnCltsZtahuo2s5DxzM9KtNj03CrUsAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSW6/JPd; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e026a2238d8so886377276.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2024 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726228958; x=1726833758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2EMotPu+SsnYPYZCxsQEhILLifcL+u+4RLDmrhDotzQ=;
        b=dSW6/JPds0DRcfTqyndSyrxbOxsoIhsHrSntNaYDLJWHnxlgZ4qHIxJQZtW/xwOL0K
         zgoGP304MV33xn5SRBUNHwU+F5gSUaykCggy4x5m3cV8TaGhaI/JLuiARCFFXeHVXPdD
         JaJuglsy+MMp27PJh6dwveJSa5RmCBhhx1P8+HHM+fl7sYLfGYbThH52MVe3QDyB9WDF
         mmBeaeV7FEXFk8XWmCEelVJ7nZvjI5ac5vcuYPS94gB7/zsVpqvyI8V5t+5r4ux5rT9z
         BsjuoElpBHsGmk4Ms3V7EpeL7h810Sa3r4EmSLggm4Vp/G9nihPDv7JQuCNSi9uWPfZ0
         xtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228958; x=1726833758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EMotPu+SsnYPYZCxsQEhILLifcL+u+4RLDmrhDotzQ=;
        b=R23px29ul7rsd5z/7ElI+txYwlHiVukU76vBNU2kpiooug1aZ53rAj5r9mEFh/W10v
         XkWdQC4t/AUzE8SbyiCQsvGkvjqPNhTgAk7O/nfzeHEYk/0VYH3fw1DfTUiKWD7RnQnx
         Whuja1N0DbAPF4yJPWBbgWVTJIVgzxFv3tUzM4wCeUVHJg3hFfUqYdZhHatXFidQKsZD
         QyDOi7b2GfEE+og2s1JkypBVkAdlyGhtl4sRFKppTkchT6HcNVom9fycM5dVMcpcvoti
         N6NZj0FF6IYNj45/nVHQCJMCY6KxelEmaUAaPFv+FlFuf4u51jI1tan4ORApBDI0kS2+
         nuKA==
X-Forwarded-Encrypted: i=1; AJvYcCXWuGFXskzm4gh+Skgqb4pElp3QxqtOfRYkzHgq8ZJMALcn+tEh6hNRwUMytdQqPU0JkEMFeOOOPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOna8PGc0t77nHKdNCwOyKQs2slQdrmTg6N+vp2wU1ZpD/M1e
	lcOodA2eoHvLUntKPHD6fIWwD2URzWLlwMWN+kVaRNt7f6jQH7XZTTOgZK3s57urxEp4XEP9fpm
	zOJZ/fnOyVM9z14Mqb3eZtwFvglBwSgEYAJ1gkA==
X-Google-Smtp-Source: AGHT+IEmYliY4E2folPA6tK9YT9mUZYVhyxJSAMt263ZcnxuojEhH8f9gYxBDVwC3jIeAmLM93D4nNjDl4YbjAmXemg=
X-Received: by 2002:a05:690c:3343:b0:6db:98ad:86a with SMTP id
 00721157ae682-6dbcc593989mr21037947b3.40.1726228958446; Fri, 13 Sep 2024
 05:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829202732.75961-1-detlev.casanova@collabora.com>
In-Reply-To: <20240829202732.75961-1-detlev.casanova@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 14:02:02 +0200
Message-ID: <CAPDyKFr8x3B9dmz1fOCOpovhN8CC=187Rtjc+cTEFKN3=U9OmQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pmdomain: rockchip: Add gating support for rk3576
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Finley Xiao <finley.xiao@rock-chips.com>, Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 22:26, Detlev Casanova
<detlev.casanova@collabora.com> wrote:
>
> The rk3576 SoC needs to ungate power domains before it can manipulate
> their status.
>
> This makes to to ungate the PM, changes the status, and gate it again.
>
> Detlev.
>
> Detlev Casanova (2):
>   pmdomain: rockchip: Add gating support
>   pmdomain: rockchip: Add gating masks for rk3576
>
>  drivers/pmdomain/rockchip/pm-domains.c | 87 +++++++++++++++++++-------
>  1 file changed, 66 insertions(+), 21 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe

