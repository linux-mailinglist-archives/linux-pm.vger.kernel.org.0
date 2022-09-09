Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19F5B39D2
	for <lists+linux-pm@lfdr.de>; Fri,  9 Sep 2022 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiIINv5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Sep 2022 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiIINvc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2022 09:51:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA5913B56D;
        Fri,  9 Sep 2022 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1662731474;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=UD8xj2GgIEFl4VXZp7ETMEeFcjVOvCtWUOQysiCTK6Y=;
    b=rkummCjPAPXp9jwZbVbzcItkdQ7IDXjdFftZ9MQ+QQ/k4MxkZbhvuUYmM1h17pPFwk
    +yjTiSZQCW7balDyWxt6C0OralCFtb3dIgAmpAkNZljzA+7CeqBHCmiTMsLhup3dfkrC
    E5puPRRP0+kGs3kwE9YcBO8WTDe2pR2FW1r9VScglhU/k5dKJwZnMjhQ5T9R0Ev0Mp6W
    RiX0vo4Yzup9uGUl0x5LrvzMphLE3HDszeXdD5S86yhE2ZdAJq7COJUX3Hl5+rYxbnED
    DCDAY4gPcVnmaPRzqjoM5+MQ6dS176sZWBZNP3gqLPEcUq1MvCk/t52whc3DpE2A0R+y
    Ho8Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrK09lg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.0.2 AUTH)
    with ESMTPSA id I8c97dy89DpECc3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 9 Sep 2022 15:51:14 +0200 (CEST)
Date:   Fri, 9 Sep 2022 15:51:08 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: qcom: tsens: Add data for MSM8909
Message-ID: <YxtEtDLVEAGP8sGE@gerhold.net>
References: <20220627131415.2868938-1-stephan.gerhold@kernkonzept.com>
 <20220627131415.2868938-4-stephan.gerhold@kernkonzept.com>
 <e5c7b34e-2a1a-840a-7f3f-652d8027fa4d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c7b34e-2a1a-840a-7f3f-652d8027fa4d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 08, 2022 at 11:57:41PM +0300, Dmitry Baryshkov wrote:
