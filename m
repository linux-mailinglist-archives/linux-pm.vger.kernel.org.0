Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62409FD35B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 04:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfKOD27 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 22:28:59 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34128 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKOD27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 22:28:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id 205so7045651qkk.1;
        Thu, 14 Nov 2019 19:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+30VBQ6Z6pahGzwHddR4V87xEKzy9SO3iX26pCuliI=;
        b=nFIgWxCJ2dZ8AUUfrv0rBQqDPsE/g8aWDwr4HMuPFIEKpaOIi6EVMubajiKEh6jCW6
         H/RgXIFJXhd70OnQ6oObOTeMo0OhmLRkHOaadLiHuiD8yVVmWytBR7zy8oP2jEmZhBql
         kfAYz+Fql23qHA0/BEMZyoOajXF4G/DC27SKMpBNTEhizPcYGzrhMKw0fFh6MiqWXM3G
         ia9ou95D5ZtF1zj82ilfZRtVHz5t/7xNFTbsUPkJLCeKuhuo6rvZAASwybUzJT/rq0UD
         q13bwhOppW486v84zFWOGGfLR4L/nFDiL9FLLWNtr67JUaEKSVyLN3oHJip2bhNVFqbZ
         qFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+30VBQ6Z6pahGzwHddR4V87xEKzy9SO3iX26pCuliI=;
        b=YMgGAT/GfyFEVfZ7NDxiWm8jUVd/y74dy9VbjVwfV2nW+etj8UVts+KueDOZAXcjQ9
         petPunoqUPC1ZSMwL8gEvcNbYQ3/ik1tQjdXAYo40sLoiCVh3CqG0/2hOae3kxhJtc9l
         CNEVz4Scxiokclt2X2fSCmlT2B+RfxAK8LbRkCFzI2ULPh+cZSmgwgV+IwneU6RLxEQY
         yMKYZG3qv1Iyfp+daWEjKzXebRERWH+l0KAT4YWZN4qbaeVtkmgxNYmtz1kTT7Ekf/Tk
         Z5r6g238eC/DVsvNPCVT3wxruRnPGFXH1UCXWFu4d0IRs1LIOAnVTdhMgGYhpufqmX1j
         FLvQ==
X-Gm-Message-State: APjAAAWRBXZlLUf8CpaUEMO/BgBJPnC5LUMWE1ArHpunkAqsIASKKhiE
        ABHENnPn3E1zr6BlOQI8XHEkpP/bazGEVXrGdrsHWg==
X-Google-Smtp-Source: APXvYqxsrgGnkZmjzHHh9s5lDeis0yQ/6UHqrpj3Z/tO+JbLzt/a8BVZivpTzV/HhB1gm2pA9rs180XhETvLdVvMCGQ=
X-Received: by 2002:a37:4b97:: with SMTP id y145mr10563545qka.133.1573788538446;
 Thu, 14 Nov 2019 19:28:58 -0800 (PST)
MIME-Version: 1.0
References: <0a6b113010ad772a633b9cfeeb280dc41f17b951.1573206815.git.baolin.wang@linaro.org>
 <20191114180233.GA14860@bogus>
In-Reply-To: <20191114180233.GA14860@bogus>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 15 Nov 2019 11:28:46 +0800
Message-ID: <CADBw62pdQ+xFkkPkzsy7j6OFh-6DTdMwPV4j4RTJ0p4+nBJJDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: sprd: Add the Spreadtrum
 thermal documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Baolin Wang <baolin.wang@linaro.org>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, mark.rutland@arm.com,
        Orson Zhai <orsonzhai@gmail.com>, freeman.liu@unisoc.com,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On Fri, Nov 15, 2019 at 2:02 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Nov 08, 2019 at 05:54:30PM +0800, Baolin Wang wrote:
> > From: Freeman Liu <freeman.liu@unisoc.com>
> >
> > Add the Spreadtrum thermal documentation.
> >
> > Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  .../devicetree/bindings/thermal/sprd-thermal.txt   |   41 ++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/sprd-thermal.txt
>
> Please make this a schema. See Documentation/devicetree/writing-schema.rst

OK.

> >
> > diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.txt b/Documentation/devicetree/bindings/thermal/sprd-thermal.txt
> > new file mode 100644
> > index 0000000..a9da7f4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.txt
> > @@ -0,0 +1,41 @@
> > +* Spreadtrum thermal sensor controller bindings
> > +
> > +Required properties:
> > +- compatible : Should be "sprd,ums512-thermal"
> > +- reg: Address range of the thermal registers
> > +- clock-names: "enable" for thermal module enable clock.
> > +- clocks: Should contain a clock specifier for each entry in clock-names.
> > +- nvmem-cells: A phandle to the calibration data provided by a nvmem device.
> > +- nvmem-cell-names: Should be "thm_sign_cal" and "thm_ratio_cal".
> > +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
> > +
> > +Child nodes properties:
> > +- reg: Specify the sensor id.
> > +- nvmem-cells: A phandle to the calibration data provided by a nvmem device.
> > +- nvmem-cell-names: Should be "sen_delta_cal".
> > +
> > +Example:
> > +
> > +     ap_thm0: thermal@32200000 {
> > +             compatible = "sprd,ums512-thermal";
> > +             reg = <0 0x32200000 0 0x10000>;
> > +             clock-names = "enable";
> > +             clocks = <&aonapb_gate CLK_THM0_EB>;
> > +             #thermal-sensor-cells = <1>;
> > +             nvmem-cells = <&thm0_sign>, <&thm0_ratio>;
> > +             nvmem-cell-names = "thm_sign_cal", "thm_ratio_cal";
> > +
> > +             prometheus0-sensor@0{
>
> space                               ^

OK. Will fix.

>
> > +                     reg = <0>;
> > +                     nvmem-cells = <&thm0_sen0>;
> > +                     nvmem-cell-names = "sen_delta_cal";
> > +             };
> > +
> > +             ank1-sensor@1{
>
> space                        ^

Yes, will fix in next version. Thanks for your comments.
