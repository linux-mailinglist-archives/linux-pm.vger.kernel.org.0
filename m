Return-Path: <linux-pm+bounces-12793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3845895C646
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C9F2857D6
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 07:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFCB13A86C;
	Fri, 23 Aug 2024 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="XslyPLyx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC713CFAD
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396990; cv=none; b=r1Jtd+hfZLwapLI3vhfKmR+/5H695cd7ZFmzVyrXsebWJy02GJEJHTlzNtKc3tE1I1hIZ61Bq7BOeZ5LhdFaKIBnuPZ7TPTi4MCG6bx+ms0G2xhUO0ex2MW+sKOAk6e2oNWxYdEk7ATgFfCxsCeg0PctFwMSbQqvgZn9tuZZL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396990; c=relaxed/simple;
	bh=6/Y+PAcwqnv9X4Hn2IGNsHNmrjRh+Nqm3Kd7gOnya3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xw2rVy/oyetFdqUcztuMygSGmRNveAcbf7WJpnnMDsy4dX4PoNTrrEsJWKfh1xBTXYQkeWq+cP9ktwNHNZ0ygCWXdcMqcz4uDIEdgsveaSWq26Trwovou1W5wS8yvlWiBrELo+WWhH1mJL1QvxNDvvNvqy7SZF3T3Ymol2uovHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=XslyPLyx; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d380d4ffcso6253175ab.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1724396988; x=1725001788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYiyuSQAwfiQQ39+HAQvaBlmRARXpxRgdyCqu4zVO9c=;
        b=XslyPLyx14NG0ioOukxMW9PD6r+BTCl8L4jjyQvyfb1PZj0zsPV9VLHBaFF55N4fd3
         vjnqU2Nl6GyE//j2sC4cKvBTBztaOctjsK+SBe9YyXUq+TQolsfDvbislIcXZhhVf47q
         nznOuXhuImmIQbN4ifHJOe25OCSOPul5AVQ1XHTQN2XHv6DujJPUOhL+t26ARZqn7Zpw
         zm8FEd7TUt2rK4kiwIrIuK6suUVWPriIw/lTV3xj5RmXDlSH6OWtu8hb36aMKnWXFldH
         anGNVLt2KiRYeZXJYm+fUH/bD0PZCJKtSYDB8ak01VMWDNed1uG7/ijlRKUqst4XE7eO
         CzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396988; x=1725001788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYiyuSQAwfiQQ39+HAQvaBlmRARXpxRgdyCqu4zVO9c=;
        b=HWb1nKEWHv1rXD0K2fvmROjI6Ipl4PTo0D5ysN808J8MsuV7ANFHR1sJLcrcWdoxsq
         R5+Y1Ou9s+R55IliScZyoOIZYaixiAMkse6nrzdeFm/V4rs6U0WS4SUaqo9K+kgJEmsp
         wNMkFnyrE609KkkLc5ujq0J03fncZV1KC5cnDz2aRO4UUVokMk0PH/8nSkqRkA9siL2c
         LWzX2Ow0MzBoyOFnBtq1r0g3rS0G8GqQR9or3dLNyiDdk8WZfEundJwUlK7B2UMwDxC1
         JFKYKUJqzfBJpqRNJmUxP89G3jr2rXKO+UzO2dVFi2UkoagI6abPvb9xmhF/KHzjt1EO
         umJg==
X-Forwarded-Encrypted: i=1; AJvYcCUs13FUbU11pvhHzjYyZ1iaW4qbRjm8ii0NfEKzAKILS5UGHwK5xyRmpKjQDtsnOp4JI3mrKUGYew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwezTYAxQVR/PLOJYROEyrPXfT4CCM1SQO4w4NLhjgSJpwXxBKk
	8EFio5fT+Vg2pmAZLLBOovQvhIARoRLAefZyOr1TIyVJcQbx6a698Cns4uOJMgHBqarOPL+XShK
	ws/ZuiPewlsI6y3x+gJpmYakKaW/OqG+ZGM+CsA==
X-Google-Smtp-Source: AGHT+IFheFAcpjMzzb2iqY4HfoVxZvmcsr/sK9zcF/qfuUz+TYRMD4/KAnFW1EAGR+jGgOYeNhlDxxZStd4REvhqF1Y=
X-Received: by 2002:a05:6e02:1a65:b0:39b:3e01:cbd4 with SMTP id
 e9e14a558f8ab-39e3c98c3ecmr14412585ab.14.1724396988109; Fri, 23 Aug 2024
 00:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814054434.3563453-1-nick.hu@sifive.com> <20240814054434.3563453-3-nick.hu@sifive.com>
In-Reply-To: <20240814054434.3563453-3-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 23 Aug 2024 12:39:37 +0530
Message-ID: <CAAhSdy0aPwod6_5xf6rw++jFFZNnOSSWJzQ9CJM0g55483rVSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpuidle: riscv-sbi: Add cpuidle_disabled() check
To: Nick Hu <nick.hu@sifive.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	greentime.hu@sifive.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:14=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote=
:
>
> The consumer devices that inside the cpu/cluster power domain may registe=
r
> the genpd notifier where their power domains point to the pd nodes under
> '/cpus/power-domains'. If the cpuidle.off=3D=3D1, the genpd notifier will=
 fail
> due to sbi_cpuidle_pd_allow_domain_state is not set. We also need the
> sbi_cpuidle_cpuhp_up/down to invoke the callbacks. Therefore adding a
> cpuidle_disabled() check before cpuidle_register() to address the issue.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index 98e7751dbfe8..3c8a509288f3 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -25,6 +25,7 @@
>  #include <asm/smp.h>
>  #include <asm/suspend.h>
>
> +#include "cpuidle.h"
>  #include "dt_idle_states.h"
>  #include "dt_idle_genpd.h"
>
> @@ -336,6 +337,9 @@ static int sbi_cpuidle_init_cpu(struct device *dev, i=
nt cpu)
>                 return ret;
>         }
>
> +       if (cpuidle_disabled())
> +               return 0;
> +
>         ret =3D cpuidle_register(drv, NULL);
>         if (ret)
>                 goto deinit;
> @@ -548,7 +552,10 @@ static int sbi_cpuidle_probe(struct platform_device =
*pdev)
>         /* Setup CPU hotplut notifiers */
>         sbi_idle_init_cpuhp();
>
> -       pr_info("idle driver registered for all CPUs\n");
> +       if (cpuidle_disabled())
> +               pr_info("cpuidle is disabled\n");
> +       else
> +               pr_info("idle driver registered for all CPUs\n");
>
>         return 0;
>
> --
> 2.34.1
>

