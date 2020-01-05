Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB713075C
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 11:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgAEKsD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 05:48:03 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44139 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgAEKsC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 05:48:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id bx28so45119522edb.11;
        Sun, 05 Jan 2020 02:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuyX84JqDmDM+0I6dBJwuvVn9myG7QWWOIsvvnZAafc=;
        b=jkz8yR+7gKud+bPKHnzAYNLSC/Q+bZfy7k/eOB4XIBURQQ3aPKjf/R0cRPxqgFZ5Up
         i5NFm96rARW4jJ5wTK2Icm4JyiTrqXRr8WpIxaMisUvNb/+pvrjU1M2IOatXWHY1LlS0
         c1Msfe3hd/G93L7B08WSilsdfPN4+4M2Y3aibRq70qjLC61f9khCYE/uJ4k3ZSyisCV5
         TLimMx8TruVdSW9gQMxipLQ8DOMyxn+dglMFeafOqpn70N6IGKJx1paoD0mBTEnSXEWO
         7uMybjLyOd8X8P+u+HwC9mpgkSYGSHjwL3bi6mebSSefYPUWsmxbz/KtKSodR4VdsN8N
         97DA==
X-Gm-Message-State: APjAAAUDaVeeXMPh6LD/CI0TYWdV9FZ+4CJ+00Gc8xmomwjX2BvT8VIA
        QdpBohdEAa4kcapEMjAQxw18pt+YwSw=
X-Google-Smtp-Source: APXvYqyPgQHyul2vpb2JJWM9wD17iqkjkB0Jxy8QHcuSyAEai2cnCP73JPPsrsB4gXAtyDp2iNBBSQ==
X-Received: by 2002:aa7:cfcb:: with SMTP id r11mr104889385edy.103.1578221280502;
        Sun, 05 Jan 2020 02:48:00 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id bs4sm7910044ejb.39.2020.01.05.02.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 02:48:00 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 20so12378506wmj.4;
        Sun, 05 Jan 2020 02:47:59 -0800 (PST)
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr29347016wmg.110.1578221279472;
 Sun, 05 Jan 2020 02:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20200105012416.23296-1-samuel@sholland.org> <20200105012416.23296-9-samuel@sholland.org>
In-Reply-To: <20200105012416.23296-9-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 5 Jan 2020 18:47:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v641_yfJ8nE2soPcUhcOGp5vDmcPUpmN=Vr1RrB5RNQkbw@mail.gmail.com>
Message-ID: <CAGb2v641_yfJ8nE2soPcUhcOGp5vDmcPUpmN=Vr1RrB5RNQkbw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 8/9] power: supply: axp20x_usb_power: Add
 wakeup control
To:     Samuel Holland <samuel@sholland.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 5, 2020 at 9:24 AM Samuel Holland <samuel@sholland.org> wrote:
>
> The USB power supply input can be used as a wakeup source. Hook up the
> VBUS_PLUGIN IRQ to trigger wakeup based on userspace configuration.
>
> To do this, we must remember the list of IRQs for the life of the
> device. To know how much space to allocate for the flexible array
> member, we switch from using a NULL sentinel to using an array length.
>
> Because we now depend on the specific order of the IRQs (we assume
> VBUS_PLUGIN is first and always present), failing to acquire an IRQ
> during probe must be a fatal error.
>
> To avoid spuriously waking up the system when the USB power supply is
> not configured as a wakeup source, we must explicitly disable all non-
> wake IRQs during system suspend. This is because the SoC's NMI input is
> shared among all IRQs on the AXP PMIC. Due to the use of regmap-irq, the
> individual IRQs within the PMIC are nested threaded interrupts, and are
> therefore not automatically disabled during system suspend.
>
> The upshot is that if any other device within the MFD (such as the power
> key) is an enabled wakeup source, all enabled IRQs within the PMIC will
> cause wakeup. We still need to call enable_irq_wake() when we *do* want
> wakeup, in case those other wakeup sources on the PMIC are all disabled.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
