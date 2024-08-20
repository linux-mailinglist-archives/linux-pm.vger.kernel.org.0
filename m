Return-Path: <linux-pm+bounces-12550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18694958255
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 11:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9880282F5B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E718B496;
	Tue, 20 Aug 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dt+Nk5xw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503F18C34F
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146473; cv=none; b=GpFjYRkKaZI7BNZorZOv1O4pm178Faxd64IXwP8djkq8TmPnIbaXRfxmvY+1Sfp5vNmmJfkPyk8N7h6s/qCZMoQDVF6FFDDwzm5JfQGztxe5rmaBU6CRf4YHEHTQkjmn/o4CfMpXws4KMLYBmCWfnLyjrngVnvwytFjVsKniov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146473; c=relaxed/simple;
	bh=bctGAWm4CZMTjMDHoBpmhXLrDTWUC45Rryu9n2fEaS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0vWEGfQGXwyQ2bdYSwcpbSQWWq2cZzwToahBNAYX76E3Djwl52DzrOp1ysnm7CBwbq6v7mVfVDIKbLmm2ZZJ9LbxAx7u0v6foKFDyBQCPYLZ4VZIVWpPsKLk+O44VcMvlPHVUmxQ2YMDHbvsyforZjWqULt5eCazvDnkuytjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dt+Nk5xw; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso3655109276.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146471; x=1724751271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XYmbMxrJSnqH0+fr9BmoI9eFFc5ifdthYZwO1eH0jRA=;
        b=dt+Nk5xwb8KdU7Z8wEv6luXaJhNZU0IZrU8b6cwXQgW5FN2Xx2JExNYPnq+6EOGcP2
         MPlQ3xvERm8hKTRdEe6IUdW7LH3prPfMhFJ66LgKfdguiohiGEZWGVyHm2ci4pgynG12
         onDmSFgmwyBFBCEV6AVg35a/HfatpnMN8NBhF/TqE0tfPOvszLnKF/qnR4Ipd7CXlAv8
         xOI1u51baLQfg0iwOBvZ2qfb8R87wH+DN/TNIoMS1sFk5ozXg//Nzxy3Ms1NoKH7S5fn
         9N9o5Y/ygZnk5vIoE/tPgRQliwTu5mL4zvDhnboNV6e1RepgvFP4hl4T/YmJ8hDlyeQT
         Zf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146471; x=1724751271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYmbMxrJSnqH0+fr9BmoI9eFFc5ifdthYZwO1eH0jRA=;
        b=cCgtJjBmMf3DkIld8vyuoDPvoDklePU4ligwsmIR3l3dXCMhMkLJl3je7qGHjX59j8
         Pt5IYUYDSQO1F/g5gqIi+b/nm9xGXB26Bn1ZU1QKtIMLVd6nQ3ztMkrSEpMMotZ3HwKi
         z9tvex5juYKyPVUVrQPSf/DU6H1alrw4EWnmRs4AeDCZLr/FC708GM9478/zXxwo4691
         9HhLKo3uh4pIDdcn6gWEi0eU8jFsgPLy310+4A3WkCITlYRJqZWSFv6FI8z5yDlYSxu1
         TIxBpNqKyyFO7LVx9ZwimAQbNWiQGAfdlsDBB7BBad7T8lwAKPn645kKDzHwqdvhuw8E
         QBMw==
X-Forwarded-Encrypted: i=1; AJvYcCVO4CmXJeSdXZ3hO+D/OFtCIh/KjzIgT9wkdtXXqsGMYW7spyZ/WiXgeobajv/5Wcs0hAXdCpiQkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqlG3dZqeL+YGIR/CUgbXGTSYuG5GJ/A8L/7yWwpHE2v4Q9+D3
	ln92u6o/wTzpkUVvDhddTrXrEmRzuhTzwOAZYhr1LJFSHmgzWW1ATYtuSjVTOJRb7n8J4wh5jGM
	Jn75AE1jEOaKqQXIwB92q8x4HvA8V4QAeRy6DlA==
X-Google-Smtp-Source: AGHT+IEFZJUEoBqdNNpJET01NaxfTcS9rX0l4uTNuyoyoMI2z/9cYVc5bx/EgPUxFSfpoLbSTEzlZup78ErabF/VoWU=
X-Received: by 2002:a05:6902:a08:b0:e11:6940:c29 with SMTP id
 3f1490d57ef6-e164a971878mr1895149276.16.1724146471063; Tue, 20 Aug 2024
 02:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819115956.3884847-1-ruanjinjie@huawei.com>
In-Reply-To: <20240819115956.3884847-1-ruanjinjie@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 11:33:55 +0200
Message-ID: <CAPDyKFqLejTCtQfU=MX587D7S3O15dZm6S3Ecz4qJTf3GOOGfw@mail.gmail.com>
Subject: Re: [PATCH -next 2/8] pmdomain: Make apple_pmgr_reset_ops static
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, 
	p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 13:52, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> The sparse tool complains as follows:
>
> drivers/pmdomain/apple/pmgr-pwrstate.c:180:32: warning:
>         symbol 'apple_pmgr_reset_ops' was not declared. Should it be static:
>
> This symbol is not used outside of pmgr-pwrstate.c, so marks it static.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/apple/pmgr-pwrstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/apple/pmgr-pwrstate.c b/drivers/pmdomain/apple/pmgr-pwrstate.c
> index d62a776c89a1..9467235110f4 100644
> --- a/drivers/pmdomain/apple/pmgr-pwrstate.c
> +++ b/drivers/pmdomain/apple/pmgr-pwrstate.c
> @@ -177,7 +177,7 @@ static int apple_pmgr_reset_status(struct reset_controller_dev *rcdev, unsigned
>         return !!(reg & APPLE_PMGR_RESET);
>  }
>
> -const struct reset_control_ops apple_pmgr_reset_ops = {
> +static const struct reset_control_ops apple_pmgr_reset_ops = {
>         .assert         = apple_pmgr_reset_assert,
>         .deassert       = apple_pmgr_reset_deassert,
>         .reset          = apple_pmgr_reset_reset,
> --
> 2.34.1
>

