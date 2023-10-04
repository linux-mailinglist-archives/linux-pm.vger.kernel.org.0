Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5667B7B25
	for <lists+linux-pm@lfdr.de>; Wed,  4 Oct 2023 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjJDJHm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Oct 2023 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjJDJHe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2023 05:07:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B58C4
        for <linux-pm@vger.kernel.org>; Wed,  4 Oct 2023 02:07:30 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d857c8a1d50so1924074276.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Oct 2023 02:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696410450; x=1697015250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=30QXTNHFmVF6SpQ7YlpsZSTCTRsGylbFUGk24eHz+aQ=;
        b=reY45Im0qe7C1p0eVqG+uAf8Q0mGZz8Tu4etEToNSRtmPT1rjkrQvifGEd7LN6eYIt
         H2nam9SpXVBMoGWFfJUqcAkyplULzZtIMc9fR/QOzWa4ecHl/Ty3fTSsxBSX5Vp+DJqE
         6Tv5Kl8hf5RuZW7Jmhwal20VrDh4yUQ2UfA8p/UN5qUwpeX2tgGLcRa4PikgcI6n/MSq
         f3a6qO5bLt3x1JGJyZkEPSS8xLAoeHkPTaaDbhd3D+3tk4MQk6z9vCq6Scay5aFIWnql
         sHoX/gxXm15/swdfTVC1qZegqJ5Yi8I02n0R61MLUjhYD6sX5DtoYdHcQWzPBO/N67+t
         VwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696410450; x=1697015250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30QXTNHFmVF6SpQ7YlpsZSTCTRsGylbFUGk24eHz+aQ=;
        b=gGdX/emCVTmbEOTLAmMeAtskeKeebEKTVV+YKgBHtJVtK0zmvTgOPSrVsLbKrsZ00r
         qV5veixQy1lVHl2lKH+ifnsBStgMf+9WtpWplgG31Wj+DWckEFmdKyNUiLh+3F7DS4s3
         kFoew58hjxHH8bqkET1NArzaIHCVaLJu97hbiNKIzmd93BItmaeI4FGH6k+Z18+IBAxy
         8WKAP0lLt7fX2zVgrNk/GfLDuZPFmD/xbPPZz+Y2oAefHqKXWLOKB8L245Y2RxvZcY9C
         vZirxmyZcJuDqHheXmlTGq5uGFd9Pe6ek41hPpcQucWqLmZwrogOzLmM8ZYA6RCl3yL3
         bkJA==
X-Gm-Message-State: AOJu0Yw9lksjgCzrRYTjAMlYSh7CxoYHdmbn1Y4XO+XDU833LEPrR7qy
        qfU5qFJO2mQvvoOKeIoZkrBRaroHeYiN16yhs7D2uw==
X-Google-Smtp-Source: AGHT+IEmqGv1gndYtcBCVwRO6QrBOeQP+Ksc6AKOg+uW2eEpuec3RZTc95O8aRBvCaLdNmMa4e+UfMJSQ1UENi56gtM=
X-Received: by 2002:a25:dbc2:0:b0:d84:90c5:4e1f with SMTP id
 g185-20020a25dbc2000000b00d8490c54e1fmr1433778ybf.63.1696410449825; Wed, 04
 Oct 2023 02:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
 <20230925131715.138411-7-ulf.hansson@linaro.org> <CAPDyKFo+XCEtTSNqtA1SeajWo4tuRroA4GrRegta5TsqSGd4eQ@mail.gmail.com>
 <20231003082322.cmok766jxzftsgrg@vireshk-i7> <CAPDyKForAJfdqqpkAP0vwZFAtSAtGMyqChLVr96v7PDWRj2qzw@mail.gmail.com>
 <20231004050427.e3aalotrtpvld6rk@vireshk-i7>
In-Reply-To: <20231004050427.e3aalotrtpvld6rk@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Oct 2023 11:06:53 +0200
Message-ID: <CAPDyKFqDKtCDVMFa=Man1EOEkXt8COg4cRcVStdKfUFOTG9BdA@mail.gmail.com>
Subject: Re: [PATCH 6/9] OPP: Extend support for the opp-level beyond required-opps
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Wed, 4 Oct 2023 at 07:04, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-10-23, 14:36, Ulf Hansson wrote:
> > Can you please explain further on this. Rafael has acked those
> > patches, so it should be perfectly fine for you to pick them via your
> > tree too. There is no need to defer them.
>
> Ahh, then it is fine.
>
> > > I will then push out a branch and you can
> > > rebase your patches on top of it ? And then probably Sudeep or someone else can
> > > apply everything ?
> >
> > Or are you suggesting to just take one of the patches from my series,
> > and then I will re-base everything on top?
> >
> > Just trying to understand the way forward. :-)
>
> Applied patches 1-6/9 and the fixed routine looks like this now:
>
> +static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
> +                         struct dev_pm_opp *opp)
> +{
> +       unsigned int level = 0;
> +       int ret = 0;
> +
> +       if (opp) {
> +               if (!opp->level)
> +                       return 0;
> +
> +               level = opp->level;
> +       }
> +
> +       /* Request a new performance state through the device's PM domain. */
> +       ret = dev_pm_domain_set_performance_state(dev, level);
> +       if (ret)
> +               dev_err(dev, "Failed to set performance state %u (%d)\n", level,
> +                       ret);
> +
> +       return ret;
> +}
>
> Does it look okay now ?

Yes, perfect! Thanks for helping out!

Kind regards
Uffe
