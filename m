Return-Path: <linux-pm+bounces-27530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0941CAC166E
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 00:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8825F1BC55B3
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4235526A0E5;
	Thu, 22 May 2025 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fORy/Kqg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9526A083
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747951789; cv=none; b=mDOqSc4gVtxA8sNq2emmf1pOuc2AXUMSkcNJArbRlNcICgS+Xq/6tXwLV/7LXoDTaCxOkV5a+e3M1gnmnakL8Qg8NCapkMj7NahWbF6QQWBpb3c9gxwwt8X1+7GwR5nxcpII76wEWVufb7/1RQhlrDcApeMgbMM4Blkve/CS+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747951789; c=relaxed/simple;
	bh=aGU5joKlmsc4tJLp/ZjJC18En5pCyl2YsaUdNZBEyNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rd7iNHxjMX+XmcIdyrAFjy8eP1AVSFQlP/ZAtWNpCc6h8zrHx3rVduG9KtYylM/WjAaNGfknHmcggJZCWaWC55q3boitTPrjEPh1Y3Cp3kj0RUYFfBslqqEwkjIwiZjVjPv+GJVqEsabRku1m/umRztgUo7j7hxw9p+yMpi5IB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fORy/Kqg; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7d6bedd114so1343257276.0
        for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747951786; x=1748556586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ytKn/xAm5fG7iosGiXWkgx37JTIZsw4UDMYhapgMJtk=;
        b=fORy/Kqgj8hWSwsElD1XqrJi5qK8Ah1B/Z41PYblSK9GiYuMpHUJljlLbd30vhzPBo
         9RvHFGr8rxEGoCbYYmEDrhNGZYHwVUnHfLS1sbBIFwN9V5dWOgzi8NkYXC4X9g3aKfmc
         5d2IN9BicLPfqqcxBgQCWYs2nQLtqbVgERyCf89O4LjysTTCPLnprJ/oW/gCb4AAMAFA
         jD7Q2/YQMDRjpyn+FNDHDwzo4bNthOfFLT9RuPLrEtQoQZQLVa6JtBp5DV4CNTzT27Wj
         8fLVo6XvsOlR+FBA50sA9BG89KBUm7DDHsjncsQgOGRBeYRr8SgrgT40eXq63VHmTsup
         qUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747951786; x=1748556586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytKn/xAm5fG7iosGiXWkgx37JTIZsw4UDMYhapgMJtk=;
        b=ZcrdztBzxiuJaoCstF26JBxiWLVNMdUazeqAzUb3hfk69XoFXpW++GicpbYxg2p7iP
         c+vx5mvJfI+YYnkCQGysHiB79m/9SivocAALB64YSQjA/fxwEpILBZQaL0o4QiEEKVV+
         st8zLoU0ougKAkIllpR1ANbuY7RjUmc8Si1SoHx4QOKdJfNAnCOkglMqDRCP+EUxKVbh
         DbNm6AM0cyQ86K014MhJBO0pro07e/UpMigReeODwawXACyMNx4PABtsOaMhN6beo+gp
         ZUcR2XCYZRWxT66K9WTqKgIJjLTWvdKQB9WqHA1DMNnLg/xUSDkfbAX9J55WHkPm8eLS
         xbtA==
X-Forwarded-Encrypted: i=1; AJvYcCUN55VYYEMoj6gTr1RLe1J6RVYeDU9W8eHIVaj1l4IOaPHFFixpI+64axE/XfRt4GRmDqLs0SM/yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1afJvqoZcVpyX1BDqOfeLVaD+/bGpXw3lQIJdAUXuNvUs6YOe
	TXY6nLx2pm2biY6iseuRE/wh96W/j0f/72BFKWuyIg0yJQiZqjSEyabnsojbHnvmJNGxcA69rWl
	bfIjWI+KtO+LCagdEvEBEf+F6g1vy7E8lGsoaLCzNsg==
X-Gm-Gg: ASbGnctvTPdsFO6LOZl8ZcR6FhmB+angoJ5X9CTDcRQmobJ6oR2BqeD1BvM6sI4WCEG
	eQakYjeLb3W5Su9jTNdml87EnvKYF7oZqtX/VIOouixO1IpZ7Pm0dHTXvTEc58ZUjdJzdpUYQDq
	Jm8lzX0gF8RF/8HP1eKPOpxEvzx+JLCvpGng==
