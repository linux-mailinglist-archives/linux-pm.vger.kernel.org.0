Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F004F751824
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 07:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjGMF3u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 01:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjGMF3s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 01:29:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC02686
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 22:29:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-cab61f812efso262528276.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 22:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689226140; x=1691818140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6NsLfF6Fujd9XILLYMbgVodQt+Dx/UesYM1x/fURW9E=;
        b=JE8YBwi/Vb1fvQmSlM49rsLmJY5mJbRLi2MuTY5HMXfns7bJ/30EK4wMKwpQrlwicl
         ahbAbozKz2RH1lKL7/b4xUh0UhJt2nRX7CKoH4eXDuLD4okNEUq7a5C2tZeCgqL43pzg
         PGy4bZMK9dVK0G8eI6Qf4F/VslhJ9G9BxbKiQ4f08J4BuIhlJ58M/FmoiETBONQitJe4
         iiHwKgyUj4ktiJ7S6nJzK5Glqxq8r3Q17XSX+vTx0hwdS3IleOKjMj5yYwlGAhNlULDK
         0TaA4+OLUdK/+2gvG0mdNiajk9ZV5+M6VxH7rVyOeIJzFnRS0BunD6QtBNGtl0gxZq1V
         bKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689226140; x=1691818140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NsLfF6Fujd9XILLYMbgVodQt+Dx/UesYM1x/fURW9E=;
        b=fWQSFXTsfEEKE6hbusWwf33CopPb3zleAaEuEbqBEs7cYQeOpGCioGOHU1IKkVjGtV
         bVucl2EhsgG3VcEb3T9gpAHRfwo/O7SvS9COBGP5cy7qF1XUp5a8/rv8RDPlcfiMJtCw
         476OoX91WM8KckPIgAwDjU0RsD4tDQYbpLYkzxBfJlE98huIx87uh2U6o7PuifZ7V7n1
         +I0w8X/la7u4zeELqt4KDJ+8hP+DtVRaF//7gkV5GrLmciKYO0XWkg6UobRXKo0WYV++
         NuDauehvsRjhoORyxdTQXh9hCqhMVqELi+Ov9VJV2Pl5lsLsekvyZX+6+DsuxBzPjU+L
         wF2A==
X-Gm-Message-State: ABy/qLZv3iyoqj1UtblggAM7dmaRSyTNeUIzDvnGUqP6i9fFLrOXMZCC
        yW9M/xs2myFwdemfL7Mblt26
X-Google-Smtp-Source: APBJJlF5xL9Pu8KTC+WYWfzUmFpYSbM/IIyFYz68lWH9Fp+ePaq8nhmoIMcdHPbeIhb74rX/xN/w/Q==
X-Received: by 2002:a25:b55:0:b0:c5d:f2af:5a24 with SMTP id 82-20020a250b55000000b00c5df2af5a24mr550636ybl.14.1689226140527;
        Wed, 12 Jul 2023 22:29:00 -0700 (PDT)
Received: from thinkpad ([117.207.27.112])
        by smtp.gmail.com with ESMTPSA id 18-20020aa79112000000b0065016fffc81sm4466025pfh.216.2023.07.12.22.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:29:00 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:58:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, vireshk@kernel.org,
        nm@ti.com, sboyd@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 11/14] scsi: ufs: host: Add support for parsing OPP
Message-ID: <20230713052843.GE3047@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
 <e6a5129a-db07-977d-2ecd-328a52cbcdc0@linaro.org>
 <20230712163406.GG102757@thinkpad>
 <CAA8EJpovHr1qxepVprk6UvnhKe+nu4VuziyKKgjV3UzommFz6g@mail.gmail.com>
 <20230713040918.jnf5oqiwymrdnrmq@vireshk-i7>
 <20230713050550.GB3047@thinkpad>
 <20230713051235.ob5z3li3lz52xtzm@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713051235.ob5z3li3lz52xtzm@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 13, 2023 at 10:42:35AM +0530, Viresh Kumar wrote:
> On 13-07-23, 10:35, Manivannan Sadhasivam wrote:
> > We can settle with this custom callback for now. If there are drivers in the
> > future trying to do the same (skipping 0 freq) then we can generalize.
> 
> Just for completeness, there isn't much to generalize here apart from
> changing the DT order of clocks. Isn't it ?
> 

Even with changing the order, driver has to know the "interesting" clocks
beforehand. But that varies between platforms (this is a generic driver for
ufshc platforms).

And I do not know if clocks have any dependency between them, atleast not in
Qcom platforms. But not sure about others.

- Mani

> The change require for the OPP core makes sense, I will probably just
> push it anyway.
> 
> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
