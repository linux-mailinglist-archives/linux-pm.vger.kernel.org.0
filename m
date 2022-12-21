Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF8565338C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Dec 2022 16:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiLUPiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Dec 2022 10:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiLUPi0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2022 10:38:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6038911F
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 07:37:58 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m14so15315810wrh.7
        for <linux-pm@vger.kernel.org>; Wed, 21 Dec 2022 07:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9m8USarmvldzMr+J44XS7SpGQ8hCtef881SAyiDae8Q=;
        b=L6UvxrJjfXcNoJPQpXOwq96HLNwZzbk+cHnU6uoWhGine4wKZIgJkQamSrBub9siJw
         gxPJkjfA3kY7F4qSZFvCHkbvUBe0aNkhZ4GzpKh+r4Dh4g5de0sx5Xvww63M+7St4+5m
         ku7HPG+dxmp7eBhgJYbDGH6+zt6STAFkhCVTxIO346CzavEADITyo2kCLjNzXKmKe25D
         wJKESrkMiE5hr+yx26pfJW17O32gBG0gmxw+mxoK2Ki4OrmfWpyPxbZORrV5mED2EvSa
         evyUayoGxEdPEeOesCCy3VjeMGYG/bbdpg4L/XPbc4Ttv4XlJtNL48ssjHRCxeSzbcg1
         xVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m8USarmvldzMr+J44XS7SpGQ8hCtef881SAyiDae8Q=;
        b=J399uizZ5a+lcyUWGaIRpIwULtMMklkrRFLvGJLm2+YxDakNstJUEksFfLMPYur1L8
         NjZN1bi6x0dQaFyrj57cIfXnzB+pIXDVBWCL1hK+J9jvdNjsTsu4qedNHNEcll0MiUi0
         zqRmPIlLp/Z9COwzcJfrN5Vrc7PfnLkBJ4MpjQOXC7vmutuyqnoEG08tPKvMVLNQ4B9d
         XV4SgJtvEsaUqfivc4H1xAa3jtKZkBWTj3bxoIldML5AO6+hSueh368lno1VpwXCwT7K
         sPLT+wC7UUVE1bQmBP//weUConChzSmkzrnKm4rfOWFtVWM4Nk0oxFFjyNyVsXDc9k8s
         twyQ==
X-Gm-Message-State: AFqh2krgpaw3P2UJSzKdIYhduT0SYCL1PVXndyHmpMjvvuY1xOARE4fi
        c+v4V/VPJrzG5CpYkP8TcKrVFw==
X-Google-Smtp-Source: AMrXdXu2fSetxXEsruEVdCSb86lzCy9KSvy0WpIy6GHQMl6GZ5Bsu8URGnddADll0uNcxHjWk/URNA==
X-Received: by 2002:a5d:4b84:0:b0:242:5b60:e23c with SMTP id b4-20020a5d4b84000000b002425b60e23cmr1295315wrt.19.1671637076795;
        Wed, 21 Dec 2022 07:37:56 -0800 (PST)
Received: from [192.168.175.23] (pur13-1-78-242-214-186.fbx.proxad.net. [78.242.214.186])
        by smtp.googlemail.com with ESMTPSA id w16-20020adfee50000000b002420dba6447sm15416255wro.59.2022.12.21.07.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 07:37:55 -0800 (PST)
Message-ID: <be2b4fef-b047-7dd5-c375-af90083e4417@linaro.org>
Date:   Wed, 21 Dec 2022 16:37:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 00/15] thermal/drivers/tsens: specify nvmem cells in DT
 rather than parsing them manually
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221221020520.1326964-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Dmitry,

On 21/12/2022 03:05, Dmitry Baryshkov wrote:
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
> 
> The code was tested on msm8916 and qcs404 only.
> 
> Note: the DTs changes depend on driver changes. Tsens driver will not
> work if DT patches are merged, but the driver bits are not. As the
> thermal sense is critical for device safety, I'd suggest merging binding
> and driver during one merge window and then merging DT changes in the
> next merge window.

We can avoid an extra release cycle with a common *immutable* branch 
shared between the two trees.


> Note2:
> For v3 I have reworked the legacy bindings support into the small and
> manageable data-driven piece of code.
> 
> I still have included patches to drop legacy support for 8939
> (msm8939.dtsi is on the list, I have provided Bryan with the patch to
> update it to new bindings) and 8976 (msm8976.dtsi and msm8956.dtsi,
> which use single-blob bindings, have been accepted for 6.2, dropping old
> bindings support depends on mutual consensuns of platform and thermal
> code maintainers). The patches are the last ones in the thermal part of
> the series, thus if they are declined, the reset of the series still can
> be applied without any problems.
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
>    thermal/drivers/tsens: limit num_sensors to 9
>    thermal/drivers/tsens: fix slope values for msm8939
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
>   .../bindings/thermal/qcom-tsens.yaml          | 123 +++-
>   arch/arm/boot/dts/qcom-apq8084.dtsi           | 313 ++++++++-
>   arch/arm/boot/dts/qcom-msm8974.dtsi           | 313 ++++++++-
>   arch/arm64/boot/dts/qcom/msm8916.dtsi         |  81 ++-
>   arch/arm64/boot/dts/qcom/msm8956.dtsi         |   4 +
>   arch/arm64/boot/dts/qcom/msm8976.dtsi         | 153 +++-
>   arch/arm64/boot/dts/qcom/qcs404.dtsi          | 145 +++-
>   drivers/thermal/qcom/tsens-v0_1.c             | 653 +++++-------------
>   drivers/thermal/qcom/tsens-v1.c               | 340 +++------
>   drivers/thermal/qcom/tsens.c                  | 166 +++++
>   drivers/thermal/qcom/tsens.h                  |  46 +-
>   11 files changed, 1572 insertions(+), 765 deletions(-)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

