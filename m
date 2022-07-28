Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39C583B1A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiG1JU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 05:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbiG1JU1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 05:20:27 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268911168
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 02:20:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c3so1043911qko.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hu67rO0amNyo4xJGexiCiUUvUEtMbOIXHax2RkMiT3E=;
        b=lb2CJHC46Wr5Ifu/1CaQCCxgOJcORTVQE+F/tTCoAYYzp1Jefl87tg7S8ffboyDFz1
         iA+HE9g5ELioBL1JqRe5CZfZO0uC4oepSfsG1PkU/dLTpPuMcfvP3HxOZDpgAD6F6JN2
         vwGA3qKvF0yPiu3ZZExSXm20IMnYFzaqfoHgmHXjy6F3xIhhnrSG8qcpT5mKEO477nu7
         e04hSWirZb86AU4nqKEzDafJEbyqEDZPjCoSo8aw6mAt3rKSv8ZVm7Mc+Ddq0Ygsz9h0
         P1FA2ExDn4FJ3fJ9tW7fRofC+iYBTq0qHdA+te/pnOvXQnNz3klzMTyce6DRUORANqDD
         9HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hu67rO0amNyo4xJGexiCiUUvUEtMbOIXHax2RkMiT3E=;
        b=d3BoeJSx135E8Be1b7olgqmJyVu5rNQrv9yf7bvCN/oqJkot/Iysjg0z2T2iqcry2h
         7HM884jjfyRIt3pk+po02e3wtxNxu0EyRae7gDTCMlRRP1pA3a//dt/7Q64Y7mt+vFIJ
         MEC/R8RsqxW/OzCspyrAmfgfhlgX2vFm8HahXUNFY9XQg272tGoa6SgUYHrTYaLqgI+M
         ke/7cpo5EwmTOlNFaUfTps9BV2F77LYIZlJb5O8AzX2Nj6KdHJw6IgTVSEl7N71uVoXm
         11zQOYN/aF9V0oFHkm7zFb5nBQaXwLOTLzWe4et6aTNhrv+Zo03qpIhIhSCzuzLz9J5R
         PDlA==
X-Gm-Message-State: AJIora8IpYuRnz9O/4BTlYSJtYUtwpOtKJ8CfJeDwJ/83I8rS85y9/vJ
        HoDVFhuNVGas31K5l2QCW1xakQRJKkjjJcOg43mHzQ==
X-Google-Smtp-Source: AGRyM1tmNKjdA1E4Lc3OT5NPu4+Pg4LIfBktyNUYU4dkcm0BCvnxsLe0R797+GT5VMDDAuxsyHaIR1G0hEkNmDR8ss4=
X-Received: by 2002:a05:620a:2408:b0:6b6:2df3:d18b with SMTP id
 d8-20020a05620a240800b006b62df3d18bmr18695863qkn.203.1659000024621; Thu, 28
 Jul 2022 02:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org> <20220728090806.nnighsbx2lcgugon@bogus>
In-Reply-To: <20220728090806.nnighsbx2lcgugon@bogus>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Jul 2022 12:20:13 +0300
Message-ID: <CAA8EJpr2=y-wT_HV4H5BTm7RPsc=--6C054WHJDpQzehU=Z+VA@mail.gmail.com>
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 28 Jul 2022 at 12:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 27, 2022 at 11:09:01PM +0300, Dmitry Baryshkov wrote:
> > To ease debugging of PSCI supported features, add debugfs file called
> > 'psci' describing PSCI and SMC CC versions
>
> These 2 are for sure in the boot log. Having them is debugfs accessible
> via file system add not much value as we would hit issues quite early in
> the boot for most of the things related to PSCI.

Yes, it was just to have all the information in a single place.

> > enabled features and options.
> >
>
> We have psci_checker.c which does some minimal testing of PSCI. I prefer
> to add things to that rather than a debugfs as it is run during boot. IMO
> it is usual useful to debug things that cause boot issue most of the time.
> I am not against this so I will leave it to the maintainers.

In my case I was not debugging the boot issues (which of course would
have required a different approach), but I was trying to understand
runtime capabilities, thus debugfs fits pretty well.

Another point for the debugfs entry: most of the people run the kernel
with the psci_checker being turned off, but with debugfs being
enabled. If we are trying to narrow down firmware capabilities of the
random device, it is much easier to ask them to cat the dbeugfs file
rather than to rebuild the kernel.

-- 
With best wishes
Dmitry
