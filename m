Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD473668E35
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jan 2023 07:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbjAMGpX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Jan 2023 01:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjAMGo5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2023 01:44:57 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F79676236
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 22:30:30 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q2so21575990ljp.6
        for <linux-pm@vger.kernel.org>; Thu, 12 Jan 2023 22:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oj46fwhldUKw7hGOkuucEHWnwosnLZLmKbpNEe+nkf8=;
        b=DMlQzIbjrx6noC4zvk1nNOJ0mMmIsO+2TmviK49LvgYJ3NNycvtwgvyH7hp0WlBEnW
         GoFkvJl52SrhguGGpkKrHH47+DtXSjzmO8mJU338Z92TyKCNfZnTNFqfmJaAsI2Vd1bv
         gB9Y15ZmpZunVX3hhX3s4A/H87lTYq3AxOkKnmf9A8g/JXYFiTTNbgkSqbsmGQ1P3ZM7
         VIss+IF8ERjk/+PSOt4+Cq9vNtxSeWAaRTVUMjCP93QCOf9aJMdAEjTYRW+id/4kT1EG
         JAYhptzgguTMeCOLh1s0gKigCNr3H4XbKVdGXmodaW4ZLd7VJV+4rNJQzHDExTKo+qjX
         WvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oj46fwhldUKw7hGOkuucEHWnwosnLZLmKbpNEe+nkf8=;
        b=4WF8T9tBSZQjhN8c3w/8bCwoP4KkLNYYqiAvqjhXsNXtviv8+8O5hqIJ7i0vOiJKpd
         zOJNPiR3ydAQVCVAIXzNvf8EGpm+h2hNimTETbdCbARYIW8z6/qSAN5Sd/hKbEvpoRXw
         PZoSDZLXdwxR2Xl7bAguACZE/5/cQrXGA4Tik84rHSDN6XyMl6i+aDlx+Uz6Klrxces2
         Opejeo0LRN1hr9Njyf/LuPgxAGgNI6SQ+1PyqfoEvhe46+bdExAPChqgB4izdvVBsGli
         m3tNVCypcwfKaPm3VI3TlMXkv1pLCUjNg1ii/YnpC3tdJFN++JC9jEhhGBKqomAqNLXt
         /C4w==
X-Gm-Message-State: AFqh2kqd4ZtUR/FZoLHsBPeZQtdRmQzfW9b74BAV4Jco9ID1eEP+jU79
        0dw7lPFlU5e3xlue2B86EY8atg==
X-Google-Smtp-Source: AMrXdXuA5g9KSX/L8Um/aMbyDWngUyvbaNrkXDGrZveQ5jVwlZB++vxUVV+D1NpsZ5pvXEz6QtRbxw==
X-Received: by 2002:a2e:bd07:0:b0:27f:ae14:511e with SMTP id n7-20020a2ebd07000000b0027fae14511emr19304641ljq.46.1673591376875;
        Thu, 12 Jan 2023 22:29:36 -0800 (PST)
Received: from [192.168.2.31] ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0027712379ec8sm2422778ljp.28.2023.01.12.22.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 22:29:36 -0800 (PST)
Message-ID: <cdebb6a9-0bc3-70ef-53ef-4a48ead869da@linaro.org>
Date:   Fri, 13 Jan 2023 08:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 00/20] thermal/drivers/tsens: specify nvmem cells in DT
 rather than parsing them manually
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/01/2023 21:40, Dmitry Baryshkov wrote:
> Historically the tsens driver fetches the calibration data as a blob and
> then parses the blob on its own. This results in semi-duplicated code
> spreading over the platform-specific functions.
> 
> This patch series changes tsens calibration code to per-value nvmem
> cells rather than parsing the blob in the driver. For backwards
> compatibility the old code is left in place for msm8916, msm8974 and
> qcs404, the platforms which have in-tree DT files. For all other
> affected platforms the old parsing code has been dropped as a part of
> this series.

Amit, Thara. This has been lingering for quite some time whout any 
attention from your side. Could you please review the patchseries? Thank 
you!

