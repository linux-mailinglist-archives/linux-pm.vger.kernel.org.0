Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7174C0C45
	for <lists+linux-pm@lfdr.de>; Wed, 23 Feb 2022 06:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiBWFyb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Feb 2022 00:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiBWFya (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Feb 2022 00:54:30 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609CE4A90B
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 21:54:00 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id bd1so1758195plb.13
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 21:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kSSqgPqSgWwd9l6HqioycoWO2GD1CoGqpsv+gFNiT9I=;
        b=lleu1EoJfeSbDrSg3KzCO1+3m8SVssae8KUkcgXKPl9xaovGjOmRD9ENgRn963QQza
         NV4ZIta1kYJgoCQMKZG6ca74wQ0YD6ytzpivDwubCIG6H0ZbL4g9Gp7igHb6ptHnAWe+
         rt9lpOPkbAnsRxeTMhlbbOqCbq9VdbKBkm+DdVxtSLzGJJq/mMIibXx5g4qisDht+Vgw
         eRXGnsztIxv9MmoeMGIYCb5N3NPr2sWH2XAnmX9fHNfeEohjN//08tlxK9COCDa1hVPx
         SZXMBK1L44IkxlxYcmoz027UHSiWCE8hKEmbLLQ8V/agZ0mE4aj1O982vSf0p5azgEay
         be/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kSSqgPqSgWwd9l6HqioycoWO2GD1CoGqpsv+gFNiT9I=;
        b=8DAaOSd5ffIxNLCSIUlOV8VT4vxwVva7aOMiGjtmJT+r0rfgWrGTVPa29+9yLwo4FT
         udq1Zz01u7eg2orXd51uEGSzB60eHwqPH2She4TH3vg9xRr5ptj3c+9XK9v3pDVbcVlq
         IOpJHn4ZMoWaMDDUJ2qlyylTfj9/3o3OdjaQZ6+46dlsOPy0SGOZPz3FkZ65cgOrHVSk
         doskRX9TMJUd3Qzk+CGQ6YNCP5n+FO7AWvE/9+jsk41P/3B1KAn0fNRGSsUBevZpBGmn
         j8z9MUbaTUHflvW5vBgVVAhiO/vDBqyabTJwFRzi02HVjslT6Mnh9bvsyzBCfnvhM5sZ
         H2JA==
X-Gm-Message-State: AOAM533StpAYu9+WBUkbIl2Ss0KZOMSX14P6BNxbT6R7CC5QcaRAjB9I
        90B9Em0jYu2bjBSH9SGVnt5JIg==
X-Google-Smtp-Source: ABdhPJzt4RsyrslagFveen7bbfrlT+7Wph+LOX6nJ+TVqH5apt4xn9feR+OBelHjxUz1Ju2kplKZgA==
X-Received: by 2002:a17:902:9045:b0:14f:14e7:f3aa with SMTP id w5-20020a170902904500b0014f14e7f3aamr25249517plz.69.1645595639866;
        Tue, 22 Feb 2022 21:53:59 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id l36sm5692148pgb.34.2022.02.22.21.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 21:53:59 -0800 (PST)
Date:   Wed, 23 Feb 2022 11:23:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [[PATCH v2 2/2] OPP: Add 'opp-microwatt' parsing for advanced EM
 registration
Message-ID: <20220223055357.t3wulpla64vt3xus@vireshk-i7>
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <20220222140746.12293-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222140746.12293-3-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-02-22, 14:07, Lukasz Luba wrote:
> +static int _of_find_opp_microwatt_property(struct device *dev)
> +{
> +	unsigned long freq = 0;
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	struct property *prop;
> +
> +	/* We only support "operating-points-v2" */
> +	np = dev_pm_opp_of_get_opp_desc_node(dev);
> +	if (!np)
> +		return -EINVAL;
> +
> +	of_node_put(np);
> +
> +	/* Check if an OPP has needed property */
> +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	prop = of_find_property(opp->np, "opp-microwatt", NULL);
> +	dev_pm_opp_put(opp);
> +	if (!prop)
> +		return -EINVAL;
> +
> +	return 0;
> +}

Please follow everything just like opp-microvolt is defined. Create a new field
in the struct dev_pm_opp, initialize it only once when the OPP is created, that
field should be used here instead of parsing the DT here again. There also needs
to be a debug file in debugfs for this new field.

Search for "supply" and "microvolt" in the OPP core, you will see all the places
that need it.

-- 
viresh
