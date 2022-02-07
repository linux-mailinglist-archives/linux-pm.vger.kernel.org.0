Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765194AB81E
	for <lists+linux-pm@lfdr.de>; Mon,  7 Feb 2022 11:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiBGJrW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Feb 2022 04:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245432AbiBGJeT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Feb 2022 04:34:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57622C043187
        for <linux-pm@vger.kernel.org>; Mon,  7 Feb 2022 01:34:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h6so4852501wrb.9
        for <linux-pm@vger.kernel.org>; Mon, 07 Feb 2022 01:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fWbd6fo3Uh6elEYwWX8/n5Alsf0PAAp4oc4nuiJlc14=;
        b=NEGgdpE0YteNXAqvAdCZywZx81JabuDYJhv5oKt9f/iVCIGIsiirS07sJdce/gAGSK
         vApzqxaddW7a/eeUoyYxPsxj6KjShxKo49HmdjGUV3AQr/oo3SFPWcEUST2A4Gm7o7KA
         qPapKDSzxjK6prAwWAugXRD41UMARf2LIprkIUqS0HbfGc7DYHJulfelAEHaj8AB6X92
         uRz7KEZeiJrxWoz3VPKcLttwW9fJINur1acpAxMcUNCv7C0ejFEqZwBjeahUy4+JAVWs
         7flAOM5AJi/kuo7jY0wL01ZpcfliP43NfgzzEa31Czza9hd/QG2vPAb91pBQ4A51Xx1M
         sKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fWbd6fo3Uh6elEYwWX8/n5Alsf0PAAp4oc4nuiJlc14=;
        b=b43nyN3Wldb6T2SvNXXKNsinzY6J/1uNKdCAPuN0Ynwd8elnEvnm1TvgRwzxeT1yW6
         jsIGugF9GzibiBjn4C6bjSn8E2UIpiEha8NvJsz/bie7w+dTYnHyzuzda1KBVffrh0hI
         r4IHnlcDiJTPFGZxVtqQ4gDgM+pSv7ukrDakFXHINjRvtTvNgD5pKK1TB/fgIcgr7SWx
         W4C96XAaDNBlRrrbNlDIvkeDYA75bG2Q8eDsmPYcF/XVvtPs+/0vC4A4slLfzW3f0sZ9
         CpImiz3wYpi13EB5PfGPkaBGrjDxQO6QgvlfvkW6XxtXFx7Q6ctd/mPROHAhxcEltp7+
         d7Og==
X-Gm-Message-State: AOAM530iWvoiNqJDfoAi+YIuG+cKdXnuUaXV7sFrfOKVyqmXzcEIZW7i
        u3dEtgHZm8yVRusn4hpeeSvv6A==
X-Google-Smtp-Source: ABdhPJxKYic4NgP+uSbi9g5JekP9iALy92JOn8u96jXpIjv5Zk/Edl8OT9URAawxFJPZynx6LI5wZw==
X-Received: by 2002:a05:6000:114f:: with SMTP id d15mr7344108wrx.626.1644226455907;
        Mon, 07 Feb 2022 01:34:15 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p8sm3410443wro.106.2022.02.07.01.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 01:34:15 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:34:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 0/4] mfd/power/regulators: dt-bindings: max14577:
 convert to dtschema
Message-ID: <YgDnlWKO6/BTxZh2@google.com>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
 <73bad620-97eb-a734-cbc8-6f001d04c18a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73bad620-97eb-a734-cbc8-6f001d04c18a@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 06 Feb 2022, Krzysztof Kozlowski wrote:

> On 11/01/2022 18:43, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Changes since v1
> > ================
> > 1. MFD: Use absolute path to schemas
> > 2. Regulator: mention all allowed properties,
> >    additionalProperties=false, add min/max values for voltages and
> >    current, don't use patternProperties when not needed.
> > 
> > Dependencies
> > ============
> > 1. DTS patch 1/4: nothing depends on it, sending here so Rob's automatic
> >    checker won't complain about DTS.
> >    I will take it via Samsung SoC tree.
> > 
> > 2. Final MFD patch (4/4) depends on regulator and power, so the last
> >    patches (2+3+4) should go via same tree.
> > 
> Dear Lee,
> 
> This patchset was reviewed and there are no outstanding issues. Could
> you pick up patches 2-4 (skipping DTS patch) via MFD tree?

Nothing from Mark?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
