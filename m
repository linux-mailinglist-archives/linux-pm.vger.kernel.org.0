Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4756C6771C4
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jan 2023 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjAVTQK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Jan 2023 14:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjAVTQJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2023 14:16:09 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA88F17CC6
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 11:16:05 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 66so12468981yba.4
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 11:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ElRpalOZi7J52XLSXhPhrczN8h5cy7ygxnPR4Rvs4Z8=;
        b=vTf4SFpURiubpPpu7XZuCTQX4/QO1dj4IcVjVuR7lw0DA8PwmS+c7CPYozZ7JPF0PW
         xOcWLmgBe9EgtCX+lwbhEkLbuwCcFzmvWe1n+qzdJqNdveC1UflKJjQN+J16cA62P17T
         TwXR4/mZ+ohzTVldmdcoRvOt+7lOVHiArXKqXRPUqfmcadYHag6L1HjK9mdj8GM/jZtW
         dLICRr68ij/grzRUPXYPrw4mEv1aD9qoS0lYAxQjZ9SIDNQKkeZcdBntOFIIhovOMrs3
         f19nWGJPNOR8UNArQZJqjzsvFxzU9UPMPqHAaTXdCzv4S2625mEEH514TBn+j8DZycKO
         fh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElRpalOZi7J52XLSXhPhrczN8h5cy7ygxnPR4Rvs4Z8=;
        b=i0SZ0DhXm8TXgcil1ADGPzPMPphqNWEIej+ODF0VhP3XZm7KDHshIaFO2jdN3F8tZu
         tqrvQiy8CGQmbiNt72Kr+SBwovx0VE1oKu1JQj8qGHs+/C7TxrcZmAHhRNyYZHyKJuQu
         ZlpW2CmBZmxWWTSz5IHEOdrzifI6qGye7+ZKmqdWvsHPPZycwx1TODV0SAR7iFdBjI09
         gISaF2RlNvU8luKxAkHssh1jBzuIX4nveOVdMVh5v8gyBFkZOGVGZtkQSZOkjrAZvHHo
         3ObFLna4z2SN8Ukf8slf6oJOuaBbY0FC7j5ThuCd3/Gmh7b9QBRoYaEkpttRcMHn6x6C
         cdMg==
X-Gm-Message-State: AFqh2kp3BhO+kSpaLZuo9Gr46GDpzOwSvCij174D7/3gwWaLuazOMn4P
        qeEqnBe7V+KPKAVq1sBrmMx38QmhU36SDvnh938KXw==
X-Google-Smtp-Source: AMrXdXtMkX/VWBDuyjzFNYmpxp9aFkNJ7bZtjzCF2zlGoh0Rxjn5KxJ6nXUYT6yICwQnAGP58KBFc8HQqblan7xaJc4=
X-Received: by 2002:a05:6902:8f:b0:800:748:7d05 with SMTP id
 h15-20020a056902008f00b0080007487d05mr1204448ybs.15.1674414964767; Sun, 22
 Jan 2023 11:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20230122174548.13758-1-ansuelsmth@gmail.com> <20230122174548.13758-2-ansuelsmth@gmail.com>
 <CAA8EJpp1c=sC0d_G1eSuOzJbjusW86zHezfwY3JRH=EBp7tNmA@mail.gmail.com> <63cd7cda.050a0220.53454.5a1b@mx.google.com>
In-Reply-To: <63cd7cda.050a0220.53454.5a1b@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 22 Jan 2023 21:15:53 +0200
Message-ID: <CAA8EJppFKDXJtt5zyM4mhEJ=BQwHUCVJcJKeH2GjkzAvwbfCBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: opp: opp-v2-kryo-cpu: enlarge
 opp-supported-hw maximum
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 22 Jan 2023 at 20:13, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Sun, Jan 22, 2023 at 07:59:42PM +0200, Dmitry Baryshkov wrote:
> > On Sun, 22 Jan 2023 at 19:46, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > Enlarge opp-supported-hw maximum value. In recent SoC we started
> > > matching more bit and we currently match mask of 112. The old maximum of
> > > 7 was good for old SoC that didn't had complex id, but now this is
> > > limiting and we need to enlarge it to support more variants.
> > >
> > > Document all the various mask that can be used and limit them to only
> > > reasonable values instead of using a generic maximum limit.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 20 +++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > > index b4947b326773..908cb0d7695a 100644
> > > --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > > +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> > > @@ -50,12 +50,28 @@ patternProperties:
> > >        opp-supported-hw:
> > >          description: |
> > >            A single 32 bit bitmap value, representing compatible HW.
> > > -          Bitmap:
> > > +          Bitmap for MSM8996 format:
> > >            0:  MSM8996, speedbin 0
> > >            1:  MSM8996, speedbin 1
> > >            2:  MSM8996, speedbin 2
> > >            3-31:  unused
> > > -        maximum: 0x7
> > > +
> > > +          Bitmap for MSM8996 later revision format:
> > > +          0:  MSM8996, speedbin 0
> > > +          1:  MSM8996, speedbin 1
> > > +          2:  MSM8996, speedbin 2
> > > +          3:  always set
> >
> > This is used for speedbin 3
> >
>
> Is it right that 4 bit speedbin is only introduced later? Cause looking
> at the current opp-supported-hw for MSM8996SG and MSM8996 originally
> (and based on what this Documentation say) there were only 3 bit and
> then they started using a 4th bit. Just asking if it's ok to keep the
> bitmap split or i should just merge it.

I don't think I got the question, please excuse me. Historically
msm8996.dtsi used 0xff as 'all possible platforms' value for the GPU
tables. Lately I fixed the CPU tables, added support for speed-bin 3.
However I left these 0xff in GPU opp table intact. I don't remember if
there was any reason behind that. Anyway this bit isn't always set, it
is set only for the entries which should be selected for MSM8996 speed
bin 3.

>
> > > +          4-31:  unused
> > > +
> > > +          Bitmap for MSM8996SG format (speedbin shifted of 4 left):
> > > +          0-3:  unused
> > > +          4:  MSM8996SG, speedbin 0
> > > +          5:  MSM8996SG, speedbin 1
> > > +          6:  MSM8996SG, speedbin 2
> > > +          7-31:  unused
> > > +        enum: [0x1, 0x2, 0x3, 0x4, 0x7,
> > > +               0x9, 0xd, 0xe, 0xf,
> > > +               0x10, 0x20, 0x30, 0x70]
> > >
> > >        clock-latency-ns: true
> > >
> > > --
> > > 2.38.1
> > >
>
> --
>         Ansuel



-- 
With best wishes
Dmitry
