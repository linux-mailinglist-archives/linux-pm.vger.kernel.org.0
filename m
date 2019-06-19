Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E284BCD1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfFSP3z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 11:29:55 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:45039 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfFSP3z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 11:29:55 -0400
Received: by mail-ua1-f43.google.com with SMTP id 8so10232237uaz.11;
        Wed, 19 Jun 2019 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/M/MdVKSBbEyQpOuBlGD0n0hZOgEXMkP9werjym1kU=;
        b=Y7rttnEu4X/xs5P8VoqirKxMc8abp/Ffn2cY4SPGAuTXmywUiodyBNOeT11/Unyb+W
         Nss+BVncGMwlKKiHB+DF5/tepokgRwowzfcj4oYOizwEBahCd/L6WMod8RIDu3vk8IPr
         xBBoYVdNn9wg9Pzh/jw8qdmvZKeTYyI2Q601x56gWhYOiS5GF7eZIj2PpLg13jQsG+iS
         eFOLiEygOCCcTYacS+nukDOXVNntyuKXC16Xt/16YKYSJ5eJio/aDMZNdrMV29ZqJdIy
         viKKAXW7m9MIQu8c0shcS2koFV5+1FOn3RCtImQ9Z3XPpoEYZDzjhJ34D/OLkBaLz4o8
         Qgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/M/MdVKSBbEyQpOuBlGD0n0hZOgEXMkP9werjym1kU=;
        b=UfF0u7yhkahooBrCLpVDlh4XKGgkmEZyyXw8IBvbOY5ycfu2xk1PDQRfL9JP9ByJXv
         5vs2okZ+8mrAcrh0tZ5iStHCLf29z3eajYsFAc8c12TTITHnpR9DheVD62vXdOPNVcBD
         If4g1D8QvigmGRycYPKXANXDyg2c6J5orfHIA7LFfrG1TPz7d8MhEX6vawJj//4fd6AM
         4ow9d0Rrn3iEA3AF8u4B8tEnyqu5ci72TN/bls0C4NPm3cTzC8HmygpPxBTzlWtYWIO5
         iZ3JHYesMl5JhV2b8NLXptidn+rVK4KPfCaC68/L43mVljYB1+xksN4mwjGg4jm4lvBu
         sMcg==
X-Gm-Message-State: APjAAAX6tdEbJ+55sg+BVUWVw8ijQwHLaLPFhrdvqLxpA0uV/rENIcEM
        /qHw2QOc/SleXDt/lDPKFRMUJln46HSX9wBueGY=
X-Google-Smtp-Source: APXvYqwdunp3E1MkOo+Jv92LDWCZ38UHwuQbzZQi//6yPp05VefWYpDLQVZFpk91w7iw0sBRrf6kaNyb/5fbo3aSgS8=
X-Received: by 2002:a67:320c:: with SMTP id y12mr870390vsy.30.1560958194322;
 Wed, 19 Jun 2019 08:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
 <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
 <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
 <CAOMZO5ADK1L5UMM9XZetHvmjTvmvUg99G7VPdeXitgpctGLCkw@mail.gmail.com>
 <CAOuPNLhZhgN26rquLQq9zHBct1QxK-7hXAza0xk-0QooPGYLNw@mail.gmail.com> <CAOMZO5BsJWTw0nCeUboam4kuKyCO3N_Ch5ZW8k5Y9KFtQBanhQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BsJWTw0nCeUboam4kuKyCO3N_Ch5ZW8k5Y9KFtQBanhQ@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 19 Jun 2019 20:59:43 +0530
Message-ID: <CAOuPNLjrAU_C_TUKFMs1d0eGsw=AxuG6d6FhNHtHFwVhfYZGgA@mail.gmail.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 8:41 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> > > Then you can test suspend/resume and see if HDMI hangs or not.
> > >
> > By this suspend/resume, you mean "suspend-to-ram" or "suspend-to-disk" ?
>
> I tested with "echo mem > /sys/power/state"
>
hmm. That's what I said. This is runtime suspend, and it works for me also.
I am talking about hibernation:
# echo disk > /sys/power/state  (with some customization)

> > This scenario is not with suspend/resume.
> > This hang is, when we make hdmi as a loadable module (.ko) and trying
> > to install it after resume.
> > In this case, suspend/resume will not come into picture. Not sure why
> > it still hangs.
> > Do you have any clue for this scenario?
>
> I haven't tried this one.
>
> Please test it with 5.1.11 and if it fails, please report.

Okay will check this on latest kernel. Thanks.
