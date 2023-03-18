Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC916BFB73
	for <lists+linux-pm@lfdr.de>; Sat, 18 Mar 2023 17:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCRQMh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Mar 2023 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCRQMg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Mar 2023 12:12:36 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB025BA9;
        Sat, 18 Mar 2023 09:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679155591; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QM+lJSxUzEdwuOZD80fMk+7IUEwl2WOSorvRQ8gzib10or1CojJz8zVC2Ynqy9wefO
    BM64vxq5uQj+9k6Ib1yhL4HDjifXFw9Px0mJ+v5vZ6au8rK4xoabI0A78o7bWkuAdE7U
    kCHNAweId0Sau2Z4kho+E/iUiFf6ju8FnXhau0N3K9I9AzbLDz0hyObh2aPWHZfWvdFc
    jS+nclAaDJ7HNx58+elnj+cePtwch07kGjGY2vBeRmNseFO2VjDsWToVpwMI69pBwKjV
    C3hLEWG0Ppwgmj0Hc5490QOAIWoOqB4esptALTGODfu8lHjF0XIPCONkn6LZUZtxZp2+
    oF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679155591;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+1JUVGGqwpyFbnd+/hrUkEmDpeWXDmsdFaI+rJ6DvUA=;
    b=rgBR5HFSl/IwBHcUYwgrRJHQafbP6jvdAlSEoyHaiBCdODSFHn3bAEEIHBRcy8yp2E
    ce97fFJZnnuJ6n8sfbziqleifX4Sq3oDlY6QbULu7ZYxkPmUldFTOtsidjzwt5eNXDmW
    ecfCteykNfhZz+YAThzPYwWliaUJzJVH141PqjsWEEmasnifgz49mqZDRdj0V3m8pabX
    wvPy1pPNFeGl9xaNNfTFw7xKXyJT12dZPWTDsp6reAngsjGIsqSS6RzHOy1AWVuWXbax
    FzoejhZ+n+woTsU88kUSwwaX4dfM0TDqMzpXhu1r2Y/GZHefeeZxFJ/E8VN3uxlxO9Hp
    EAnA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679155591;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+1JUVGGqwpyFbnd+/hrUkEmDpeWXDmsdFaI+rJ6DvUA=;
    b=GtsC5fJPvCMZqy/JLeJahzJtPFg9x2wIcaKxjE0Hv9xynCd7gobtsZX2BLye+jExOG
    kXefhfDwhaO56mR3MzDUvbisI0lP7HgLDI5COoyypgKk2fEnPf16FJnrzWH13pv6ByuX
    Esq4dgvVMDiImYGOcrZNJoxh+wHntse/dEDEnet9fPM7CqrM9IYAeQRCv4l5LT9fiURr
    EZaUa6MC/A83cMaMUQlYEcmm+CFRRx7W1aFrRVEVtd4bh5gjCvuHRv515Td4jpsnh+Kt
    VkWMmx6tYrYrT9UsP8SZh1prWuCQYspWb8Wu+odLGoZEFUAVb4/PrDW0qOcFXfdIF4xB
    jj9g==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKjWrKs9lg=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id i40d22z2IG6V81U
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 18 Mar 2023 17:06:31 +0100 (CET)
Date:   Sat, 18 Mar 2023 17:06:30 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/6] thermal: qcom: tsens-v0_1: Add mdm9607 correction
 offsets
Message-ID: <ZBXhhpbMHUaWXoWb@gerhold.net>
References: <20230315103950.2679317-1-stephan.gerhold@kernkonzept.com>
 <20230315103950.2679317-4-stephan.gerhold@kernkonzept.com>
 <30e4ee62-0297-0ffe-23a5-87db096a6154@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30e4ee62-0297-0ffe-23a5-87db096a6154@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 18, 2023 at 03:02:35PM +0100, Konrad Dybcio wrote:
> On 15.03.2023 11:39, Stephan Gerhold wrote:
> > According to the msm-3.18 vendor kernel from Qualcomm, mdm9607 needs
> > "correction factors" to adjust for additional offsets observed after the
> > factory calibration values in the fuses [1, 2].
> > 
> > The fixed offsets should be applied unless there is a special
> > calibration mode value that indicates that no offsets are needed [3].
> > 
> > Note that the new calibration mode values are called differently in this
> > patch compared to the vendor kernel:
> >   - TSENS_TWO_POINT_CALIB_N_WA        -> ONE_PT_CALIB2_NO_OFFSET
> >   - TSENS_TWO_POINT_CALIB_N_OFFSET_WA -> TWO_PT_CALIB_NO_OFFSET
> > This is because close inspection of the calibration function [3] reveals
> > that TSENS_TWO_POINT_CALIB_N_WA is actually a "one point" calibration
> > because the if statements skip all "point2" related code for it.
> > 
> > [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d9d2db1b82bf3f72f5de0803d55e6849eb5b671e
> > [2]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d75aef53a760e8ff7bac54049d00c8b2ee1b193e
> > [3]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/drivers/thermal/msm-tsens.c#L2987-3136
> > 
> > Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Fixes: a2149ab815fc ("thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607")
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> BTW, did you notice some crazy readouts or would this have gone
> unnoticed had you not dug in the code?
> 

I'm afraid it would likely have remained unnoticed. I think these
offsets only make a small difference but it's still good to have them
for slightly more accurate readings.

In v1 of this series I had the offsets for MSM8909 already (hardcoded
into the old calibration function with all the bit shifts/masks etc).
It was more coincidence that I checked MDM9607 for v2 because I had to
make the code more generic with the new per-sensor nvmem cells. ;)

Thanks,
Stephan
