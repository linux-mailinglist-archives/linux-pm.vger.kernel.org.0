Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D2A7634AF
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jul 2023 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjGZLVG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jul 2023 07:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjGZLVE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2023 07:21:04 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2C6269A
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2023 04:20:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c4cb4919bb9so7175501276.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2023 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690370448; x=1690975248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XrZDdY5HjNhB0A5DSPeigCBlnEFyCrNBq0d87sVDWrE=;
        b=TT1mQ0zEisFdk3DJhNQdJDwNpe0mJo8JtUdgHsBCD79NNKAAGWvUb9tiCAh/o7o+WG
         c1MzFSA5woFqqEpeXisZnuwd25uQjR2B92Z04q0kL5iVdOEPcaJuCjQp3Xrh6rRD1ooK
         kgSrGdBSL794/xP7rtfPoBK6KzuwLDaJVKAiPPw0ljNaX+At0vleqf0dfrPrRb03pRlW
         TQ504X5BPhFchGCnScOrVM/8y40QlDh56+TQ4KyEvm5JIzbhIDcC5mAcCDlCqbRgpRPs
         DaqW57IlQtm1S9P1BKhHYHQvG2G7gVM0iQuSqtdZWSGTN90wiCUdmdFlgCGM+iNjjCXR
         fhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690370448; x=1690975248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrZDdY5HjNhB0A5DSPeigCBlnEFyCrNBq0d87sVDWrE=;
        b=NYOUE/7o5GnUJSAVFeOjgxUFAJI044PldZPpCRSXoFGPPH47ZTbtvwUdWbon/C/GFj
         WHBCUh5n2Fylq7ue0mJHfs4ShdbrJg7/kobYEAB/bKp6GJPlagf5NrK7NhEe8zO5U2dZ
         B73Pq/yETPwybYF/mUP9WKuje8AUoGojvwpNIgeclv2yFQ2u3Y7cfrAUb9Pi0NTPhwPm
         SGonN2/qAaL6Z3JD9sxqQIxul04QOaVJwmzc1Zl/USZ9WjJAyXqurbV/FQAqXKfzBDNw
         E4a0Oe8i+k5Ru4KaTgPGFYh8o3l/jvsZjTb2Y8ZKjXC1WSOJXNJ5l1oPGHF3BLvFLNXL
         NDpA==
X-Gm-Message-State: ABy/qLYeAYEra42XPA9AYr8ilrCX1+XTIVw9oR+U0/M4aLOJVtJ2Sy2z
        9qOONFQiodepMjgn+7vn3GM+H1Oeeh7rMH73FPGMpA==
X-Google-Smtp-Source: APBJJlGcsh2FTZu3XS/7LE1emqCZsTOs6YLB7V0tOBxgdbxn7ukKbkdSPAM2HdJkj6fX2HsWGVyjzXLvmrKapnbC6sM=
X-Received: by 2002:a25:c58b:0:b0:d0d:2d82:7a27 with SMTP id
 v133-20020a25c58b000000b00d0d2d827a27mr1535893ybe.13.1690370447746; Wed, 26
 Jul 2023 04:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-10-ulf.hansson@linaro.org> <20230719152426.qwc5qqewrfjsarlz@bogus>
 <CAPDyKFogrwFnz2ZuKE-mLrCQmTCQcrtjhhyzB4CnoVnxAXqKEg@mail.gmail.com> <20230721143728.GB1092306-robh@kernel.org>
In-Reply-To: <20230721143728.GB1092306-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Jul 2023 13:20:12 +0200
Message-ID: <CAPDyKFr9V6iPJhXXrv5RxgAE-YvXDboN5GP8E=q2VHnjs8cL5w@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] cpufreq: scmi: Add support to parse domain-id
 using #power-domain-cells
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 21 Jul 2023 at 16:37, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jul 21, 2023 at 01:52:17PM +0200, Ulf Hansson wrote:
> > On Wed, 19 Jul 2023 at 17:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Jul 13, 2023 at 04:17:36PM +0200, Ulf Hansson wrote:
> > > > The performance domain-id can be described in DT using the power-domains
> > > > property or the clock property. The latter is already supported, so let's
> > > > add support for the power-domains too.
> > > >
> > >
> > > How is this supposed to work for the CPUs ? The CPU power domains are
> > > generally PSCI on most of the platforms and the one using OSI explicitly
> > > need to specify the details while ones using PC will not need to. Also they
> > > can never be performance domains too. So I am not sure if I am following this
> > > correctly.
> >
> > Your concerns are certainly correct, I completely forgot about this.
> > We need to specify what power-domain index belongs to what, by using
> > power-domain-names in DT. So a CPU node, that has both psci for power
> > and scmi for performance would then typically look like this:
> >
> > power-domains = <&CPU_PD0>, <&scmi_dvfs 4>;
> > power-domain-names = "psci", "scmi";
>
> That is completely backwards. Entries are named based on the consumer
> side. The function of each clock or interrupt for example. Here your
> entries are based on the provider which should be opaque to the
> consumer.

Okay, so you would rather prefer something along the lines of the below?

power-domain-names = "power", "perf";

The "psci" name is already part of the current cpus DT binding
(Documentation/devicetree/bindings/arm/cpus.yaml), so then it looks
like that deserves an update too. Right?

Kind regards
Uffe
