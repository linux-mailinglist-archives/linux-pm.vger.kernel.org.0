Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31463C4E9
	for <lists+linux-pm@lfdr.de>; Tue, 29 Nov 2022 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiK2QOv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Nov 2022 11:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiK2QOV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2022 11:14:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C076479
        for <linux-pm@vger.kernel.org>; Tue, 29 Nov 2022 08:14:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d6so13878334pll.7
        for <linux-pm@vger.kernel.org>; Tue, 29 Nov 2022 08:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kNFxlZ5UZHdqkY5D469ZlAF99iMQpaT7Z5Tb3gRNO6s=;
        b=mklqGGWoIM/Kk03/T+/9GKUrA6BxCbIlOnGYi47ya+PsGaq5PuQ79ArfHzHUmocpKh
         UWYRyw2YoIeBkjr3Eqm6k/Gdwca1jZhoqdZYMEv0kDpavQqW0uemlTyNhrp3s8Lyp0wf
         dfoVI3AWKhWpEbKWDtpXW8RUcscnpr6oqcIWCY5X0aF1OS5tSH/X9xee82Tifpp8sMRD
         co8Ej+77pmSyRY25H4eiRVWk8ImjBJxYvrt7ksEMgk4BwtOVGzzQd6dW7IwDPPvW45Db
         MMLLaFIp/OL9/QILpT4+Emv8SB0DSzXuP/u0J5ZxNBL52B7jukWPRDqx1Ry5wVQdlurk
         K0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNFxlZ5UZHdqkY5D469ZlAF99iMQpaT7Z5Tb3gRNO6s=;
        b=6b64fgoH8WVQcxFyHqNzFgqlYQ1/KehIDWYBVNgXlBwLKir5gI+YQpPgDJn9EWPs4u
         VCwP9AXrofdnxhUH8Jki1AWYr8lMUxUps5QwnAfgxJv/96zVnpytp2F97f9h5+IKroX6
         PM+pmU56qHuGSZhPoAHCIMFVRZFDsIQIZFxIhqXFTmqtwKeuwFDPvpf8hnDUGYsb4G+P
         cbg6T/+Vs+derudrIOhHK9XxaP1iIyh/QPvZiz1a5AgJzt5MlT46M9HaM6dWNNAUOVOz
         oN65IvDiK5GlEdO/O+yoc8Xn+f214LZbXRO4MMN1QrHmDKyINHuhDkAItjaLJV/K1YHa
         Wf1A==
X-Gm-Message-State: ANoB5pmuLC1dGCeCCUZ1+8fXfA9D5IGHtZ8o2wzFnQu3pKCTCJi/vZNW
        8fGDDLbNZuBTF9V8rINl4EfqKgNUoNUsyBJyef/spw==
X-Google-Smtp-Source: AA0mqf5Rhd9HRwHYXDQMJsdsuHv6CWi3cvL30xHSRd2rhgyF1yVicxH7ZuTFM37ksIosNcYkVDDs3i5NQrVQbGRzqH4=
X-Received: by 2002:a17:90b:1d45:b0:218:6db5:fd98 with SMTP id
 ok5-20020a17090b1d4500b002186db5fd98mr61969036pjb.164.1669738459171; Tue, 29
 Nov 2022 08:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20221128142912.16022-1-marcan@marcan.st> <20221128142912.16022-3-marcan@marcan.st>
 <CAPDyKFobMvef_BWGMR=7avODh2r5XNMGpwO3xYgrN-u=DqRwbg@mail.gmail.com> <41c6882a-bff0-378c-edd3-160b54be7c1d@marcan.st>
In-Reply-To: <41c6882a-bff0-378c-edd3-160b54be7c1d@marcan.st>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 17:13:42 +0100
Message-ID: <CAPDyKFqZJEqijsKMhMSZVCOA-RugnEJ7aqxwRRin1JE3i1WxMA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: cpufreq: apple,soc-cpufreq: Add
 binding for Apple SoC cpufreq
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Tue, 29 Nov 2022 at 15:00, Hector Martin <marcan@marcan.st> wrote:
>
> On 29/11/2022 20.36, Ulf Hansson wrote:
> > On Mon, 28 Nov 2022 at 15:29, Hector Martin <marcan@marcan.st> wrote:
> >> +examples:
> >> +  - |
> >> +    // This example shows a single CPU per domain and 2 domains,
> >> +    // with two p-states per domain.
> >> +    // Shipping hardware has 2-4 CPUs per domain and 2-6 domains.
> >> +    cpus {
> >> +      #address-cells = <2>;
> >> +      #size-cells = <0>;
> >> +
> >> +      cpu@0 {
> >> +        compatible = "apple,icestorm";
> >> +        device_type = "cpu";
> >> +        reg = <0x0 0x0>;
> >> +        operating-points-v2 = <&ecluster_opp>;
> >
> > To me, it looks like the operating-points-v2 phandle better belongs in
> > the performance-domains provider node. I mean, isn't the OPPs really a
> > description of the performance-domain provider?
> >
> > That said, I suggest we try to extend the generic performance-domain
> > binding [1] with an "operating-points-v2". In that way, we should
> > instead be able to reference it from this binding.
> >
> > In fact, that would be very similar to what already exists for the
> > generic power-domain binding [2]. I think it would be rather nice to
> > follow a similar pattern for the performance-domain binding.
>
> While I agree with the technical rationale and the proposed approach
> being better in principle...
>
> We're at v5 of bikeshedding this trivial driver's DT binding, and the
> comment could've been made at v3. To quote IRC just now:

It could and I certainly apologize for that.

It's simply been a busy period for me, so I haven't been able to look
closer at the DT bindings, until now.

>
> > this way the machines will be obsolete before things are fully upstreamed
>
> I think it's long overdue for the kernel community to take a deep look
> at itself and its development and review process, because it is quite
> honestly insane how pathologically inefficient it is compared to,
> basically, every other large and healthy open source project of similar
> or even greater impact and scope.
>
> Cc Linus, because this is for your Mac and I assume you care. We're at
> v5 here for this silly driver. Meanwhile, rmk recently threw the towel
> on upstreaming macsmc for us. We're trying, and I'll keep trying because
> I actually get paid (by very generous donors) to do this, but if I
> weren't I'd have given up a long time ago. And while I won't give up, I
> can't deny this situation affects my morale and willingness to keep
> pushing on upstreaming on a regular basis.
>
> Meanwhile, OpenBSD has been *shipping* full M1 support for a while now
> in official release images (and since Linux is the source of truth for
> DT bindings, every time we re-bikeshed it we break their users because
> they, quite reasonably, aren't interested in waiting for us Linux
> slowpokes to figure it out first).
>
> Please, let's introspect about this for a moment. Something is deeply
> broken if people with 25+ years being an arch maintainer can't get a
> 700-line mfd driver upstreamed before giving up. I don't know how we
> expect to ever get a Rust GPU driver merged if it takes 6+ versions to
> upstream the world's easiest cpufreq hardware.
>
> - Hector

I didn't intend to bikesheed this, while I do understand your valid
concerns from the above statements.

Instead, my intent was to help, by reviewing. Simply, because I care
about this too.

If you think incorporating the changes I proposed is a too big deal at
this point, let me not stand in the way of applying this. In the end,
it's the DT maintainers' decision.

Kind regards
Uffe
