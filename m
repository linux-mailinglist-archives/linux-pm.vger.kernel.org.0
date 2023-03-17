Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B83E6BEC94
	for <lists+linux-pm@lfdr.de>; Fri, 17 Mar 2023 16:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCQPLw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Mar 2023 11:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjCQPLt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2023 11:11:49 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D2E2BF15;
        Fri, 17 Mar 2023 08:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679065663; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OCcXsHRmuKa+sLox4/7AGham5SQey/UeFaoYscgjSu6eu5KEgdFVdKwHuS7T8Ej7EY
    6KYn2wn0Co+QYqODO/bPPxfR5Mbnkw8ccbzqcyDWdFvvGqUwt3RENbnQ/2+k93lPoT0f
    BOX2ELAJPpWahS/E4/rOWaWz6XzpRhEQjpPdgzUF2VKV7wi++WMqgHKVmDiOeEOTPggm
    kVWpciGB2RSSvEuDYUnOgw/geMEVwVdJf1lRdoHsU+xw6V43EATYcPsuc5iJpCaXOMDc
    xsAMK6VwGRpKqzVJHgJkUbXtr/dM11kM49XHFrHzXkkbvnG4ffl22G0JNtDDmVAAjPe0
    S97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679065663;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Bg5tiTHnWuEjrwbVFU8mQBT11uFxh9IrkXhotJWkwPc=;
    b=SUCqMdI8YXw3fOFvzbWWL3NnLeOA+QN5gVBPNqIZhX92/VWtbxP1W8Q6s0kPItogjk
    9waSbag0WByRLMGPZ14ygAMBOzcyeSnFkYQq8cJY02gYBez8ZTpGLDdueiRj24dGHKO6
    CXXMio8UIjQcsa6KFjibABDUNEIg5QJMSyNVt/Q0KqJ3d8adzkJDyra8fulywavR93kg
    KvV2r36Br5g0LQ8ftqh+TRAgmjhHB4zxKiRrHcDBuvjwIhmbJZ22p/5U96x0mkG9en8j
    cHzOEbNobPzcGwqhv6svaU3obWT5DdOSeYzZn7jfsPpUNgrrIFfs3UkGaD8q+qpeQoGQ
    gbDw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679065663;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Bg5tiTHnWuEjrwbVFU8mQBT11uFxh9IrkXhotJWkwPc=;
    b=hSscblhuTM1MBH8nTgtq7kHm0NXaS5Rk0U52kVXIQEOdNhs/5IgxSi2+Rg6eBUX3Zl
    7Md70Z/ZR5k1gEzAjCpHlo0NyCSKX3B788oEIusUChl+JeZkqKOJMjotRGjylnO9o5Lj
    WJqiHhPNB/Ni4rmZ8G0L/V3wIWdJfiTJPC4szQtOzE1BY+sKHqHjxq2xK1vCcQilmPkf
    j1uoMCba7q8In49mV9vkVDo0tKFddyknLbdaNKB98QL1WcI1ev6IYjDhg2Lp337Eo2VV
    BQgu28JbjzAoVxdh8hAkCBUCyDfZCfWrbi0mKVjAR1V4VreQt52V7Snc0NtmBrVp+kAh
    JTdQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKjXrKpU"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.3.1 AUTH)
    with ESMTPSA id i40d22z2HF7g6cX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 17 Mar 2023 16:07:42 +0100 (CET)
Date:   Fri, 17 Mar 2023 16:07:35 +0100
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
Message-ID: <ZBSCN0f8yC/nkGll@gerhold.net>
References: <20230315103950.2679317-1-stephan.gerhold@kernkonzept.com>
 <20230315103950.2679317-3-stephan.gerhold@kernkonzept.com>
 <ad64143c-13c0-63e3-561a-620c44f26b9d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad64143c-13c0-63e3-561a-620c44f26b9d@linaro.org>
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

On Fri, Mar 17, 2023 at 01:39:25AM +0100, Konrad Dybcio wrote:
> On 15.03.2023 11:39, Stephan Gerhold wrote:
> > According to the msm-3.18 vendor kernel from Qualcomm [1], mdm9607 uses
> > a non-standard slope value of 3000 (instead of 3200) for all sensors.
> > Fill it properly similar to the 8939 code added recently.
> > 
> > [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/arch/arm/boot/dts/qcom/mdm9607.dtsi#L875
> > 
> FWIW there's a 4.9 release for 9607
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.2.3.6.c5-03900-9x07/arch/arm/boot/dts/qcom/mdm9607.dtsi

You seem to have linked 3.18 too?

I don't see tsens support for mdm9607 in msm-4.9, although maybe I'm
looking at the wrong branch. :D

Thanks,
Stephan
