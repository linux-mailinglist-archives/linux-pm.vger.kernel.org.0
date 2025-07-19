Return-Path: <linux-pm+bounces-31090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E175B0B0C1
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 17:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B508B1AA45FB
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2756628850B;
	Sat, 19 Jul 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="T+uD/Gxq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62830270548
	for <linux-pm@vger.kernel.org>; Sat, 19 Jul 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752940354; cv=none; b=eGKwB+oybbBtlO8mREp5jpVp4y8URKqeiyVKo0KeoSMV4PmMLNziLIJ6GtxUTMX1MabgAs9XX7UxYYomo7ox27di9tGUmwPVldjzGDuwed2kHLyv0PtOYG4gCwYh+k+pNQWKtGe92uT32UMFbVraPqYmasYG3CezSn14WjeVu2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752940354; c=relaxed/simple;
	bh=u5bc8PEesDrnBIXOtuFP7+ZA4bNJkI3uyCmzQ6D87WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsiqoMqSECoDkt/GoTRPbchBfvGhWtXQjhawP4tGhmO1W1gPJXt5sIywyLCcXe++cH/Lkl40caA8V5jj4PgL7p8qK/Xve0kJKVUN6nCeVEF8kPbhNYOThT5v9G1oAhMXk/y//z5B4Rg1niHqseA9uSNcFus6Wd3mURf4Cwj9vq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=T+uD/Gxq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b435ef653so23565271fa.2
        for <linux-pm@vger.kernel.org>; Sat, 19 Jul 2025 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752940350; x=1753545150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5bc8PEesDrnBIXOtuFP7+ZA4bNJkI3uyCmzQ6D87WI=;
        b=T+uD/GxqVcLAZ3jyJDJvvB2C5ehK2HaS9u/DQIWCvzOHH7OZFU+MvGD7k1LJFmqnsO
         WxuQdXNLSxEgeeKWX8KEuMK7l7F6UblJqt4Kv8ZaS2z7VTpqiNftyu7a+dYRA6+zyDc/
         f7xvKiLWQSyD0v8ob7m294L9LFuiGSWv4bLieGrC4lYZcdR3GeqyD+YBjEeXe82eYMoi
         T6WHKa8zXAn5SQhwsrznXWIuJcozgIeYGTG73xXmmsH3ZpFpze/0qIaBnWhMkLQeJTvV
         oTMFlZ+fNNsgTfr24/pehvnFULpMxlqvAMJgcfRjpmaQOn8zll/9YMZX7ALMBUqsS1aQ
         XLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752940350; x=1753545150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5bc8PEesDrnBIXOtuFP7+ZA4bNJkI3uyCmzQ6D87WI=;
        b=qEHbVxqxCi0X8wCYLovzMKAbRnSkMzMN/BipJBdyHbxR6Guvf99z4lPIMqAv8NKNCX
         dTUIKDC2aYz2Ov+cAqV8b0ogBZdujowrBt0QY0hEHEhnwPDQf+9n8hdDNodT33QNkulf
         X0rej4kqekid9f5lQ/HRm1xjZOF3Ov5ynYtWtPIXgBu9R8oLNyPx+zGxmfAk0EQflfyU
         U+6fLK/nr2/DdwOJnJYc8Itsx/y+GKuJNQ5fOUuRvt9z1nhp39BIDUchw+nILlvCDH7I
         NTI61nAnxWyJqy3Z0HryJWNlwkai7BpJlGapxpfTfN/w4Dh33u8PvSMYdtGXOv9h3qeQ
         Z7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvhhZz8zp0qtDl4EqRofz5rvqNbnHXSb0OvuQLoFepQDzrSZ3zbEUKQBJLZcJh8FFYgOVt07vCYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLtQR1LW34iVSlS7efic83KgEl5Xv8WfYj6IQWeTGiVCaIUiR
	FqKG04iXVbyPZAhvEJ3Vfdh5d86qPY4n03qIQb99c64GJmFPfJrWKmVVDk1E/C/ZzHw7Mt1mUdI
	rbPrcsaIFaB+TMnSV7psN6NlbCmFbUaDXqB7T1OW4kA==
X-Gm-Gg: ASbGncuR/FsKDDmkqi7TG8a7G+4rmwsX39fskuFf9bUWq2V0CJICjTAokhpTsewHBGz
	SE66k0tngzIdSz1oj6pxZZkolXiJa/d0lpjOuQUhu8M+9NnG6GBwwKRQ5n7xOZtFzgD+4PfovWc
	zXC/9c0pGleL91nMhU33q3FpFyZ1WQEMc7GgLEkn2eqvYyLonqWoYrM/6iHPgb8uSEbCIyCyCIL
	Yi12Ph41XUIyNuzIxesIygILhL20e4oROrXujM=
X-Google-Smtp-Source: AGHT+IFmiA61E4Gg0hTSxNIaahpYBE3l0iLJ8kM3KyoRS/pDDJR+mBK07r+7Ph2Rktom9ZxkS+DLG3ISTwAgRVBfuh8=
X-Received: by 2002:a2e:a550:0:b0:32a:85ad:2162 with SMTP id
 38308e7fff4ca-3309a46638amr29026981fa.7.1752940350231; Sat, 19 Jul 2025
 08:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
 <20250610-smc-6-15-v7-6-556cafd771d3@kernel.org> <8f9fdb3e-9655-44ce-8a2f-c1628c88c929@kernel.org>
 <CACRpkdZdz7eHVjgX-X_UwjJ_qSu5hSPeocuQ9DWSiyjNLU5AmA@mail.gmail.com>
In-Reply-To: <CACRpkdZdz7eHVjgX-X_UwjJ_qSu5hSPeocuQ9DWSiyjNLU5AmA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 19 Jul 2025 17:52:19 +0200
X-Gm-Features: Ac12FXzcG7EoJK0F7AkshhLftC2Qw2ygudqOy-1un15EMy9NVqfotyOTu45yZjU
Message-ID: <CAMRc=McNK3fmbP2UON0EGkjM6gH_1zSHFr_PzZ9JhR7a5swLQw@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] gpio: Add new gpio-macsmc driver for Apple Macs
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sven Peter <sven@kernel.org>, Lee Jones <lee@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Hector Martin <marcan@marcan.st>, 
	Neal Gompa <neal@gompa.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, linux-pm@vger.kernel.org, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Conor Dooley <conor+dt@kernel.org>, 
	Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 5:42=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Sat, Jul 19, 2025 at 2:59=E2=80=AFPM Sven Peter <sven@kernel.org> wrot=
e:
>
> > top posting on purpose: are you fine if Lee takes this commit with the
> > rest through his mfd tree?
>
> Bartosz should answer this since he's dealing with the merge
> window for GPIO, but generally it's fine, and it's even using
> .set_rv.

Yes, for sure. Lee typically provides all interested parties with
immutable branches after picking up complex drivers like this. I
already reviewed it but for the sake of completeness:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

