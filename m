Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F361301056
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 23:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbhAVWyD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 17:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbhAVWx1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 17:53:27 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7ECC0613D6
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 14:52:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q131so4773992pfq.10
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 14:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJKac0a7OSKp1f0kvUdgdMfcoqobY0w2Qi4X2IElxuc=;
        b=AnFnMxm7WfC1rua1IAn/BS6BSjggXvQNEVtQhO35dCfNT1aEkmSRuUWxnRufpUz/Ob
         ceKZJdL20R0z6pVacalU66DpQmGxYUqfmTfdUH7WgYKoXccDChPAt9AdVvWrn77Y9uft
         3Mn5lWJ4Ql3DMS65MwjK0+bqUMxoc7aEiGo7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJKac0a7OSKp1f0kvUdgdMfcoqobY0w2Qi4X2IElxuc=;
        b=q1wSljwLYzNGpeAr2+chJboejYabi/RRRUUXJX4XOB5aGChPZDXupREAOfMdvly4r+
         /KMbpEV9IhRcHDk/7mQhvuAXEEoYBIY6y+0fierUyNrhV8F1JOirGhyua5L29bO4Tykx
         tIDXuMmIf15uNZgG1gTAc7jWizIjELTFA671NEnzGDY4ut8gL0a+yPZK+WiaeTfbidCN
         PbZ44I31XbYviaGQFnV0U7v6PoT0vkgXoYGqLMqmSF8y3J1U2ic7EyN+4vx/yf1WCok8
         VMa/MzsKYMnHBKEkZaXWDUPriBhFePHQsZZjEyGDMhEwJqMQaqnFmWc1EN8FBtFGZ7z8
         wTrg==
X-Gm-Message-State: AOAM5335tNctAofxikPPiNbSitKH6oat/wzALn9AxIAm74rt+jvarPQ5
        zOt0HtfryzoG3tTA7G5Z/UTpTLMJpSP29Q==
X-Google-Smtp-Source: ABdhPJzp8LHwexv71sLxZHS49wC3I1PVH82OCL8Tj5sxjcCCZgjzjMMzjq5XpCQh3zwKj3aJAov01Q==
X-Received: by 2002:aa7:9192:0:b029:1bb:f763:3cac with SMTP id x18-20020aa791920000b02901bbf7633cacmr7223411pfa.72.1611355966312;
        Fri, 22 Jan 2021 14:52:46 -0800 (PST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id 24sm2961696pgt.14.2021.01.22.14.52.46
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 14:52:46 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id i7so4802666pgc.8
        for <linux-pm@vger.kernel.org>; Fri, 22 Jan 2021 14:52:46 -0800 (PST)
X-Received: by 2002:a67:2ac6:: with SMTP id q189mr1198085vsq.49.1611355613860;
 Fri, 22 Jan 2021 14:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20210122215900.1168610-1-dnojiri@chromium.org>
In-Reply-To: <20210122215900.1168610-1-dnojiri@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jan 2021 14:46:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XW5rodt0LdmzVwnzUgBgxe98zh1PshHa1G5=oUcg6aAA@mail.gmail.com>
Message-ID: <CAD=FV=XW5rodt0LdmzVwnzUgBgxe98zh1PshHa1G5=oUcg6aAA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] power: supply: PCHG: Peripheral device charger
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     Vincent Palatin <vpalatin@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Ching-Kang Yen <chingkang@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Jan 22, 2021 at 2:07 PM Daisuke Nojiri <dnojiri@chromium.org> wrote:
>
> +static int cros_ec_notify(struct notifier_block *nb,
> +                         unsigned long queued_during_suspend,
> +                         void *data)
> +{
> +       struct cros_ec_device *ec_dev = (struct cros_ec_device *)data;
> +       u32 host_event = cros_ec_get_host_event(ec_dev);
> +       struct charger_data *charger =
> +                       container_of(nb, struct charger_data, notifier);
> +       u32 device_event_mask;
> +
> +       if (!host_event)
> +               return NOTIFY_BAD;

Drive-by bug report: the above should be NOTIFY_DONE.  By returning
NOTIFY_BAD you're preventing other people on the call chain that come
after you from receiving any events that aren't "host events".
Specifically this includes keyboard events, switch events, etc.

The patch <https://crrev.com/c/2645556> contains the fix.

-Doug
