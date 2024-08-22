Return-Path: <linux-pm+bounces-12726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BA495B6AD
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA701F24D0A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8834E1C9440;
	Thu, 22 Aug 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F1B7hyyy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297F1C944B
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333422; cv=none; b=RAjeuwOPYM7t8FoLB3wQK4rApStO0ZDFmPuL3e52RpVc9HsYdNOFfMiHz45ldoRs8IW60SVqg5u1ZIIOqSF6KjyLi13eTdr9T+qYnwi5v+NS9P56lzs+LF/ZI+3yIl2+XOxtlVYd1oTc35+fKg35fPjvt4EBAzdCuNk7Gg7KwK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333422; c=relaxed/simple;
	bh=6uixaA1bOPbEnG+jiXt7A8JornGFwFdjfUFAjLRH2EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZBsBuZR2l5sGGtqvhXbabLnq0EpJN2KS5FJFnP0+RTh+J7xQ4bIcP0LLU7PT0A+YCGSzM7ci3nKJ+BjykiYOBLfpWh43pRASwl5UpAPVtsZ5pcpL0i3DwRICErSlzZybZON7E4O9vIgEDkYk65/HRJTGXri441cw3IgRzOs8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=F1B7hyyy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36d2a601c31so428873f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724333419; x=1724938219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sow4oJ1Jg0NDdR25xAMQ/COQ7rWcnilFzdDGv7rWYss=;
        b=F1B7hyyyQHMitx5K0P5zu5z7pN0wcPyTuQyj3pk0nae4aKv0xf4Pj+gVt864LagolK
         PH+LB/cyZn3rFTkWUm+R74Tl4DUhEjP0uAyuzuqwrPmEEEFKSN9l61NPMQ4luqpObrfY
         mYBpcswcP8K2Q/VJhfMOFOqvJ+0smtlx2FnNJWEaQESdpTBXfwCD/gFK0J9GNQ4mS6k6
         4aEpjMuar/pXWx53uyJshumRJUj89PhlFwdnxwetA2wv2tpyrUHe01nEBwn5cozIRXu1
         drV+IejapoUrKQ8raiknh8nSko7llbxOdOmK74aly878HGi0YQs5ZmxYTU4xfvj4KZlw
         EupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333419; x=1724938219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sow4oJ1Jg0NDdR25xAMQ/COQ7rWcnilFzdDGv7rWYss=;
        b=TZZybkV+U/krUtVOhHWCCXHwDj1MrCoRf2Zomizep8bLioiT30voKnyvUh5/UYkB56
         DJdzdSdYXvP2uJ6YNibDj0aA7YP+u0MH2lvBJe37WT7TbuHa5p3fV15TGjzz3QeL2yuZ
         VlhN1I8PV4dK18dOfs02O4XT/Sr6c74vTcfxLwosEgZ1cUnov7nU8UcX6hN3WckdElrH
         nbMCqoYluClXH5f0cR2mBHsh4pdxYGRaNPN27g9lMxpsM74dCsqJKiHfXoIccwOUK2Xn
         goE9XkCBL44S/pmVHRPyca5kUYABlbCiqeoWOwfY3HNwm0qqZAxHOX590G2kJcPBb16E
         Js/g==
X-Forwarded-Encrypted: i=1; AJvYcCUxH9rWFqMRv4ngFzR3BfYEQaoKSakMLKAySw8g75SI/WDo8ytU3ycaoVimvsvU8MfM7+9iULtyBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG4vFY8ZUaalLD1FlYZsfaNaPlhgNPbTz7R/w4OfEaIuY5J7Yv
	KMbawRfX8Y8gM4IpsnQb9L8nSXCVTCXdpBifSgD0m6Nr2/DIHWRkSGoJ8XQU1Cg=
X-Google-Smtp-Source: AGHT+IGUf6uLXVvibGKBn18YUjYGGvG9tobdZE/ovA1c/SHbPaxXsAPGDRGyV+P+LRK9TkEArUVlsg==
X-Received: by 2002:a05:6000:124e:b0:371:8277:6649 with SMTP id ffacd0b85a97d-372fd5bb0e7mr3605771f8f.2.1724333418430;
        Thu, 22 Aug 2024 06:30:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1e6:1bb3:7777:498e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff633sm1699552f8f.77.2024.08.22.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:30:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Jonathan Corbet <corbet@lwn.net>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: add a driver API doc for the power sequencing subsystem
Date: Thu, 22 Aug 2024 15:30:16 +0200
Message-ID: <172433341423.27429.12007142599226863583.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821100818.13763-1-brgl@bgdev.pl>
References: <20240821100818.13763-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 21 Aug 2024 12:08:18 +0200, Bartosz Golaszewski wrote:
> Describe what the subsystem does, how the consumers and providers work
> and add API reference generated from kerneldocs.
> 
> 

Applied, thanks!

[1/1] Documentation: add a driver API doc for the power sequencing subsystem
      commit: 8b7e0a6c443e855374a426dcdfd0a19912d70df3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

