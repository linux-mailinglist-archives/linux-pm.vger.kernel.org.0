Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD0046CA1
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2019 01:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfFNXIC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 19:08:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46429 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfFNXIC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 19:08:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id 65so3096386oid.13;
        Fri, 14 Jun 2019 16:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jbs5gzhwgZIg1gF5LjyrTrjnsR6guamGnNknrQ4qVAk=;
        b=NWloPDLUh5GtKP0cuS/9WWyBMm8xtdPz+BFptPrE5sWLkV/PvP+EfVJG7YDdHXb3CK
         Ko4E41KT54QVFCnJmwAIBq5+lRAlfKo/2aLqHYK1SxQ7W3fZBmMBTvYOx/C4z3ZIc8b4
         v7CucK3frz1rTBiEUX65UtrBkarGsV66+Q6+lqvZF6qnciOYwQIV4XX+UbX++7CRZXVl
         gqXLsO/Txz+RofTh6dtzUyfWVe5vtiMpMRbT/Uq8/eKQ40vSMcWWspANqD01F5o1CEsN
         aTjgId6A6EtHivKIcbvYmvtz6pQM1IBhDPVZwQBOj4SY2xWcock67YW3esttnz/5BHOp
         Nhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jbs5gzhwgZIg1gF5LjyrTrjnsR6guamGnNknrQ4qVAk=;
        b=kfAfRNh52JsTZUJOczGK41hmLhEd+FCfrwO55QABEYms/t8+BrAeIf3RAlZo1ymGJH
         xtP9HoZZ/qDrUkzo1QMgVTMa3eoqTkvxKEzAmQ/MreP8IL+brhWcFSu87v6qD6Qrbl42
         8guvqxXptjVtxHVrY0+fNhn41Dh2umh+ASmNVzJ/kHr75EvVOR5gKjXjmrbWB3uAfHvq
         UQDwqaI1wh5FNwHgo/908LbuZW+o8hQhb8y7ng94V8WyZ4LjLANvliYQvGTOeRtp5J1/
         fPNvf1sHTXIkgnlen0QNgdO4/eQSJWn+RoqZ7Ms5fP8XbPWk7+muvEGW5NKYMQRA0BuV
         DdYA==
X-Gm-Message-State: APjAAAUE3yUmOjYf6zIzhdPWuFoxvTPFThqN3S/4dnZObbvLY3byNsaW
        QlfkdxO+BPSC6mN9geGSXdaWE8/ikjv5OklW9D4=
X-Google-Smtp-Source: APXvYqyH9KgPHZJQaQQ2Ns83mm/RN5lHJA27CuwFAUocbtaCA5Vog7dH3CLQILg9/hDPeQHBcBx3UH3A9hbvupgCz7U=
X-Received: by 2002:aca:e185:: with SMTP id y127mr3447788oig.98.1560553681382;
 Fri, 14 Jun 2019 16:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181329.18657-1-tiny.windzz@gmail.com> <20190525181329.18657-2-tiny.windzz@gmail.com>
 <CA+E=qVdh1E8Y7dZO0JSS4DJE2bo=98MuSKRt7nmeFg-td7Ua9Q@mail.gmail.com>
 <CAEExFWtjNridLsMXOnBe2mJOPhUOYJ6G3wGF3gx=0oQoQROOGg@mail.gmail.com>
 <CA+E=qVeOSw=_z4OiQ4++z8g-KN29UYVXGicNd3PtHobg4xaG+w@mail.gmail.com> <CAEExFWs58UNcVcQNnwK3dk5cpmfQRnjdRWAmYs5M1t_ONr1Bpw@mail.gmail.com>
In-Reply-To: <CAEExFWs58UNcVcQNnwK3dk5cpmfQRnjdRWAmYs5M1t_ONr1Bpw@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 14 Jun 2019 16:07:36 -0700
Message-ID: <CA+E=qVf-_2DWbf55bCnjbkZH9N4a1_K16OxN9=o=NrZAV7GXPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
To:     Frank Lee <tiny.windzz@gmail.com>
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

On Wed, Jun 12, 2019 at 9:50 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> > If you have a git tree I'll be happy to contribute A64 support. IIRC
> > it was quite similar to H3.
>
> I built a ths branch and I will do some work later.
>
> https://github.com/TinyWindzz/linux/tree/ths

Looks like you forgot to add your patches to this branch.
