Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2166DDF6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 13:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjAQMp4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 07:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjAQMpy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 07:45:54 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD19738665
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 04:45:53 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id p188so33842061yba.5
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 04:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vxknlLDnsxojLcmQ59vK0ZLgoKiVLvxFkDDOG8faM4Q=;
        b=uqcNVH96+N3QhwEoMwCX0XF8bNjcpWqYdeKTdHchHyJ1W9LW/wuK5nUhmLsPUlqcjz
         7kV/qMP8k1vWUT7gagwrWaw7KqPt9kl/O1+irrBaSgnivLTfRy1btFgNHs0Gl7SiH9ji
         A532CpWpeNHRHouB4wkT/dQOWzRCmCVnPNfD0yz9tD2N5LAH6g28XDE2L5EmjbPp6huX
         HmiS0kgY0TYGihNMa3JOOZNERhi1bTob47MaH4+Nrpum65ConMPIFPErUsUSkUeMwqmm
         3hVtI2/l7sxxTNcHAoq5MxayhbFf0SXOt3b2IzUI8MGo0MOoUV//HbK6Oam84fX+IabD
         kN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxknlLDnsxojLcmQ59vK0ZLgoKiVLvxFkDDOG8faM4Q=;
        b=Af6mI7A1KEYiBhLC0k654jQQlpOX3hNYvCLcSyJQdAU+9oi7WRbR0wnGef0gnnpEJu
         Lh6hO/OjGp+o5ueZxDPe7v3z+BwBTnAGO+oZCaz/7u2YgtMpb7k1gC35gH42eJhnI0VT
         InkNc/z4Men6UD8HiAskUE6vxHXoXJSZSbzuN7MEwJdFwx2C4Ls/RDlz1nlo3OiH7Lm9
         emHysgIrSyyA9Kd9doFIsQFyFTzRIS3vF6RWVjXjAO2kIw6tlvobIDH5dHaHbz8GmkOR
         7o9rm1bDTu6WaPqStqf2i40jgUqgYPrdJH7Bmtum8/vjy/Gb1NsfsyjocqsMks5KmW+6
         8WMw==
X-Gm-Message-State: AFqh2kpgyrj6K9upGpnA3aUcKKEO22fL0+MQS83aL0wAq9GlSqNJYkog
        cSmCjESQLi1xCnvHUG2DWHkYoHdQAKWRv7W5/yp/pA==
X-Google-Smtp-Source: AMrXdXuPODb5km1vVWLEOajbQIs4XSX8t9jdXpVQTtsxlKrB6VmMItgiux+DXoc2jwTxQ8qklnWstNG6QM+ZlY6ut2o=
X-Received: by 2002:a25:ca81:0:b0:7d2:891e:ee59 with SMTP id
 a123-20020a25ca81000000b007d2891eee59mr439542ybg.152.1673959553051; Tue, 17
 Jan 2023 04:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20230109174511.1740856-1-brgl@bgdev.pl> <20230109174511.1740856-3-brgl@bgdev.pl>
 <bbd21894-234e-542e-80ec-8f2bb11e268e@linaro.org> <843eed4b-552a-a529-83ed-b813c1346c5f@linaro.org>
 <CAMRc=MfTynAACwy+hB+FxOQ=-gA+307viz7LCUk8zmn4H7BaOQ@mail.gmail.com>
In-Reply-To: <CAMRc=MfTynAACwy+hB+FxOQ=-gA+307viz7LCUk8zmn4H7BaOQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 17 Jan 2023 14:45:42 +0200
Message-ID: <CAA8EJpp=w=PurE8GYBOPWmz5GnuXPo8Wyd=Xho0M_yNRciG+0w@mail.gmail.com>
Subject: Re: [PATCH 02/18] clk: qcom: add the GCC driver for sa8775p
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org, Shazad Hussain <quic_shazhuss@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 17 Jan 2023 at 14:44, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Jan 9, 2023 at 10:06 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 09/01/2023 19:58, Konrad Dybcio wrote:
> > >
> > >
> > > On 9.01.2023 18:44, Bartosz Golaszewski wrote:
> > >> From: Shazad Hussain <quic_shazhuss@quicinc.com>
> > >>
> > >> Add support for the Global Clock Controller found in the QTI SA8775P
> > >> platforms.
> > >>
> > >> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> > >> [Bartosz: made the driver ready for upstream]
> > >> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >> ---
> > > [...]
> > >
> >
> > As the driver didn't get to the list, I'll comment OOB.
> >
> > Please use clk_regmap_phy_mux_ops where applicable (PCIe PIPE clocks).
> >
>
> Looks like it's impossible for this platform as the PCIe PIPE clocks
> have two parents.

That's the point, please check the history of other platforms. XO
becomes the 'off' state rather than being a separate parent.

-- 
With best wishes
Dmitry