X-Google-Smtp-Source: AGHT+IGYyJxLMA8/8GOi2bmSkwfU/WISSYVhRusNzbVkFPw+Z4WEurkZHKkq6Z3/hyy3zkRDJ4/v8Z7Q+C1zdP3A248=
X-Received: by 2002:a05:6902:2190:b0:e7d:3b61:e24a with SMTP id
 3f1490d57ef6-e7d3b61e544mr19540272276.32.1747951784370; Thu, 22 May 2025
 15:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>
 <4o3wo76st7w6qwyye3rrayuo2qx773i6jfzcnbkhdj76ouh7ds@3e2mblehkgwf>
 <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
 <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev> <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
 <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
 <3b1963ba-f93f-48f2-8fb0-a485dd80ffcb@tuxon.dev> <CAPDyKFqrAS4iV59S-zJ9H7_3VuGr9JdZABhfUGBwTzQNDCasaw@mail.gmail.com>
 <482b55c9-a210-4b2d-8405-e9f30d48a8fd@tuxon.dev> <CAPDyKFpLF2P438GGWSgbXzpT7JNdUjtZ2ZxYf1_4=fNUX3s-KQ@mail.gmail.com>
 <4fzotopz57igmiyssgkogfbup6uu7qgza3t53t5qsouegmj7ii@wfiz4g3eiffs>
In-Reply-To: <4fzotopz57igmiyssgkogfbup6uu7qgza3t53t5qsouegmj7ii@wfiz4g3eiffs>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 May 2025 00:09:08 +0200
X-Gm-Features: AX0GCFugZ72jR4N4Zhb7o7hjSV-HtwPLk02fPFYwEJ3WEVVCfay8AKrTsrcY3DI
Message-ID: <CAPDyKFoxs6wDCLp5EGHVqkqSstBLNmngps2KfanRezV_EN8tuA@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jonathan Cameron <jic23@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 May 2025 at 20:47, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> On Thu, May 22, 2025 at 06:28:44PM +0200, Ulf Hansson wrote:
> > On Thu, 22 May 2025 at 16:08, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> > >
> > > Hi, Ulf,
> > >
> > > On 22.05.2025 14:53, Ulf Hansson wrote:
> > > >
> > > > That said, I think adding a devm_pm_domain_attach() interface would
> > > > make perfect sense. Then we can try to replace
> > > > dev_pm_domain_attach|detach() in bus level code, with just a call to
> > > > devm_pm_domain_attach(). In this way, we should preserve the
> > > > expectation for drivers around devres for PM domains. Even if it would
> > > > change the behaviour for some drivers, it still sounds like the
> > > > correct thing to do in my opinion.
> > >
> > > This looks good to me, as well. I did prototype it on my side and tested on
> > > all my failure cases and it works.
> >
> > That's great! I am happy to help review, if/when you decide to post it.
>
> So you are saying you'd be OK with essentially the following (with
> devm_pm_domain_attach() actually being elsewhere in a real patch and not
> necessarily mimicked by devm_add_action_or_reset()):

Correct!

>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index cfccf3ff36e7..1e017bfa5caf 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1376,6 +1376,27 @@ static int platform_uevent(const struct device *dev, struct kobj_uevent_env *env
>         return 0;
>  }
>
> +
> +static void platform_pm_domain_detach(void *d)
> +{
> +       dev_pm_domain_detach(d, true);
> +}

Well, I would not limit this to the platform bus, even if that is the
most widely used.

Let's add the new generic interface along with
dev_pm_domain_attach|detach* and friends instead.

Then we can convert bus level code (and others), such as the platform
bus to use it, in a step-by-step approach.

> +
> +static int devm_pm_domain_attach(struct device *dev)
> +{
> +       int error;
> +
> +       error = dev_pm_domain_attach(dev, true);
> +       if (error)
> +               return error;
> +
> +       error = devm_add_action_or_reset(dev, platform_pm_domain_detach, dev);
> +       if (error)
> +               return error;
> +
> +       return 0;
> +}
> +
>  static int platform_probe(struct device *_dev)
>  {
>         struct platform_driver *drv = to_platform_driver(_dev->driver);
> @@ -1396,15 +1417,12 @@ static int platform_probe(struct device *_dev)
>         if (ret < 0)
>                 return ret;
>
> -       ret = dev_pm_domain_attach(_dev, true);
> +       ret = devm_pm_domain_attach(_dev);
>         if (ret)
>                 goto out;
>
> -       if (drv->probe) {
> +       if (drv->probe)
>                 ret = drv->probe(dev);
> -               if (ret)
> -                       dev_pm_domain_detach(_dev, true);
> -       }
>
>  out:
>         if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
> @@ -1422,7 +1440,6 @@ static void platform_remove(struct device *_dev)
>
>         if (drv->remove)
>                 drv->remove(dev);
> -       dev_pm_domain_detach(_dev, true);
>  }
>
>  static void platform_shutdown(struct device *_dev)
>
>
> If so, then OK, it will work for me as well. This achieves the
> same behavior as with using devres group. The only difference is that if
> we ever need to extend the platform bus to acquire/release more
> resources they will also have to use devm API and not the regular one.

Sounds reasonable to me! Thanks for a nice discussion!

When it comes to the devm_pm_runtime_enable() API, I think we
seriously should consider removing it. Let me have a closer look at
that.

Kind regards
Uffe

