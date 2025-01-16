Return-Path: <linux-pm+bounces-20558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E0A13E95
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1207A53D2
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0578C22DFA1;
	Thu, 16 Jan 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+EhvJgK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7522DC41
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043129; cv=none; b=rPdkyKs5huV225Tv5Dqa04mWaYnh5GotSZdgwcMx+K3MnCM30NbVnxUw+Ji/08/eeM2TN3IWhkJ9TkivpKiuuU4o41kgZHv7p468pJLBUJOVqTY+ZkYdOUFTF6oms1CfWKVyBjkPP85XbYfO2GLIRFoRiC3bjz0Y2bxoKEr9fYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043129; c=relaxed/simple;
	bh=QGPiUeQaDByXyGYfaiyGjoevsH3zwreWTmPpwDEUSo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0IVd2lUFfb2Xn+sxVNhQFfeI2m5p5nY0M2xtIgsHmXWaRMb8M/inxrC700+Hf9e5L/yBRRosU5FltYwC6Gu1V8oHS1idDds9WOuSTh7v1wXrra2zb6JVvIOifl70C7g6MPa+mvN+6IsEj90UPhLvm8YJVn7Oidmc2kUF8ZmsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s+EhvJgK; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5447fae695so1949794276.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 07:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737043127; x=1737647927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QGPiUeQaDByXyGYfaiyGjoevsH3zwreWTmPpwDEUSo8=;
        b=s+EhvJgK6tpTSiC+IF5lidiwlqftFr8ktRSeenwtj2WoglWlo7clXdpvf2YoJUevAg
         awdgeKABjxbPWxG6oZxPzjYZ8GoPfr4IVuPdrNLx3rUSXaAwUCPo+7ys+yLs4GkNmafZ
         6rQF9lbuq1LuhGiWplfTxlFXr8f3QzRaJ1sJSNfGZ6E180VEoKfKIavjOZ8j/bVQUTQV
         wD9aFZoTZJ8/bQNSkOhEULTYzGAm6BfTAmKBmodd096y/AK7x6qFpxpO16A+1uMM2d8m
         6vNq7XnOZozmk1qAVhB9+roqq2D7UKfCP8iSLkY0AME08s8DqBjfkcOWW3p9PI/+yGkx
         KPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737043127; x=1737647927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGPiUeQaDByXyGYfaiyGjoevsH3zwreWTmPpwDEUSo8=;
        b=RG4w8zT7zji0mehgy+fiDjzx8qNeeaw2gNKAK/8R4vAsrJ/EFOdSfqUq4eh0m0dO3j
         cw87zwCshwLDiu/cJqTtJKiCvmq/fMFyS5cXcSnDPr9GFtFyNObxWe265p1igAYUq0Bl
         fNmf8wBBNX1SODgTmNc2QC6+PGOGq9IYOZ6SSL3fSmvqe4q8Wi2UxyRnEEm3W7PPyM9j
         zeLCHYqytQbmecops+9vJAfiilWDDKh3rGvyL/aAG1cjKGcVSyyekSiw80gi6aJ2W0bQ
         +tJlj7pVWb2mrljTLZxNEZjnvqGogxoKunFyhBjaeh68lIbjC5z6YLZEU7oPtDgDGsVG
         bXEA==
X-Forwarded-Encrypted: i=1; AJvYcCV36kLoiRyjsxCAUhNHIMg6SS3juaVjAQFLg/f9LDf0hRlwo25W3StzoZ3WjuDIMTdeESHO5pxUUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynTsysZN2DVjkwuxsm26KHQgrYiNzsd7tF++AIai5Xc+/bMccG
	kszfcVZDNQhmmrlvGjhv7H6E/Fhaqbe7XuDukdsT+CweykNWehZMem7a3rhIHDxfzb0IHY/ORt3
	gn00z1KGq4RMqERPjHteQ3YzVze7PkmlR4Do2QQ==
X-Gm-Gg: ASbGncteLQXrir1iDS8J6IF54u9ajweQQPrH4gCxoyVihG0rSKMy96naCY1Vv46WlfD
	NArKwqyHGJpDLF457HgS2HKxPtiJ9HGfWct1yHf8=
X-Google-Smtp-Source: AGHT+IHzQbQYAi6FZO8GNmu8t3VQrhl2ccDWHjHOxE3SLBVC4VwnOsYtSa0UftO9WxJZ8AnPeBd+o1qUAP/ZQG8iuDk=
X-Received: by 2002:a05:6902:18c3:b0:e57:8814:13a6 with SMTP id
 3f1490d57ef6-e5788141804mr6901177276.17.1737043127387; Thu, 16 Jan 2025
 07:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109131313.32317-1-ansuelsmth@gmail.com> <20250116070214.vdnbyyqnciifngha@vireshk-i7>
In-Reply-To: <20250116070214.vdnbyyqnciifngha@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 16 Jan 2025 16:58:11 +0100
X-Gm-Features: AbW1kvYjzgMKu3xCJVK7F5l29WK5ilTbahAEoFI6YcNzZrqQ5wXTPLxX0mm-M2A
Message-ID: <CAPDyKFr_z3WUyO2bTV7fPt8=ECdoHCERd=f5UN8MmNpyN=Rm_A@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
To: Christian Marangi <ansuelsmth@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 08:02, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Ulf,
>
> On 09-01-25, 14:12, Christian Marangi wrote:
> > Add Airoha CPU PM Domain support to control frequency and power of CPU
> > present on Airoha EN7581 SoC.
> >
> > Frequency and power can be controlled with the use of the SMC command by
> > passing the performance state. The driver also expose a read-only clock
> > that expose the current CPU frequency with SMC command.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v10:
> > - Depends on HAVE_ARM_SMCCC
> > Changes v9:
> > - Fix compile error targetting wrong branch (remove_new change)
> > Changes v8:
> > - Add this patch
> > - Use SMC invoke instead of 1.2
>
> Any inputs on this ?

Apologize for the delay! This looks good to me! So, applied for next
to my pmdomain tree, thanks!

I assume Viresh will take the cpufreq patch via his tree? Please let
me know if you prefer another route.

Kind regards
Uffe

