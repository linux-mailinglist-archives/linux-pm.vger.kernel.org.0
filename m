Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1179E15A413
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 09:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgBLI5o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 03:57:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43598 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgBLI5o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 03:57:44 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so1005450qtj.10
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2020 00:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ur3OMSSElNkgt+TEQoz3DfEtasxtebNZtxecAgjVKuM=;
        b=arBmSPB9ulCRr5nKRcy/iAlVZW/WzcptFmfTDvviOna9Y+2/oHBtpe68dTXgTyZZW/
         etzaNL4Lie//Orgzo7vVuX1aJkkUVn463rJ0dh5n+kks75+xBNAjMjhXCdk25BsvTZ/N
         TeNJcFWRDjK8PbSVwil692NHPZvsMw0K43sbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ur3OMSSElNkgt+TEQoz3DfEtasxtebNZtxecAgjVKuM=;
        b=NtB/rkc6DozLm7jfGlSGPjiCFl5bFqb57wKSx/yjwvIf0PHpyt6Tg9t16gZnFUu1xv
         +w+AkYYHSudi+yNznSc4UwsuzhKEoS0aSxCd2zGIxBErwR94/T7MS8n7mZ/TwFJCDmq8
         vX5h9K5/C8f4H7Y81laFOu5KT32YCahgCU8zLWP0VFDdpemnzxOMlYOCqE3kTdWkMShZ
         sz9G2YnFfG7cSEBf/914R+GeOIfyvewKkCT39spiEa9okHVC0lL0GHhMO6hqFjee1urn
         AstWZC3O6xLGaaMdcA0GxiLes08gBCtbL/hrsehU3sBktC/dvhdZfGq7hESxD0WjH1aU
         qAog==
X-Gm-Message-State: APjAAAVFamm860FiEIacNrxtiJJCrvws0cofzMBaCV17TESmEc08ClpH
        0B+zg4CNfGaZVwba6l29ufRPoYJ0+SDe65RmwL6YxA==
X-Google-Smtp-Source: APXvYqxorrffWfYqWThJdb2802Q9wpqx/0ArmTu95O0YEH6TV5vyJHl/3t9mJasI8JO2Tuj56xQaBvdWGN/uFJP9uGA=
X-Received: by 2002:ac8:2fbb:: with SMTP id l56mr6311584qta.346.1581497861704;
 Wed, 12 Feb 2020 00:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20200212075529.156756-1-drinkcat@chromium.org> <20200212081340.vcfd3t5w5pgxfuha@vireshk-i7>
In-Reply-To: <20200212081340.vcfd3t5w5pgxfuha@vireshk-i7>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 12 Feb 2020 16:57:30 +0800
Message-ID: <CANMq1KA1=LTtCD2ic7GcskX7izuEkAqUo1xxwwCXBeTLi0r5vg@mail.gmail.com>
Subject: Re: [PATCH] PM / OPP: Add support for multiple regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 4:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-02-20, 15:55, Nicolas Boichat wrote:
> > The OPP table can contain multiple voltages and regulators, and
> > implementing that logic does not add a lot of code or complexity,
> > so let's modify _generic_set_opp_regulator to support that use
> > case.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> This is already supported in a different way. See how following driver
> does this (hint dev_pm_opp_register_set_opp_helper()).
>
> drivers/opp/ti-opp-supply.c
>
> The problem with a generic solution is that we can't assume an order
> for programming of the regulators, as this can be complex on few
> platforms.

I see... And you're right that it's probably best to change the
voltages in a specific order (I just ignored that problem ,-P). I do
wonder if there's something we could do in the core/DT to specify that
order (if it's a simple order?), it's not really ideal to have to copy
paste code around...

> --
> viresh
