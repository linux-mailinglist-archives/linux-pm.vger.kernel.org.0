Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38073EDB31
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhHPQsV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:48:21 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41604 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhHPQsV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 12:48:21 -0400
Received: by mail-ot1-f44.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so21657997otu.8;
        Mon, 16 Aug 2021 09:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAk+bXSQUScQbdU5hNORsZL/qLSnE93O+ICos9MpVYM=;
        b=tt+wbufNWHQzQuwt7TZxD1A6hnUUpgfkDK2ood4BtZTGEsKUMu0ZHUoDxIgywO5FZH
         uMnwCWTM1miT19qEo0sgWHQrsTDS4SRZwHAk9awTu0KPEtHcvZUT5s/UQ/uIZeX+etn0
         Vs+rU39BLh+CeEUpe0b/nr3luyUIrlQrMQ31Hwc8hukYMcJdrPA0zprVAnToFNk4fAcg
         OBuKvzjL2kd1VEZzEyFndBWsxhSxPMsHM7AYaEMEaUs9tjG6uXWDCBm44xKDxggy137R
         smhYoZfWpX+o4x+Aya6l+Sb8T+7P8nyA6c6Jst9NYXxszthThifsf3IZJMbQeYj3yhx1
         +k6g==
X-Gm-Message-State: AOAM532JSip88mJMSUsxQxFnB71cMHp0Z/EegTJu4oN42tm0EBCMRBW6
        UgFxfODZZfi2m89ePHTUJkc8mhYoyJHLEd5ZlAU=
X-Google-Smtp-Source: ABdhPJzpwRhStifHUxeXzjqKHqeL0dRGj+AgWwaQQGNX6ZnhipsU1pGx0OW1q1o/iokxq6dkwbVrt5/8YqeEpgTQZ+M=
X-Received: by 2002:a9d:a75:: with SMTP id 108mr13243553otg.260.1629132463966;
 Mon, 16 Aug 2021 09:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <1628767642-4008-1-git-send-email-rnayak@codeaurora.org>
 <1628767642-4008-3-git-send-email-rnayak@codeaurora.org> <CAPDyKFqruKGya1tbPjzAA=eO5v3Gipt2DH6RBbMi6e_vXmA+dw@mail.gmail.com>
In-Reply-To: <CAPDyKFqruKGya1tbPjzAA=eO5v3Gipt2DH6RBbMi6e_vXmA+dw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 18:47:32 +0200
Message-ID: <CAJZ5v0gjpkb00hpStw-8LLOYbrht+JWbndVBGLWSWDwTDRW7ww@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] PM / Domains: Add support for 'required-opps' to
 set default perf state
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 12, 2021 at 1:46 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 12 Aug 2021 at 13:28, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> >
> > Some devices within power domains with performance states do not
> > support DVFS, but still need to vote on a default/static state
> > while they are active. They can express this using the 'required-opps'
> > property in device tree, which points to the phandle of the OPP
> > supported by the corresponding power-domains.
> >
> > Add support to parse this information from DT and then set the
> > specified performance state during attach and drop it on detach.
> > runtime suspend/resume callbacks already have logic to drop/set
> > the vote as needed and should take care of dropping the default
> > perf state vote on runtime suspend and restore it back on runtime
> > resume.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

All three patches applied as 5.15 material, thanks!
