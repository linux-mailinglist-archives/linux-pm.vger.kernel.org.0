Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D0641EF8
	for <lists+linux-pm@lfdr.de>; Sun,  4 Dec 2022 19:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiLDSnN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Dec 2022 13:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLDSnM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Dec 2022 13:43:12 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004CB861;
        Sun,  4 Dec 2022 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1670179365; bh=UUqOerOHLcT4DA45tzAd8yincP+C3QXMaXtuhiA7dsk=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=EZRyX1/bH8QfsANLdiqT0Lr7AmAIwUVrUAfJMeKb7Q+liGL1QW0dphCzBKDey7+Sk
         BMmWlKJOKnuLy2fH0ajPqdv9JdqE8CAkJrcHlYqmVyjTHhE2YvwMpo68iw4MdT09X7
         SrJpNvyvoml8ZlCOyHjQDX9YRDISryWc2TrmN13A=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sun,  4 Dec 2022 19:42:45 +0100 (CET)
X-EA-Auth: q0CFIaYcH3tux4yZT1C6hGmaU4Gdfhsd7jE0TFA1UIJ9nEy8jNt3270a/2/u2erwgYTnGMOl7nEHWD98HeDEcBOTBHdLORRK2wE4HBxv5Q8=
Message-ID: <2186df0393c6cf4dab88772aceed7202090f5a1d.camel@mailoo.org>
Subject: Re: [PATCH v2 08/15] thermal/drivers/tsens: Drop single-cell code
 for msm8939
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Sun, 04 Dec 2022 19:42:43 +0100
In-Reply-To: <20221204055909.1351895-9-dmitry.baryshkov@linaro.org>
References: <20221204055909.1351895-1-dmitry.baryshkov@linaro.org>
         <20221204055909.1351895-9-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le dimanche 04 d=C3=A9cembre 2022 =C3=A0 07:59 +0200, Dmitry Baryshkov a =
=C3=A9crit=C2=A0:
> There is no dtsi file for msm8939 in the kernel sources. Drop the
> compatibility with unofficial dtsi and remove support for handling the
> single-cell calibration data on msm8939.

Could one invoke a "msm8916-like exemption" here ?
Also, msm8939.dtsi was submitted once [1],
and if helps we could send a v2 this month...

[1] https://lore.kernel.org/linux-arm-msm/20220419010903.3109514-1-bryan.od=
onoghue@linaro.org/


