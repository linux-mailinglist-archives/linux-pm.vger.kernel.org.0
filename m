Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DD72A1F57
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 16:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgKAP6f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 10:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgKAP6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 10:58:34 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E4C0617A6;
        Sun,  1 Nov 2020 07:58:32 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id v19so7348200lji.5;
        Sun, 01 Nov 2020 07:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9w5lqe/JTQMl14qtp1wqbV1q8PlicycEi9x7TwQ3O4I=;
        b=SrzcyTOQk7M4NCVfGsoyDQqZ6rFb3eZJcZzNQdiSNUT7txNNGhlL0NpT0+LOVda3Ih
         MiBUFAFrziuKtC1hCr5a+CEaEWrzgJICLO3UevGr9h71XEutrEV0cHH5XzfUCoDohH8E
         a45GiU+47GmYSJC5/FJSPBiNPS+BW+zygQuK/B9e8hXqfmnzMvhGZiFF4GdJVXlS3tet
         OXIAqAP/N5ThaauVK3L4z2MuyLnqwYL3XMOTewX8A7/1Tid7b0erQsFJ9lqKusNF0R4a
         YPiOTsbHK0dGj8R7DKeLodHLpNxXs+/ktqgRnbQMasDwrSlX/7YSgiQGBPol/B0k4Ama
         wPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9w5lqe/JTQMl14qtp1wqbV1q8PlicycEi9x7TwQ3O4I=;
        b=sb0Ckl4xj/v6BieRMsyQH/o4DzJcIhqVWb5qBdtZ7SL5I8aHnrHBMpFfFGE/ud0c0+
         8jgsZ876eRmnN5KcDOSpZWZt2Ugsz2RJrYC1cI3nh92upfT3OvLCGPPOYdpUZOHO8Ufj
         osWjjlyGex3kBNIWONAqLSEJLxB8Aucg5dnGL7StcUFi872ckD/Ku/gNMi2CyTQgPgJc
         +5KMljdfb7aJpf9VP3YNYY2ATg9pDKJFbFgK79Xeo3vMuCXBXxIoz7wz/62IViqBern4
         Czj/WoM3x0PdoESSUdXtuJWWx7KO4Lh5KfivCnzECRmppVwbAcfk4+YPhY5+37Z8lAJJ
         9hWg==
X-Gm-Message-State: AOAM530VU73UhycfC+o6WxqrzJPmFKjttqem7WhT9sWaCFrlfLfmwJ3A
        1rpWoXe3Adj/ux5xJnFGdKyHbBOFM4hi1ZC8qFE=
X-Google-Smtp-Source: ABdhPJxWcrG0gmpm+NAN1BZS7Iw6tgZ8ick38nOYLMklui1fLFdUIqBpA2BV8e/ASXPN+5HRZr3OVEYaeMhtvt6PCqE=
X-Received: by 2002:a2e:681a:: with SMTP id c26mr5169187lja.56.1604246311413;
 Sun, 01 Nov 2020 07:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20201025221735.3062-1-digetx@gmail.com> <20201025221735.3062-52-digetx@gmail.com>
 <CAGTfZH1PV4r-pD=zTKD71nQb5+UobJKa5mBv-Nb2ZgSubkscjA@mail.gmail.com>
 <2ebd184c-60e8-19e2-9965-19481ced1c70@gmail.com> <CAGTfZH0=6R02euOR3JHgA0iLq5++Yvp3Z_wBCEs7bzkfuorEFQ@mail.gmail.com>
 <5f5a22b1-4d01-5698-1bca-6bcc66c55e6f@gmail.com>
In-Reply-To: <5f5a22b1-4d01-5698-1bca-6bcc66c55e6f@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Mon, 2 Nov 2020 00:57:55 +0900
Message-ID: <CAGTfZH3s-1cROd3_X2weBs6i1irgJQJZP+8G+rj9p3KZMUu2vQ@mail.gmail.com>
Subject: Re: [PATCH v6 51/52] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 2, 2020 at 12:49 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 01.11.2020 18:44, Chanwoo Choi =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> OPP core will try to grab the clock reference for the table and it may
> >> cause EPROBE_DEFER. Although, it shouldn't happen here because we have
> >> devm_clk_get() before the get_opp_table(), hence seems the deferred
> >> probe indeed shouldn't happen in this case.
> > It is my missing point. If there, you're right.
> > Could you provide the code point to check the clock reference on the OP=
P core?
>
> Please see it here:
>
> https://elixir.bootlin.com/linux/v5.10-rc1/source/drivers/opp/core.c#L110=
1

Thanks. It seems that if device tree node contains the any node,
it is not EPROBE_DEFER because of just using "clk_get(dev, NULL)".

The patch[1] used the 'dev_err_probe' for getting the "emc" clock.
Do you need to check it more?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commi=
t/?h=3Ddevfreq-next&id=3D09d56d92ad25b58113f4ec677e9b1ac1e2c3072b


--=20
Best Regards,
Chanwoo Choi
