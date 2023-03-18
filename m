Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4776BFB65
	for <lists+linux-pm@lfdr.de>; Sat, 18 Mar 2023 17:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCRQBF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Mar 2023 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRQBE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Mar 2023 12:01:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE91B28213;
        Sat, 18 Mar 2023 09:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679155258; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=D5m/uWvsWIYVGsuXnRxfx/byaWI0xEkpV6LE0YB97ZtepML259T4rhMteImj6l5c8u
    QmEnfWlk6n94XB//UbqHYcDfBalgywdOIR1sbH1EOrXEbUq1pfo31AjLWvun8gED9PtT
    0X3EEVheli7YYNEc/a9lfJsky+stgqfhF3BXs/PJ9znHqg6fpMCKzgt+fhuNw+mHFdoT
    NTckZypCbFu7NUQIIoHtUfQTv6aeNijAuziZRwBB2l+iBsLvYAkW6Kjz4yPY7Hn+FL1t
    AArx2DMAmd6b+q1JmNhugCxXjmi4ND6LPJZHjDvmQ7rVFV65SVljv/GeR9YTzqJ0HRtJ
    wrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679155258;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BorzDKph6yDuV2CwRHmTgXwBDb3OTpmSXaYIXiFcQgg=;
    b=qZihJS76FTxmzJ0oM0Ua4bNjsR3JQRbKAlpd1kjW0AMWNvpIDCfmh5imWh/u3TU2rZ
    CxbP+RS4Od1hw3JoOqCj2NAnz94XEMmkxKgGOXvRmc72B040jZ4oniklUVAolWpwH0hM
    SU1dR1aOLc2N/zoxQIOx6U7Te5WjntjlK5kFfcMLm+vxXraTLGXJzRMJkRcdOzXEFsKc
    q05PQ2kKF285oBw/A2cfEcoWnay+g5jU2GkQjAnM3aUmtjw4Bel3vky089FepwRpu1fX
    fn0YrBxKxYCKcWfwxEB9j/ubW67c95i/CUYIX5PHCxxC1tFJtGVxyVwDs6zznP8lW4lW
    I+rA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679155258;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BorzDKph6yDuV2CwRHmTgXwBDb3OTpmSXaYIXiFcQgg=;
    b=nTozUwD1Yw5ah92CNYNSQkmuhLirYXsDvoHHDWzVNAn3pORlPneka8es67T6gjrDnw
    M4MwDvzYKwKv4ztKTg5a+x+++jPSoxNFo7P9pLdTGmLdhtGvqUGYQqnsx2BUXnUA4YmY
    Xc+Dbwpe3fg671YhBUOsbt/TvDS2YHhWKNyduG6GwGrye/rnwCGWz1cx4DWc9p6Xd9Yn
    9i1UD72GHEeGYz0FcPifmidEsYHW5yl0xGrVvDq9Sakbi+4tIeTHumdGhDCVi2PazH+n
    q6SS0eEh4BOFw/Ou1Gfz7hm/Z369MwG02UOb+j8RpICj5RHNwnKr0zl0A4GqUVZfaAiI
    TA5A==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKjWrKs9lg=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id i40d22z2IG0v812
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 18 Mar 2023 17:00:57 +0100 (CET)
Date:   Sat, 18 Mar 2023 17:00:52 +0100
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
Subject: Re: [PATCH v3 2/6] thermal: qcom: tsens-v0_1: Fix mdm9607 slope
 values
Message-ID: <ZBXgNPg+g6TLP0Zt@gerhold.net>
References: <20230315103950.2679317-1-stephan.gerhold@kernkonzept.com>
 <20230315103950.2679317-3-stephan.gerhold@kernkonzept.com>
 <ad64143c-13c0-63e3-561a-620c44f26b9d@linaro.org>
 <ZBSCN0f8yC/nkGll@gerhold.net>
 <2fd76707-9cf5-dbac-3514-89395a4225c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd76707-9cf5-dbac-3514-89395a4225c2@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 17, 2023 at 06:37:16PM +0100, Konrad Dybcio wrote:
> On 17.03.2023 16:07, Stephan Gerhold wrote:
> > On Fri, Mar 17, 2023 at 01:39:25AM +0100, Konrad Dybcio wrote:
> >> On 15.03.2023 11:39, Stephan Gerhold wrote:
> >>> According to the msm-3.18 vendor kernel from Qualcomm [1], mdm9607 uses
> >>> a non-standard slope value of 3000 (instead of 3200) for all sensors.
> >>> Fill it properly similar to the 8939 code added recently.
> >>>
> >>> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/arch/arm/boot/dts/qcom/mdm9607.dtsi#L875
> >>>
> >> FWIW there's a 4.9 release for 9607
> >>
> >> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.2.3.6.c5-03900-9x07/arch/arm/boot/dts/qcom/mdm9607.dtsi
> > 
> > You seem to have linked 3.18 too?
> > 
> > I don't see tsens support for mdm9607 in msm-4.9, although maybe I'm
> > looking at the wrong branch. :D
> Yeah wrong link
> 
> and wrong kernel, it's actually 4.14
> 
> https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/637e99f66c270385149d1f0041758c24c4f84aaf/arch/arm64/boot/dts/qcom/mdm9607.dtsi
> 

Nice, I didn't know there is mdm9607 in msm-4.14. :)

Nevertheless I think msm-3.18 is a better reference for the tsens code.
In 4.9+ Qualcomm originally removed support for tsens v0.1. When porting
the older targets it seems to have been hacked back in with very little
thought. Note how it's called tsens 14xx there instead of v0.1, just
with different register offsets. Personally I wouldn't trust what they
did there, especially because most mdm9607 devices in the wild use 3.18.

Thanks,
Stephan
