Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA854F6C49
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiDFVN6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 17:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbiDFVNA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 17:13:00 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8151BB804
        for <linux-pm@vger.kernel.org>; Wed,  6 Apr 2022 12:57:42 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kd21so3158026qvb.6
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2022 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUZUtAp0dNwDr70/3lwG/QXaTgnWDHbJ/WL9ZfSGWRk=;
        b=QbEWGQvz8QdfpaSSWzt2ahUaFClQusByq1H7eAXIihyrMv69CUSc0Obwe9mDIEr+oq
         NVWT1dMj8rWahYjX3IMWk05Ru6cZtKqAjPdMbDTslI8oP6q38LzSn9KvbFLG82O0eNLk
         nz3dUf6pE/rhl9TEzuuT5wZJiYKG1jTyA8zUQMMPF8d5hExV6C24zDjKWnELb7k4bqMo
         DQGpCIhtv25SC5mskEG2mecROEJIZo4OJZIlx09IKRBVlYVeXc0BT4p4NA8jU/npMJxs
         Kd9v1vP26RIrHpzdWT89Mj8lmCH62Y+loDYx6ml3LCJFpfxLaYcMX2ww4Z5yBdrkl+mE
         Dxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUZUtAp0dNwDr70/3lwG/QXaTgnWDHbJ/WL9ZfSGWRk=;
        b=CIFifLVqGyMipOjpUgCcdaCEPFawkvx3pB9rxMIRadQYQYdLMrWGDZqHjtXZRjopXH
         Hm/vjP975RAtvUcTVKQejTVdqebrjXkeaXctBxs2arJftn5vTKphtL6U/9rU9ndODOlf
         wO+q0SdmsMfTsAq3S5TkQRd0v/rE30QFGQd0BbqFK5KdEv/u9YvqaT99yvZhCWgq2tu2
         ltV94VEt8oY2dwhj3P9buDIb9S4IzJyscO9WhR0xR6Cdksbf/E3B0YVDw73BbBfcJsgL
         nJR7zeg7KFhRsrpiyZX1uXWsH6tiwn4awgRqsM8+VEtQixfqlJ1/CtcKuDNkhy3Wji1T
         DkQQ==
X-Gm-Message-State: AOAM53252ttabZMyXcuwMNOBvD65bF3qNCagKIL7Vh6OtMtTZPELCwN5
        SK/GrZh9zxcVEE66wMqbbvlou3c0RuzhXaRIgl3+Zw==
X-Google-Smtp-Source: ABdhPJwW5Y59IRMz9jgyY9HfpNawpulXkvT7vk6Ukk08ydzcarQ2XkfE97k98h2L3Ubtj03m63GiXZksPtvgTMY9kOk=
X-Received: by 2002:a05:6214:20e4:b0:441:7bed:5ccd with SMTP id
 4-20020a05621420e400b004417bed5ccdmr8928927qvk.119.1649275061386; Wed, 06 Apr
 2022 12:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220406002648.393486-1-dmitry.baryshkov@linaro.org> <20220406154028.EC897C385A3@smtp.kernel.org>
In-Reply-To: <20220406154028.EC897C385A3@smtp.kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Apr 2022 22:57:30 +0300
Message-ID: <CAA8EJpod2cNOYr3g+DmdWo_2Ujv7-pW39fBKqcpCPvtVgP5-NQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] arm: qcom: qcom-apq8064: add separate device node
 for tsens
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 6 Apr 2022 at 18:40, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Dmitry Baryshkov (2022-04-05 17:26:44)
> > Currently gcc-msm8960 driver manually creates tsens device. Instantiate
> > the device using DT node instead. This follow the IPQ8064 device tree
> > schema.
>
> Why can't the schema be changed?

But these commits change the schema. They make apq8064 follow more
logical scheme of ipq8064.


-- 
With best wishes
Dmitry
