Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB607714903
	for <lists+linux-pm@lfdr.de>; Mon, 29 May 2023 14:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjE2MEL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 May 2023 08:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2MEL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2023 08:04:11 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285AD9
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2023 05:04:09 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565cdb77b01so26427167b3.0
        for <linux-pm@vger.kernel.org>; Mon, 29 May 2023 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685361848; x=1687953848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2plw05Kj1GqS9DZ4v7YPnt5HZhf5Vi3QfmRalqD/9E=;
        b=Yb9AbhtkESyzW4UCaJL00nxKM2J8YN24gJ1OYukCu7dxIHr8/arT5qXLo1SnIVIYCv
         G3D6sBj+4lJJ3qVmautZe+oPkToSDcNvwEP8bY8Jblyhkd4MSfPe9eopzyewIRILxmT1
         L1KH1ksve+DaolrpWz43SCTvEN8bbOnFSPERgEvCrjZubO6gFFojpA4/1j6uD/dpPgwo
         qqbVz4r3pNV6P2K2b0pQxMrADwiXDvZTvJFxwm3b7uj/AvvFThI2Xl6GQjeztNNeMygq
         igEnx4MNOqQVuR2/4NzGCYLhZAV/6tGV/8CIQirShAfVlCS1bVpiUlyp0MqqxOZjIkjb
         ySyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685361848; x=1687953848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2plw05Kj1GqS9DZ4v7YPnt5HZhf5Vi3QfmRalqD/9E=;
        b=b/vVDK2HR/1pgowwiZLCjeR3Fwx8LbCiqSTK7NE84SOMS6FsXbT5+GOCSI5Ftl0tWQ
         fq1saFwXNmqJ39FpN1qt7D3RdbUAO8QVZXyIZxzeOTXw/YKxz2IoGrGuLw/dr+QailN2
         kL49Od2T1TR1388Xsy9nfXX7WztfoIE9s0S8TIQgTkBNYpQJwMuUFhPdwbNFuREV1wxB
         kFPWjaGLOYWXHA1LZk5nxQyuihSaTYnlOkFrn3XB+zR3s2g8wuZELellCnjaHhH5q0XH
         lfppuk5aNHTSacQqnkCganfLZL+cHMLM1E+mhw6NwMYYs7YNgtcdT7IUIzgie2zN9E9X
         EvoA==
X-Gm-Message-State: AC+VfDyexxLBYGr4Sk2E3XYQuOXkDowMp6/OEIqNVk8uImLjO13bGDlY
        6vEEonN3mnc0WW1R1KNvPMLP7/G2NSwurHSJ7VJ7720ZYo23+aVTPY4=
X-Google-Smtp-Source: ACHHUZ5r0/R3DR5PN7uN55XUQan64ulWn0CJxl4jFW9DYYqJ2+zCHrHX44nufDLoUvl5YRa1tJn/hpXRlFm8KHpIzGE=
X-Received: by 2002:a0d:cb11:0:b0:565:de69:2ac9 with SMTP id
 n17-20020a0dcb11000000b00565de692ac9mr6574038ywd.29.1685361848544; Mon, 29
 May 2023 05:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFiuC=8bwgac2kafh6om3jHw6QtcDqtomA-Fpt+uekcqMv63aA@mail.gmail.com>
In-Reply-To: <CAFiuC=8bwgac2kafh6om3jHw6QtcDqtomA-Fpt+uekcqMv63aA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 May 2023 14:03:32 +0200
Message-ID: <CAPDyKFqdSFhHobJD-22MsE1jTpaLzKDBWw-vH1NGza=27soBHg@mail.gmail.com>
Subject: Re: On dev_pm_domain_attach function behavior
To:     Quang Hoang <quangh@google.com>
Cc:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 22 May 2023 at 06:08, Quang Hoang <quangh@google.com> wrote:
>
> Hi Ulf Hansson,
>
> Hope you are doing well!
>
> I am Quang from Google Silicon team. I am working on drivers that use gen=
eric power domains.
> I have a few questions related to the behavior of dev_pm_domain_attach fu=
nction and genpd:
>
> 1. in dev_pm_domain_attach function, why don't we pass power_on variable =
to genpd_dev_pm_attach function?

At the introduction of the dev_pm_domain_attach() function, the
power_on variable was only relevant for the ACPI PM domain. For genpd,
we needed to always power on, as that was the assumption that was used
by the consumer drivers to allow them to probe their devices.

> 2. Currently, if a device has only one power domain, its power domain is =
automatically attached and powered on probe. What is the reason behind this=
 behavior? Why don't we let the driver decide when to power on its power do=
main via calling pm_runtime_get_sync() for example (as in cases where a dev=
ice has multiple power domains, see this patch).

The behaviour comes from legacy. It's not a trivial task to change the
behaviour in genpd around this, as a lot of consumer drivers rely on
it. Especially those that use pm_runtime_set_active() in ->probe().

In the case of multiple PM domains per device, we did not have legacy
behaviour from consumer drivers to consider - thus leaving the PM
domain powered off while attaching is perfectly fine.

>
> Looking forward to hearing from you,
> Regard,
> Quang.

Kind regards
Uffe
