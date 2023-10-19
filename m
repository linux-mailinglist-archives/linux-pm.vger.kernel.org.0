Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912A67CF6AF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 13:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345329AbjJSL07 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 07:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbjJSL06 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 07:26:58 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF421115
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 04:26:56 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso8218809276.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 04:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697714816; x=1698319616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PUrrcj+/ipouo/XR5RIgfw8wVuJ5J+7IILf/FghVZXQ=;
        b=L9f38YWU39ice32PN6Gk6IneWrA7GTaQko/2pMcAvyIFSspRayFYidiSyXxz2TvxN2
         WN+AT23DvUuAmVfiqxO5t7JJvOjTG45teXEl1i17H6KohaXZ2J3HaEv4C1ZzxyqS7CSF
         XDCY/nfkOClC2h/6Idw1icUqG5+fRg1yqlGOJjZgDiNHGJkLpOXPyvs8sHnJj5rhox1B
         BIvDcp+Iy3H/Ax05TllbFrTpBmXIJ/lSJOP4Ebbl8eBdcc+w0f4Mwwh0bcjBz9O7taiH
         WJ9OTdif9c/a0MKh1izip+0iJM2a1P6I0Ba36ezCz5zfbM2xput761mY9GEDuN0WUnMr
         c5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714816; x=1698319616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUrrcj+/ipouo/XR5RIgfw8wVuJ5J+7IILf/FghVZXQ=;
        b=OVmU0PTEjTaVPehzdISOvQlkl+zm4P0LkLFOx/0Jc1eUF77+CGuKQs1QtF+mNZGZqs
         TsgFpRIS2nkovHtoTXF/fXNK0ZrXXwktFC7eHQ/kAlRkJoWybmEaBCwo+AgEIIaSUOps
         am6IUixJh5p+RosWXumBvSXUYpcZaaCQwo2P1VN7VN6Tv601xfrfu/KKxi/xV234txsJ
         ffeociyma8aXBlxYfU1WqhtfwwljEg9df/P/QGmAHJHDbUIb4QKpPICU8FBC9lJC6zra
         3uVCasRQKyU7WallCs0mC79JT6W4r/8dEiiS7rydtgRrK3MAnam3HZq6QkBq0u1ZzL/f
         2aAg==
X-Gm-Message-State: AOJu0Yy82hNQkYvOPk+J+Yd79UuGkzuhoUS9zmsBP9QilTL2kQHS2Ray
        Zl7zh3deB9f2bFTf5KQbqOCPHXGGnRvfpAiz1inm2w==
X-Google-Smtp-Source: AGHT+IHHpyH97w+iL3El9mSizFMVO4FKJ8HXRgdkh6mPyu1/bq7yU2Ex3EFkQtcuQTKmfRtzWjhohIwy1xpnLV3M9ik=
X-Received: by 2002:a25:ae99:0:b0:d9a:fc8e:7c05 with SMTP id
 b25-20020a25ae99000000b00d9afc8e7c05mr1859738ybj.45.1697714816028; Thu, 19
 Oct 2023 04:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
 <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com> <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
In-Reply-To: <CAPDyKFot9=M1ooP_Q1AOgG5o_4DTQ2qsyai1ZdXAzBwf89W4uA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 13:26:19 +0200
Message-ID: <CAPDyKFr5A-P=UhWs4rUMBWup3pH75WAhcZ56Y2_Sfk3=WfxRCQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] cpufreq: qcom-nvmem: Enable virtual power domain devices
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Oct 2023 at 12:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 18 Oct 2023 at 10:06, Stephan Gerhold
> <stephan.gerhold@kernkonzept.com> wrote:
> >
> > The genpd core caches performance state votes from devices that are
> > runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
> > runtime PM performance state handling"). They get applied once the
> > device becomes active again.
> >
> > To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
> > calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
> > devices that use runtime PM only to control the enable and performance
> > state for the attached power domain.
> >
> > However, at the moment nothing ever resumes the virtual devices created
> > for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
> > means that performance state votes made during cpufreq scaling get
> > always cached and never applied to the hardware.
> >
> > Fix this by enabling the devices after attaching them and use
> > dev_pm_syscore_device() to ensure the power domains also stay on when
> > going to suspend. Since it supplies the CPU we can never turn it off
> > from Linux. There are other mechanisms to turn it off when needed,
> > usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).
>
> I believe we discussed using dev_pm_syscore_device() for the previous
> version. It's not intended to be used for things like the above.
>
> Moreover, I was under the impression that it wasn't really needed. In
> fact, I would think that this actually breaks things for system
> suspend/resume, as in this case the cpr driver's genpd
> ->power_on|off() callbacks are no longer getting called due this,
> which means that the cpr state machine isn't going to be restored
> properly. Or did I get this wrong?

BTW, if you really need something like the above, the proper way to do
it would instead be to call device_set_awake_path() for the device.

This informs genpd that the device needs to stay powered-on during
system suspend (assuming that GENPD_FLAG_ACTIVE_WAKEUP has been set
for it), hence it will keep the corresponding PM domain powered-on
too.

[...]

Kind regards
Uffe
