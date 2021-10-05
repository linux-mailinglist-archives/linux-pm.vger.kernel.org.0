Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F603422754
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 15:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhJENIB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 09:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233365AbhJENIA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Oct 2021 09:08:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA93C61526;
        Tue,  5 Oct 2021 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633439169;
        bh=LBXeQPdnongCHHFOfC+fjyOcJRys5u65ipIxCzTick4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gDHzo93l854WzFerwfvh36GtjhaZ7Weyyg6jAhTVjRIj7T7AbKsMTsNzVqZMuu7K4
         TcTSD3E+LAyL1d9ggksxUB8GNR7m7FN0TcfCOzrjXBZQkWedsCOg/XqD1JLt+gRsfG
         nwOwc1smfbytVhQmZSx3xyUmvdAUjpA1IBOqMwYWFtWP973OpeOAWJmRhVJonOSZS/
         rA5+tBKp8QAAcN9v1h0BJaGkykK7h4pdw/ucljGjQSp35BdaUvcoiVqidquW9tBzhF
         GlzBDQXxnWVLhonQO6pdteY37AcYrkm0wFRB5st+2UxoEll2jlfcnv2f6Sbf3Gcjix
         JPzcYLsMKV0yw==
Received: by mail-ed1-f44.google.com with SMTP id v18so77109170edc.11;
        Tue, 05 Oct 2021 06:06:09 -0700 (PDT)
X-Gm-Message-State: AOAM533+xUuZhoqL5+eq+Sue7UBgxzGzVpHSsBDjnygZAStWaJcfZ2PN
        K6pb/AZDrPJSC+IVWt58V1pDL8QW0VEcv1kmEw==
X-Google-Smtp-Source: ABdhPJzaDPA+eqvi7RrlFbwXQ2RyM9quXXqzBd25W7ggPUd88sGd4fU1jywhVaFqcYfoqXwS07gace2G8er+DPiqaDA=
X-Received: by 2002:a50:d903:: with SMTP id t3mr25974872edj.70.1633439126004;
 Tue, 05 Oct 2021 06:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211004112550.27546-1-j-keerthy@ti.com> <20211004112550.27546-2-j-keerthy@ti.com>
 <1633436798.497006.3226792.nullmailer@robh.at.kernel.org>
In-Reply-To: <1633436798.497006.3226792.nullmailer@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 5 Oct 2021 08:05:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKLuE+RhH+T4UKecMhRjbm69rwA1a2+FjrnMPKUf13J6A@mail.gmail.com>
Message-ID: <CAL_JsqKLuE+RhH+T4UKecMhRjbm69rwA1a2+FjrnMPKUf13J6A@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
To:     Keerthy <j-keerthy@ti.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 5, 2021 at 7:26 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 04 Oct 2021 16:55:47 +0530, Keerthy wrote:
> > Add VTM bindings documentation. In the Voltage Thermal
> > Management Module(VTM), K3 J72XX supplies a voltage
> > reference and a temperature sensor feature that are gathered in the band
> > gap voltage and temperature sensor (VBGAPTS) module. The band
> > gap provides current and voltage reference for its internal
> > circuits and other analog IP blocks. The analog-to-digital
> > converter (ADC) produces an output value that is proportional
> > to the silicon temperature.
> >
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> >  .../bindings/thermal/ti,j72xx-thermal.yaml    | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Woot, TI has blacklisted me:

The response from the remote server was:
553 Sorry, your email address has been blacklisted. Please contact
Texas Instruments Inc to have yourself removed.
