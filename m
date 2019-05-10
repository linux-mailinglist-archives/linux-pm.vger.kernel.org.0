Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D728B19F26
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 16:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfEJO2v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 10:28:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45406 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfEJO2v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 10:28:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so3095890pgi.12;
        Fri, 10 May 2019 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5Oi8wgM3c7VZCjV18iRdw+7qn7zvts+cTHtCwBqjHM=;
        b=nq3zx1x5VL+cGbpWDRSOBluCOhRnpUh2MlzP+DhaJ2HjuHeVTR4uff37eduuHWuURQ
         r+sNKq5SvgIqqO26AodtDckICsfNXfHwSQYsf/1m0D36esR+yOYFfmEoaOijezohoeSF
         LIO3To0D7MXdxOVQCFfQ8hOhS01PM0imBtOggc14u4xAAgq8M4AJNWv7o3IcAf9wcN6P
         ADydeJy/MRZ3eSOKchBoFJH4Un4cKV5u/MeQxrMgkOyjT5s29wIWjVwRpZHK32NybgPU
         N/ewEm9xw1wxLKDpg6C0dRCyqKv2zllv216eyucXbnwdruPlqt45/loVoxMjMEKNYkw8
         19YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5Oi8wgM3c7VZCjV18iRdw+7qn7zvts+cTHtCwBqjHM=;
        b=ILydUaNrUv4RT07S4TwkNXRkzKu5XO45RouMV4FZcQa7C3kwVnMK33S+kLFeh/qmhr
         M+X4YRcOF2zuGCfccTK7WFJzj5d/s/tP69o1i+Jz9Q+2qOA9Jd9GnQOSSVrVtWdkXiAy
         iJn5wgGdWm27Ft/EVUBt2fYc6prd7Hd24ccFpO0KWFiE/eOBrzLF5VPdhghilZqj3pzA
         BdLK4urIagx8Zj99+wjlMHKaMSMENOF6Dao0VxznBfeo32kBn+uTSGxe4+44JgBsgXFw
         x+QPuPz6TMPOfdEyqy8foEc5yKgRc8fM+wDVy9V52OKLvl4LsSYQYJaHDQY9aQwOEV08
         vu6Q==
X-Gm-Message-State: APjAAAVbb74fiaCx3RreprgUJKJnU81WfMtcBP3E5eUlGJP6+S//Riie
        hVsFwxrEi40nDUFNWcifrAagczh2p0S2ZNKwNS0=
X-Google-Smtp-Source: APXvYqxZzlZClPGkEfF+Pas8jn9Dt4sc2KJPHGuWRJWOk8VXLZA3Czo529pD8zzxY1RG4lP1/Raiz3qUaBz1BvKEotM=
X-Received: by 2002:a62:56c8:: with SMTP id h69mr14529798pfj.49.1557498529791;
 Fri, 10 May 2019 07:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190424074353.458446-1-lkundrak@v3.sk> <CAHp75VcXteqg200aB6w_6ngR7=cj3S7HQOELOTV4rYUmCe+dLw@mail.gmail.com>
 <267d992479dcdf8c0425407e131f112ece53f5c6.camel@v3.sk>
In-Reply-To: <267d992479dcdf8c0425407e131f112ece53f5c6.camel@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 May 2019 17:28:39 +0300
Message-ID: <CAHp75VezL3EainU04E7t=Qo+_mUCNJ2yc=HbEHY0vW-8eHpySA@mail.gmail.com>
Subject: Re: [PATCH v6 0/10] Add support for OLPC XO 1.75 Embedded Controller
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 9, 2019 at 9:00 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> On Wed, 2019-05-08 at 18:07 +0300, Andy Shevchenko wrote:
> > Pushed first 8 to my review and testing queue, thanks!
>
> Thank you.
>
> Looking at kbuild bot errors, it seems I managed to somehow mess up
> again. It is not true that just the [08/10] patch relies on the
> psy-olpc-1.75-battery-signed branch of power-supply tree (see above);
> in fact [03/10] also does on x86.
>
> Would it be possible to include that branch in your testing as well? It
> is going to be included in the power-supply pull for 5.2.

Still some warnings.
Unfortunately there is no time to push to this cycle and test, so,
I'll withdraw them from my queue.

> Also, it seems patches [09/10] and [10/10] landed in your queue; they
> are not ready.

I didn't pull them in the last attempt.

--
With Best Regards,
Andy Shevchenko
