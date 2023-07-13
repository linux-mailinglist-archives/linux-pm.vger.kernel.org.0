Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45941751859
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 07:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjGMFxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 01:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjGMFxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 01:53:50 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606FE1BF0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 22:53:49 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a3b7fafd61so339919b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689227628; x=1691819628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G9WcmhiPaDbhClEKCeWjVz4d9o3HB8tMobRvLpjiDVg=;
        b=B5YypG0ak4I6Rre7Vqs3E1Pr4Ekj9PUrVbecN4P8RA4VkXvK7AVN4d7Bl0r0LXBkrC
         7UFLElNs0AxAziZt7hH98hh3DZM2pLvypWlCwmD16dwYLHM49KNGaFVGQ6+fM/OY2Uk0
         TP57kZ+3OhRvgZPry5T13l9pRaPdOA47Hbmp7yzhc2pwDixLqJJSeAXwolDl7LCO3R/L
         JWXN0kgKaL3+aFNity2FUAGMpq7aV7lN8QzH5F7IKTHpO1jBgCpQrjfQxDidf1rCTQqH
         YPtM7osnmbwykT0fnqqXaq/IkR3z8G0cJYW0hPoB50TcCAZTe6nsbhvOaHiojkxZRfp4
         N+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689227628; x=1691819628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9WcmhiPaDbhClEKCeWjVz4d9o3HB8tMobRvLpjiDVg=;
        b=doEe+04nuQAIVeaxndwJu7eOueg2IBoWOdFBMnqJ8Kao9xtE/VSTBOOnhmNSPCzR6o
         rhJxToZ/YdHNUSk2kcdx1AY7kzvVS7Fj2RZwO90Qig8zm9JiFcV76di/xL51qamqvv/Q
         45FptqQGarOTA9Y5u0E0mCWe+Tymkx6UJq69tKFEAKLqeRpttlgUmfv8kiCWqFWkg3gA
         QRacuGZBSip0eN74d8073g4r38yvVFSsxW83mngbJyThk15IrBE16872Izbs+Vrh7brq
         5/d/n54C6HOfSKRk/2fv3c8FU9N8lfMIwRG6vNiQyRZwtiULh+ALn69ljsZbddrTXvqj
         Vx5w==
X-Gm-Message-State: ABy/qLYnpcPXUKAJL+Sc3nUn9pvbzx+7QHIRE67RCScIc5Rp93j+T10D
        uV8ve9TtJ1sh/Rw/XF4tkffb
X-Google-Smtp-Source: APBJJlEtSDOcLFFSsaVra3MhJEI2q1v/jqoFG4/1vf56Y3Q/69961njV+QB/qijFLB5voGRWjtEFWg==
X-Received: by 2002:a05:6808:1153:b0:3a0:3a17:a146 with SMTP id u19-20020a056808115300b003a03a17a146mr839218oiu.57.1689227628648;
        Wed, 12 Jul 2023 22:53:48 -0700 (PDT)
Received: from thinkpad ([117.207.27.112])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78c02000000b00673e652985bsm4552692pfd.118.2023.07.12.22.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:53:48 -0700 (PDT)
Date:   Thu, 13 Jul 2023 11:23:29 +0530
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
Message-ID: <20230713055329.GF3047@thinkpad>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-14-manivannan.sadhasivam@linaro.org>
 <e6a5129a-db07-977d-2ecd-328a52cbcdc0@linaro.org>
 <20230712163406.GG102757@thinkpad>
 <CAA8EJpovHr1qxepVprk6UvnhKe+nu4VuziyKKgjV3UzommFz6g@mail.gmail.com>
 <20230713040918.jnf5oqiwymrdnrmq@vireshk-i7>
 <20230713050550.GB3047@thinkpad>
 <20230713051235.ob5z3li3lz52xtzm@vireshk-i7>
 <20230713052843.GE3047@thinkpad>
 <20230713054302.tu6fgd3meb5krsx5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713054302.tu6fgd3meb5krsx5@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 13, 2023 at 11:13:02AM +0530, Viresh Kumar wrote:
> Okay, sorry about missing one point first. I thought we are adding the
> clk config callback (which neglects 0 frequencies) to a Qcom only
> driver and so was okay-ish with that. But now that I realize that this
> is a generic driver instead (my mistake here), I wonder if it is the
> right thing to do anymore.
> 

That's the pre-opp behavior as well. Reason is, most of the platforms have only
gate clocks supplied to the ufs controller and cannot change the frequency. Only
Qcom requires changing the frequency of _some_ clocks, so that's why we have to
use this hack of skipping 0 freq clocks.

> On 13-07-23, 10:58, Manivannan Sadhasivam wrote:
> > On Thu, Jul 13, 2023 at 10:42:35AM +0530, Viresh Kumar wrote:
> > > On 13-07-23, 10:35, Manivannan Sadhasivam wrote:
> > > > We can settle with this custom callback for now. If there are drivers in the
> > > > future trying to do the same (skipping 0 freq) then we can generalize.
> > > 
> > > Just for completeness, there isn't much to generalize here apart from
> > > changing the DT order of clocks. Isn't it ?
> > > 
> > 
> > Even with changing the order, driver has to know the "interesting" clocks
> > beforehand. But that varies between platforms (this is a generic driver for
> > ufshc platforms).
> > 
> > And I do not know if clocks have any dependency between them, atleast not in
> > Qcom platforms. But not sure about others.
> 
> Maybe this requires some sort of callback, per-platform, which gets
> you these details or the struct dev_pm_opp_config itself (so platforms
> can choose the callback too, in case order is important).
> 

Yeah but that seems overkill since the current config_clks helper satisfies the
requirement.

- Mani

> > > The change require for the OPP core makes sense, I will probably just
> > > push it anyway.
> 
> I tried to look at this code and I think it is doing the right thing
> currently, i.e. it matches clk-count with the number of frequencies in
> opp-hz, which should turn out to be the same in your case. So nothing
> to change here I guess.
> 
> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
