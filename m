Return-Path: <linux-pm+bounces-39278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2305DCAB9B3
	for <lists+linux-pm@lfdr.de>; Sun, 07 Dec 2025 21:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D184F300DCB6
	for <lists+linux-pm@lfdr.de>; Sun,  7 Dec 2025 20:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4118D2D7DDF;
	Sun,  7 Dec 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ky4v70h4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A21D6187
	for <linux-pm@vger.kernel.org>; Sun,  7 Dec 2025 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765139351; cv=none; b=Zd0XhP+JH96p/2lcyOoZVbclQVihZpN2uPfjtAYqI27L1uA9ZyS5EYZcQoK3Y7/Xs9QKUrXsrXuZ7+IgRU3oLu4bXqezlfqgPgy2G9lTlUavb7YluTdDuyN+dc7IzeLCX+s6PeC0xoT4bmJzKQC/k/fCRVXJETm+kxWl0CE4GvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765139351; c=relaxed/simple;
	bh=cZYSC9+98Y9i7XpOTcAIYlA2d9TBR3AIkxTvZgmr90U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mwguw+W7bpPug3+ZDwfdo1+A30Qkrvkzulz9H3jfEEBTUtLaIku7O8MBkq0QMpGxv35+cAAgPtnQYmvYplWa7+4bJDHaBJfhBcebmqASxM+NeLxOBH5oDSiViiK5OzBubcpOgTAuW4mqeomtH7THFG/W4o6vKFXcLHMSVqoJjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ky4v70h4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC276C19421
	for <linux-pm@vger.kernel.org>; Sun,  7 Dec 2025 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765139350;
	bh=cZYSC9+98Y9i7XpOTcAIYlA2d9TBR3AIkxTvZgmr90U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ky4v70h4b7Kh0fugjCuzvdHDPcpA0ZRUZaJHzO4mzcXmL/QV1YhjjYDlMsDWfvl5n
	 diYIFBoEjmCN26BmOng4ckDFwGOSEyQyXtPQRt1Y+bYtkfn3OVxR7JdpmEMXP/k/AE
	 uuW3+1J/TO/yrF5t+ge7rUjGY9EuqzP78AIIAmzIGBRXBNu5v0VV2tMTDjDTRSyoqa
	 sWFB9Stjjl4A/cC7T4Ve2Nifw3MBIBQmcOQSt4Rzo4eH6u1NVNuQ8xBB3h+DEHxKqT
	 efOLN1qGcOKfapIgqJOYJ1baSin3fpBLIL9MT2kjK6Z/xAXAG+XqRtzQs2txFvjG7g
	 MYgIuidztXXpQ==
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640daf41b19so5061129d50.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Dec 2025 12:29:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSPvzjTR1PFkByJ4Lj4IYOQvwp3EDdhGsSzWr8Ig+Q/oLPaThmGdb6u8+A+hrghB3yC2QqGym10g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8fOrhiVYSR46oBkR/vygcjaLJgW8YyTT0086SxJfCqdn5er8
	a9SM+7bWa0T5u8vYAhfnxSRgKbAfgIih9uB+iUTJkkUBrvlk338KgUo4gjXYhBnxlW4BeLYSVis
	MN/K2Igrueu+o/vAL7v2+G/YvOS1Bg9o=
X-Google-Smtp-Source: AGHT+IE9fPPUIEs19yrPnHebGqeO8ivf7ywBFjbjnY2Je2ILqKppxCQki7j0QSwUY6+l8CGm6SeXU6IVKpVTVjhCRfA=
X-Received: by 2002:a05:690e:b87:b0:63c:f5a6:f308 with SMTP id
 956f58d0204a3-6443d748cf9mr10909802d50.31.1765139350062; Sun, 07 Dec 2025
 12:29:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251206163101.828-1-mintupatel89@gmail.com>
In-Reply-To: <20251206163101.828-1-mintupatel89@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 7 Dec 2025 21:28:59 +0100
X-Gmail-Original-Message-ID: <CAD++jLkMxzbAVgDb86zWdfAuTNZ+e83t2RA--zpsGGzV6m7=WQ@mail.gmail.com>
X-Gm-Features: AQt7F2q5ge7dhzy4AbxlAS2M5T2m0XXXZsr_UDl8KSL7BVJdRX8_OfePa57UR9s
Message-ID: <CAD++jLkMxzbAVgDb86zWdfAuTNZ+e83t2RA--zpsGGzV6m7=WQ@mail.gmail.com>
Subject: Re: [PATCH] Dumping GPIOs state during suspend state
To: Mintu Patel <mintupatel89@gmail.com>
Cc: Saurabh Kumar <saurabhsingh14june@gmail.com>, 
	Shahid Kagadgar <shahidkagadgar3821@gmail.com>, Dilshad Alam <Dil.alam@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mintu,

thanks for your patch!

Mainly I am awaiting the power state maintainers comment on this.

