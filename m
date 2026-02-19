Return-Path: <linux-pm+bounces-42866-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDypHBjplmn4qwIAu9opvQ
	(envelope-from <linux-pm+bounces-42866-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 11:42:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1BE15DEF8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 11:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7DE03016528
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B051E329C7B;
	Thu, 19 Feb 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naFK7Lx+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86330E0E9
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497747; cv=none; b=tpl9lrbWStp5eMJpsgVxKmw1IwtwrvKVEoq+f5d9U/h8gtFFUlIn0cgKErVrrZDhcGQ9SxzLQUvUygHokXY8MWryGScq8FQUDUAjkjAEwsuC01yYHIC1pXLxDYFLJHJWD+RqGx2kOoozImcsOzsm9dbbkAA+yvpWKb7cdLKi3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497747; c=relaxed/simple;
	bh=DLPmFNF1t8rnOwqY9hlCUC2Ch1cA0qmj6oKQsJQAcNY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9r3qmV4Vnlwy7CTArV3uRy11bNUcyz2FKh+JmUr9mBvNISEdx4p5UTFeQBD3ToaRn+ESmzPoTyWNwfrEoG52MawF7chlfvMhCQ7ZG1iaHFladGBYLrEpaNUsudcdUa6y2rPAtg3TpQgJWazTHCgBR/Y5/HqICEVeTHbrpCoPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naFK7Lx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6125FC19423
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 10:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771497747;
	bh=DLPmFNF1t8rnOwqY9hlCUC2Ch1cA0qmj6oKQsJQAcNY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=naFK7Lx+nRvH7hlGjS35VL9Awqe3H2tAWucIbD0lsKh70ltbEXD0WTiZrPBD0UONc
	 Ov0mzTLgepQidPNdn+FDJB24eVYzBsvpbJALg9hZcV56dNqnMgIgYYSTpsl0V613NU
	 hLwor8TgheN6bFJVwJGdZ4DIGITVNubG8ZArXSv0uheKsQ5H4o54KYElZSQd1wU3TZ
	 S2pRBgJ+ApzHvnPjcBYw9uVegDXo3A5iMb7JvZohsQjqaBrQ7+Pbd5NGWPb5FaoN+S
	 NRTBvYv2r65tMrxRNHY8XFCuOVe25npaU8P1AKz2IczjFlZF6/ztxb39vnUQ0OzqoZ
	 YirLz+wD76CIA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso946951e87.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 02:42:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWg870bgv9zAkM1U6VoD+eNqUHjGf9C3jZl2BsF2NyDhddz3XV66EN04Im0aRydRyHSW392Esfr6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9bEe7+N8/I9PML9I3LgVsZQvEAjyPrwGqV1LHySDC4nkRwpc
	6d0Kothj1wZRLkDb0J93oFR9551UNXiHCNFCzerxuZ2KaKkKdH8UDomOiSqrwMMzkQbkOU6RD9V
	1ipoDyRMe4XDhJn/hOCf70DznEdfbfRurU3vTC8bTMg==
X-Received: by 2002:a05:6512:2529:b0:59e:13e5:a2b1 with SMTP id
 2adb3069b0e04-59f83bc4cd0mr1644668e87.46.1771497745708; Thu, 19 Feb 2026
 02:42:25 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Feb 2026 04:42:24 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Feb 2026 04:42:23 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aZYoL2MnTYU5FuQh@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZYoL2MnTYU5FuQh@google.com>
Date: Thu, 19 Feb 2026 04:42:23 -0600
X-Gmail-Original-Message-ID: <CAMRc=Me55NNKbbQZTtzKxkhcro6_po3SLBx9arzwOvpC-_0ycQ@mail.gmail.com>
X-Gm-Features: AaiRm52MA7KEukpqz8dIijfRJL4YhT4gaVm1dHPBRSZDgYaq5kKAFrrCVuVlu2A
Message-ID: <CAMRc=Me55NNKbbQZTtzKxkhcro6_po3SLBx9arzwOvpC-_0ycQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: sbs-manager: normalize return value of gpio_get
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Xichao Zhao <zhao.xichao@vivo.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42866-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BC1BE15DEF8
X-Rspamd-Action: no action

On Wed, 18 Feb 2026 21:59:49 +0100, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> The GPIO get callback is expected to return 0 or 1 (or a negative error
> code). Ensure that the value returned by sbsm_gpio_get_value() is
> normalized to the [0, 1] range.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/power/supply/sbs-manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
> index 6fe526222f7f..343ad4ab4082 100644
> --- a/drivers/power/supply/sbs-manager.c
> +++ b/drivers/power/supply/sbs-manager.c
> @@ -199,7 +199,7 @@ static int sbsm_gpio_get_value(struct gpio_chip *gc, unsigned int off)
>  	if (ret < 0)
>  		return ret;
>
> -	return ret & BIT(off);
> +	return !!(ret & BIT(off));
>  }
>
>  /*
> --
> 2.53.0.335.g19a08e0c02-goog
>
>
> --
> Dmitry
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

