Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E65778901
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjHKIeJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 04:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHKIeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 04:34:09 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A912D61
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 01:34:08 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d299ed34bacso4109712276.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691742847; x=1692347647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlPks5RfZ7ZuuF4veH6UFGF96UAsIgYOKlSgCtodLJ8=;
        b=uct1KpyVVXAN1XY/QM50eCIH9llQ2dG/FTAEmVzYrRGOS6H5Xet+i6ZZv7G7Wdooef
         UxBG8GGT7obJCC/td0sZ7jfEbdcpjbm1QdOIWRJ0eaBiRfFGm+t/+4qAVd8l9zlns2nn
         HpjR33YcAZi8qjj0+AMTpkDxo/7wvl3lskPw55smF1bmBkrPfs7GKQ+DUfS7phlAdaGm
         aOkLOKq+lew8vyJ0O/FYydRn7WRCIOUvkLQMEmc4BvwGyi2q75fGUeptQ9Dyzoi5EMBK
         fT+v/tfPX/SOYVqI7LE4qgEo/Kyw0QZDWRbPTyduKhuy3TzBfDR8S5vycC5Ab70Bj6RR
         cOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691742847; x=1692347647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlPks5RfZ7ZuuF4veH6UFGF96UAsIgYOKlSgCtodLJ8=;
        b=eax8ysKstCNRknzekB6qEHFAhOdfBXx7Ah34anFir9YNZlUfttss9PoATtbT/WJ7vD
         8u681b2vIWbe89P2f6S1+HqsgKySNoB1nU6rqdQyPqYse5yT9kme2njS4sKTIVV1VBag
         G8HYKYui68CS4aQQG+Nq45VsNMkfns24pjYrV/jaggIIwsWU8odlAEx6yfTzqkSgMODN
         ZzqqYzxSYTGdMsGNiWfeeqI3hAgCeoWqyu+dKf2VXAfuobLM1bR5CORP7EyV9qHdJ4w8
         SdOmq3Hi2dgc1fCAnPPA1WEykr9tPjFZHXYiOmUL18ptHnqKcq3OYv3xoXzlqWjhxJLl
         3EfA==
X-Gm-Message-State: AOJu0Yyn1Z1gnu/2rkGx1f/Bla7NyBYmVnd59cTpAlL7xF3X+vkrTLMI
        wTghO6C0v6vVSz4E/DImg3mcaQ290d5dEo0dG/R4kg==
X-Google-Smtp-Source: AGHT+IGDKmFIPcNpzctVVpJv8zj95k7QI/TYLHHP0dQqn0CWQG6HUYL2v9QpYmdkli1taZvhRyNJv1GEEbOkYT1WE98=
X-Received: by 2002:a0d:db06:0:b0:583:7545:2f2e with SMTP id
 d6-20020a0ddb06000000b0058375452f2emr5171460ywe.7.1691742847345; Fri, 11 Aug
 2023 01:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <ZKYvpgs6p3S7nglh@google.com> <CAPDyKFpWybtCWt9pVcFMKcV0zBrjCzhhmAzYN-JPw2ZS6mUpwQ@mail.gmail.com>
 <20230707164149.GP6001@thinkpad> <ZKxHHvBKvJeWiioc@google.com>
 <CAPDyKFq6R8ar9nj+3OUX4HDNs0q+a+XcLdvNCX5GG_n0pW7cng@mail.gmail.com>
 <CAKHBV254i3fdQ7UX0Pc+CDaKO_OROA276vmgDPx4aPtZTiS2Bw@mail.gmail.com>
 <CAPDyKFq6gVbQ7cGggmqgPGwNd9=5jdm=zN6zfT5VPeSrqkYR4w@mail.gmail.com> <CAKHBV24Exdi38rLH3_LQcFOV1kR39gw3X7DwKOC3tdtp2EzXtA@mail.gmail.com>
In-Reply-To: <CAKHBV24Exdi38rLH3_LQcFOV1kR39gw3X7DwKOC3tdtp2EzXtA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Aug 2023 10:33:30 +0200
Message-ID: <CAPDyKFoTraq93VdUwfxSKWUEYd+Z3xkWtHiEotM+F2fAF8GvfQ@mail.gmail.com>
Subject: Re: Prevent PM suspend from powering off the domain for non-wakeup
 in-use devices
To:     Michael Shavit <mshavit@google.com>
Cc:     Ajay Agarwal <ajayagarwal@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        manugautam@google.com, quangh@google.com,
        Koudai Iwahori <koudai@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Aug 2023 at 20:00, Michael Shavit <mshavit@google.com> wrote:
>
> On Thu, Aug 10, 2023 at 11:57=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> > I think you kind of already answered this by yourself. We can't rely
> > on all drivers to update the runtime PM status of their devices during
> > system wide suspend - simply because there are no requirements (legacy
> > wise) that they need to.
> [...]
> > Moreover, as runtime PM gets disabled/enabled for all devices by the
> > PM core in the suspend_late/resume_early phase (for good reasons) - we
> > have a window when runtime PM can't be used to power-on/off devices.
> > In other words, if a driver needs to power on its device (and the
> > corresponding PM domain) during this window, how will that be done?
>
> Ok makes sense. If we're to rename dev->power.wakeup_path, could we
> then think of it as a way for device drivers to declare that their RPM
> state is in fact managed during system suspend/resume?

I just posted a patch and decided to start simple, just by adding a
couple of new helper functions that act as wrappers of the existing
ones.

What you are proposing seems to be something entirely new. We can't
reuse the existing flag for this kind of thing, I think.

>
> Another question that I haven't been able to figure out by tracing
> through the code history, is why the genpd domain *also* needs to
> declare the GENPD_FLAG_ACTIVE_WAKEUP flag. Shouldn't device drivers
> setting device_set_wakeup_path() be sufficient for the core to decide
> not to force power it off during suspend? In what scenarios would a
> genpd provider want to leave that flag unset?

That's a good question. In principle we decided to keep
GENPD_FLAG_ACTIVE_WAKEUP a while ago [1], as a way to let the genpd
provider opt-in to support so called in-band wakeup irqs.

For out-band wakeup irqs there may be some additional pieces missing,
to allow the driver/subsystem to inform the PM domain that it has
configured a system wakeup, that doesn't require the in-band wakeup to
be armed.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/1510588003-16650-3-git-send-email-ulf.hansson@l=
inaro.org/
