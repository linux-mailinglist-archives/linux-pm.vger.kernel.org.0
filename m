Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9313781C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 21:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgAJUw7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 15:52:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33417 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgAJUw6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 15:52:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id z16so1701868pfk.0;
        Fri, 10 Jan 2020 12:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvcCFZkysQidKiJvm9PwvRevHJn0ApmIpMkmiKizlUY=;
        b=Mtrq2OkCsKTaspK+alSIkuQfbXjNcMm1TZ2Qr7u1s/AjyHWAer1J81ZquiA6lgk7tD
         KCBXVwetULrQwOCqNpmQ+XEjh9OqLZqGWD+vSgobDcwvJWPNjbTf1J0ZkWpRrh45ViSA
         1Gjadie9ofniPiqhApHw9HIETBCbgPkJ50+m8PGaMdx26HraErOu4LHYhTyiGLd/pj2D
         rUTJUOYvUCOt1s6xTgYHQhSI00FSoXKAjkIbRPErukdzedqCngJCJC0hnHImCDWF1ftq
         caL6DG6jL4MQysw78Id20Pv7DmmqknEroPEJ1EkJRaEE0XlcD7UB2FccAa1fkCrMfAXw
         Disw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvcCFZkysQidKiJvm9PwvRevHJn0ApmIpMkmiKizlUY=;
        b=UNOsSlvjx+TSzVd980o6ZEe+NBQUTIcoFYS7gt4RWRifaG7SakTcLDU9BDNxfJP1wN
         YgycRdXtBrlTTBQmMxwCOEoSreDMFYZMZm6AYvoObyrrSknLkOGHlw8zCeaiV6CmMa43
         XIDzYopAyG6MYPade384JnRBRfZVqq0BeoZDvwaQQHk3LT9wffLofOg51MLk8qHIZQAG
         XAOnNosbdeiZNUXIjhJV758CLoaRkhZGAe1rcI9XuInv6jYVkKRdq9xv8jwNtHujei48
         5X7muwmSWR3l2q2+1YEQHp0KaSNQ+Sv/ThcPyf0G8AxN1Ey5oLtFrTdJoet8b9/jCpR+
         QjiA==
X-Gm-Message-State: APjAAAVdcYqAWXxGvjOrg0J52pQSEjqyAUnd/dpWC8f0nIh+kk8ZKLfB
        h23Q+yqiCJ1buxJqC40GN1WFBY7a1rRBnB3UyZY=
X-Google-Smtp-Source: APXvYqw6Xu9loDn0pgNinRErW4FVDRVgmk/roF5+2Q6H9QnhbbczXJh7CQxD0aoDSiws8vGwt/HxpcK2qu+sZSc/O8o=
X-Received: by 2002:aa7:9474:: with SMTP id t20mr6083380pfq.241.1578689577857;
 Fri, 10 Jan 2020 12:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20191221071751.269025-1-lkundrak@v3.sk> <CAHp75VcYoWqvgLv-PmgxqhrHmYOH5=Nru6Msj3rryT=jL+y9xw@mail.gmail.com>
 <1bbf1ea76949f6ef4e856ed799f75d03bf20f293.camel@v3.sk>
In-Reply-To: <1bbf1ea76949f6ef4e856ed799f75d03bf20f293.camel@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jan 2020 22:52:49 +0200
Message-ID: <CAHp75VezK9xc4ZC3j_Ayaeyi16kntC_CE3K0-Qx-nAVbdY=dKg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: olpc_battery: fix the power supply name
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 10, 2020 at 10:00 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> On Thu, 2020-01-09 at 17:09 +0200, Andy Shevchenko wrote:
> > On Sat, Dec 21, 2019 at 9:18 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > The framework is unhappy about them, because it uses the names in sysfs
> > > attributes:
> > >
> > >   power_supply olpc-ac: hwmon: 'olpc-ac' is not a valid name attribute, please fix
> > >   power_supply olpc-battery: hwmon: 'olpc-battery' is not a valid name attribute, please fix
> >
> > I'm wondering if it's an ABI change and how user space is supposed to
> > cope with it.
>
> It changes the sysfs path. It is rather unlikely that udisks or
> anything else userspace cares.
>
> If it does, then I guess the warning that suggests that it's a bug that
> should be fixed should be removed instead.

That said, I'm fine with this as long as power_supply subsystem maintainer does.

-- 
With Best Regards,
Andy Shevchenko
