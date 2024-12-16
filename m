Return-Path: <linux-pm+bounces-19285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1B9F2C0E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 09:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636FF18807F8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFF91FF615;
	Mon, 16 Dec 2024 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1lIz0zXr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61EF1FFC41
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338278; cv=none; b=o0FU9itc/cVBIbNkaWvJEHv7nagMViCdcBur9paZR/qC0lsp1kEou7srUiRrNdWfoWF8P73TFt88Xq1N8Xza7KU2k7eQGDyH6N9J0HPWUW/+LvG5ibfDzbTR426lGC0ZFHRLvI0Bh0KiYxuyD29b/wy16hEK0/jesK5ee+7b3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338278; c=relaxed/simple;
	bh=dwL4oyCtuYrCZ6yF/bR5QHEDHgK3LUp6b+1GIr7tsfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t16h2/5yaRmoMMduQrk9+86YGQqHNCeJv5gufIYjm7KjkB13GMkV0QB+J/A5acgdj807foinG5iUOmGOk7yoFcYIvmJ+YW0PowVidSTQlayY7NdvT3Z/OzB8Y6WMVta1MqI3Q9fpjQ5GVXbUG0afyj5Ya9mDjIot8/3UpmUHvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1lIz0zXr; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-300479ca5c6so37697841fa.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 00:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1734338275; x=1734943075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhuQsaT5H6o7+J7ElfZP8hf7dLA1Xda/1J2z/GHfUlo=;
        b=1lIz0zXrxz2Bt+ACzNhoBTs3FLt82bLmCAH1FFEVb5mEbrHWyKrtzKOf3XMJMsxe7x
         Ssq/KcYTCWCVmG8ntLAbrZVxwSFeQpAmALvxJxOb4L7alPYPKr3COq6PacxIA4fSsLmt
         v0rm1ASu+hDoNnhX2z58UfH/t9xYraXG7eXc4oCTAQ1+8HecsSGBqo0TY74ypooJ92Pq
         caelUONH7mdLP7TQh6REAVkHM4OUo4/TpFyyUAoobM5no8Fd2XUcUXFXgLxONlwrdb1A
         yzwc1/J/qsag14rlb2xOKoEBfQQj3pm2OYqBVe4569zPAFFX+esaMmJELkYaMDPTJ/R0
         UPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734338275; x=1734943075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhuQsaT5H6o7+J7ElfZP8hf7dLA1Xda/1J2z/GHfUlo=;
        b=EnPsB2YkCvkrrF6KpFmd2a+U3CBzULs6CUbfqiE9b9QKEFjPHYjASZJGqrTNrIJBK+
         Tv88586CO67aO5/glzp6rUO5BMv4g4/aWeRwre2dBNNmceUn4Ackv6glP/ptJIOJHX3g
         c3tfV1/0uvUq90i8Ft/m5tPYs2QQwf53gdfUoD4Fzua5ZlZLfG3qGH7CPr8U0cQsy12T
         Mbq65iZg9mkwqcfKoqO6YSSwv6PKzJNz4kKXIbFem6igmmH74s4zT6Qyb24JUVUoWLeJ
         NTYWUyIUusUc5hSUl+LJZ9oDGMivuC4ozunc2+XHPzByySnVhyqjoGbYiaKRKqaiDvgB
         WfIA==
X-Gm-Message-State: AOJu0YwEzuJ9pSCYrlI07xAiJD/6uIRVXMLY3q6ES0zxt3A+kHaciDac
	XAcwj+MpSIVGRCpwk5q98CJfMcT7voKhuQ/6g2DsZuJBNtwCXuovpXJWFvhtrVmQGzTsdFDssve
	5aIczGa7u8U0r1+b0938X2AHeUTH0zVtkOZT6xw==
X-Gm-Gg: ASbGncswxFxd0FjZ0B/fbbnEL8P7darCvV6aK+Z8UJmkmgGTmayx0PYwcmCwk7FCFIR
	URmMn5v2Lj2WwLpaFqUS+nk+VrD4rGEz0ELuYeJCtVk56ZNWU8HUUAIyrdK6e4nou8uY1QQ==
X-Google-Smtp-Source: AGHT+IHGoOBxZInoO9/bLGpfbpoKkckOqpofRNQ0i1v/Phpq4yTUAC0eZCfCprZDfuAMk0DaFCGKGOn7jaMLHHmiaik=
X-Received: by 2002:a2e:a7c1:0:b0:302:1861:6de7 with SMTP id
 38308e7fff4ca-3025448d109mr35383821fa.24.1734338274879; Mon, 16 Dec 2024
 00:37:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202165723.17292-1-brgl@bgdev.pl>
In-Reply-To: <20241202165723.17292-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 16 Dec 2024 09:37:44 +0100
Message-ID: <CAMRc=MeNCj0kY8OGxyHMa9pOEtSeEysOhrP5cVcwyTUdF95dkA@mail.gmail.com>
Subject: Re: [PATCH] interconnect: icc-clk: check return values of devm_kasprintf()
To: Georgi Djakov <djakov@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 5:57=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> devm_kasprintf() can fail and return NULL, add missing return value
> checks.
>
> Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/interconnect/icc-clk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Gentle ping.

Bart

