Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ACE742D4C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jun 2023 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjF2TQg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 29 Jun 2023 15:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjF2TQM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2023 15:16:12 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB57293CC
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 12:07:49 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-98502b12fd4so25983066b.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2023 12:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688065668; x=1690657668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZbDXG8/P8AC0d5PmWBfdocnKrP8P7g8d4t1BrxofpI=;
        b=Dji4p+hcpDq8qe4Z0lKmF1v9hWF2X3i0qp3nJjhr3vUwjydt/x39phxroGkWCpOd6L
         /nONNnJELrV1FUBadjuc1T/ivnwoRfV8uh4J5PD56Xwh+9x1tFzLh7g777a4PK8Ww/Hl
         ZnHWtpyJm5YaED2ZQ+1aZFJ0rj3SGgvMMI/+K4SHSRibnutqCma7anziFx9LS++mtzJ0
         TO8JPTlQWOCRoJ6eyH1ddVDFe8LkCCmD3DNxn4xnzyGtWSg++G4SHf9qFRjq/eRVhvrr
         Zd0op1mbHd7iwamMGkFWUwCL6lR2ffoiqR/sUwJikfC0o3p0DrqIKk0MPpi9qfH16Am0
         y8vQ==
X-Gm-Message-State: ABy/qLbtFXK15js8D9QYKwVS+mnkS4NlCOFwQuanM7bK+yh9j2FQCLY2
        SpflbaLaPnbRsQyaBlUp2KbTzI1VXxw2i+b6jlo=
X-Google-Smtp-Source: APBJJlG+4LY2Y6lO1eCOuN0mbtFNkr3YI68mXHb78e4rf4RROAQxAiPrsNNcXjYS0Mbf/FJKdxt2MwTdhx0WTk44+gs=
X-Received: by 2002:a17:906:148c:b0:987:6960:36c6 with SMTP id
 x12-20020a170906148c00b00987696036c6mr209859ejc.5.1688065667948; Thu, 29 Jun
 2023 12:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230525211655.627415-1-evalenti@kernel.org> <fb558491-9906-fb3a-60c5-349cb4210695@linaro.org>
 <ZH5ve2KX/Y0DXQnE@uf8f119305bce5e.ant.amazon.com> <ZH5whRBkGCun3Gq+@uf8f119305bce5e.ant.amazon.com>
In-Reply-To: <ZH5whRBkGCun3Gq+@uf8f119305bce5e.ant.amazon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 21:07:36 +0200
Message-ID: <CAJZ5v0gbwRNrjBOxGfFTNJ2meBU3fncBpeHZSCAjhFRYQ9VkaA@mail.gmail.com>
Subject: Re: [PATCH 0/3] thermal: hook in with reboot and crash
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org, Eduardo Valentin <eduval@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 6, 2023 at 1:32 AM Eduardo Valentin <evalenti@kernel.org> wrote:
>
> On Mon, Jun 05, 2023 at 04:27:55PM -0700, Eduardo Valentin wrote:
> >
> >
> >
> > On Fri, May 26, 2023 at 10:27:39AM +0200, Daniel Lezcano wrote:
> > >
> > >
> > >
> > > Hi,
> > >
> > > On 25/05/2023 23:16, Eduardo Valentin wrote:
> > > > From: Eduardo Valentin <eduval@amazon.com>
> > > >
> > > > Hello,
> > > >
> > > > This small series of changes teaches thermal core about
> > > > reboot and crash callbacks. The intention is to have the core
> > > > to get notified and the pass in the event to thermal governors
> > > > that are willing to perform actions during reboot or crash events.
> > > > The thermal workers will be teared down in the process too.
> > >
> > > What problem does it solve?
> >
> > This cover letter was not clear enough. In fact, the context for
> > all patches I am sending now and will be sending in near future
> > is when the thermal subsystem is configured to control temperature
> > of a target device. The thermal subsystem is configured to have
> > cooling devices that will act on the target system, and has
> > input, temperature sensors, to have visibility to the target system
> > temperature.  In this case, the problem is when the controlling system
> > becomes unresponsive upon reboot or crash, therefore losing
> > control of temperature of the target system. This series solves the
> > problem by giving knowledge to the governors of such events, allowing
> > the governors to have opportunity to act before the actual event happens.
>
>
> Again, this is a different situation than a emergence shutdown due to
> temperature/overheat on the typical application of the thermal subsystem.
> Where it runs in the same system it controls the temperature of.
>
> Here we want to reduce the likelihood of loosing control of temperature of a target systems
> upon events where the controlling system is unavailable.

So the use case for this seems to be a BMC running Linux that is
responsible for the thermal control of a host system.

It kind of escapes me why you want a thermal governor in the BMC's
kernel to be part of this.
