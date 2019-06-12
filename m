Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3142C66
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440320AbfFLQeL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 12:34:11 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:36706 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437983AbfFLQeL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2019 12:34:11 -0400
Received: by mail-it1-f176.google.com with SMTP id r135so11619389ith.1;
        Wed, 12 Jun 2019 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZCvV7cQZNCXBtTHIkCdgNG0kspEVIGlXIe1tEdoftI=;
        b=K4PtkffJIk+TE/PjxWZEP5nN8FkQHPgXAGeT3uxWRKzGQ4EbBsFVAZo//Ps8v9/9lR
         01Me35dSGJijOLOkBOdFkRMMHCXY3Jb8EbVhHYzUhpwigqZHHUlqkuKqozzOeAPg59sv
         uhI2ma5g7nmvdqsM90Vz+irqdn9EeA6mjdCrgt3Av9D+ohHT9bgsdLviUupvenzKsXLO
         K58G87lqMGxakjom677RMKy2RnOcEUVyx4l+v+0XcplTBFvpe9a0iwxrz72BoM86e3ph
         NUX6wMsWVYgn/9Cv6txMGYIxMiOTT1dyMA9VtKyvCMIRRoaLTcZ1ClztUkmodfWdu+wH
         xeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZCvV7cQZNCXBtTHIkCdgNG0kspEVIGlXIe1tEdoftI=;
        b=WmSmI9qnLbyFkGbwEN7fWrSZaMV17DlBysqr3qv0/hL5VEhsW5h1xJquKIIgfH1Wt7
         WTX92mzoS1LkkL58j36DsyoNR4vpIEFdREFbu2SF+V9MfpTKRlHmDgl1u5BoS8NvABUi
         ckns9Eop8yiaMRQw/CptPFiqWzg9g4AMxGfGbGHeyzfRRGw0qv2ckN+a3q51YGmySbXJ
         AWIIJZ1tlnVwEi0kqp8VJHeGBTtvwrr6k/Yxng1yDDgFsteEBCmsg9JH/xGjrjGnpKFM
         BtUkQlDD9pQP5eeqSzYT0yfxmoSG8WU/dmcoP1FcWEXHWiugNIVJlCNGYNrIjZtQuIkg
         bYpQ==
X-Gm-Message-State: APjAAAUvUhGZLSr0+hyJaxa1W0/TOHw3Wvl5K4byMjXtxYFhOB4aXgUn
        VAgrwtX5Wm8CNrKj3y5NduA0FNPw8DUFLuz3+dM=
X-Google-Smtp-Source: APXvYqxZh+o05jcOyHqNSKk8Ivk+tjl4Knc4o8YOtYWoSJKwFDgIF7OFeSVxDyD/mGUxk6569iAyD5s0t7IzvUZzteM=
X-Received: by 2002:a24:cf46:: with SMTP id y67mr19345396itf.105.1560357250240;
 Wed, 12 Jun 2019 09:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190612162816.31713-1-tiny.windzz@gmail.com>
In-Reply-To: <20190612162816.31713-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 13 Jun 2019 00:33:58 +0800
Message-ID: <CAEExFWt+8NKj4EYvQ10KoeUX8ej6Pm1gLgyVtozwMRSYC-p-Sg@mail.gmail.com>
Subject: Re: [RESEND, PATCH v4 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

@Rob: Could you please review it?
