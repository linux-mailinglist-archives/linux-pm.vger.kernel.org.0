Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6D468E56
	for <lists+linux-pm@lfdr.de>; Mon,  6 Dec 2021 01:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbhLFAlD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Dec 2021 19:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbhLFAlD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Dec 2021 19:41:03 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A245C0613F8
        for <linux-pm@vger.kernel.org>; Sun,  5 Dec 2021 16:37:35 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so11504098oto.13
        for <linux-pm@vger.kernel.org>; Sun, 05 Dec 2021 16:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=np4s1nuaKyUdMl2ToIjJIup0qete1o/mPorocqdoQT4=;
        b=jwpLMf1cJoIr3h7a89wTxen9q945XDMCaI0Tsieb//TNvNAzFKNlg5LY82Ss+05Ugh
         EY1ha+XXvglTAyoHnCLCnLo48kUI388MNPGFL2OJlVrn9kYg/qkd1NH2bKRJAH8OtRzy
         aG4roM2YoEnCoinvJ1oD06kclhC78AUxxkCPxtQYv7bKUL8KTYoK7wP2TJmPNMVWIhM/
         AbLZ/Z7whK3lMTbU8UrQQrzd7qww58RNGlM63hg7DZ1qamU9Qr8L9iohIKsIrcXwQMF5
         6BxpjjpnqlQNtf+7u4T/0/weuBOoq5HJlMQYM58v6Nkm/UUm/gFnStFezQ5l3rXAehw8
         FDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=np4s1nuaKyUdMl2ToIjJIup0qete1o/mPorocqdoQT4=;
        b=wN9A2GwFqAMRrPNkSPnyf7GQhokOmRtaetZC9oWJ0pyqcMTCNgcBSFgRBLHtMCkQXi
         jFqOVFbZYmHZgyKdFfWOs3OXQbU4F43/XxKg+kv8N7Kck3bInoJ/t2bH5neig+O/UWOE
         Y6x69Y/8Qyz9rCNILrNtkHwmCshyrwOMhIYx0NRKRR68EqfcYNWipGz3xlh9fJjzx0jw
         bQ1iE3F7QGDEOH68iAOHStlhcOqvWfNKw/hQ5n5BZrPMVQ8NKf41rqC8yJGQ1HI9UBA5
         9opAARJ2P3nSjJJvI9rSvlArwP4C+FozJA4JDvLXOBRayV0V3BdFjkP2yx2LleC94x/F
         n9iw==
X-Gm-Message-State: AOAM533G/0zOuerzUm/AJrO6Txj2H9G4EHvPJTV3Cww2dwYsSfQHvntd
        Gdvx5Ab5Auwe+3H3vTQgBc0vtN3HsebVAWskdohFhg==
X-Google-Smtp-Source: ABdhPJx0bSOeeWhesBs4XfhMT0LHYZ7nSO1feORKIU9x6ejSMPCX1HcTnhB6EhOYLdvowIFCs+Z9j3kCa8RsCx66LO0=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr25852146otl.237.1638751054757;
 Sun, 05 Dec 2021 16:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20211122234141.3356340-1-linus.walleij@linaro.org>
 <20211122234141.3356340-3-linus.walleij@linaro.org> <20211203210206.6b5cxb4i63j5jpv7@earth.universe>
In-Reply-To: <20211203210206.6b5cxb4i63j5jpv7@earth.universe>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Dec 2021 01:37:23 +0100
Message-ID: <CACRpkdZVK+Vsd8e-gFmiSapuxGKxOPkX+1yVj9VrU5ah5ARH2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] power: supply: ab8500: Standardize maintenance charging
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Marcus Cooper <codekipper@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 3, 2021 at 10:02 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> I wonder if this will ever be used by any other driver. Having
> multiple maintanence states seems to be very specific to the
> ab8500 driver stack.

It's actually coming from Samsung and their way of dealing
with their Li-Ion batteries. They even have further charging
states... Like starting the charge with slightly higher current
etc.

> But the code itself looks ok and considering
> this does not expose any (potentially unfixable) userspace ABI
> and improves the AB8500 mess I'm fine with it.

I will rebase this patch before the NTC things and send
it separately so it can be applied. It will better to first merge
the pointer passing change I iterated though, so I'll wait a
bit so we can agree to merge that.
https://lore.kernel.org/linux-pm/20211206000651.4168035-1-linus.walleij@linaro.org/

Yours,
Linus Walleij
