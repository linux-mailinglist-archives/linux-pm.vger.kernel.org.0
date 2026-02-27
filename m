Return-Path: <linux-pm+bounces-43347-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N+8Lg/RoWkfwgQAu9opvQ
	(envelope-from <linux-pm+bounces-43347-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 18:14:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AF31BB4AB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47EC33017037
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E642356A3E;
	Fri, 27 Feb 2026 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAg+Tc4E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423E3542CF
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212335; cv=pass; b=iXYEn2MYDunCj1HoAGZ8LRWp/HjV96YluSIVZF+XhsaslaoKCWzNB4cE1kfkAhzufT0E7t+5a4ot7oXhlvWpXNPl/B7GxaPhlZ5+RgMK7y0j+PuRZx+JgISTvyWjMxFT+DqAqN6diOScS/HvkbKKiBYUf6naDHrHd8QUPx5wA8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212335; c=relaxed/simple;
	bh=PCfezWlqNqd7uS3taiiwQ+8glDG+PKKRTO2Yo237mH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPHjAKJNjJKnyVbFbqiiwQj6m9junaqiJS3v2yyR7hp0LKiVGWrFoqnm9P17s2lQ0z5jY+jN/WGOI9ZexdY7H6otAeKLLF28vv1qtTj2eN1yRa4lZV8An/4PZJcfXMfgO41kqAAYpW9HOf8QohLfC3eeURJuOhQSc5GxDkwUC1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WAg+Tc4E; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-389f9e70ae6so28577891fa.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 09:12:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772212332; cv=none;
        d=google.com; s=arc-20240605;
        b=ZnTVvqKgTunK3XqKXs0zF2o6nDGox9porQv9HA83iBhE7Yj0/g4eurz6tjnwXebfFp
         /sD1fQyMh0behAqa1D7cJCqRDY8EJnHD+YEK1T/zRdE1OtMNl6Y7X1FBlBKG2SPHKvnW
         GiGy1nduVDPSg+EPHPtCx0QqoIkPOkjwxu4mW3V8GtlByL1u9u2VxiqCWjFtYIpzvxYA
         r1OCzRD6+908QfE0Ff8iq4l2PHvSFHORZday7UVfvi0k3EDOPLk8In/8J3EToKSgWqeF
         uDimkQoxz+NEcdVhxhgaBRHpOM3Z97+Jwfzxx1gyLjhFzcq3QHjxkJu9jz4C26Cg59E3
         VahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DHJQnX7dxsaQirsNm1TyUYVKGkK5VW9C/E+gULXjR68=;
        fh=7qqzAnME56tzid8wIwwyXuSSU9hbYqsjW4s6z3dRKtA=;
        b=SSHTHoksWZ8BhwNCyZupFE0Mrg8PQPe9GPYAYXkqAmpcZMLSJSCgTNaM50+wzacxDy
         RGW6dEC5pzY6RVAH3T7DQuAY2p1cTQtr6BU8+S7HvDVMadRJwVnJ5nOfnCG+gWIa+EI/
         uVgI34KRTHYcQWOqIo0ysRgoA2y93ZhTjbfwvnl8lLud5qz018OrLitZd5huwEvCq0az
         JU9Dwt0AANo/JGW3GOUbj0A6UcllPwCFocc/3+tFDycx+MFxSnWZFPDzoqHycKwC7YBO
         av2fbIcCxLHm+vmj1LGaWXPKxHU7kOoJ7FrDz1fTe4T2I7uK5b7qjJ22k9Ao/Hjl0hJM
         GEog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772212332; x=1772817132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHJQnX7dxsaQirsNm1TyUYVKGkK5VW9C/E+gULXjR68=;
        b=WAg+Tc4E2+XutrejHidE+RVygAHR6tIzp7raNgSc+8WmuZSrECJTwo55wFqOV/g3IN
         4gHrnz6nJ3ygDDhg49oCNpbVVQcvT4t+6UaitJLMRdY0WDfgTJWwiu1ox17h2Z4muoAz
         EfNMQF+ymZv0UB04ilyPlQL1ganrSmVOJ0ndV4EL7q53TxwthQWQHSEG1XQHgQB4ZHKt
         q3Ks8q15nNXoxfZ/jF6moepOYmUToIfFCZkijCfOm/risrTwoEDiiBHi8sOwqRsAh/64
         823XnBZMe3iqj7CyGPu9E34H1gwmAhgnv0ho3tJfJaheNH5GxoBdJnCxhYHmvlsey9FV
         1hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772212332; x=1772817132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHJQnX7dxsaQirsNm1TyUYVKGkK5VW9C/E+gULXjR68=;
        b=Zccqr0X4bJHEZhaCoVKJYc698ixJVYM4GiKzT4qQFDACaexZnvF1kFypsTxTZLDU0S
         KR47YHgxqbf+cEN0T6Qiqg3EDZZda0BSfT6rzK1Rx9qQLtQh6zweAyR4xLaebIvoWAdv
         I6m3Q9FABSM1R+3NpVCa/qJOyF8H+Yq4UMucnXuiNi4qxuaN5RYqFQjyk5AhgS61z3ru
         OtcohueG4DXJ+Q6XqSUoWqe2EN4HAknAZ9gQ/QAuBX9HdR65EBT9qfPCo1MGKDo0WGWt
         DVm63WA/aA2VpBCBjhpvxRCzHq3YpZlDIWsG2wjSpAp84Ppni/pH5DXwEjU9CrojHe6j
         wSMg==
X-Forwarded-Encrypted: i=1; AJvYcCUGagsAr/xARqNmhG4KajcIFSxI4nQ4i4Vlw2Fbvfi+2nFiRk9LX/5Re5VsCA1/LXe88oX0snYMrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpe4zctyjAW9CQWi/5Xi2U0ikv/o79GWSHxL/sb/MeIS2XvE66
	QWoX+tAMYcSSASNJvRJNEIJynpj3arXY+mPu818jddbwUivJbYl43i+wLGkWxOasMOcSzW3HAYz
	HzMVte79DgjOo5FdcUjmg3vazxSNTpaKVHIOTn7IiVg==
X-Gm-Gg: ATEYQzwP7OMp6BrV5/Yof9y9W67NLOgOxqpqG9+BH825bUBsFopRZgdChEQ9xUbhQU9
	IH+B/nvlfStojvu1uyzQgdJdUgy5Yo6DRr2Bp+6rNmqd5vnpZpjjnsfycIn5Bn5zp8RgeQOs/69
	oUck0Xr8lzXmran1Oyc5CFLT1jzMen4pTcOTTNf1dOcrzl6KdPFrRooi1TmncS1i8w/2bfA8Qzw
	5DRb1ptRLYLIoKwQrwoziOArVcyyNnJgNJSLoLPDw7qc3QaHtjZCoJT5WfBZ1FZU/2SGP64nWYo
	wVMa3E01
X-Received: by 2002:a2e:a548:0:b0:389:ffaa:7812 with SMTP id
 38308e7fff4ca-389ffaa78femr22939551fa.41.1772212331723; Fri, 27 Feb 2026
 09:12:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212150039.67117-2-mcanal@igalia.com>
In-Reply-To: <20260212150039.67117-2-mcanal@igalia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 27 Feb 2026 18:11:34 +0100
X-Gm-Features: AaiRm52rbLI-MD2y29yAU8kDsNHpRGPIqV7ky23ZuQA7ygykHEA0rYtPZw_Y9NM
Message-ID: <CAPDyKFpT6m4N9AWSMO2VKm1M3n22Ye9+i-t7QT-JtTtB6kfuFA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: Fix broken reset status read
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, 
	linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,gmx.net,vger.kernel.org,lists.infradead.org,igalia.com];
	TAGGED_FROM(0.00)[bounces-43347-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,igalia.com:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 04AF31BB4AB
X-Rspamd-Action: no action

On Thu, 12 Feb 2026 at 16:02, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> bcm2835_reset_status() has a misplaced parenthesis on every PM_READ()
> call. Since PM_READ(reg) expands to readl(power->base + (reg)), the
> expression:
>
>     PM_READ(PM_GRAFX & PM_V3DRSTN)
>
> computes the bitwise AND of the register offset PM_GRAFX with the
> bitmask PM_V3DRSTN before using the result as a register offset, reading
> from the wrong MMIO address instead of the intended PM_GRAFX register.
> The same issue affects the PM_IMAGE cases.
>
> Fix by moving the closing parenthesis so PM_READ() receives only the
> register offset, and the bitmask is applied to the value returned by
> the read.
>
> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains=
 under a new binding.")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Applied fixes and added a stable tag, thanks!

Kind regards
Uffe


> ---
>
> Hi,
>
> Most likely this bug went unnoticed as there is no in-tree driver
> currently calling reset_control_status() on the BCM2835 reset
> controller. Although I'm sending a fix to the .status callback, another
> possibility would be removing the implementation of this callback
> considering that (1) it's broken and (2) it's not used.
>
> I'd appreciate your feedback about the most suitable option.
>
> Best regards,
> - Ma=C3=ADra
>
> ---
>
>  drivers/pmdomain/bcm/bcm2835-power.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/=
bcm2835-power.c
> index 1d29addfe036..0450202bbee2 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -580,11 +580,11 @@ static int bcm2835_reset_status(struct reset_contro=
ller_dev *rcdev,
>
>         switch (id) {
>         case BCM2835_RESET_V3D:
> -               return !PM_READ(PM_GRAFX & PM_V3DRSTN);
> +               return !(PM_READ(PM_GRAFX) & PM_V3DRSTN);
>         case BCM2835_RESET_H264:
> -               return !PM_READ(PM_IMAGE & PM_H264RSTN);
> +               return !(PM_READ(PM_IMAGE) & PM_H264RSTN);
>         case BCM2835_RESET_ISP:
> -               return !PM_READ(PM_IMAGE & PM_ISPRSTN);
> +               return !(PM_READ(PM_IMAGE) & PM_ISPRSTN);
>         default:
>                 return -EINVAL;
>         }
> --
> 2.52.0
>

