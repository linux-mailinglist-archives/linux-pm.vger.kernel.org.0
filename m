Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467295E92AC
	for <lists+linux-pm@lfdr.de>; Sun, 25 Sep 2022 13:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiIYLVW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Sep 2022 07:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiIYLVV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Sep 2022 07:21:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722F32E6BD
        for <linux-pm@vger.kernel.org>; Sun, 25 Sep 2022 04:21:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i26so6758967lfp.11
        for <linux-pm@vger.kernel.org>; Sun, 25 Sep 2022 04:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=duVQyVLuGWggGu+8Z6F+GJlfNp5/JJucEkdX/LlC7QM=;
        b=zy101Vl2fAM9C93MPqWcgwAgfCbKq4SO3IoJw1BgWY7dCpiJy7lK9bW/Q47xO2cC57
         4Y/25g/946aYKqRXM/bJheQ/1CmSftoWlC0PscJe2jOH2v/NwYZdGGZECOE2gevle1v1
         Huozl5KJVfOH6DiP9+18jnRUPtKIvmATS/t0russJVc4AsWWLDIXJ+g+IsjEyMpEQ/Tq
         pDYuyazep16gdyvMoe5cQTEd8sMuztiUQDMylXO540GzCoYDmNezfRjKaBXi59LfqIrE
         njaEaF+WHyJgpTahV9iFyFxpB5B7L9TH6HSL8rQIVxximN1j4vqmZqhdKmeTfDxmvFMs
         gDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=duVQyVLuGWggGu+8Z6F+GJlfNp5/JJucEkdX/LlC7QM=;
        b=AUD4m4ZNGALseL4j4AteGVh11/bdv7GUhVIBE/BRJ55bjVMom8Q808ryow8uEDHdE+
         f0fcqUyo4kJhCmFCYG0FTFAuyE+4U27xTlV4mjUHw8Fuk68XkqLYMuAS0D9upffO/wmq
         lPxtMOL/gaGPc54Xxvqxe6+4qt3ngLRc2uPY4mqqa+xgWJ6LNCB3+r9ITEgP2rSZtMUU
         Lo7aBlEyELjPXw104EjKtPwDpsfo3eydIM3BeVCJX1N3ko9aXLCvn+wDTXrSphbF3YIm
         UWg7tagCxqKl/SeDWoAD3PB0s2ziQkevtcobwKRrdxVrOS7Rlg9glNo3jnLT4pYPXaae
         QJKw==
X-Gm-Message-State: ACrzQf0X9v95KOMCsH43OYXRtTIlMMT3+cIwhmVQ+yLhTFUceeObB0nZ
        4jnu2jSQHucd+p6Dn67ldF7+JRdhrYdhZw==
X-Google-Smtp-Source: AMsMyM5umAEhirxj9xxoewdxEYMdawpTbW9PVpngUd2UxEUhJPNXJQMwDYSM3hK6i2iFf9q2CgAHPA==
X-Received: by 2002:a05:6512:a8c:b0:49e:359f:5563 with SMTP id m12-20020a0565120a8c00b0049e359f5563mr6478163lfu.563.1664104876758;
        Sun, 25 Sep 2022 04:21:16 -0700 (PDT)
Received: from [127.0.0.1] ([94.25.228.177])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025fe7f33bc4sm2060371ljc.49.2022.09.25.04.21.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2022 04:21:16 -0700 (PDT)
Date:   Sun, 25 Sep 2022 14:21:11 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
CC:     Andy Gross <agross@kernel.org>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_00/10=5D_thermal/drivers/tsens=3A_specify?= =?US-ASCII?Q?_nvmem_cells_in_DT_rather_than_parsing_them_manually?=
User-Agent: K-9 Mail for Android
In-Reply-To: <YzArWZ1+OKvCNM7d@gerhold.net>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org> <YyyaH1ZXF9IvLpwd@gerhold.net> <93a790fb-20dc-0f31-2eed-09f5b538bea9@linaro.org> <YzArWZ1+OKvCNM7d@gerhold.net>
Message-ID: <722E6DEE-BD57-4573-A151-508917961D1B@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 25 September 2022 13:20:09 GMT+03:00, Stephan Gerhold <stephan@gerhold=
=2Enet> wrote:
>On Sat, Sep 24, 2022 at 09:58:56PM +0300, Dmitry Baryshkov wrote:
>> On 22/09/2022 20:23, Stephan Gerhold wrote:
>> > On Sat, Sep 10, 2022 at 03:46:51PM +0300, Dmitry Baryshkov wrote:
>> > > Historically the tsens driver fetches the calibration data as a blo=
b and
>> > > then parses the blob on its own=2E This results in semi-duplicated =
code
>> > > spreading over the platform-specific functions=2E
>> > >=20
>> > > This patch series changes tsens calibration code to use pre-parsed =
nvmem
>> > > cells rather than parsing the blob in the driver=2E For backwards
>> > > compatibility the old code is left in place for msm8916 and qcs404,=
 two
>> > > platforms which have in-tree DT files=2E For msm8974 the original f=
unction
>> > > is left intact, since it differs significantly (and I can not test =
the
>> > > code on msm8974)=2E For all other affected platforms the old parsin=
g code
>> > > has been dropped as a part of this RFC=2E
>> > >=20
>> > > The code was tested on msm8916 and qcs404 only, thus it is being se=
nt as
>> > > an RFC=2E
>> > >=20
>> >=20
>> > Thanks a lot for working on this!
>> >=20
>> > After thinking about this for a while I wonder if we can go even a st=
ep
>> > further: Can we drop SoC-specific code entirely for 8939 and 9607 and
>> > match the generic compatible (qcom,tsens-v0_1)? This would allow most
>> > v0=2E1 plaforms to use generic code like for qcom,tsens-v2=2E
>>=20
>> While this idea looks appealing, I think it's a bit against our custom =
to
>> put hardware details into the driver rather than putting them into the =
DT=2E
>> So, I think, the 8939 will have to stay as is, while for the 9607 and m=
aybe
>> several other devices it should be possible to create a fallback entry=
=2E
>>=20
>
>IMHO the existing tsens-v2 support is a good example that it's sometimes
>better to have some minor hardware details in the DT so the driver does
>not have to be changed for every single platform=2E Extending from
>specifying the number of sensors in the DT to the exact set of sensors
>is not a very big step=2E

Fine, I will take a look=2E

>
>Also, aren't you also going against the custom here by moving the fuse
>hardware details to the DT? :)

Not quite=2E Fuses are completely software thing=2E=20

>
>> [=2E=2E=2E]
>> > And actually there are two revisions of 8939, the older one has one
>> > sensor less (msm-3=2E10: msm8939-common=2Edtsi vs msm8939-v3=2E0=2Edt=
si)=2E
>> > This could also be easily handled from the DT without any code change=
s:
>> >=20
>> > 	qcom,sensors =3D <0 1 2 3 5 6 7 8 9>;
>>=20
>> Usually we only care about the latest revision of the chip, earlier
>> revisions typically correspond to engineering samples, never hitting th=
e
>> actual consumer devices=2E
>>=20
>
>I'm afraid we might have to care about both revisions here - I recently
>checked a couple of MSM8939 devices in postmarketOS and there are
>definitely two different revisions used in production - they are easily
>identifiable since they have different CPU revisions in the "lscpu"
>output (Cortex-A53 r0p1 vs r0p4)=2E

Ugh=2E=20

>
>Thanks,
>Stephan

--=20
With best wishes
Dmitry
