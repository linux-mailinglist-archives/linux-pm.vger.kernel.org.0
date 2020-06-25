Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5847D20A8B7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406523AbgFYXS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 19:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407747AbgFYXSz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 19:18:55 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFA7C08C5DD
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 16:18:54 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id s18so4542826vsi.6
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZUejZ4FxIPzgalcSBOTl7RrSB8oG1JXXKFu2TzIVTY=;
        b=gEFD/h6/YccJ6NUPfYT/xgz0X+isX8Cd6CGn2UCUGx7jpM3t81GIEKLZxSIh9n3gSf
         LyFFAVqzLW2EOg2vox4IxQFv/KkghELE3h+1pMYcAk3L5vCjE1vuqYv6ModKBhiykPJm
         E+uZ3A7Yo3f2524NLn2qvAOct1Q0SfZjBL3KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZUejZ4FxIPzgalcSBOTl7RrSB8oG1JXXKFu2TzIVTY=;
        b=j9g2RyIBEasX1whbN1VtaNRuiizki7VYvrwCuWkcz9xs11CxieRRR7frIO47wB8kcd
         iTwIikLqDgP4IMKqLUaMKJNl6gYApHZrZZnLDxtV7EDyCZavN1TV4RWDFctpU52EGJqi
         pEW/b/wWvyDX2HjUXgDGXTBHDpsW4mYS3yoUrAGgdHK8MGwSfRifMT7s5eD3goxJDDuJ
         0oRCTMwnUpbEh+5wkeIGhoTr3R92h1A8rGKH1+C3nIdayNWnjj3jsljUEggFNSYGpvrG
         focrRv8hGIcSNjfPpjiYAGtilNVrJHTOAsnkwkpfY8EsGWcoy5o5KP0C0GQ+EPDgia7K
         amrQ==
X-Gm-Message-State: AOAM531BxJThsF+4bxluLFiDMgc2tfGuSa5flvo+s7ilJTmQI3iQ3/xC
        das3p/VeiDc6GgJgIL74NbsBpLq9KeRYBC0ytxrTag==
X-Google-Smtp-Source: ABdhPJzhi8dHdwc7k/3b1+iOeFD6RskzYY/+B8+g9RbXB08kX6vZ9AZiixX+D9Pnv0ODrkx1cdSZ8uCd7wY1U33lSFI=
X-Received: by 2002:a05:6102:1167:: with SMTP id k7mr517235vsg.71.1593127133874;
 Thu, 25 Jun 2020 16:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200624111128.v2.1.Ibae403db54245c458d14297f1892c77c5055da41@changeid>
 <1593080522.28236.17.camel@suse.com>
In-Reply-To: <1593080522.28236.17.camel@suse.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Thu, 25 Jun 2020 16:18:42 -0700
Message-ID: <CANFp7mUmk=HqPyJ5TS5uQPyaEtOWdz=D+7XBS8MyikuF9y9EJQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Reset port on cmd timeout
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-usb@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for the heads up Oliver -- I will send a patch with a comment on this.

On Thu, Jun 25, 2020 at 3:22 AM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Mittwoch, den 24.06.2020, 11:11 -0700 schrieb Abhishek Pandit-
> Subedi:
> > QCA_ROME sometimes gets into a state where it is unresponsive to
> > commands. Since it doesn't have support for a reset gpio, reset the usb
> > port when this occurs instead.
>
> Hi,
>
> on first glance this looks like an unbalanced PM reference. It is not
> because the operation is suicidal, but this deserves a comment, unless
> you want to get a note telling you that you caused an imbalance every
> few weeks.
>
>         Regards
>                 Oliver
>
