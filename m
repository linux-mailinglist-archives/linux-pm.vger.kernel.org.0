Return-Path: <linux-pm+bounces-17705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA29D0E89
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7D828122F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2C192D80;
	Mon, 18 Nov 2024 10:30:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628BC1DFFB;
	Mon, 18 Nov 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925833; cv=none; b=MhgA67JIBTe5rJaMzrzfNkdpIKzX8dhv3fnBfyVzE5ZVB9N+ai8s3Z+kFgfOCLx2/i6c3cj/mI32AiJ0c39a7jiaN6XgKqQoXWXd+aQ8vqPBYEBbWRxsL5iCL3bF06XunBNBTMjEun0isVBXFkXRvDA6etsSL011ds+w0TOkcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925833; c=relaxed/simple;
	bh=/nQX0U9Y6cHJk2ozwZYj0FtT6pGTQgAAwM8lBV3pp2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIO8Fd3UmHIYo5R6AXBbzE57HTXl23rhApI18l72uUI8GRIApM7OPOSAsQVOmATzfWWsGOQ8qP2jYW4DnMtyAF7AJG/t9oF10wIH1/4H1VWw5bLxpg8mp8KKaas23A+FnniS4P4zXaZow6mVBy1zVzPYOX2hxXrFHGAeYvtHGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e9ba45d67fso38018087b3.1;
        Mon, 18 Nov 2024 02:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925830; x=1732530630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQbnQSmYTs8lTs9KsyqJRXL7FDdkfo0nlRN8P6xRSI8=;
        b=XRneBmQkSQjcmO3d2CH2bIyjmIsFCWjzR72IY351uIObHuthGaaBteKTyIerqdBlqE
         ExY4eOT02JKEqkAor+Q/2i1v5kKDk6XItAGJZzYp6SYA3gKzFiWe4mQSdZ56WmAiNC0l
         R9hJNY7gPwKXlmWh1ksrLzW7F+PzJW4PQf0nw4jLM0/ylvwR348IO7eeDuBI5dW3SFni
         20QgLFGd77cdXkXU1HusRuqGpLkuSYOvLS2RkjUUjQ5kn0up9VuutnjyqNyAyNsn6FYy
         zqKOcyu4iLI1hKPJsu4hOA2S0A9t8ROSsEKmqhLdZ+jf2ggCup8RXkNdTHsFI2mpWqiD
         K5mg==
X-Forwarded-Encrypted: i=1; AJvYcCU4QrnkcsRPw43nZ+tYvc6NkiddROechgT96151f4bZt5ikjkk6kT7e1kZwt2CwACCJtCoQg4uLz0Rz2Z4wWjrIdBE=@vger.kernel.org, AJvYcCUl6XcUd21etFxTyl9461wLVOVq5N7qwylZ5iPowWvpukFtnySDaUgkhQmnMAiA5jpdE1dwoHLqJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDsnS33nOGqMQvbAYkybq0fV4/VElroSvtKKwmZvBt7OfyrUE
	STO7Vje80s+9MeskvTHmH+BtCIBegjHmiMkebk4OTziD5Rt08+DDx0NVeENp
X-Google-Smtp-Source: AGHT+IGivuflQWcwvBIOIuQnjLHh7J7FpMYIRoJsRREHfWCY7MYQk09UJm6fS5PRi4TbT0SPZpr0yQ==
X-Received: by 2002:a05:690c:a9a:b0:6db:c847:c8c5 with SMTP id 00721157ae682-6ee55c073edmr103178937b3.16.1731925829790;
        Mon, 18 Nov 2024 02:30:29 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7127854esm11570097b3.26.2024.11.18.02.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 02:30:29 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea7c9226bbso39647147b3.3;
        Mon, 18 Nov 2024 02:30:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuS5fM0lG71nZ+lVVouPcNbAtXjQD4LrrE9Ev/jo+MjVgfqZRAHNmSm75+eCRLwRjTPjI2C0n0G82s/ePq5WmONaM=@vger.kernel.org, AJvYcCWUraLPmae7lLS+5Aq2rosulBW6f6ep8WqZfDEfprNshQrX//UX2W7M/7zRxQbnmlNEgc7LRyMg6Q==@vger.kernel.org
X-Received: by 2002:a05:690c:6012:b0:6e5:a4d6:e544 with SMTP id
 00721157ae682-6ee55c3e51dmr124949047b3.24.1731925829027; Mon, 18 Nov 2024
 02:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116172934.1829676-1-niklas.soderlund+renesas@ragnatech.se> <20241116172934.1829676-2-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20241116172934.1829676-2-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 Nov 2024 11:30:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXvvD9+2=GvH+AtZUvKx2dhMEtR3e5oXQBF8FgBOVL7eQ@mail.gmail.com>
Message-ID: <CAMuHMdXvvD9+2=GvH+AtZUvKx2dhMEtR3e5oXQBF8FgBOVL7eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: rcar_gen3: Use lowercase hex constants
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Sat, Nov 16, 2024 at 6:30=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The style of the driver is to use lowercase hex constants, correct the
> few outlines.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Thanks for your patch!

> --- a/drivers/thermal/renesas/rcar_gen3_thermal.c
> +++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
> @@ -57,11 +57,11 @@
>  /* THSCP bits */
>  #define THSCP_COR_PARA_VLD     (BIT(15) | BIT(14))
>
> -#define CTEMP_MASK     0xFFF
> +#define CTEMP_MASK     0xfff
>
>  #define MCELSIUS(temp) ((temp) * 1000)
> -#define GEN3_FUSE_MASK 0xFFF
> -#define GEN4_FUSE_MASK 0xFFF
> +#define GEN3_FUSE_MASK 0xfff
> +#define GEN4_FUSE_MASK 0xfff
>
>  #define TSC_MAX_NUM    5

LGTM, but you missed a few:

$ git grep "\<0x.*[A-Z]" -- drivers/thermal/renesas/rcar_gen3_thermal.c
drivers/thermal/renesas/rcar_gen3_thermal.c:#define REG_GEN3_IRQCTL
         0x0C
drivers/thermal/renesas/rcar_gen3_thermal.c:#define REG_GEN3_IRQTEMP3   0x1=
C
drivers/thermal/renesas/rcar_gen3_thermal.c:#define REG_GEN4_THSFMON15  0x1=
BC
drivers/thermal/renesas/rcar_gen3_thermal.c:#define REG_GEN4_THSFMON16  0x1=
C0
drivers/thermal/renesas/rcar_gen3_thermal.c:#define REG_GEN4_THSFMON17  0x1=
C4

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

