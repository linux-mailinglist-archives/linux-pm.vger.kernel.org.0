Return-Path: <linux-pm+bounces-5725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399A892781
	for <lists+linux-pm@lfdr.de>; Sat, 30 Mar 2024 00:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCA128161B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 23:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D713E8BC;
	Fri, 29 Mar 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pe9BIhi6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658313E881
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753444; cv=none; b=lWQ6d0iSHuubn5YAjb1qW2LNOaaWEgsHArtAPULQO0s54lpEc84v9w9FpcJurux82H9OxkT6sRqGY9709M6idXnIJpCVyGLP7tPT/r2jH0xOl4qXv7TSWydQFKFpw69mVGnjcb5TBuYqTfwtaqgrz9GawKIW+7aN9Hq7jIwaID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753444; c=relaxed/simple;
	bh=ElBPjDIZnQxhX8OMQsnhNQHvpAXQI/SVRBZi1UXufCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afME6LfqiY4vgRzlDWXf6a8iBbY72SuJSJKFLwRdjfQHXy4sFgiSJQqyfd/0TK3MpYyMtp1ryat2+YSEqn7xMncFmIndid+V0wC2eCsySOil7H1EBfn5tNHrDNFpXFHCNCHlrrsNQa/MroJPS144JcsYlrHU24hw1gzt3sUb4Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pe9BIhi6; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6969388c36fso12888206d6.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711753440; x=1712358240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElBPjDIZnQxhX8OMQsnhNQHvpAXQI/SVRBZi1UXufCM=;
        b=Pe9BIhi6wVmFE/tDN7PvIW+xx1fkS5qJ8BQ87PXx2ib9ZbsUwUL3IieQIbzopBnNSl
         nNa7uwuQP71R5DH07M+zMXKJ+oYtkwCm+zu/nojbXB3OMFkidtFdBKail2L+MZT+RzPx
         PHopoUVHHYELKSJfa9m2GY8jnZ0EZ4RXciTDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711753440; x=1712358240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElBPjDIZnQxhX8OMQsnhNQHvpAXQI/SVRBZi1UXufCM=;
        b=Fi60F5STKCMO5dJ4WZ8xeiXbY8BW4c3D8ysIpPS/R4EhgJl6Bu1TNT3SpoiXsEQJbi
         zc2u901lFK1mhnCIrBHXXIg5srcO8KquwdKtmEbveOnEJe/dRpUSTAUbuljzPw1ag35M
         H6nUFQzNa4IIgra/sNRhThvJfNzmMwGWKiJr4quZ/Wi35F+0SiPRN3C0vxjXDRPhHc8z
         C2/SHCLaTJS/gVa/fPCJez7Ni8QUon416xm7jb+2Du4UqbGewTVwKXdVqpBTX5XmgL1I
         EJN1cXjms4cxSUL/BOwq3/xbIgimprX8GLwNyyMgaUewZS4Tnj3PeB2uERIPtJ5s30VI
         3y7w==
X-Forwarded-Encrypted: i=1; AJvYcCWIHQl25AaFaXLzCwW2i533EHNBRYjYzmEAkzpQskwTQrowqP3pBhW4WQgxGf4FYEtcrXGGh7xLHfF3l+9SM0S23e3YmwEry24=
X-Gm-Message-State: AOJu0YwqaMBeSNMyI148pV5aJxaw041dF43c0a+wqHWCTtsGhmKQlhJx
	rXq4m8RLWloh2qrhwo84ZwHfrmpyKcTZmdusOMZQe1gFDHfP8QYS///Znv5iHwVxQOAcrlNlIVO
	EMb6/rKguKZaI7twC3+v1opX/HCgPoIPHlOuX
X-Google-Smtp-Source: AGHT+IF+mqQ03gYx7d0d7DYJJ7rVBmyQcQsToUoGLPiRc+Fc5LU2ayUB7rH83oD5qBV9wXHQ8tTdvtFZhUqkRt2CKmo=
X-Received: by 2002:a05:6214:1905:b0:690:d952:f17a with SMTP id
 er5-20020a056214190500b00690d952f17amr1755577qvb.31.1711753440726; Fri, 29
 Mar 2024 16:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329075630.2069474-1-tzungbi@kernel.org> <20240329075630.2069474-6-tzungbi@kernel.org>
In-Reply-To: <20240329075630.2069474-6-tzungbi@kernel.org>
From: Prashant Malani <pmalani@chromium.org>
Date: Fri, 29 Mar 2024 16:03:49 -0700
Message-ID: <CACeCKadpks=55-bfi2qOX0VdB5Fc0394OBEdKBoRBCsS6MNwAQ@mail.gmail.com>
Subject: Re: [PATCH 05/18] power: supply: cros_usbpd: provide ID table for
 avoiding fallback match
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, linus.walleij@linaro.org, 
	brgl@bgdev.pl, hverkuil-cisco@xs4all.nl, mchehab@kernel.org, sre@kernel.org, 
	alexandre.belloni@bootlin.com, chrome-platform@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:57=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> Instead of using fallback driver name match, provide ID table[1] for the
> primary match.
>
> [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c=
#L1353
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>

