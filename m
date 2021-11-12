Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4D44EFDB
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 23:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhKLXBn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Nov 2021 18:01:43 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46750 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhKLXBk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 18:01:40 -0500
Received: by mail-ot1-f46.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so16009648otk.13;
        Fri, 12 Nov 2021 14:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n70w2ubplDiZAdzqk24kbZs0VlRAwLWhU8ICxlpOJjA=;
        b=FGlTsBGwxWhD6oeD83AtgukxpAFTvEWpbQTUD7gb50Ma5DgHNyMuCk4G0E7upUuXNT
         3Rk2+DzbV/1JHOMlTrK818kby+sNPjPck/ZUfkjToU2Z5sauV3nht355/up/aNd6Iz6B
         nXB1JOvs9zGr0ElphCNBzKPaMRvHj0rVUaGw3lFLyX/b0mASHoF83oG4LXDCzGcci2mQ
         SCD3N2T2tlXa/DHPFisNk+I5xe27gQN2AmvWfvwzD8nQOGTLVwM9YLwHbkmpjQd0WEll
         /fuUoZ7QLV1u7T0gERB09doatqtClt/VdleIHlS9O2NnFnVDpOJXuOZ/5hunLOZc229G
         N4BQ==
X-Gm-Message-State: AOAM533I6B57dCg8IiZ6YWUiSEf9h4vB84F3PKDZQOv7zmvUbxmChI0Z
        OTsHqFOZUecYWlOV7du9Lg==
X-Google-Smtp-Source: ABdhPJyclPgxDJ9KXlC2POWFBgGSHoxPgp2rjJQPATtn61R3v0OFcZJxbAqUJDOxOG6Ief5H0ietBA==
X-Received: by 2002:a9d:805:: with SMTP id 5mr14501816oty.383.1636757928682;
        Fri, 12 Nov 2021 14:58:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d25sm1530251oti.9.2021.11.12.14.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:58:48 -0800 (PST)
Received: (nullmailer pid 3534743 invoked by uid 1000);
        Fri, 12 Nov 2021 22:58:47 -0000
Date:   Fri, 12 Nov 2021 16:58:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Edwin Chiu =?utf-8?B?6YKx5Z6C5bOw?= <edwin.chiu@sunplus.com>
Cc:     Edwin chiu <edwinchiu0505tw@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bingings:arm:sunplus:add sp7021 compatible string
 to sunplus,idle-state.yaml
Message-ID: <YY7xp3qcO68rJJUC@robh.at.kernel.org>
References: <cover.1636356928.git.edwin.chiu@sunplus.com>
 <5d2231d33d647d24d2b95c9f652687f7f1dccd2d.1636356928.git.edwin.chiu@sunplus.com>
 <1636376582.101053.3181499.nullmailer@robh.at.kernel.org>
 <d2e1fc4e7913459fbc96d845eb73b87b@sphcmbx02.sunplus.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2e1fc4e7913459fbc96d845eb73b87b@sphcmbx02.sunplus.com.tw>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 09, 2021 at 06:58:24AM +0000, Edwin Chiu 邱垂峰 wrote:
> Hi Rob:
> 
> Look into the full log, it show you check 3 programs
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Context	Check	Description
> robh/checkpatch	warning	total: 0 errors, 1 warnings, 67 lines checked
> robh/dt-meta-schema	success	
> robh/dtbs-check	fail	build log
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 1) The checkpatch warning is WARNING: From:/Signed-off-by: email address mismatch: 'From: Edwin chiu <edwinchiu0505tw@gmail.com>' != 'Signed-off-by: Edwin chiu <edwin.chiu@sunplus.com>'
> ==> I want explain to you that <edwin.chiu@sunplus.com> is my email in the company, but it disagree operate by "git send-email".
>     So I used <edwinchiu0505tw@gmail.com> in my linux system to operate with "git send-email".
>    Actually I checkpatch in my side was 0 error 0 warning.

The email used to send and the author emails are independent in git. 
There should be a 'From:' line in the resulting patch when the sender 
and author don't match.

Maybe you need to set sendemail.from config option to your corp email.

> 
> 2) Regarding to dtbs-check issue, your list warnings related to others company's yaml file, it not my yaml file case. 
>    What is the purpose you want? Or what should I do?

You aren't adding anything custom, so why are you even adding the 
schema? arm/idle-states.yaml should be enough.

> 
> 3) Execute=>make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
> There are many config select items…..I don't know how to select them.
> (I execute "make config " and "make all" were pass)
> Can you teach me how to do "make dtbs_check"?

Did you read Documentation/devicetree/bindings/writing-schema.rst?

To check all dts files (for an arch) and run the validation, do:

make allmodconfig
make dtbs_check

Rob

> 
> 邱垂峰 EdwinChiu
> 智能運算專案
> T: +886-3-5786005 ext.2590
> edwin.chiu@sunplus.com
> 300 新竹科學園區創新一路19號
> 
> -----Original Message-----
> From: Rob Herring <robh@kernel.org> 
> Sent: Monday, November 8, 2021 9:03 PM
> To: Edwin chiu <edwinchiu0505tw@gmail.com>
> Cc: robh+dt@kernel.org; daniel.lezcano@linaro.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; rafael@kernel.org; linux-pm@vger.kernel.org; Edwin Chiu 邱垂峰 <edwin.chiu@sunplus.com>
> Subject: Re: [PATCH 1/2] dt-bingings:arm:sunplus:add sp7021 compatible string to sunplus,idle-state.yaml
> 
> On Mon, 08 Nov 2021 15:55:09 +0800, Edwin chiu wrote:
> > Add the compatible string for cpuidle state on sp7021
> > 
> > Signed-off-by: Edwin chiu <edwin.chiu@sunplus.com>
> > ---
> >  .../bindings/arm/sunplus/sunplus,idle-state.yaml   | 55 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  6 +++
> >  2 files changed, 61 insertions(+)
> >  create mode 100644 
> > Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the following warnings. Consider if they are expected or the schema is incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1552228
> 
> 
> spc: compatible:0: 'arm,idle-state' was expected
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8074-dragonboard.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8084-ifc6540.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8084-mtp.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dt.yaml
> 
> spc: compatible: Additional items are not allowed ('arm,idle-state' was unexpected)
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8074-dragonboard.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8084-ifc6540.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8084-mtp.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dt.yaml
> 
> spc: compatible: ['qcom,idle-state-spc', 'arm,idle-state'] is too long
> 	arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8064-cm-qs600.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8064-ifc6410.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8074-dragonboard.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8084-ifc6540.dt.yaml
> 	arch/arm/boot/dts/qcom-apq8084-mtp.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-samsung-klte.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-sony-xperia-amami.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dt.yaml
> 	arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dt.yaml
> 
