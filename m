Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519E65E9315
	for <lists+linux-pm@lfdr.de>; Sun, 25 Sep 2022 14:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiIYM2q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Sep 2022 08:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIYM2p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Sep 2022 08:28:45 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85C131DE1;
        Sun, 25 Sep 2022 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664108922;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MMXh4VTc9xyRIFnGJgzfy6w+wQpMT4xlRlxlji+Xdao=;
    b=Y4q6GvkU2iQuKCvfXQxk/nGezlDmYqnuiJyCgJF6xSe4lesPQSnOfAf84rF31tiweS
    5i/tCXTz/7TZJMqIOFmMGkhhANhA1bCpW0SlQhik9MAMDsaNIIsVErvjDPyJZ/HZOqCH
    ceDTM2Y83yLHU0J7HuoJWqoNtAC6YmqBPK4CgpK6b+l1U7rtgcsCXMBmFCPA9lDwPIcC
    uutkVqLoI2FAwnFoKbhPfzn/9E1xgMmTq8msdYzyW27KHo7YMDFT8NyG7H4Lqb1pBvAp
    lU6L4SvO6DfD/6L9zaFvoKBiG5mSSgtPPzc4DLYq3RUQY8wSKtOh1FQmDjVybv1Hjq0D
    CvZw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK85lg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.1 AUTH)
    with ESMTPSA id dde14cy8PCSf5O9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 25 Sep 2022 14:28:41 +0200 (CEST)
Date:   Sun, 25 Sep 2022 14:28:36 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] thermal/drivers/tsens: specify nvmem cells in
 DT rather than parsing them manually
Message-ID: <YzBJdG0niOotj9K1@gerhold.net>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
 <YyyaH1ZXF9IvLpwd@gerhold.net>
 <93a790fb-20dc-0f31-2eed-09f5b538bea9@linaro.org>
 <YzArWZ1+OKvCNM7d@gerhold.net>
 <722E6DEE-BD57-4573-A151-508917961D1B@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722E6DEE-BD57-4573-A151-508917961D1B@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 25, 2022 at 02:21:11PM +0300, Dmitry Baryshkov wrote:
> On 25 September 2022 13:20:09 GMT+03:00, Stephan Gerhold <stephan@gerhold.net> wrote:
> >On Sat, Sep 24, 2022 at 09:58:56PM +0300, Dmitry Baryshkov wrote:
> >> On 22/09/2022 20:23, Stephan Gerhold wrote:
> >> > On Sat, Sep 10, 2022 at 03:46:51PM +0300, Dmitry Baryshkov wrote:
> >> > > Historically the tsens driver fetches the calibration data as a blob and
> >> > > then parses the blob on its own. This results in semi-duplicated code
> >> > > spreading over the platform-specific functions.
> >> > > 
> >> > > This patch series changes tsens calibration code to use pre-parsed nvmem
> >> > > cells rather than parsing the blob in the driver. For backwards
> >> > > compatibility the old code is left in place for msm8916 and qcs404, two
> >> > > platforms which have in-tree DT files. For msm8974 the original function
> >> > > is left intact, since it differs significantly (and I can not test the
> >> > > code on msm8974). For all other affected platforms the old parsing code
> >> > > has been dropped as a part of this RFC.
> >> > > 
> >> > > The code was tested on msm8916 and qcs404 only, thus it is being sent as
> >> > > an RFC.
> >> > > 
> >> > 
> >> > Thanks a lot for working on this!
> >> > 
> >> > After thinking about this for a while I wonder if we can go even a step
> >> > further: Can we drop SoC-specific code entirely for 8939 and 9607 and
> >> > match the generic compatible (qcom,tsens-v0_1)? This would allow most
> >> > v0.1 plaforms to use generic code like for qcom,tsens-v2.
> >> 
> >> While this idea looks appealing, I think it's a bit against our custom to
> >> put hardware details into the driver rather than putting them into the DT.
> >> So, I think, the 8939 will have to stay as is, while for the 9607 and maybe
> >> several other devices it should be possible to create a fallback entry.
> >> 
> >
> >IMHO the existing tsens-v2 support is a good example that it's sometimes
> >better to have some minor hardware details in the DT so the driver does
> >not have to be changed for every single platform. Extending from
> >specifying the number of sensors in the DT to the exact set of sensors
> >is not a very big step.
> 
> Fine, I will take a look.
> 

Thanks!

> >
> >Also, aren't you also going against the custom here by moving the fuse
> >hardware details to the DT? :)
> 
> Not quite. Fuses are completely software thing. 
> 

Good point, but this depends on the point of view: Since those fuses are
likely "burned in" at the factory I would consider them to be part of
"hardware" like everything else. Even if I wanted to I probably couldn't
change anything about the layout, at least as a user (and probably even
as a customer). :-)

> >
> >> [...]
> >> > And actually there are two revisions of 8939, the older one has one
> >> > sensor less (msm-3.10: msm8939-common.dtsi vs msm8939-v3.0.dtsi).
> >> > This could also be easily handled from the DT without any code changes:
> >> > 
> >> > 	qcom,sensors = <0 1 2 3 5 6 7 8 9>;
> >> 
> >> Usually we only care about the latest revision of the chip, earlier
> >> revisions typically correspond to engineering samples, never hitting the
> >> actual consumer devices.
> >> 
> >
> >I'm afraid we might have to care about both revisions here - I recently
> >checked a couple of MSM8939 devices in postmarketOS and there are
> >definitely two different revisions used in production - they are easily
> >identifiable since they have different CPU revisions in the "lscpu"
> >output (Cortex-A53 r0p1 vs r0p4).
> 
> Ugh. 
> 

Indeed.

Thanks,
Stephan
