Return-Path: <linux-pm+bounces-24191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91565A6553C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 16:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A056C3B5714
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D5248195;
	Mon, 17 Mar 2025 15:13:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7152475C2;
	Mon, 17 Mar 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224391; cv=none; b=IJyAEAMXMW7UrZnOikzFTM2HiecdF3Kt9CIJOmCQp+iPWkRipcayFtZyay1PR4651Av/PipF/Pz/JwBDSl6xA6Yg3G4lg+xqBCP09AFAR5GK+2aIYmEAlp8iyYCzxAGX5yytoWQNx4MblCNEm3P2gNWJG78OyKrI8ItUz2QozcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224391; c=relaxed/simple;
	bh=8ki4q0Edxr8GKUpbOiCXmfNSUZiSPK+DhkD9J9jyQTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmdS8GyuOKq2+cdaPowJj8jZ5hh4R8bRMd2oKKIaDZQ9Tz4DpBrz6rc5IwUHft0boZgXyukudJOg0mFjhoCXmgDr7Jw4bnaBGIfrss6C9TVPj423rzYLe8uf+mS+xi5BI63kqWbKSEqSsUkKjJ0flAeigsWiEagM9adnowxNzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c56a3def84so456835185a.0;
        Mon, 17 Mar 2025 08:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742224387; x=1742829187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQ8jIa57lwjhm1REatzmQlcd9Rf1xXrQeJeoH6yAZjc=;
        b=jDSYVr3mtlyyljhWPj9n4NCO6ayOLMHDBnU8Yfp5mpGpFGKBRwxHBv3HUU/3NGfsfj
         q6ruu4qVj9e5xT2dE2az/5rXSsj22OQawCRapw86LZE4hhUXMzFklvymWxYBQFbl1yTu
         pIJ2fyzPtnLHnMvM3k6OIHzGYlrIsOulivvfIG3DVwVWK8Fjnpk5wv8ULkMwrdUBpFxw
         D+S5nQuZnumHY2+i/plWadC30229XRbAUU42wLnqMCz8n9NiEIIpEW4GGKka7NM/PeLX
         bkZZiuo4iKbKzt921MyvVkL/HrzSVygr37CJpokfkB+Bs1Cj5NmkjgAkTPQ8BwjVytjn
         KQIA==
X-Forwarded-Encrypted: i=1; AJvYcCUJLhKB9ebFvIOu2BJjCSympVHGF86FDkjOpchGXQAbQj6ESSeQ2nmu21q6KAnNJzQkWOM+DZVs6n/dOQKc@vger.kernel.org, AJvYcCWW2MO22yiL7HMmhawMIS1gLN0mXgCBKlCOWyoSBAHhUWwbXmjdU1DKspGd93P7vVrCfBWyVPvNs3AymeLB7eOA7WA=@vger.kernel.org, AJvYcCX8h3ayvmmVsFi5KMD/D9l3a8LSp9JMRuMKhHgUGfYpoCf11GFOU9PJ68rpZ8om0QkbSA3CS4o56N8=@vger.kernel.org, AJvYcCXrhbf0mWI0XpRZEDU+fJ9Ybk54nKDPzyhlHtDGQKV8TjFvJc1XezlS6AP65QSv766sjC77hF8FYFxU@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIBrtrzvTJNGyOSbYJdey2oXOQai8R3ME4ZRlT7vv6rXVBd7T
	8cVn+Y1sevZyOGtrw+0i/Nm226MSWqxPNmffvi6GJX8g2xzcN1Ek/vu8h3yY
X-Gm-Gg: ASbGncuvMptg7M1INEnD5JRuwqpTd0dI5MvGJR3zRz16a9gkl1gFWZvz+ULSYdKZ5dg
	lYOLVzHbvXIKQwiEBSIeOmgi/rAXbgtMvM5ihLSgu5yaM55pcDgBFC+H0nWq4VM6NhEhVLS2CKk
	n4j8JNJ1Z0iPzqrwnhdXHCx632uFImaJKS0+psEg0ToCSPotoN4MYRRI9VRZh3qj4MSUrdcQIWf
	JJzG24hObq5FvkKeqE9zyuhqxFoDlLyjP4hnT5ox2gA1FaAe/buSnPRVbKKZIoSg/msF8deeTXx
	Qer0TFTcLFjj/16hq5qc3D5sxdg5AGVYHetdAYno3fxm9o0XORIJFNzYFG2NPKeLPeskJW/LCk/
	f45Zg0Ikpm+I=
