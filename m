Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCA29C44
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 18:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbfEXQ36 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 May 2019 12:29:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37255 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390021AbfEXQ35 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 May 2019 12:29:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so5638308pff.4;
        Fri, 24 May 2019 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsSYQVXsBY1mlm2cIOkHAHijOgSPMJrx2a8OVNsTPRk=;
        b=gyMNUSgfpkJ9locCgYPUYUhmSYez9pzqDg0TulwtrT5Nfiez5O14X8vV4I5UpVHha4
         6aF+2uocz9uA/BYUdKwM77wJ+Jvam7gFkRA2vVy7Av0Gkudq7ES2aJjzEkfqAUPEUQpo
         8xc3N/nYSyAlJTTPVMEAl7gdTy+JxuOF54L3MtvdKlS4p9rHo4uxBkbhOpOjB9Zcy8vz
         ocQIyVzpvNBnTsbLsByPCZNR8rmYfDwbDZ6xkLaHEXMC2mT/nhGV8XQOH+DSnw0Ft6Rs
         Ju3ojKdCKOHXT3yuAM2J71p3yo1lTdR7EMYV0fsfKPTnS3Hm87nxVir+eDBEGQ7qRgZE
         cVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsSYQVXsBY1mlm2cIOkHAHijOgSPMJrx2a8OVNsTPRk=;
        b=qo/S0o1u5hGvnMc18bLGX/sVhHKv5IQ9DAJCVZxz4FnMAxF4fpceITZ5neKIhdHeQV
         xE/cbr64V2mURYcWaHN7sPak1GhyT17/n6uxDlg6wIJSp3z9/nQHFf0WEckMnfYf2e5b
         lZAHVWf0aaCK/QguEIhovmxGRse+v50pGRY1Z+3JpU66H2akrCIdecIx1Hb502Z6QHlH
         FrOO0I3bzb7G9LNY9QkJcS3fpJ8TfP2SgCdWKEmpBGTcPTYySh03BchyI9Hbt0dit/3n
         VXpzU6ReqCMhySOdD8vTLJRw6AjJR7dkksa57Ah+himHghC8xrSWy5mbcgtgp3UDSd0K
         Pi8Q==
X-Gm-Message-State: APjAAAWVzo/yYZq5yCLL8KMQnd9IBIYXw1RiFKLahl9WY+lXLRQZtXaK
        cJc0NuRIGaT+cSDKTqiTxnCtdtuhF3Mf+MKcnYs=
X-Google-Smtp-Source: APXvYqxdYwqrHJQ39GJGnL5rgpjr2N4T4KrOxqPjif5uTV9eXkvwz3vvNAczrCsGtdQmjlgRVKlnMU+HGaEq9dNUTig=
X-Received: by 2002:aa7:9159:: with SMTP id 25mr83129430pfi.64.1558715397273;
 Fri, 24 May 2019 09:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190513075641.1277716-1-lkundrak@v3.sk> <20190513075641.1277716-2-lkundrak@v3.sk>
 <20190513090743.GA19319@amd> <5e814f2a3b1282da53d0f828dd9276ca91952f75.camel@v3.sk>
In-Reply-To: <5e814f2a3b1282da53d0f828dd9276ca91952f75.camel@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 May 2019 19:29:45 +0300
Message-ID: <CAHp75VdB_hwxoqN1FmOFeWahtYY18sdtB58+foGLo1+o0=kXWw@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Pavel Machek <pavel@ucw.cz>, Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 13, 2019 at 4:18 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> On Mon, 2019-05-13 at 11:07 +0200, Pavel Machek wrote:
> > On Mon 2019-05-13 09:56:32, Lubomir Rintel wrote:
> > > The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> > > signals for handshaking. It needs to know when is the slave (Linux)
> > > side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> > > controller node) and when does it wish to respond with a command (the
> > > cmd-gpio property).
> > >
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Who is expected to apply this? I don't think more iterations will make
> > it better... it seems pretty good already :-).
>
> The whole set is meant to go in through platform/x86; it just missed
> 5.2 due to some issues discovered by the kbuild bot when it entered
> Andy's review queue.

It will be promoted in a few days to our for-next.

-- 
With Best Regards,
Andy Shevchenko
