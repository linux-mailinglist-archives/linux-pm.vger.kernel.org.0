Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E157F99091
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 12:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfHVKUK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 06:20:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33677 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfHVKUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 06:20:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so4146405lfc.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2019 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wPBDtmTZhqkyTNz0MqWgEkHLzILpQif3A3GQnsT/mi8=;
        b=YH8DY7eZIuy+N5wDuMxNcN/eV2PnncZNHKtZnk/Ev1sfTVb93MNfhwZaV0fFw0K1oy
         5MX0uxb4PmY6nuTDa10FjmDjGjT3uN3XzwSpUuR+Bz7QcnSW7P2TwVHVyhV6P9XaoQLz
         QmmsJQkd8i5rMJhzNKloN8I5jU4CAd6fR5XIQ44MvktPPGMJsFyiP2GgX8XRFmIZ0Vx8
         Gy1DEAD8AsgKAjBGXuU1rY84orP8m6xmRP+LMIWYo0sR/38ud+lwnarD79w/o67x6CAJ
         HO7mQU8/fs+LC/1uOI6N+X8QhWUsL11BYLNFs1h2pbi2o8B1H9z3fYGdqs733UEZhQ9A
         52oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wPBDtmTZhqkyTNz0MqWgEkHLzILpQif3A3GQnsT/mi8=;
        b=cAGpaQWDtrUwAaxpan4RgZhWvyAwCzGnH8+K1EqhQtNzNA59eOjk/t+iRbiBtE96Wn
         eAB8YMZcxYpfH02PsAgxY4Z3yDYhGt2nTYReYs0URVLOSEvJ/t1htt24P/mc6cNlg/3j
         kzy4abWU1AxUsb0wWuf2QbPWehGZDfmpGUjz+qojaxjTVgkzCXFUrk6sM8gM1VJgOHH0
         sSCUXSXugoFGUfpvPyHW76Qo1mg6mRzInpe9DHBUbxKuIBBMZ5nM+izTGK+8zmYYpzck
         pISROXubFuxe8J7DXMMHukMtetidNFNhoB/eaYwvLmIhBfVEuJnll7+55oqPuRwxLuCp
         xFpg==
X-Gm-Message-State: APjAAAX2HGdLeNw8i8wzWS6fUsEHWHgQA8GvEaSaEQSDiTHAjjz8Ywe+
        5Kh2vnqRB6PLY1ntCrPU0Ty9fA==
X-Google-Smtp-Source: APXvYqxDQXf3LY5Ds0SPDRViU/Z88Dzf56IoZrVylWXa05DGSliVoBFyyrB3KfXrpeflaqNyf452jQ==
X-Received: by 2002:a19:e04f:: with SMTP id g15mr21819606lfj.46.1566469205557;
        Thu, 22 Aug 2019 03:20:05 -0700 (PDT)
Received: from centauri (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id k8sm3758979lja.24.2019.08.22.03.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 03:20:04 -0700 (PDT)
Date:   Thu, 22 Aug 2019 12:20:02 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        linux-arm-msm@vger.kernel.org, vireshk@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/14] dt-bindings: power: avs: Add support for CPR
 (Core Power Reduction)
Message-ID: <20190822102002.GA8494@centauri>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
 <20190725104144.22924-11-niklas.cassel@linaro.org>
 <5d579b36.1c69fb81.85eba.ff51@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d579b36.1c69fb81.85eba.ff51@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 16, 2019 at 11:14:13PM -0700, Stephen Boyd wrote:
> Quoting Niklas Cassel (2019-07-25 03:41:38)
> > +       cpr@b018000 {
> > +               compatible = "qcom,qcs404-cpr", "qcom,cpr";
> > +               reg = <0x0b018000 0x1000>;
> > +               interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
> > +               clocks = <&xo_board>;
> > +               clock-names = "ref";
> > +               vdd-apc-supply = <&pms405_s3>;
> > +               #power-domain-cells = <0>;
> > +               operating-points-v2 = <&cpr_opp_table>;
> > +               acc-syscon = <&tcsr>;
> > +
> > +               nvmem-cells = <&cpr_efuse_quot_offset1>,
> > +                       <&cpr_efuse_quot_offset2>,
> > +                       <&cpr_efuse_quot_offset3>,
> > +                       <&cpr_efuse_init_voltage1>,
> > +                       <&cpr_efuse_init_voltage2>,
> > +                       <&cpr_efuse_init_voltage3>,
> > +                       <&cpr_efuse_quot1>,
> > +                       <&cpr_efuse_quot2>,
> > +                       <&cpr_efuse_quot3>,
> > +                       <&cpr_efuse_ring1>,
> > +                       <&cpr_efuse_ring2>,
> > +                       <&cpr_efuse_ring3>,
> > +                       <&cpr_efuse_revision>;
> > +               nvmem-cell-names = "cpr_quotient_offset1",
> > +                       "cpr_quotient_offset2",
> > +                       "cpr_quotient_offset3",
> > +                       "cpr_init_voltage1",
> > +                       "cpr_init_voltage2",
> > +                       "cpr_init_voltage3",
> > +                       "cpr_quotient1",
> > +                       "cpr_quotient2",
> > +                       "cpr_quotient3",
> > +                       "cpr_ring_osc1",
> > +                       "cpr_ring_osc2",
> > +                       "cpr_ring_osc3",
> > +                       "cpr_fuse_revision";
> > +
> > +               qcom,cpr-timer-delay-us = <5000>;
> > +               qcom,cpr-timer-cons-up = <0>;
> > +               qcom,cpr-timer-cons-down = <2>;
> > +               qcom,cpr-up-threshold = <1>;
> > +               qcom,cpr-down-threshold = <3>;
> > +               qcom,cpr-idle-clocks = <15>;
> > +               qcom,cpr-gcnt-us = <1>;
> > +               qcom,vdd-apc-step-up-limit = <1>;
> > +               qcom,vdd-apc-step-down-limit = <1>;
> 
> Are any of these qcom,* properties going to change for a particular SoC?
> They look like SoC config data that should just go into the driver and
> change based on the SoC compatible string.
> 

Hello Stephen,
thanks a lot for your reviews.

I agree with you, will drop these properties from the dt-binding
and the driver once I respin the series.

I'm hoping to get the cpufreq part of the patch series merged this
merge window, so that the patch pile will decrease.


Kind regards,
Niklas