On Sat, Dec 6, 2025 at 5:30=E2=80=AFPM Mintu Patel <mintupatel89@gmail.com>=
 wrote:

> It is difficult to find out which GPIOs are going high during suspend

Why is it not hard to find out which GPIOs are going low during suspend?
I don't quite get this initial sentence, why does polarity even matter
in this scenario?

> without manual probing with multimeters or oscilloscopes.

I understand this part, the system is suspended so it can't be inspected.

> In order to save the power especifically for battery operated devices,
> It becomes must to pull GPIOs low during suspend.

This assumes a certain type of silicon architecture does it not.

IIUC it is important to pull GPIOs low *or* high in some cases,
and what really needs to be avoided is pins being in tristate
(high impedance, high-Z) becaus this can really cause leak
current. Is this correct?

GPIO does have a notion about high
impedance state, because it has .set_config() that can actually
put a pin into this state, while it is mostly handled by a back-end
in pin control when available, so it is not something all GPIO
drivers are semantically aware of.

Consider if you might want hooks like this in pin control
rather than in GPIO, but maybe you want both.

> As of now there is no way to trace which GPIOs are high during suspend
> without manual probing with multimeters or oscilloscopes.

This is already mentioned above.

> This patch would help the developer to find the GPIOs are high during
> suspend state without struggling with hardware devices.

Fair enough, that is a reasonable usecase.

> The patch would print the below logs:
>
> [  244.029392] GPIO Chip : 3000000.pinctrl
> [  244.029394] GPIO   Suspend state
> [  244.029404] 3      1
> [  244.029418] 17      1
> [  244.029424] 21      1
> [  244.029431] 30      1
> [  244.029436] 32      1
> [  244.029440] 33      1
> [  244.029444] 34      1
> [  244.029447] 35      1
> [  244.029453] 41      1
> [  244.029462] 51      1
> [  244.029470] 57      1
> [  244.029492] 90      1
> [  244.029496] 91      1
> [  244.029515] 114      1
> [  244.029519] 115      1
> [  244.029523] 117      1
>
> Based on the above logs, GPIOs 3, 17, etc are high during suspend state.
> Thus particular driver/submodule can be modified for configuring
> the GPIOs accordingly for suspend and resume states.

I think I understand what you are trying to solve: you want to inspect
what state the pins are not "during" suspend, but *at the moment
suspend happens*, there is a difference there, and this is why
some of the text is confusing me.

I would do this differently.

What I would do it:

- Go over all pins both when going into suspend *and* when going
  out of suspend. This creates a snapshot of the GPIO lines
  before and after suspend.

- Store not just pins that are high, because that is a pecularity of
  the system you are trying to debug here, store the state of
  *all* pins, because other users of this facility may very well
  want to know which pins are *low* at suspend and resume.

> +#ifdef CONFIG_DEBUG_FS

Why debug_fs? All this does is pr_info(), it doesn't need
debugfs at all.

It could perhaps depend on CONFIG_DEBUG but I would
suggest that you create a new Kconfig especially for this,
like CONFIG_DEBUG_GPIO_STATES_AT_SUSPEND_RESUME
OK maybe a bit long but you get my idea.

> +static void fetching_gpios_state_suspend(struct gpio_chip *chip) {

Use "fetch" (passive form) not "fetching" (active form).

But no, rename the function:
print_gpio_chip_states() because that is what it does.

> +
> +       int gpio_num, value =3D 0;
> +
> +       pr_info("GPIO Chip : %s\n",chip->label);
> +       pr_info("GPIO   Suspend state\n");
> +       for (gpio_num =3D 0; gpio_num <chip->ngpio; gpio_num++ ) {
> +               value =3D chip->get(chip, gpio_num);
> +                       if(value !=3D 0) {

As mentioned I would do this for all states not just high
pins.

> +                       pr_info("%d      %d\n",gpio_num, value);
> +                       }
> +       }
> +       }

This is just printing the state if rg

> +void gpio_state_fetch_at_suspend() {

I would call this
gpio_print_state_at_suspend()
because that is what it does.

> +#ifdef CONFIG_DEBUG_FS
> +extern void gpio_state_fetch_at_suspend(void);
> +#endif

What about putting it in a new include
include/linux/gpio/system.h and include that?

>  const char * const pm_labels[] =3D {
>         [PM_SUSPEND_TO_IDLE] =3D "freeze",
>         [PM_SUSPEND_STANDBY] =3D "standby",
> @@ -429,6 +433,10 @@ static int suspend_enter(suspend_state_t state, bool=
 *wakeup)
>         if (suspend_test(TEST_PLATFORM))
>                 goto Platform_wake;
>
> +#ifdef CONFIG_DEBUG_FS

This Kconfig needs to be changed as mentioned.

> +       gpio_state_fetch_at_suspend();
> +#endif

As mentioned I would like this to be printed also on resume.

Yours,
Linus Walleij