X-Google-Smtp-Source: AGHT+IFCoXgloUWugsECO/wjOvuvljNjOYRf2E09vbfpLGYKrHWqmT6Q+QXr5hqozMUtvZbXn2B48Q==
X-Received: by 2002:a05:620a:4706:b0:7c5:5909:18dc with SMTP id af79cd13be357-7c57c778293mr1845261285a.14.1742224387367;
        Mon, 17 Mar 2025 08:13:07 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9d641sm595699885a.65.2025.03.17.08.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 08:13:06 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c2303a56d6so522431785a.3;
        Mon, 17 Mar 2025 08:13:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUitvTI2s+dKcTq7fQow5RFh6FJHX+DFe3h1/iiN1ilJ7VIJcQsj6fiIXqkML/2az6WQ02OFToRWKE=@vger.kernel.org, AJvYcCW5BSaHEcGRLKtrxJxeZtXQQd15Xd7PPAHr3sqOi/0UgRMbimhJ+A+FVaZBAbfY1ZrADCWyy5StoAcp9B5S@vger.kernel.org, AJvYcCWvIIprG5pWHEc3JHDu19YdSJj4AJGSiSAJoWErn1uqU+1Y4swCHw2Hc65RZsABWBB1O5K0wuumFuAayAOTFh+tsIk=@vger.kernel.org, AJvYcCXUK4LWn6TjRLfrFeMYgqJfkU/Ww6+bVy+ApSscdOJVkiD8UhdCivBmNx/POIhj+lPsGudJcmMNP1+C@vger.kernel.org
X-Received: by 2002:a05:620a:8085:b0:7c5:4711:dc56 with SMTP id
 af79cd13be357-7c57c8f0a91mr2168801385a.48.1742224386414; Mon, 17 Mar 2025
 08:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com> <20250315081225.92118-2-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250315081225.92118-2-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2025 16:12:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXWGLUzJFKdDR3hLf0iOoKzb15fNQmvzZZQq-a8e6cxfQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jpg6lX0oXExhMFjEColgNw9-KenJiMYc5N0Q9n60tEKl9Tzw_t66R6DG7U
Message-ID: <CAMuHMdXWGLUzJFKdDR3hLf0iOoKzb15fNQmvzZZQq-a8e6cxfQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] soc: renesas: rz-sysc: add syscon/regmap support
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, magnus.damm@gmail.com, 
	devicetree@vger.kernel.org, john.madieu@gmail.com, rui.zhang@intel.com, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	sboyd@kernel.org, biju.das.jz@bp.renesas.com, linux-pm@vger.kernel.org, 
	lukasz.luba@arm.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Mar 2025 at 09:12, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> The RZ/G3E system controller has various registers that control or report
> some properties specific to individual IPs. The regmap is registered as a
> syscon device to allow these IP drivers to access the registers through the
> regmap API.
>
> As other RZ SoCs might have custom read/write callbacks or max-offsets, let's
> register a custom regmap configuration.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

> --- a/drivers/soc/renesas/rz-sysc.c
> +++ b/drivers/soc/renesas/rz-sysc.c
> @@ -6,8 +6,10 @@
>   */
>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/sys_soc.h>
>
>  #include "rz-sysc.h"
> @@ -81,6 +83,14 @@ static int rz_sysc_soc_init(struct rz_sysc *sysc, const struct of_device_id *mat
>         return 0;
>  }
>
> +static struct regmap_config rz_sysc_regmap = {

WARNING: struct regmap_config should normally be const

Aborting review, new version has been posted...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

