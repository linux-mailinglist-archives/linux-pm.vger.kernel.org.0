Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F063FEB81
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbhIBJnx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 05:43:53 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:61473 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245185AbhIBJnw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 05:43:52 -0400
Date:   Thu, 02 Sep 2021 09:42:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630575772;
        bh=xRF9eqv4PKo+kZdEnxZf3slEfaXPEv4ICmGtDtFFhr0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=wf/2sLr+/ZxXhfe0qyapMX8pS587V7p1N27/s2WJgjM3SOUs+CYlEFEHut78r4LcB
         JEjb4vIvf6QDTkk4B9UWDfaTgdJm5LqSJOomxhnu12RoDcyHDoBtmIkjZm6x1RzLQo
         WyIJAWORp36Wf43sqL3Qe6yr/w7XzZnKDuzJK2wQ=
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v4 1/5] interconnect: qcom: sdm660: Commonize RPM-QoS
Message-ID: <UQVSYQ.02005O7OLITH3@protonmail.com>
In-Reply-To: <efafd058-ad68-eb0a-af42-40d879ef63d9@linaro.org>
References: <20210901121518.152481-1-y.oudjana@protonmail.com> <20210901121518.152481-2-y.oudjana@protonmail.com> <9af0f031-101e-53b4-514e-9ead44320f4e@somainline.org> <efafd058-ad68-eb0a-af42-40d879ef63d9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Thu, Sep 2 2021 at 02:01:59 +0400, Dmitry Baryshkov=20
<dmitry.baryshkov@linaro.org> wrote:
> On 01/09/2021 21:48, AngeloGioacchino Del Regno wrote:
>>  Il 01/09/21 14:15, Yassine Oudjana ha scritto:
>>>  SoCs such as MSM8996 also control bus QoS in a similar fashion to=20
>>> SDM660,
>>>  with some paths being controlled by RPM and others directly by the=20
>>> AP.
>>>  Move relevant functions and defines to a new object so that they=20
>>> can
>>>  be used
>>>  in multiple drivers.
>>>=20
>>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>=20
>>  Hey guys!
>>=20
>>  I'm waiting for the interconnect RPM-QoS commonization to be merged=20
>> as I
>>  have fresh
>>  interconnect drivers for MSM8998 and MSM8976, ready to send, that=20
>> are
>>  also using
>>  the very same QoS mechanism as SDM660.
>=20
> We were also looking onto this. I'd propose to merge sdm660 code into
> main icc-rpm.c instead of splitting it into separate file. We have
> enabled QoS for apq8096 (msm8916) and msm8939. See
> https://lore.kernel.org/linux-arm-msm/20210818015732.1717810-1-dmitry.bar=
yshkov@linaro.org/
> for the reference. I'm waiting for Shawn to publish v2 of his fix,=20
> then
> I can post v2 of my patchset.

I'll wait for your v2 to post v5 of this series then.
Please add me to Cc when you send it.

>=20
>>=20
>>  Yassine, please check Shawn's recent patches for SDM660=20
>> interconnect,
>>  which are
>>  fixing some bits for the QoS implementation and adding some required
>>  clocks to the
>>  SDM660 interconnect driver.
>>=20
>>  Adding Shawn to the Ccs as to make him aware of this patch;
>>  also adding Marijn and Konrad from SoMainline as probably interested
>>  parties.
>>=20
>>  Cheers!
>>  - Angelo
>=20
>=20
> --
> With best wishes
> Dmitry

Thanks,
Yassine




