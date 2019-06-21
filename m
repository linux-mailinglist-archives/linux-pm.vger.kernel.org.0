Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF154EB7F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfFUPEk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jun 2019 11:04:40 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33749 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfFUPEk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2019 11:04:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id m8so4037654vsj.0;
        Fri, 21 Jun 2019 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z7+8itbNjVbWEFVe7Q1gJ/IkKA5Mvml8D7msm2siMus=;
        b=k21ZM2uDf46eU5l4FsI4bUX5Fz3bLPpM7Y17vqd+3+fdIeMyYxeaM3nak9TyHc6IIQ
         JhXpvZAe55+ABxcBUIuJFP2KUAjIXPrZq4eIChJlsOqRVHC9jLLT8N3lq0/YtiNymP25
         DE4TBZwMQX2zcZR33spJ/eNJRBA91MIi8wBhFJaONCraODhYxVxgpnWWiusKeIVo7C7U
         2hFeH6EfajspdHsQ9As2jMSgmISE/0wyMHr4Ti7vuuj/vk9MbvLJ7LyRB/2fdlG3fx1m
         Ji3CiUE/uFZTrhasxlddJSMjRCxg3Nsf/iwIAaXBt9S6e3R6N1yrJQCIz8P1Neiki3/o
         P7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z7+8itbNjVbWEFVe7Q1gJ/IkKA5Mvml8D7msm2siMus=;
        b=Mwbk+E4P7l3H5MTXKJuDWcF1ntaTR2L5oJYtMRMyBBvrGxExjWpSlU/52IJcIP79Z/
         XmB33geeV0ZyrD4higiBwv2gH4biHFj3Q0GVHnBoazM5EHu5P2N06RwysQED3YaIcEPz
         4yX6alHv6ReWKfQMWtiEJ8Jh90P9/3HbAWAAXtt0xG8rvGfci/vSwJ2pvViKGYgbmebf
         Fk7yjC52NgS99Hbh8h5IBNdPsE3WcCBqjT8YBe5gkziXGkQ7/l3vQfckQhHmxmOxrlye
         h+hpP+ROkWz0W6a6pZnxrq+PXbkaK67+h9l+XyOMYL+5Upzyd/q1ku5z9NDHEDsOGvOJ
         Si7w==
X-Gm-Message-State: APjAAAWv5UAsI/9A2d++04x7gK5JYUKXCbhN8KbHZUV1Jq99AooaUd4/
        BnNr3WtqWrubURGjQs+G8CaJx4RQh4Fns1phJPU=
X-Google-Smtp-Source: APXvYqxECcqND+//GgSQB85ap31qfmlFHuFLGwtL3cSpYFZCGpYTkiWbdu3HJZp78o4a27K8jrdR1u3H5B9LypVNee4=
X-Received: by 2002:a67:320c:: with SMTP id y12mr8546999vsy.30.1561129479136;
 Fri, 21 Jun 2019 08:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLiBA9VjEoG_D2y2O5mKiqsDNW1VZXOk1eWXpGY+h86acg@mail.gmail.com>
 <CAOMZO5BcLaS0gXUPi6oN6vjqagS5yf+rHh+EUjmi-Wi1OX7vqQ@mail.gmail.com>
 <CAOuPNLgEEfDca4aeT1+q8GfUfGzbJ4x6JwGf-ROB1pgpXUBHSw@mail.gmail.com>
 <CAOMZO5BY8JcLNMCRCC_d=emy8HR6kE=dB9f5qfZ=ci_c+Jak0w@mail.gmail.com>
 <CAOuPNLjYhkP_kL+q-ZpiDZMMpOHrU88BFBc2agtnCzXt8dihOg@mail.gmail.com>
 <20190619150406.GB19346@kroah.com> <CAOuPNLgYN3FDvNsaWqom45h7aFz=HczDdL-QoHOc_Sreqf8T2g@mail.gmail.com>
 <22247.1560961607@turing-police>
In-Reply-To: <22247.1560961607@turing-police>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 21 Jun 2019 20:34:27 +0530
Message-ID: <CAOuPNLigooUw7RUj-tYX7isZg2FYRiq=15jduKJy-z6JgPLVVg@mail.gmail.com>
Subject: Re: [IMX] [DRM]: suspend/resume support
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Greg KH <greg@kroah.com>, Fabio Estevam <festevam@gmail.com>,
        linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 9:56 PM Valdis Kl=C4=93tnieks
<valdis.kletnieks@vt.edu> wrote:
>
> On Wed, 19 Jun 2019 20:47:34 +0530, Pintu Agarwal said:
>
> > No I mean to say, there are lots of features and customization already
> > done on this version and stabilized.
> > Upgrading again may require months of effort.
>
> This is what happens when you don't upstream your local changes.
>
> And no, saying "But we're a small company and nobody cares" isn't an
> excuse - Linux carried the entire Voyager architecture around for several=
 years
> for 2 machines. Not two models, 2 physical machines, the last 2 operation=
al
> systems of the product line.
>
> (Not the Xubuntu-based Voyage distribution either - the Voyager was a mid=
-80s
> SMP fault-tolerant system from NCR with up to 32 486/586 cores and 4G of
> memory, which was a honking big system for the day...)
>
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rzhang/linux/+/v=
2.6.20-rc1/Documentation/voyager.txt
>
> The architecture was finally dropped in 2009 when enough hardware failure=
s
> had happened that James Bottomley was unable to create a bootable
> system from the parts from both...
>
> So if your production run is several thousand systems, that's *plenty* bi=
g
> enough for patches and drivers (especially since drivers for hardware you
> included in your several-thousand system run are also likely applicable t=
o
> a half dozen other vendors who made several thousand systems using the
> same chipset....

Yes, I agree, but unfortunately I don't have any control.
I normally keep finding things, which seems interesting for me and
propose for upstream (even if it is very small).
And, I completely agree that system should be designed such a way that
it can be easily up-gradable.
But, as I said, its not fully in our hand :(

Also, I think this case is slightly different.
Here, even if I try with latest kernel, there is no use, since
hibernation feature is not fully support for IMX.
And I think that is already known.
I came here looking for some pointers and help and get some clue to
proceed further.
If I succeed in making it I will definitely like to contribute upstream :)

Thank You!

Regards,
Pintu
