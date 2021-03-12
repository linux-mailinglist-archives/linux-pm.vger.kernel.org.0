Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C419338A57
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 11:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhCLKh1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 05:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhCLKhZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 05:37:25 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4E4C061761
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 02:37:24 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id d25so12259288vsr.11
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 02:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3/Vc1Ah6eKHyLWI1pgidt8/nWh+3HJqZHQUqW0QsJY=;
        b=e/OV4wNhRA/Hs5pdnjxqlm48AcxIBgreDOOJNjy58xe/C+lYYaCP1LvYHtxw5nNMDd
         ALc5X7QtHJfqYjQJtkk29KbBS+sCEO+r861cukBYcKfIkwG7Ou4nlCW1n/UmnxXDl8UZ
         Z/fv7WEl9eLwGeyto13VUunS/sfPRI2c3QsnbpFtyEdc7Gfom8B6Uyb0CQaIhkyCgJpI
         Vsh00DPD7rj87XdaxRSYPfBsBAN7FvwewFG9kAbAybHO8w6BrDs7Q/oHkpYaTspxVr8g
         hG55hBJ9e6DnKN6cjQsuVlY7/n4MxMQTtSF3SukeI2+Zdfpe9OF7WCVtCu8zUxSY8ajX
         hHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3/Vc1Ah6eKHyLWI1pgidt8/nWh+3HJqZHQUqW0QsJY=;
        b=BQJG5DvU2lR7E9dnFmc8S3Wv4irhtFa91Prh3CzII1gLd4FXJBH1aK/c2Ez1pb6/B1
         jmH0T71N3F6Dlw/vNqgVDsSQ1OBQ9FtuQIuRVJs2O+5Scnnc3KUCFsMiuCvz9gLgkdiK
         deViiuWJIo2Tgx0w6OOLBSHs7xaAk9xvSsJdAvrpjegqtZLCvKxseb0SJxJlbzlz/+cr
         B/vFhtPNNQiqdQ792dT/7IHpKzLzrSJNvHp61J1SQJGg1TCCJk40HEEgfVk1ptWIl8Xo
         23rgvspBdcu+bfV1hH0AAAzq9AI1KDthvHducNlnRfJ57lXSeQw/ZF6Bg/oKa5ceUcFL
         IDhg==
X-Gm-Message-State: AOAM531AJY0Ir/3YBqDVL96FXWry6qIaDbP9DfdUirx+pwtRKZjHs7t+
        I5tCm3ktuXQ8FbjhNb0ShFF3U8gyY4zIigOLxf9+nA==
X-Google-Smtp-Source: ABdhPJyLTgXQd1zTmLlKpEGuucdoDu6MxM1Ifem4y53cs/Xb9ONexPA+wPxOnpJgqOBWr4/fpZSZO+YOQXGKhLX6tmk=
X-Received: by 2002:a67:6942:: with SMTP id e63mr8188302vsc.48.1615545442849;
 Fri, 12 Mar 2021 02:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20210311192105.14998-1-digetx@gmail.com> <20210311192105.14998-2-digetx@gmail.com>
 <20210312053312.zgke2mzjkqmwn67i@vireshk-i7>
In-Reply-To: <20210312053312.zgke2mzjkqmwn67i@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Mar 2021 11:36:46 +0100
Message-ID: <CAPDyKFqrUCjTfrNqZ4gFfQS6LpoQCevGc-tv4WVOwuGhx5iiBg@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] opp: Add devres wrapper for dev_pm_opp_set_clkname
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 12 Mar 2021 at 06:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-03-21, 22:20, Dmitry Osipenko wrote:
> > +struct opp_table *devm_pm_opp_set_clkname(struct device *dev, const char *name)
> > +{
> > +     struct opp_table *opp_table;
> > +     int err;
> > +
> > +     opp_table = dev_pm_opp_set_clkname(dev, name);
> > +     if (IS_ERR(opp_table))
> > +             return opp_table;
> > +
> > +     err = devm_add_action_or_reset(dev, devm_pm_opp_clkname_release, opp_table);
> > +     if (err)
> > +             opp_table = ERR_PTR(err);
> > +
> > +     return opp_table;
> > +}
>
> I wonder if we still need to return opp_table from here, or a simple
> integer is fine.. The callers shouldn't be required to use the OPP
> table directly anymore I believe and so better simplify the return
> part of this and all other routines you are adding here..

Yes, please. I was thinking along the same lines, when I reviewed the
mmc patch (patch9).

>
> If there is a user which needs the opp_table, let it use the regular
> non-devm variant.

Kind regards
Uffe
