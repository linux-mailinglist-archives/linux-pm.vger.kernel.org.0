Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F975751734
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 06:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjGMEJ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 00:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjGMEJf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 00:09:35 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE72D2737
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 21:09:22 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b06ea7e7beso244569fac.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 21:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689221361; x=1691813361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6C1hFH1e1r14+LlLoW2U5T6jLyfkGUaKnsim50K84rk=;
        b=MHk1ZLmI+NLEzwdzzXFJ2jjDX0NfoPhZMypbHUVS5rPsQUoutqeC37UymQQ2KZVbvw
         y2FtVRnCNBZs0xLnERTZMH4wcoW9RnQv6EJ6TKI6g3bmoxZw6MuMKg7K0y6PPBNloVJI
         KsDVSpgVpErLhM1X1m1JHigX65HcwWsMPBTGZG4AoRK6E15HwzyPfMIZbiflH0OZS4md
         C0HHVu63WL2fwlqCv6wvAe69E3kVdpvwmvpeZ8v9A1oDy569bACXor3gBJgekbT+evjF
         9qlEliA415d2cixtzugl6FUOQeQxXrVUfDzxEkF+1LzD+YTQx/QS5oU5O488h+QhdzwR
         SObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689221361; x=1691813361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C1hFH1e1r14+LlLoW2U5T6jLyfkGUaKnsim50K84rk=;
        b=WJ9/3Bv9N1gz9v5btGrojYWmAkInhgfNGTNlVnFkp+YlXYNMu3CeYi/j1FoIv9bqpx
         PYH4PBOlWzSmJhKLAT1wYOknJigp+qDaJTrcrd8asuDAxjGKXqM4PdGohQeZJ7+3t8ma
         0srFK/9TRV2Vfw7WPQstChA962XUBN/PQGVsPDDHQU1Ry/GNm86UklyzSspAywcn8zpZ
         uOJUh3WzxI5RM0NC/fX9QJQKR/DNoSyRjGUVTD6Dzm/krBN7a+wVhroNlOd4akMGFw25
         v91rZzkD+Qv25eNvYYZus09spJJ0B3wjhFKHmnMfHoGN7Z03RiwFD1STS4IhfdCTiyv/
         BzgA==
X-Gm-Message-State: ABy/qLZ2mVE1ED7k7oAOOyuwr+bBKwenDIkXx4QMfj/jH5oYQhGNiux0
        oqJTsRrbCDx9Tv1R+uQZHI22qA==
X-Google-Smtp-Source: APBJJlHltuR/N+6Ns0BpUwIbzkwv42caxHmZintv/YBkjLmokXkXL5Q/QOp+ih2yXtk7i+F4MR8pIg==
X-Received: by 2002:a05:6870:1fc8:b0:1b0:89e0:114f with SMTP id gp8-20020a0568701fc800b001b089e0114fmr713337oac.31.1689221361112;
        Wed, 12 Jul 2023 21:09:21 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090ac28c00b00262ff206931sm10788288pjt.42.2023.07.12.21.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:09:20 -0700 (PDT)
Date:   Thu, 13 Jul 2023 09:39:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 11/14] scsi: ufs: host: Add support for parsing OPP
Message-ID: <20230713040918.jnf5oqiwymrdnrmq@vireshk-i7>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
 <e6a5129a-db07-977d-2ecd-328a52cbcdc0@linaro.org>
 <20230712163406.GG102757@thinkpad>
 <CAA8EJpovHr1qxepVprk6UvnhKe+nu4VuziyKKgjV3UzommFz6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpovHr1qxepVprk6UvnhKe+nu4VuziyKKgjV3UzommFz6g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-07-23, 19:48, Dmitry Baryshkov wrote:
> On Wed, 12 Jul 2023 at 19:34, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > On Wed, Jul 12, 2023 at 04:15:12PM +0300, Dmitry Baryshkov wrote:
> > > On 12/07/2023 13:32, Manivannan Sadhasivam wrote:

> > > > +static int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
> > > > +                             struct dev_pm_opp *opp, void *data,
> > > > +                             bool scaling_down)
> > > > +{
> > > > +   struct ufs_hba *hba = dev_get_drvdata(dev);
> > > > +   struct list_head *head = &hba->clk_list_head;
> > > > +   struct ufs_clk_info *clki;
> > > > +   unsigned long freq;
> > > > +   u8 idx = 0;
> > > > +   int ret;
> > > > +
> > > > +   list_for_each_entry(clki, head, list) {
> > > > +           if (!IS_ERR_OR_NULL(clki->clk)) {
> > > > +                   freq = dev_pm_opp_get_freq_indexed(opp, idx++);
> > > > +
> > > > +                   /* Do not set rate for clocks having frequency as 0 */
> > > > +                   if (!freq)
> > > > +                           continue;
> > >
> > > Can we omit these clocks from the opp table? I don't think they serve any
> > > purpose.
> > >
> >
> > No, we cannot. OPP requires the clocks and opp-hz to be of same length.

I am okay with having a patch for the OPP core to modify this
behavior, as I told privately earlier.

> > And we
> > cannot omit those clocks as well since linux needs to gate control them.
> 
> Hmm, I thought we push the list of "interesting" clocks through
> config->clock_names.

Yes, another way to solve this would be keep the interesting clocks in
the beginning in "clock-names" field and let the platform pass only
those to the OPP core.

> >
> > > Maybe it would even make sense to move this function to drivers/opp then, as
> > > it will be generic enough.
> > >
> >
> > There is already a generic function available in OPP core. But we cannot use it
> > as we need to skip setting 0 freq and that's not applicable in OPP core as
> > discussed with Viresh offline.
> 
> Ack.

I am okay with either of the solutions, it is for you guys to decide
what works better for your platform.

-- 
viresh
