Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97A24C9E8B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Mar 2022 08:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbiCBHqC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Mar 2022 02:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbiCBHqB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2022 02:46:01 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2097EB0A4E
        for <linux-pm@vger.kernel.org>; Tue,  1 Mar 2022 23:45:18 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i1so881653plr.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2022 23:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F9EtQ8yCDPdY6oJUsT6nUpz0TTVJMffkSKOyUDKlf6g=;
        b=dNj/gUws35uaqKdhHY3lu4/zgchEG0cqtQXu3vowcftUBbkQXDkZR/CJz0J4FqCnym
         YHsfvEv3jRC6KpDCQY61D7QW5Q8oVYrwz+W/iVgktqhA3/qjboT8klvbsxZN4hYr0ITE
         pix8SawqbDMwN93+4g22NeRi8YOW2YoF2EUAS99h2CYBbGwL7ESNnIiBnzojb6OKOG3P
         00zgyWDWKDTGg1u3jvQXsogb/NO6DTpgHC56HONXtaW39xDBqLBzAABe0+5ETvNga1ug
         bKu3nMCvrCIIZdAfh6U1gwvcnicUJ872A6zvrzzSd8mI8IHX6dNmZa5jVZf67asZkh+N
         QQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9EtQ8yCDPdY6oJUsT6nUpz0TTVJMffkSKOyUDKlf6g=;
        b=r5M48e5QrvfxLmLyRGOZif0QSljw5nrIeCUK0YZbzbIDjhjA56mpimRUceyGcSGNAU
         sDjvgmQOKrIPR1NCveXqrLtt8ZfIQQobWBcFVgMmvf1WYlyh7XcGZ5DhM+W290l2+YhL
         X55VHZ+q5DLgQ1g9VevD/SMq/GoPs/vAT6b1Y37Mvuqcw683oWHNkgvJ21u19o6dG1YD
         MUa4ANtJnMcZYZhgQCqU5jsG3o2jpKyducY9dkPRhwc0dsftW3XLE+KcHBrN1g5TTxF3
         cUaEdPw8uNbSYuBG5QBlNeIi4VN6+KJDAqEFVACOMb0WeInKxQbenyedbMgo0J70ZJ+Y
         tcZg==
X-Gm-Message-State: AOAM531uFXRLATEcBZQsWKhbB+8NCuOqcc3pZuu0owV4GnkxjE8h8dLh
        hABLI4nTVFvTl4EyR4rDRXqa0w==
X-Google-Smtp-Source: ABdhPJwYMu1C28ILx7eUzFRPd7Lj2NxP1BHQ8w5qbPr6FmhQ/Gj7s683H8KNjPhBk+XXAQ0mNbiCjA==
X-Received: by 2002:a17:902:b696:b0:151:7777:2211 with SMTP id c22-20020a170902b69600b0015177772211mr9195582pls.46.1646207117588;
        Tue, 01 Mar 2022 23:45:17 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id b3-20020a056a00114300b004e099ec2871sm20035153pfm.154.2022.03.01.23.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 23:45:17 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:15:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] OPP: Add support of "opp-microwatt" for advanced
 EM registration
Message-ID: <20220302074515.dqzoutfiobildiph@vireshk-i7>
References: <20220301093524.8870-1-lukasz.luba@arm.com>
 <20220301093524.8870-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301093524.8870-4-lukasz.luba@arm.com>
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

On 01-03-22, 09:35, Lukasz Luba wrote:
>  /**
>   * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
>   * @dev		: Device for which an Energy Model has to be registered
> @@ -1517,6 +1567,12 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>  		goto failed;
>  	}
>  
> +	/* First, try to find more precised Energy Model in DT */
> +	if (_of_has_opp_microwatt_property(dev)) {
> +		em_cb.active_power = _get_dt_power;

You can also do (to fix the warning) this instead:

em_cb = EM_DATA_CB(_get_dt_power);

Similar for the else part.

> +		goto register_em;
> +	}
> +
>  	np = of_node_get(dev->of_node);
>  	if (!np) {
>  		ret = -EINVAL;
> @@ -1538,6 +1594,7 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>  		goto failed;
>  	}
>  
> +register_em:
>  	ret = em_dev_register_perf_domain(dev, nr_opp, &em_cb, cpus, true);
>  	if (ret)
>  		goto failed;
> -- 
> 2.17.1

-- 
viresh
