Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A9447FFF
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 14:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbhKHNFs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 08:05:48 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36562 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhKHNFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 08:05:48 -0500
Received: by mail-ot1-f47.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso25346883otv.3;
        Mon, 08 Nov 2021 05:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=VKUPtClGvMYDKizfMfyOiejcSked8y/6afCSZ5ymgCk=;
        b=II9+Ysa6MT/5r+K7JE7Weh+ZEjafzXd7gqfRs31wXYaiGbuchSw+5LkxCS97fXi0ZB
         rV61HA2bkQpQIcLty9Lq3It0ZTp+UrBHbcL4p3fwukgTE7WfPGs5LmSx5FrSBXuAwhPg
         th1jEABuY+KkqMKJLAeuVVD0opaDxeLaoLf/ObopQ4IFSPFlxIXc0v0G/jjEsLdwqJPd
         TBwkxIsa+EE6EgXv1ZfTUfGGngzW0xp5Nf876RswFjhOwwMbxbF12Ir6Qn4FkgxlKmjB
         SaOUtEHaNfGLD8QxkHtwCUZagbfRhSTtjUxKCxYwKGibfC5SjfAqaIu+1Zyi+k/0STuJ
         ICtA==
X-Gm-Message-State: AOAM533YShN21yDudWCtCfMyY1Q2o921wepTs/hadKhGoz2VYphVhRSD
        +Kg1/yWvaxH3TI5RaiTnLF1Qhlh1RA==
X-Google-Smtp-Source: ABdhPJw3S8w5gZ3puthsDp3FS0eJzL6zUpv+m5QlrHcSA+4WrWDFdno2qQox8R91MoOjqXvcLuUwYA==
X-Received: by 2002:a9d:7cca:: with SMTP id r10mr26834237otn.228.1636376583565;
        Mon, 08 Nov 2021 05:03:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u28sm3448014oth.52.2021.11.08.05.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:03:02 -0800 (PST)
Received: (nullmailer pid 3181500 invoked by uid 1000);
        Mon, 08 Nov 2021 13:03:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Edwin chiu <edwinchiu0505tw@gmail.com>
Cc:     robh+dt@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        Edwin chiu <edwin.chiu@sunplus.com>
In-Reply-To: <5d2231d33d647d24d2b95c9f652687f7f1dccd2d.1636356928.git.edwin.chiu@sunplus.com>
References: <cover.1636356928.git.edwin.chiu@sunplus.com> <5d2231d33d647d24d2b95c9f652687f7f1dccd2d.1636356928.git.edwin.chiu@sunplus.com>
Subject: Re: [PATCH 1/2] dt-bingings:arm:sunplus:add sp7021 compatible string to sunplus,idle-state.yaml
Date:   Mon, 08 Nov 2021 07:03:02 -0600
Message-Id: <1636376582.101053.3181499.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 08 Nov 2021 15:55:09 +0800, Edwin chiu wrote:
> Add the compatible string for cpuidle state on sp7021
> 
> Signed-off-by: Edwin chiu <edwin.chiu@sunplus.com>
> ---
>  .../bindings/arm/sunplus/sunplus,idle-state.yaml   | 55 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1552228


spc: compatible:0: 'arm,idle-state' was expected
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dt.yaml
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dt.yaml
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dt.yaml
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dt.yaml
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dt.yaml
	arch/arm/boot/dts/qcom-apq8084-ifc6540.dt.yaml
	arch/arm/boot/dts/qcom-apq8084-mtp.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dt.yaml

spc: compatible: Additional items are not allowed ('arm,idle-state' was unexpected)
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dt.yaml
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dt.yaml
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dt.yaml
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dt.yaml
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dt.yaml
	arch/arm/boot/dts/qcom-apq8084-ifc6540.dt.yaml
	arch/arm/boot/dts/qcom-apq8084-mtp.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dt.yaml

spc: compatible: ['qcom,idle-state-spc', 'arm,idle-state'] is too long
	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dt.yaml
	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dt.yaml
	arch/arm/boot/dts/qcom-apq8064-ifc6410.dt.yaml
	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dt.yaml
	arch/arm/boot/dts/qcom-apq8074-dragonboard.dt.yaml
	arch/arm/boot/dts/qcom-apq8084-ifc6540.dt.yaml
	arch/arm/boot/dts/qcom-apq8084-mtp.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dt.yaml
	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dt.yaml