> 
> The code was tested on msm8916 and qcs404 only.
> 
> Note: the DTs changes depend on driver changes. Tsens driver will not
> work if DT patches are merged, but the driver bits are not. As the
> thermal sense is critical for device safety, I'kindly ask to have an
> immutable branch with the driver changes that can be merged into the
> msm-dts tree.
> 
> Note2:
> I still have included patches to drop legacy support for 8939
> (msm8939.dtsi is on the list, patch to convert it to the proposed
> bindings is available at [1]) and 8976 (msm8976.dtsi and msm8956.dtsi,
> which use single-blob bindings, have been accepted for 6.2, dropping old
> bindings support depends on mutual consensuns of platform and thermal
> code maintainers). Corresponding patches are the last ones in the
> thermal part of the series, thus if they are declined, the reset of the
> series still can be applied without any problems.
> 
> [1] https://pastebin.ubuntu.com/p/rfkZgy767K/
> 
> Changes since v5:
> - Reworked bindings to use patterns instead of enum,
> - Changed the order of items in msm8974/apq8084 bindings. If there will
>    be any other platform using main & backup calibration values, it would
>    be easier to reuse msm8974 bindings by using 's[0-9]+_p[12](_backup)?'
>    patterns, rather than listing all the cases explicitly.
> 
> Changes since v4:
> - Changed DT bindings to use HW sensor ids rather than bare indices.
>    This follows the usage of hw_ids in thermal-sensors specifications
>    (and corresponds to the ID visible in debugfs).
>    Previously there was no correspondence, which resulted e.g. in usage
>    of s0_p1/s0_p2 for sensor 0, but s4_p1/s4_p2 for the sensor 5 on
>    the msm8916 platform).
> - Reworked msm8939 code to ignore the sensor10. It is available only on
>    latest hw revision, it doesn't seem to be actually used and it also
>    wasn't covered by the old single-blob bindings because of the parsing
>    error.
> - Fixed missing include reported by testing robot.
> 
> Changes since v3:
> - Added a patch to fix the tsens compatible string on msm8956 SoC,
> - Fixed num-sensors and slope coefficients for the msm8939 SoC,
> - Rewrote code supporting old bindings into the simple data-driven
>    parser common to all legacy platforms which made dropping support for
>    old bindings less demanding.
> 
> Changes since v2:
> - Made init_8956 static, as pointed out by the testing robot and by
>    AngeloGioacchino Del Regno.
> 
> Changes since the RFC:
> - Sorted out the msm8976/msm8956, custom slopes are used only for msm8956,
> - Implemented proper support for msm8974/apq8084,
> - Added tsens_calibrate_common() and ops_v0_1 which can be used in
>    common cases,
> - Removed superfluous identity hw_ids
> - Fixed calibration calculation in tsens_calibrate_nvmem() for
>    ONE_PT_CALIB case
> 
> Dmitry Baryshkov (20):
>    dt-bindings: thermal: tsens: add msm8956 compat
>    dt-bindings: thermal: tsens: support per-sensor calibration cells
>    dt-bindings: thermal: tsens: add per-sensor cells for msm8974
>    thermal/drivers/tsens: Drop unnecessary hw_ids
>    thermal/drivers/tsens: Drop msm8976-specific defines
>    thermal/drivers/tsens: Sort out msm8976 vs msm8956 data
>    thermal/drivers/tsens: fix slope values for msm8939
>    thermal/drivers/tsens: limit num_sensors to 9 for msm8939
>    thermal/drivers/tsens: Support using nvmem cells for calibration data
>    thermal/drivers/tsens: Support using nvmem cells for msm8974
>      calibration
>    thermal/drivers/tsens: Rework legacy calibration data parsers
>    thermal/drivers/tsens: Drop single-cell code for mdm9607
>    thermal/drivers/tsens: Drop single-cell code for msm8939
>    thermal/drivers/tsens: Drop single-cell code for msm8976/msm8956
>    arm64: dts: qcom: msm8956: use SoC-specific compat for tsens
>    arm64: dts: qcom: msm8916: specify per-sensor calibration cells
>    arm64: dts: qcom: msm8976: specify per-sensor calibration cells
>    arm64: dts: qcom: qcs404: specify per-sensor calibration cells
>    ARM: dts: qcom-msm8974: specify per-sensor calibration cells
>    ARM: dts: qcom-apq8084: specify per-sensor calibration cells
> 
>   .../bindings/thermal/qcom-tsens.yaml          | 153 +++-
>   arch/arm/boot/dts/qcom-apq8084.dtsi           | 313 ++++++++-
>   arch/arm/boot/dts/qcom-msm8974.dtsi           | 313 ++++++++-
>   arch/arm64/boot/dts/qcom/msm8916.dtsi         |  85 ++-
>   arch/arm64/boot/dts/qcom/msm8956.dtsi         |   4 +
>   arch/arm64/boot/dts/qcom/msm8976.dtsi         | 153 +++-
>   arch/arm64/boot/dts/qcom/qcs404.dtsi          | 145 +++-
>   drivers/thermal/qcom/tsens-v0_1.c             | 655 +++++-------------
>   drivers/thermal/qcom/tsens-v1.c               | 340 +++------
>   drivers/thermal/qcom/tsens.c                  | 168 +++++
>   drivers/thermal/qcom/tsens.h                  |  46 +-
>   11 files changed, 1610 insertions(+), 765 deletions(-)
> 

-- 
With best wishes
Dmitry