> On 27/06/2022 16:14, Stephan Gerhold wrote:
> > The MSM8909 SoC has 5 thermal sensors in a TSENS v0.1 block similar to
> > MSM8916, except that the bit offsets in the qfprom were changed.
> > Also, some fixed correction factors are needed as workaround because the
> > factory calibration apparently was not reliable enough.
> > 
> > Add the defines and calibration function for MSM8909 in the existing
> > tsens-v0_1.c driver to make the thermal sensors work on MSM8909.
> > The changes are derived from the original msm-3.18 kernel [1] from
> > Qualcomm but cleaned up and adapted to the driver in mainline.
> > 
> > [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.UM.7.7.c26-08600-8x09.0/drivers/thermal/msm-tsens.c
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> >   drivers/thermal/qcom/tsens-v0_1.c | 119 +++++++++++++++++++++++++++++-
> >   drivers/thermal/qcom/tsens.c      |   3 +
> >   drivers/thermal/qcom/tsens.h      |   2 +-
> >   3 files changed, 122 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> > index f136cb350238..e17c4f9d9aa5 100644
> > --- a/drivers/thermal/qcom/tsens-v0_1.c
> > +++ b/drivers/thermal/qcom/tsens-v0_1.c
> > @@ -15,6 +15,48 @@
> >   #define TM_Sn_STATUS_OFF			0x0030
> >   #define TM_TRDY_OFF				0x005c
> > +/* eeprom layout data for 8909 */
> > +#define MSM8909_CAL_SEL_MASK	0x00070000
> > +#define MSM8909_CAL_SEL_SHIFT	16
> > +
> > +#define MSM8909_BASE0_MASK	0x000000ff
> > +#define MSM8909_BASE1_MASK	0x0000ff00
> > +#define MSM8909_BASE0_SHIFT	0
> > +#define MSM8909_BASE1_SHIFT	8
> > +
> > +#define MSM8909_S0_P1_MASK	0x0000003f
> > +#define MSM8909_S1_P1_MASK	0x0003f000
> > +#define MSM8909_S2_P1_MASK	0x3f000000
> > +#define MSM8909_S3_P1_MASK	0x000003f0
> > +#define MSM8909_S4_P1_MASK	0x003f0000
> > +
> > +#define MSM8909_S0_P2_MASK	0x00000fc0
> > +#define MSM8909_S1_P2_MASK	0x00fc0000
> > +#define MSM8909_S2_P2_MASK_0_1	0xc0000000
> > +#define MSM8909_S2_P2_MASK_2_5	0x0000000f
> > +#define MSM8909_S3_P2_MASK	0x0000fc00
> > +#define MSM8909_S4_P2_MASK	0x0fc00000
> > +
> > +#define MSM8909_S0_P1_SHIFT	0
> > +#define MSM8909_S1_P1_SHIFT	12
> > +#define MSM8909_S2_P1_SHIFT	24
> > +#define MSM8909_S3_P1_SHIFT	4
> > +#define MSM8909_S4_P1_SHIFT	16
> > +
> > +#define MSM8909_S0_P2_SHIFT	6
> > +#define MSM8909_S1_P2_SHIFT	18
> > +#define MSM8909_S2_P2_SHIFT_0_1	30
> > +#define MSM8909_S2_P2_SHIFT_2_5	2
> > +#define MSM8909_S3_P2_SHIFT	10
> > +#define MSM8909_S4_P2_SHIFT	22
> > +
> > +#define MSM8909_D30_WA_S1	10
> > +#define MSM8909_D30_WA_S3	9
> > +#define MSM8909_D30_WA_S4	8
> > +#define MSM8909_D120_WA_S1	6
> > +#define MSM8909_D120_WA_S3	9
> > +#define MSM8909_D120_WA_S4	10
> > +
> >   /* eeprom layout data for 8916 */
> >   #define MSM8916_BASE0_MASK	0x0000007f
> >   #define MSM8916_BASE1_MASK	0xfe000000
> > @@ -223,6 +265,68 @@
> >   #define MDM9607_CAL_SEL_MASK	0x00700000
> >   #define MDM9607_CAL_SEL_SHIFT	20
> > +static int calibrate_8909(struct tsens_priv *priv)
> > +{
> > +	u32 *qfprom_cdata, *qfprom_csel;
> > +	int base0, base1, mode, i;
> > +	u32 p1[5], p2[5];
> > +
> > +	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> > +	if (IS_ERR(qfprom_cdata))
> > +		return PTR_ERR(qfprom_cdata);
> > +
> > +	qfprom_csel = (u32 *)qfprom_read(priv->dev, "calib_sel");
> > +	if (IS_ERR(qfprom_csel)) {
> > +		kfree(qfprom_cdata);
> > +		return PTR_ERR(qfprom_csel);
> > +	}
> > +
> > +	mode = (qfprom_csel[0] & MSM8909_CAL_SEL_MASK) >> MSM8909_CAL_SEL_SHIFT;
> > +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> > +
> > +	switch (mode) {
> > +	case TWO_PT_CALIB:
> > +		base1 = (qfprom_csel[0] & MSM8909_BASE1_MASK) >> MSM8909_BASE1_SHIFT;
> > +		p2[0] = (qfprom_cdata[0] & MSM8909_S0_P2_MASK) >> MSM8909_S0_P2_SHIFT;
> > +		p2[1] = (qfprom_cdata[0] & MSM8909_S1_P2_MASK) >> MSM8909_S1_P2_SHIFT;
> > +		p2[2] = (qfprom_cdata[0] & MSM8909_S2_P2_MASK_0_1) >> MSM8909_S2_P2_SHIFT_0_1;
> > +		p2[2] |= (qfprom_cdata[1] & MSM8909_S2_P2_MASK_2_5) << MSM8909_S2_P2_SHIFT_2_5;
> > +		p2[3] = (qfprom_cdata[1] & MSM8909_S3_P2_MASK) >> MSM8909_S3_P2_SHIFT;
> > +		p2[4] = (qfprom_cdata[1] & MSM8909_S4_P2_MASK) >> MSM8909_S4_P2_SHIFT;
> 
> Please use nvmem_cell_read_* to read these values. This would allow you to
> push all the possible si_pi definitions into the DT and use mode to switch
> between them. And mode can be read using the nvmem_cell_read_* too.

Thanks for the suggestion.

I agree that this would have been nicer if this had been implemented
that way for all the existing platforms supported by the tsens driver.
But now we already have 7+ platforms using exactly the approach I'm
using in this patch, with existing bindings and existing device trees
that must stay supported.

My msm8909.dtsi is actually mostly just a simple overlay on top of
msm8916.dtsi, so I would like to keep these platforms consistent
wherever possible. We could change all the existing platforms as well
but in my opinion this would just make the driver and bindings a lot
more complicated because the old approach still must be supported.

Also, I think the main benefit of having all the points as separate
NVMEM cells would be to allow having a generic qcom,tsens-v0.1
compatible, without SoC-specific code required in the driver. However,
subtle differences in the way the calibration points are used (e.g. the
fixed correction offsets in this patch) will likely make SoC-specific
code necessary anyway. And then it doesn't matter much if the bit masks
are in the driver like all existing code or end up being put into the DT.

TL;DR: I would prefer to keep this as-is to keep the driver simple and
consistent across all the supported platforms.

Thanks,
Stephan
