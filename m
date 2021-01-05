Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E236B2EB0FB
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 18:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbhAERFf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 12:05:35 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:42578 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbhAERFe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 12:05:34 -0500
Received: by mail-io1-f51.google.com with SMTP id q137so28783109iod.9;
        Tue, 05 Jan 2021 09:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sxTRWEC8MOpnTMUesMj6I4isC8VAjw1tkHEHI23HMOY=;
        b=Yp1OlFAVVJr3/SYx7XsxB0clQ0uvqbYVBkDG7WshR4D0AeJ/UGMerce1rP3WlF+sTj
         xBkjHmQXaDF/k3SFdE4dNMbsyi7Znuiraa0bWvulNKmhFoj6Ug3YEvvdXM8j/OYP+FZe
         sZ3H83u5Ju/yWvWp5yynXuDr3EsCMzNTcPtGldnCqiqwSk7GRybIzrYQH2OXE5dvvhpK
         bwq/DEva1vXPCbTEga6tSDsQdnaT2qK6WaKlDMgMv/BEB0l11/+mQb5FKTBo5HJR5D1R
         tPzZmXvktmC0ClDyNWu97kaHfEvYxKRCwlVF0kpCR5xNYAAdo8A0GGfBOZD1ovGANkAv
         e1Pg==
X-Gm-Message-State: AOAM531EL6tGFA8Pt87aD89FIUPRtDDAk1cfVEVa4rR1qCTcF10UJw1n
        JCMB+nrlpHJbwH7gqAPQVw==
X-Google-Smtp-Source: ABdhPJyv0RgKbg7aFtr2sDhxf/W4b4hYcZ75/Cv55V8/TksMzERWMcHIKqT2VRvHjbZ5WhzqUSHWPA==
X-Received: by 2002:a6b:4f13:: with SMTP id d19mr56135iob.121.1609866293433;
        Tue, 05 Jan 2021 09:04:53 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 9sm57733iob.28.2021.01.05.09.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:04:52 -0800 (PST)
Received: (nullmailer pid 372421 invoked by uid 1000);
        Tue, 05 Jan 2021 17:04:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org
In-Reply-To: <1609842147-8161-2-git-send-email-claudiu.beznea@microchip.com>
References: <1609842147-8161-1-git-send-email-claudiu.beznea@microchip.com> <1609842147-8161-2-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: sama7g5-cpufreq: add dt bindings documentation
Date:   Tue, 05 Jan 2021 10:04:48 -0700
Message-Id: <1609866288.037184.372420.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 05 Jan 2021 12:22:25 +0200, Claudiu Beznea wrote:
> Add DT bindings documentation for SAMA7G5 CPUFreq driver.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../bindings/cpufreq/cpufreq-sama7g5.yaml          | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-sama7g5.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-sama7g5.yaml: properties:cpu-supply: '$ref' is not one of ['description', 'deprecated']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/cpufreq/cpufreq-sama7g5.yaml: ignoring, error in schema: properties: cpu-supply
warning: no schema found in file: ./Documentation/devicetree/bindings/cpufreq/cpufreq-sama7g5.yaml

See https://patchwork.ozlabs.org/patch/1422407

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

