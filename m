Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF85A66DDE9
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 13:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbjAQMo3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 07:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbjAQMo1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 07:44:27 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6A636FE9
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 04:44:24 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id d66so19596728vsd.9
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 04:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zb5Tffie3pKgu7Pq9EaJZQMrKrZX87HByUGIdfaPiXU=;
        b=EOqh9vgF7LnKfYFX11HFchok8Ae1u/26sj7dus4KD2RWFXfYayHqXF8VO8jT/RmVRk
         HYFhGfh+6MdHD/itigrkDCbBknY+fNhnignJoOp6If7O90qOuoVmMmV/bZ5FQ5coS32m
         yYs9vJmQMWLZM1KqJSSKFIHh6X9qwKy/mxuzBEKdbmv9YXeD9CNN8/Gbgp8pCRdEVTi3
         VAZ/DSrPCbtPh0MWMQifOhCgBhm1J7mOWH+hg0LDh/pg3kcP3TtsE3XvKJvY9uFCmPix
         9azcjpSOhRz7ukQtann+ENJf5EQIb8mqf0rMOyR+Cq6dMjTWf5fVnvvgVQHM+b3xdKxp
         LH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zb5Tffie3pKgu7Pq9EaJZQMrKrZX87HByUGIdfaPiXU=;
        b=AcfL90477nA/Lxwrqe7UERRnksyq6ZUWBp6B2eciXx3jsWTrnoP8JGdTExu0R4d+hb
         IUrkOJy5DQo9JMh/u/rYB7rPy6Jg+Bp8w/4PYHx8HMKJxfMRf4RhTw8nvaiiO5kPitQf
         ccTvQkFpVw4NKkOKrdMszZkkyx0ySU/u27fUswt2a6Uc5BsBFzHC7er5IkLf9hCEynCx
         lt8BdPWr2aYcy9DmBDUMDq1AamZEbuLrqbkhn4i8vZt0yKCARA51E64Ev8ulGeFvV7ko
         WTVONjRIsqLMfpKkEhdjIwRsj/T7aNP6v0WvfwPhIbluJ0V4PXTcRyiLCnPY8dc/ujRH
         7WoQ==
X-Gm-Message-State: AFqh2krTH3C3WnaWm+hdy+RN/wdWdtF2RWXFizb1UtRWCpF/RGdaonO3
        za7L7sG9kMQJ48d5TOfnvzXnKv/iv7rCqcz8UQWlfg==
X-Google-Smtp-Source: AMrXdXuiYMsRUH99cR/6JzARKg2uSTda58F6pQigrwwH/EVEnADISBrDDLRNg95x8ypLViV89a3Pkk8FPSZi57WIjdw=
X-Received: by 2002:a67:f2da:0:b0:3d3:d90c:5ef2 with SMTP id
 a26-20020a67f2da000000b003d3d90c5ef2mr450965vsn.17.1673959464106; Tue, 17 Jan
 2023 04:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20230109174511.1740856-1-brgl@bgdev.pl> <20230109174511.1740856-3-brgl@bgdev.pl>
 <bbd21894-234e-542e-80ec-8f2bb11e268e@linaro.org> <843eed4b-552a-a529-83ed-b813c1346c5f@linaro.org>
In-Reply-To: <843eed4b-552a-a529-83ed-b813c1346c5f@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 17 Jan 2023 13:44:13 +0100
Message-ID: <CAMRc=MfTynAACwy+hB+FxOQ=-gA+307viz7LCUk8zmn4H7BaOQ@mail.gmail.com>
Subject: Re: [PATCH 02/18] clk: qcom: add the GCC driver for sa8775p
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 9, 2023 at 10:06 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 09/01/2023 19:58, Konrad Dybcio wrote:
> >
> >
> > On 9.01.2023 18:44, Bartosz Golaszewski wrote:
> >> From: Shazad Hussain <quic_shazhuss@quicinc.com>
> >>
> >> Add support for the Global Clock Controller found in the QTI SA8775P
> >> platforms.
> >>
> >> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> >> [Bartosz: made the driver ready for upstream]
> >> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >> ---
> > [...]
> >
>
> As the driver didn't get to the list, I'll comment OOB.
>
> Please use clk_regmap_phy_mux_ops where applicable (PCIe PIPE clocks).
>

Looks like it's impossible for this platform as the PCIe PIPE clocks
have two parents.

Bart
