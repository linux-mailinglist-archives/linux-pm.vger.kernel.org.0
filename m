Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68707300CB7
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 20:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbhAVOC7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 09:02:59 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:34358 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbhAVOBa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 09:01:30 -0500
Received: by mail-oo1-f47.google.com with SMTP id x23so1420445oop.1;
        Fri, 22 Jan 2021 06:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xhZ6J/Bvz/RbZpLJdDAM5wDmNVNbE/omNtX1Jgn0sOA=;
        b=Cu5+W9tPNPVEbdjYXKJ80APv+W9AMHrUVs4rLQ5qkJ4XgaEXov6ZDP+LhTIqg2M9JE
         5X6VQhdkDoNygpsEYIFxfnvT4GeetaZuOiMUHOSP9GBiy+2a6hP+BouUsGTW/hYSb3pk
         g4o5w9xu5YaN3LAIXcfO2cymCn8gQjZEv8Qqg3EOSVrZ1l/kjietxFhKHBzRQTndPYVT
         Z39qURXuPN5sL8vHNX8mJRw4rKG0jgb6PSeAnp1kWSfKpLTuRLh28Gumj/CtQBrMfxcm
         UlcouREj0I6Df7bUMjAFWcRza2Y/7JSHqVWE2WuX5Imx/+vBYgffx8YUM8FN8wGBmSGJ
         yFmw==
X-Gm-Message-State: AOAM533Rrw0Cysa70SBnLlHiTINFLPmNvabgHafS7eoe/hW3LSPSizYL
        kt7m4f2Jfg50ykmdtSlQTg==
X-Google-Smtp-Source: ABdhPJwsQ567jYvGKAXrJ8GXwHfph+c1hzHOKrEfxXnYzXPvj3BlK74M/P0Zxaj2QTnrY3kIFAMnew==
X-Received: by 2002:a4a:9c5:: with SMTP id 188mr3812377ooa.77.1611324049044;
        Fri, 22 Jan 2021 06:00:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b15sm1690907otj.15.2021.01.22.06.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:00:48 -0800 (PST)
Received: (nullmailer pid 674373 invoked by uid 1000);
        Fri, 22 Jan 2021 14:00:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20210121191853.14600-1-ansuelsmth@gmail.com>
References: <20210121191853.14600-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v8 8/8] dt-bindings: thermal: tsens: Document ipq8064 bindings
Date:   Fri, 22 Jan 2021 08:00:45 -0600
Message-Id: <1611324045.688114.674372.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Jan 2021 20:18:53 +0100, Ansuel Smith wrote:
> Document the use of bindings used for msm8960 tsens based devices.
> msm8960 use the same gcc regs and is set as a child of the qcom gcc.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/thermal/qcom-tsens.yaml          | 75 ++++++++++++++++---
>  1 file changed, 65 insertions(+), 10 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:25:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@4a9000: nvmem-cell-names: ['calib'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml

See https://patchwork.ozlabs.org/patch/1430043

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

