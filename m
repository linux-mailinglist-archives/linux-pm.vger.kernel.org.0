Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2E7D19E
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 00:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfGaW7F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 18:59:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44825 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfGaW7F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 18:59:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id e189so51946414oib.11
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvayO7XeLTy4X/5U3hiq/uu/ecirEncxcxFHnyvxXOY=;
        b=MZwcDUi4tR1G4oOJB4TqUTN5aSX1GloRDcsyDdkg9pgM6Y4OOeIdzBZz+5e9apI2TF
         SfqkvWNFv8Hp7X83FA7vjkoOPtJiWY9tLmmHUvhcyo+lyjS1ZCHoS2x74bE1dX8YEFPl
         WAHZ8LyXqJ63ftyyerKaspMAHnrCjY6J5lgp3VSKoHklPJwMsP6DlW2EKdgqv2gg1OmK
         bdapoa0TuPAT5F5ZICJwjifRuzY7TWULCwViKgLADIwKMa1pOo9W5Mm2T4Tg4ZebCfDH
         RGeJxb2rwYX219Fyq3lT1DzNEDCkEitB6etiQCdh5Pm2hZyIEE7513zhXdcjE/fH7lGD
         wnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvayO7XeLTy4X/5U3hiq/uu/ecirEncxcxFHnyvxXOY=;
        b=LrIgb+pEgl0m/PFrPeTkiD/Fo0R54XAUO8GiIQlmzI94SPcNYGQE5RZWi/3TkBTIi8
         m982Fyj7EgKQZeIa/QBHAimIlw291zTiO2T4GWz23JAescz1R/YgEnLMTS3QrVxoSWF+
         VNENiW1Oei0EUCaBo6wwdND50Q3JFZlRrUj7LrBntoZ5Ss5601mU+brC4WbXEZsTiHqm
         UulGSql3QdBasJos2Rypy4XcY7GjP4J39Zpbgqj9kRq4e8huZQh5Bj5aNBcAOz/eA5KR
         9eNmFIp3PQ9QzPD9XJdjw+QUKUKtVy8lSs6UUqoX/BqhznubrAAafVlxYqixiJwqg0V1
         EyDg==
X-Gm-Message-State: APjAAAVpKu2LW6gESwkGbkArXuorDzv90TJwYZomRsJDg0eDOnN4nqbq
        ETv8dV670zalN870F20i55TXjLzvecCwS/FDOYs=
X-Google-Smtp-Source: APXvYqyUMhMQGrPCnz4Km3SI1BL8a++DrhrK10Cd3/evsUszLBjGzYJ96bkzEQgPGssDRVfcF2DZTFh6Eh/vfDu63eU=
X-Received: by 2002:aca:af55:: with SMTP id y82mr59277816oie.172.1564613944162;
 Wed, 31 Jul 2019 15:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com> <6987393.M0uybTKmdI@kreacher>
In-Reply-To: <6987393.M0uybTKmdI@kreacher>
From:   Tri Vo <trong@android.com>
Date:   Wed, 31 Jul 2019 15:58:53 -0700
Message-ID: <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 31, 2019 at 3:42 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, August 1, 2019 12:31:16 AM CEST Tri Vo wrote:
> > On Wed, Jul 31, 2019 at 3:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Wednesday, July 31, 2019 11:59:32 PM CEST Stephen Boyd wrote:
> > > > Quoting Tri Vo (2019-07-31 14:55:14)
> > > > > +/**
> > > > > + * wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs.
> > > > > + * @parent: Device given wakeup source is associated with (or NULL if virtual).
> > > > > + * @ws: Wakeup source to be added in sysfs.
> > > > > + */
> > > > > +int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
> > > > > +{
> > > > > +       struct device *dev;
> > > > > +       int id;
> > > > > +
> > > > > +       id = ida_alloc(&wakeup_ida, GFP_KERNEL);
> > >
> > > So can anyone remind me why the IDA thing is needed here at all?
> >
> > IDA is used to generate the directory name ("ws%d", ID) that is unique
> > among wakeup_sources. That is what ends up in
> > /sys/class/wakeup/ws<ID>/* path.
>
> That's not my point (see below).
>
> > > > > +       if (id < 0)
> > > > > +               return id;
> > > > > +       ws->id = id;
> > > > > +
> > > > > +       dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > > +                                       wakeup_source_groups, "ws%d",
> > > >
> > > > I thought the name was going to still be 'wakeupN'?
> > >
> > > So can't we prefix the wakeup source name with something like "wakeup:" or similar here?
> >
> > "ws%d" here is the name in the sysfs path rather than the name of the
> > wakeup source. Wakeup source name is not altered in this patch.
> >
>
> So why wouldn't something like this suffice:
>
> dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
>                                 wakeup_source_groups, "wakeup:%s", ws->name);
>
> ?

ws->name is inherited from the device name. IIUC device names are not
guaranteed to be unique. So if different devices with the same name
register wakeup sources, there is an error.
