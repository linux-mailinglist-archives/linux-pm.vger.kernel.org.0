Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9F63CBE0A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 22:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhGPUzN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbhGPUzM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 16:55:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95408C061764
        for <linux-pm@vger.kernel.org>; Fri, 16 Jul 2021 13:52:15 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u15so12430208oiw.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Jul 2021 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=igKuGeiMB9XP6nxZZ+PIi1FthZOiouK6b3cCHBxksKE=;
        b=HR+uz2qNYilxv1tgAKGAEkzxzeI+y2gpODn56cN/+SpUI9cmCe3Pa9R7AAxIPAKxL+
         lQVpcX15+P3JDy+uu/YJWkJMCoYLhGUeOt27YAdjObi9nLmJ4jtNXBy9Jhqoy4j2Ojln
         OXP4+WPgHmtYWGkuSewLKtcbT2QnYgVB4k77KPMtCRf79zFQYoGL6qX9KeQwgp77zEtI
         w9hfOuFxcV8Ti+TAY2lGMLzdVoTZk8jPNhW11YTi24AQs4IN0jBecAfAlX6uggEmveob
         viGUGK2p5GA9Bc2ntfo5HcAwuuwqt3XdAQME4VUc4hEDBqjUMQC2pw6AD27b+1CTvKmS
         aZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=igKuGeiMB9XP6nxZZ+PIi1FthZOiouK6b3cCHBxksKE=;
        b=PReBPtWZY6q1p5VJQ2ip3+uoN/RYbSaHjg68pPJGyTPHPD7wU21njAATD/G56E0Vju
         0BWfW3O6kLtUKCTUl8AhLIgXLKPIE3yhzjyvwoMfwzBPShzxilMVIUVUkC1x2Tvy6/fv
         kF/tPFED0qpoFZwUOVP1ZZjPxTpxiTu/3eBaAwEng9tgiVPQZYFHUJjl6h/TeNPf6bPg
         6lC93J/Wc06hRhu7E0FMCMGqX9LQqGzcQNyGf7JJ98ilykDclrbvEU0ERR5wRRf2ssJc
         QghZmB8b3hALnktD4RDXToNthJ5jGD10Jlh3lMIP10W3qn5H1jF7sIDvDhBMET+QXfnQ
         haoQ==
X-Gm-Message-State: AOAM530M8ox4H4uLl7Xwx8aq2wnSibGfJtjYyWysiWwVQneBuVeiylSZ
        TzsuP7BK0Sk/wiC9SiqnP3NXBg==
X-Google-Smtp-Source: ABdhPJyIdma5lUUzHC6dbYwpyOQT+jE11sJiWCeqlG3aFNwcOJHeoiTmVMB4cuH5Ki256xGi1CGFZw==
X-Received: by 2002:a05:6808:1523:: with SMTP id u35mr9425249oiw.132.1626468734835;
        Fri, 16 Jul 2021 13:52:14 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a7sm2091197ooo.9.2021.07.16.13.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:52:14 -0700 (PDT)
Date:   Fri, 16 Jul 2021 15:52:12 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rojay@codeaurora.org,
        stephan@gerhold.net
Subject: Re: [PATCH v4 2/2] arm64: dts: sc7180: Add required-opps for i2c
Message-ID: <YPHxfHPC/faq/y+J@yoga>
References: <1626429658-18961-1-git-send-email-rnayak@codeaurora.org>
 <1626429658-18961-3-git-send-email-rnayak@codeaurora.org>
 <YPHpsO5LlQRQxj9y@yoga>
 <CAE-0n53CHD8c7C4ETWRgzmZmFSCcBw46wSs4pKbYMRjA_tD3yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53CHD8c7C4ETWRgzmZmFSCcBw46wSs4pKbYMRjA_tD3yg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 16 Jul 15:21 CDT 2021, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2021-07-16 13:18:56)
> > On Fri 16 Jul 05:00 CDT 2021, Rajendra Nayak wrote:
> >
> > > qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 MHz)
> > > Though qup-i2c does not support DVFS, it still needs to vote for a
> > > performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
> > > requirement.
> > >
> >
> > Sounds good, but...
> >
> > > Use 'required-opps' to pass this information from
> > > device tree, and also add the power-domains property to specify
> > > the CX power-domain.
> > >
> >
> > ..is the required-opps really needed with my rpmhpd patch in place?
> >
> 
> Yes? Because rpmhpd_opp_low_svs is not the lowest performance state for
> CX.

On e.g. sm8250 the first available non-zero corner presented in cmd-db
is low_svs.

And if this (which?) clock requires a higher corner than the lowest
possible in order to tick at this "lowest" frequency, I'm certainly
interested in some more details.

Regards,
Bjorn
