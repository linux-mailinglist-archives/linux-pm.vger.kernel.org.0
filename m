Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3669042CAA
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 18:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408921AbfFLQuD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 12:50:03 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54819 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408886AbfFLQuC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 12:50:02 -0400
Received: by mail-it1-f195.google.com with SMTP id m138so11919478ita.4;
        Wed, 12 Jun 2019 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JO7k/ClhjVdqToWeoJoYGo3bEt8L7eZPdlH/fBFJuKE=;
        b=TAKqqn0G/vV3fPY4tZ83gwm2Hw9HhcFNuTbZWx8ZEVBV+cWYI7notKlmymqifBVg2K
         UxJ+8RwVo6Rfh1vtL1PeTyo1G2+CGMZtjWqMD3+uc4ptB6DaLirqv4mHTZ4+lTG8ZTJR
         I5kiYgNFvY/BM5i0ScMOqJZcTYeHW0V8yED/t+ZjGMSx9UNTZv6ctv7hNJYwUQg3bNQk
         xFy57BhPJk5djKA90xszJx6puysAkve14K0hmshn6HRpzXFiqydO4+tAAY8l3haT0TDc
         +xNDCUiviVVzv02/Pry2QOdhYSk7jzMs/+76pAzdzeK7Lj8k47qc9C7EYRdlVPRjmzOx
         jK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JO7k/ClhjVdqToWeoJoYGo3bEt8L7eZPdlH/fBFJuKE=;
        b=lhw3LogyZsZXSxwR4/amiRwSNSoW1/TMCapsF9Sgu5SuliIhGMLaTQiQleI63+77m3
         tKo5Qlho4iuwvObeCQwhmk2jr8JPRVpFKB/9TR7CMocL8RtB9IsxLC3km3mZBS9eW7C/
         bY3GnpMsVPuYY1WmimTQmWTv9jN/zfxlw6fa25mce8ZZUwun4oYCk1B6AdbaBHNiGH67
         yrSGWY6xRdFU/d75cXtbyIX2lM4MdX65kl7xQkzERU0WbcVykauwtL/hXbM/tM8nCrrn
         yTmjNSsWJA+G/3wD74UpHE4m+xpZfvITxP0jPtE6CYDyXZ3d8BoAT4nX8VAzTdY8Ekq1
         7ZpA==
X-Gm-Message-State: APjAAAW7PGv+6PcA/n/0G1ago6Ny1OiWF/7oorwBgGi4lolxthCCelki
        rPSGnK3Ao2W6lDYPo8Qc0bB94VFzdXrjhX2t14ulnq5DfeA=
X-Google-Smtp-Source: APXvYqzmcfhx2XovBMaT4tzSeJzeAp9gWzVe5Ka/LFGHFQ3luDfFcddrL85N1pCbOWHmvK/gBAL8MuEcLAeoFSfQ9EQ=
X-Received: by 2002:a05:660c:8c5:: with SMTP id g5mr64709itl.40.1560358202002;
 Wed, 12 Jun 2019 09:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181329.18657-1-tiny.windzz@gmail.com> <20190525181329.18657-2-tiny.windzz@gmail.com>
 <CA+E=qVdh1E8Y7dZO0JSS4DJE2bo=98MuSKRt7nmeFg-td7Ua9Q@mail.gmail.com>
 <CAEExFWtjNridLsMXOnBe2mJOPhUOYJ6G3wGF3gx=0oQoQROOGg@mail.gmail.com> <CA+E=qVeOSw=_z4OiQ4++z8g-KN29UYVXGicNd3PtHobg4xaG+w@mail.gmail.com>
In-Reply-To: <CA+E=qVeOSw=_z4OiQ4++z8g-KN29UYVXGicNd3PtHobg4xaG+w@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 13 Jun 2019 00:49:50 +0800
Message-ID: <CAEExFWs58UNcVcQNnwK3dk5cpmfQRnjdRWAmYs5M1t_ONr1Bpw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> If you have a git tree I'll be happy to contribute A64 support. IIRC
> it was quite similar to H3.

I built a ths branch and I will do some work later.

https://github.com/TinyWindzz/linux/tree/ths
