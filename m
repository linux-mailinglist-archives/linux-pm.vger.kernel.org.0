Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD264BCA0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfFSPRq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 11:17:46 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37984 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFSPRq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 11:17:46 -0400
Received: by mail-ua1-f65.google.com with SMTP id j2so10230184uaq.5;
        Wed, 19 Jun 2019 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3W31eT4pjnEE9VumU700qhsrfgm3ej+hMlDN8GbJRU=;
        b=iyBAkwkWJj1+Aw13vY7fCF+blFJGykJyavfB2eMwITvxzAB144ff0wRE3tgEkNWEBF
         hxXtdJ1Qub7oJphAZ4nogBgMeM9uGHymppWIfKEbGHAYoVdouvQkgjOqfKDp6mj8iehQ
         OuywrdJFZlgN1p7KIULRqiw12TsvkbsUV3SA+EYRbng++P0/EoIB3b17k7O0lPdwwRc5
         KD2L4N1LAidT+01zEt0+/gs72VcZJlyG2r21IuJY7DnEEalr8NWoGlpml8EfRwTsKhqD
         L9n/REmLSyfE+BmiK4ex+kwTkqIMeH+Hosxo8zEeVJboON6PAMPS6w0rvrVJXoQbUp6K
         Ij6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3W31eT4pjnEE9VumU700qhsrfgm3ej+hMlDN8GbJRU=;
        b=JGyD+e9csilET5QfDjGU2pWHIIEHC/dLmhJ/LgmvdVXZUQnN9zaLks3gFS8Rw51cz7
         8XdprsW0FPxa3aN/9+nCXBu/RXITGursDKONAtwCs4x819cY89tR1Oy/ajJcNdXMa2IT
         RM0wBB2E8GBiCxrsRcAMgw4oVRZTDvEviaUuP5UGzWEdoH88FMsuS1GZYYV74ruEMziv
         k45XJ7q3p6VTPv0jdcSNM/k9UjgSSQOqnO60+uR/0u5G+BvlNDonGkr0suVI4w05ul5G
         mFWyZ77YQS62VFlJCDR18luOdRZ/UhIwsHrD8f6xdNpuVbpKt84ORaic1Qm4fHF5kVg4
         duxw==
X-Gm-Message-State: APjAAAUXpbjmLChUGPQFOc6dD0T9jhGJr9Cgu79Plor/s/WNhzjuOeY8
        jAkBejpW8EDF9wN+jIcCQKeMn02DzrGha34fn7s=
X-Google-Smtp-Source: APXvYqwQFXiKBQhKIgxQWpWN0iV3lA9cGQ+Hkpj2dsp1L/4TSPbcNmuVqNJnISoxxObtW2bKXn3xtrfX6S2seJNuz2E=
X-Received: by 2002:a67:320c:: with SMTP id y12mr827714vsy.30.1560957465295;
 Wed, 19 Jun 2019 08:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
 <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
 <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com> <20190619150406.GB19346@kroah.com>
In-Reply-To: <20190619150406.GB19346@kroah.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 19 Jun 2019 20:47:34 +0530
Message-ID: <CAOuPNLgYN3FDvNsaWqom45h7aFz=HczDdL-QoHOc_Sreqf8T2g@mail.gmail.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
To:     Greg KH <greg@kroah.com>
Cc:     Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 8:34 PM Greg KH <greg@kroah.com> wrote:
>
> On Wed, Jun 19, 2019 at 07:03:39PM +0530, Pintu Agarwal wrote:
> > You can think that the version I am using right now is almost 4.9 itself.
> > Upgrading again to higher kernel version is again difficult, also
> > customer does not want it.
>
> They don't want a secure and supported kernel over the lifetime of their
> device?  That sounds really odd.
No I mean to say, there are lots of features and customization already
done on this version and stabilized.
Upgrading again may require months of effort.
Of course upgrading is planned for later products.

> Never create a new device using the 4.9.y kernel tree unless you have someone else doing the support for it
> (i.e. a SoC vendor that you are paying support from).
>
Actually, this is not a new device. Its an older device itself.
This is an experimental activity.
