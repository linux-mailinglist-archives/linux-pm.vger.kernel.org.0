Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B664F93F3
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiDHL1p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 07:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiDHL1d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 07:27:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A3DA27FB
        for <linux-pm@vger.kernel.org>; Fri,  8 Apr 2022 04:25:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a6so16795274ejk.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2022 04:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=fq/K4JNV15oSFxy2NseTqwYWn1DV3eYrSDISuIsrfjY=;
        b=gS3p0Nm6TFQkDgli679VWBZD/2P9mr04tsUkL37/VstyIDdKRmc8C5aKwlpIyQGm6B
         bnv88XZrC4g5oK9cjGlkBdZIdAbfi7yrwv8buadDnFeEfPk/dGG+rS7PAr1AcAHx07nX
         WR0g/K6SpetZYe2wQsetONgUrSorQ3OmC3eCJesipeoRBW6OjrMRb3873ycB3VolfVRg
         9U9FL2DACMpecMb2ULtRNEz4yYMOD71Utato5rdq+NJzF50u+xJ5k0MAlFZCFLGdLVGK
         gJwr91VI6b0CsrDQM8ldeEraQz1amXaU9bd7a9PyesSZAw1bprEA8TemdIUGWXS5RHX8
         XfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=fq/K4JNV15oSFxy2NseTqwYWn1DV3eYrSDISuIsrfjY=;
        b=pR4P3uqd93wnulnbk2nYIA0i6NTUp+8TFZIMVUOAT/7SCwP1LrV3fI1JPw1nX+O7L0
         YjTr4voY2yiagyf17yW2az7pDjFQCvtnmulSh9spTS1dkYa6E7NzRz26v6h3bdhd+xc5
         aLaWlDOPSLSCHuhBCoHIISCOJrT0+urjt4Nn5wz1IcwtRIapmMdtkQObcXoRDVV57A0M
         elQNleHxtZiJ2A+8vM5AOkoulFYzW6xt0ZEC29cKcwmvZv5FJAHqSVcaCrlimf9aJoc0
         Lwh0rmRxP1Qeqj99hHR/hs9yX7pGtcse7BiQ0au47snJiW5BarTUiDNUGDw4wNplkV39
         Lbvw==
X-Gm-Message-State: AOAM531TjYhdVqfVAXqeQ/qsU35Gv/BLxxc7JO51UdXDRrFNQaxrMHLD
        sHjFioAzf4Dy2bwx2LXBFy4d0g==
X-Google-Smtp-Source: ABdhPJyeiuA6W53n6q0nTKiH0iz4FzlTJpMeID7G1rR7HGiuE6Z5+rJk9xaGb2yFLvehiheSF8RWjA==
X-Received: by 2002:a17:906:32cf:b0:6d5:83bc:e962 with SMTP id k15-20020a17090632cf00b006d583bce962mr18531651ejk.108.1649417128191;
        Fri, 08 Apr 2022 04:25:28 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm6365666edl.28.2022.04.08.04.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 04:25:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 08 Apr 2022 13:25:26 +0200
Message-Id: <CJ4TKNHK955X.2YYNAV248UMK8@otso>
Cc:     "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <linux-arm-msm@vger.kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>, <devicetree@vger.kernel.org>,
        "Thara Gopinath" <thara.gopinath@linaro.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <phone-devel@vger.kernel.org>,
        "Andy Gross" <agross@kernel.org>
Subject: Re: [PATCH 05/10] dt-bindings: thermal: tsens: Add SM6350
 compatible
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Rob Herring" <robh@kernel.org>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-6-luca.weiss@fairphone.com>
 <YbpLqwFJI/nfvxd9@robh.at.kernel.org>
In-Reply-To: <YbpLqwFJI/nfvxd9@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

On Wed Dec 15, 2021 at 9:10 PM CET, Rob Herring wrote:
> On Mon, 13 Dec 2021 09:26:06 +0100, Luca Weiss wrote:
> > Add devicetree compatible for tsens on SM6350 SoC.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > ---
> >  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
>
> Acked-by: Rob Herring <robh@kernel.org>

It looks like this patch hasn't been applied yet. Could the responsible
maintainer please pick it up?

Regards
Luca
