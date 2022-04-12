Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892884FE82D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358787AbiDLSpZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Apr 2022 14:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241938AbiDLSpY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 14:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78E54BC0;
        Tue, 12 Apr 2022 11:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2728961B48;
        Tue, 12 Apr 2022 18:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79012C385A8;
        Tue, 12 Apr 2022 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649788984;
        bh=w2CtaQZcF4jWpOWkg14I1V3aX1NHUeLpL6sv3cNvE14=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TTbUWeGTGtqpQE0D+lZtb/8tdEIjV52Fc7it9gm8vfWhdnCkaw5s/ZzlO9/VmCjtT
         x7yguM8OC+11YUql9KlJFvivx1SokY2L1/DebBVzV8mFHd4FSJXchqqvtdk/Sirj9b
         59J2M48SwJd7L5LiI2uzBieuW6atj60W1SwRCBJO43dvOm2lDP9K6xesW8WAZXOfIb
         /f9wvnN5cbMnDvQ6F+7ww7FAn2A3XpQl/hqqF1QdpfDWCGNEn9wv2rU+Gf5gbMSPDQ
         SflqFvq2sZTWlYqUGvLonrr3GLMx5Jn7e9gV0o/2DDG1OVmBLKkIa5/ACr2hkZbbfU
         KUXMsDy8/rDqg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA8EJpod2cNOYr3g+DmdWo_2Ujv7-pW39fBKqcpCPvtVgP5-NQ@mail.gmail.com>
References: <20220406002648.393486-1-dmitry.baryshkov@linaro.org> <20220406154028.EC897C385A3@smtp.kernel.org> <CAA8EJpod2cNOYr3g+DmdWo_2Ujv7-pW39fBKqcpCPvtVgP5-NQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] arm: qcom: qcom-apq8064: add separate device node for tsens
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Apr 2022 11:43:02 -0700
User-Agent: alot/0.10
Message-Id: <20220412184304.79012C385A8@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Dmitry Baryshkov (2022-04-06 12:57:30)
> On Wed, 6 Apr 2022 at 18:40, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Dmitry Baryshkov (2022-04-05 17:26:44)
> > > Currently gcc-msm8960 driver manually creates tsens device. Instantia=
te
> > > the device using DT node instead. This follow the IPQ8064 device tree
> > > schema.
> >
> > Why can't the schema be changed?
>=20
> But these commits change the schema. They make apq8064 follow more
> logical scheme of ipq8064.
>=20

Sounds like ipq8064 and apq8064 follow different schemas. Is there any
benefit to harmonizing the two vs. just leaving it as it is in the dts
and making the schema match whatever the dts has?
