Return-Path: <linux-pm+bounces-38753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFEDC8BFDF
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 22:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A64E10A9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 21:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D41315D5E;
	Wed, 26 Nov 2025 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dfVu+VHY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21085231858
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191698; cv=none; b=RHf3UAInLN3HEsau9Ulp2IwFoj8M9RpEJSV5mE3u0q7m5qS4uz03oZnHZbzlPhkPwzmFBQdzifWn1QzTNsFvAYhWtPD5rQjaOJiW89Swbyzw3LP9gIXwneN1uPTnqMcwXe5KBAWPTTashrKGQ7J6G3tIXvZwDJPYDYH1LhuLBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191698; c=relaxed/simple;
	bh=lUOxGFZ78xvHDTluUGBVoIJYPvZab4ZiOPNCVlqCknc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsIRq/byI77TAoP1i2BngyHLlA1ljRJhzCZhSrcwnUGYJyCI/O9QdpqLDFpGtAKr9liAzXwf9PVvfA1b0orWup0B2ds9l0OSEsQESaAVo0OSube5M3gmpqXoUJYazBSiLsUbhd5Evv1sCEI4Yg9yRj3xDJgi5a4qks2GwxM05rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dfVu+VHY; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b735ce67d1dso35028266b.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 13:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764191694; x=1764796494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvpq77EHbE9ZQYcAQmpT2IxQIE0vT2cTVq0TKuSJOLs=;
        b=dfVu+VHYoqBth0/qAeNvwj0fRFoV5vAsrG0Lg0YXx++D+XTDWxbUjQdYSNrrHSroO4
         YBx3ihLKecpQbHU9YdTXUITVBm9aUEYKm4TmYSO4wnY9DuTjBorADBAAPIzYif9vZNYr
         ohuvhsLxiu5i98YcQS1WaKg52DBJPVYcPiwX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764191694; x=1764796494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvpq77EHbE9ZQYcAQmpT2IxQIE0vT2cTVq0TKuSJOLs=;
        b=Ltx7Hxwe1l/1bXTuoeKM5yGaMFsmdTSVvHh5OZ3w3fKFcOF+sSM+fxRltZ3op9YBjF
         Scs4NDhK/46FQGRLTCn4SsvmnEHrPgxNgeXr48xjmx6WccqZYigrq0wN5cxa4H6K9Y1d
         QeiQMuPit/Po8+E7HkHy5fKIc7o9Hu9ad70lTkqP6Oa0wra2dvr+Tc2Pscs1y6FFItjm
         McH86ctwuGtTSe8HfF/N00Ngk5RlooTBGKptTaU5xXtaBf2dSTCry0RSxQJiLklFMLtI
         9oER3yhCPRvBprxnkd2DZ8iDFTzcMyAxlqGpBrNnNRn4kM2a3KXEiw5pxS62onhHwErf
         h0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmsd6YtW8fJTi4pMOux/1VNOF0C4VxIWhimXgDMEgn1aVE7JIkDpsN4wA59kV7dPF94rUVJBgpXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/n+DJwNYv4Rcu2MzPxDYR0yb5dRl4JWOYLpL448tQIGAmjur
	JqkxfXnfkxx4di6NWokzRp4EfEteeUFZZgw8WBmUeALrgfKPfsbcEXTR1KgHmm7EvRhEhvjWfiK
	Hb7utozBboA==
X-Gm-Gg: ASbGncvw63+PpX2ImDwdsGga57b8/6NrTxuVE0W3CNxs/wZu4rHifpe/1A5Ltcb8oak
	qrXQpbU0BPfl8D9PWmjdkXRgARAKlLu6rK7g9EME+xtub4Efl0mLrTj2C+2FebOdDp8qK6CA0Ho
	q2T7cLiH5omsQ8/Ck05U2uZ7WfY+1jdH2qQp9i2IsBpLxb2ypppPMJZWQiTPFXD4w2DFvfguyfW
	hq2Ll8EgmDvhkPq/NwDljysO4pOlOuwUegEDhxMcjTE7QIgxtOhKcWbLSpPZOMOYs/Upy5zTMNK
	prtn25SbHaU3i3voAkoKKKNp//5qO60q43uU5zUbucPwaj1OLsKTWPzTm8ihdBGVnDBar746rI3
	5YkI18tKK80GF6IUXRPiLyAH9TER+YAFB74MrIm0NKHRLbn2UMrHACx9iEtm/hJZSTXGC14Zgm+
	GgiZIu8Ff6oEPnLvL5Cp0/qNa2TU/7eGAh2xYEctINJ/vfBGDrlSRhx2m3YZme
X-Google-Smtp-Source: AGHT+IELw4HXIPUEMHSFAvnJZNXqzYtIqIRbeYk3/Olu2GaG0Qal7C1448hgn7Rnzv6doTYQ3U48EA==
X-Received: by 2002:a17:907:6e8b:b0:b76:26bc:f95f with SMTP id a640c23a62f3a-b76c50c2061mr857048266b.0.1764191694134;
        Wed, 26 Nov 2025 13:14:54 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4fc4sm1986275666b.43.2025.11.26.13.14.53
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 13:14:53 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b735ce67d1dso35024666b.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 13:14:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXItPdQGWsQM8ZIxnM1qV3ZOZeyQrjr61FyKzi2jKbhUWtEw+1coGf8pD+a8Fc0sQSPzyhbbs5nCw==@vger.kernel.org
X-Received: by 2002:a17:907:2d12:b0:b73:594e:1c47 with SMTP id
 a640c23a62f3a-b76c540b1d5mr946225966b.26.1764191692891; Wed, 26 Nov 2025
 13:14:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiFS7=wrjCoEguQUqwd=L4tJHNP8mCdagg0FR8NQTGLtw@mail.gmail.com>
 <0e90cb97-c0bc-48a9-92ec-2493e89ce6d5@roeck-us.net> <CAHk-=wj0coxhdnHMvhKAGfEy3AMgk+BX2n=Qvemt0Z=ZxsM8+A@mail.gmail.com>
 <d79d3d38-1fd3-4708-930c-621a4c28cce1@kernel.org>
In-Reply-To: <d79d3d38-1fd3-4708-930c-621a4c28cce1@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Nov 2025 13:14:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmwZTxxT_hEbRR=-H0yT5uXtfr3t47Hw4B+Z_M4aGPAA@mail.gmail.com>
X-Gm-Features: AWmQ_bkxKXh64nOuzuMse_wErDtXDOhI_T4gIirDmpFu3inz__7Y_7kccnj_n8M
Message-ID: <CAHk-=wgmwZTxxT_hEbRR=-H0yT5uXtfr3t47Hw4B+Z_M4aGPAA@mail.gmail.com>
Subject: Re: Linux 6.18-rc7
To: Hans de Goede <hansg@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 12:45, Hans de Goede <hansg@kernel.org> wrote:
>
> Maybe you can cherry pick that patch?

My fix is different. It looks better to me, but is entirely untested:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad8cccc24887655ebf0a3f459d38d1fb683df46a

I did check that it at least builds on both i386 and x86-64, although
only in limited configurations.

          Linus

