Return-Path: <linux-pm+bounces-21495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F765A2B189
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 19:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F937A1E15
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 18:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7058919E7ED;
	Thu,  6 Feb 2025 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNGfUrI2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664D18FC7B
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867556; cv=none; b=LWd+Gv/bsBEojy+rYdK3QOj/sAsuuVqLs46kKpbQzTW4oxq4BXwY16vrVyu8m/vfUhtcK5a4Pw6UH8RhJ5WWpfbah4ma+aEeo879DLMsVmuSxlD3YKdI5kRVYZ1jlzCv/gkmXNDrCNQv69tTKnNE6g3RTJUUErHsMh8EmG4+58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867556; c=relaxed/simple;
	bh=Tjiel0WFtQD9YS5CKTSuxdiX698M0xiSfjn6FPVYi/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJ65EQ5tPaUrz1Z0XN3DPodkLH4CIMBjZKN1Y390ljQob1v0DNB4NyXxsOegmQNVzczuW9BCvWSzAO15EtVcqYanGqi5NJbwIQLAX1U/3Wse0X7vIVRCZY6iDgiljJL5DhNoqCEjwxx8yfvNfUWkI8D6eYWq/vhHm4BHcFh2Sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNGfUrI2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30227c56b11so12739231fa.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738867552; x=1739472352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tjiel0WFtQD9YS5CKTSuxdiX698M0xiSfjn6FPVYi/E=;
        b=MNGfUrI2QJjLfNL7FN95W/o+6bCjZO3TuTVKS0f/h7L8vxqPtufMVpe5cVSGAuFeUC
         XrcTHuvPW4sbPuylvaaCr9QxZWqDxEqJJq1yE51tOHtXCAJPyy1AF9MU7CZl5vX651pe
         KIqV8wLK3LpR83E7O8pmn5TBYQNJl1d6P6HFr0s8TYPMo+rLKRXy564CSNigirwGChsJ
         pEAcAXFTaJ8DQY4yND+4wSyAjp6uaL3UycX9G0ay2pVcBoMz+hFzBRFtIE+1u0q5+0yZ
         rIaqF/Ksa5m/oxkUqW80Srol1Z3ODQUfBcCxh+FxRewuVbqhsMf3cMgciSHN4ooCwjtg
         OOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867552; x=1739472352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tjiel0WFtQD9YS5CKTSuxdiX698M0xiSfjn6FPVYi/E=;
        b=cMTerms8fmu13WlEMmjOps3Yzxb9ksBHjbdh3oEL7pQs+WqzmkJkU1j0/91njYIcFl
         kveKLFIB0k2HhnWkeioagYhqLfCkYE68+spn7Uqw6jWvpvQd8WWQts4OoWlSpWAuw4aw
         i9pWwKf5IDaF4/FZ5DGmU1Ldd8GrOkzY1gtlqVJQD96AY7f7uJ0wLeoSvdF1Zx2mZx0m
         yjpCu8DyIYutAkO5Xe9J/ZhK3LACzDUgqQId2tYJRU0fzE6Vo7AJs0KaotMPFdazcYiP
         kQNwjUtUgSVGwYG1mqanDDMP2P6miLuljMlg0pRFKwH0qkeH1OWfRvp82Dm5laLEIiXq
         6uRg==
X-Forwarded-Encrypted: i=1; AJvYcCVr5Ud7IW7+ZhBjq1zr7PGp/ReS2BQAXVr/bMjdCIYNwvufHvJSRv4RhwS6UMBvgJDA0arUAi4SHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Z5ZZwErzsvscwiZQOTIAWi66j374LVf3iDFhhH9NQmQGQUrm
	RvBz9u6ut9scknUAusVbx7vUmDDs4oeeGsbA5hbCLo+aogcr7BKboREuZeMuE5k5fhABrq2pWun
	XkFEUu8N/7NXQqtAypMwrLGuxdr5HaSHjaygTtg==
X-Gm-Gg: ASbGncv75bcrmwSHakGrveL2u+zglB3JBY0GauMdGysUmIzD+724yaiTDmAyRzXU1tp
	ahhk9O6RbKrrdU9yHNPwOQ9JzMGM7vypOvVLwuLTEBGgw591tEW+zLRxfnyQJQSBW8xDhFRU=
X-Google-Smtp-Source: AGHT+IGpDLY6SHQ668oUnbFgq2auSN1gE3jhzoMa4jDVlTNizXykYl/yxJFI/SmN6Q4nixNkxOa7mlXWwfcYQBp4TGg=
X-Received: by 2002:a2e:b16f:0:b0:302:3ff6:c8db with SMTP id
 38308e7fff4ca-307e5a7cf4dmr162071fa.24.1738867551683; Thu, 06 Feb 2025
 10:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203080902.1864382-1-raag.jadav@intel.com> <20250203080902.1864382-6-raag.jadav@intel.com>
In-Reply-To: <20250203080902.1864382-6-raag.jadav@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Feb 2025 19:45:40 +0100
X-Gm-Features: AWEUYZk2YRZtcaKVdDcLea0eYDsFvswTZJTr6Ycy-zr9WIcLxtUKOfzaSSPbXpw
Message-ID: <CACRpkdaWm7Lo125AsgyU3+p=WB3unVZFqvudVD53SSLESsT0=A@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] pinctrl: baytrail: copy communities using devm_kmemdup_array()
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	dmitry.torokhov@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	sre@kernel.org, jic23@kernel.org, przemyslaw.kitszel@intel.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:09=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> wr=
ote:

> Copy communities using devm_kmemdup_array() instead of doing it manually.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

