Return-Path: <linux-pm+bounces-5925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75305898616
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 13:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12B4BB23AE1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 11:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1482D9F;
	Thu,  4 Apr 2024 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COZ8WqEA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16282C7E
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230355; cv=none; b=cQZ9LlIUDxZdTEE++OGTPzV1dhQ5hh7vAArJdSgHodh59PNv7sXaGO1Bsip+g9kykPBfiUlgdTtazzp4/AM1V5Oh6RScwS/Xx457IGcENVqrTISrjIyPINJwSMatlhuRj/+lzB76ONr3fSWVWkov8wOR7XidiZvIPnF0pjNEK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230355; c=relaxed/simple;
	bh=wUwTbBI6FvC+9csBIWb+K1MiF218QWtdW5pK12heMYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7UgYg3N45P3rtFrSmYuR0umdwCWxchm3n7jthZUNzJcHS2AJecY9jlPGGXgvF22w9bja4I5pP04VYW9lzsLwyU7+f/qKM/iEuKBFuICDW7l5CKE2kehiKTehWxMfHMnfk5xNA+xg5ZAAzDsBU9MYJ008TfgtfiPGWRcGPqnQzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=COZ8WqEA; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso889226276.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712230352; x=1712835152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hqMPpBRPBNPrxNkvU21NJl5hteTV5S6UOoiZfBhbP8=;
        b=COZ8WqEApBJO+XlWN34aRYaTicUU3XmrzS3aS7W8uF+BKmFeaaecN2aI1erxCps4Yk
         MzIk+RWHvhRdhK6yhQ1Krs1IYd3h6/mrZJkZV37eSTqkdjEte1AK7Fy9XVENpLpY9rBw
         Y8z0ShlLGI0iAiGde1enoAe8RJC08+nzDncNJgrnAlTNHHATbig5jjJ7MXtxqGdPhjbt
         9DfRX8Y43OrGH3kIqDp2SGZxqvzJFvKOVivAKWZ0MezFGtMeOPhZ3ndTi4qQlcsJglQa
         xzW46CucLFv48KTspHqXKHEKCglFWuZAieVhmlSA1MNiZl/v5chzyeAZRKSRRIuL2rQ3
         vQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230352; x=1712835152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hqMPpBRPBNPrxNkvU21NJl5hteTV5S6UOoiZfBhbP8=;
        b=OQMnYCHhtESFyZQ8O2BMFm9FSA2VuXjEH9roySWrT2c042Zwv+BW0fvWdrtSb77WtB
         tiec6UMqpcp7zd35+oTCaboCxe/394T9l8DqUtZ6Hu8MUYOFxfcYAOu51lbP/7nLzKgy
         KK1pu3kJBgZD60Z+QiZEDsmhSFUazp2SOZSQjSqViLfz+lMPU14J9Oq0PPrKr9R2MR0f
         fZFHuMQKqbD2S2g01JSefUKU+A0W3y0HOn0JB8W69NA214Mn9uqB3S65UGr8JqkoLhc8
         v0GOS/XjYdrw48A0caIJ5KQVl2V/6CRNeSytKWe1PlGupuxxFJ9r4QBs+rzy5boeFbKK
         jkLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+neYG6Giq2mw5ZerEnPe80cEXxhrk/pQZMfmh0lKXQLkP9ADTSl1JQ4bPuSd1au3ek2gB8PUTr8+bTYnaF1t1SMnRHgUZWH0=
X-Gm-Message-State: AOJu0YxbH3VHzOcFWUhtRS/Aoirdtbj8jyuiSPS9NaVQ0VBLJNL2gwnU
	KeqtpF1T9TwkIty/pXbsjgvBoSu7VSN/feiiz9zIsHoN3nKB0BlPRmWonbbpyg+7GZJIvrpACQa
	K5W+2UzGliIUb5cQ4tqE1t+P9bHV9fr4+2YUWVw==
X-Google-Smtp-Source: AGHT+IF8EfX9KQQ1p4iTi06dX8tZK+FXrkWjcL6lXHqjNaEzB+PCWJA7HAgzLCdOea5bBV2RrgagddXs06++gkV4LIw=
X-Received: by 2002:a25:dfc4:0:b0:dc6:e4f8:7e22 with SMTP id
 w187-20020a25dfc4000000b00dc6e4f87e22mr1960662ybg.62.1712230352423; Thu, 04
 Apr 2024 04:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329075630.2069474-1-tzungbi@kernel.org> <20240329075630.2069474-3-tzungbi@kernel.org>
In-Reply-To: <20240329075630.2069474-3-tzungbi@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:32:21 +0200
Message-ID: <CACRpkdYGH27Z3YKN4b1y_ZeagbtYqX1Wo7BXnyKsZ=oH-FoQmg@mail.gmail.com>
Subject: Re: [PATCH 02/18] gpio: cros-ec: provide ID table for avoiding
 fallback match
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, brgl@bgdev.pl, 
	hverkuil-cisco@xs4all.nl, mchehab@kernel.org, sre@kernel.org, 
	alexandre.belloni@bootlin.com, chrome-platform@lists.linux.dev, 
	pmalani@chromium.org, linux-gpio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 8:57=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:

> Instead of using fallback driver name match, provide ID table[1] for the
> primary match.  Also allow automatic module loading by adding
> MODULE_DEVICE_TABLE().
>
> [1]: https://elixir.bootlin.com/linux/v6.8/source/drivers/base/platform.c=
#L1353
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

