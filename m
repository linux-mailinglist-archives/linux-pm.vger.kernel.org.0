Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900F27276AC
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jun 2023 07:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbjFHF37 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 01:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjFHF36 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 01:29:58 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F420526B6
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 22:29:56 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33b1e83e204so401975ab.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 22:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686202196; x=1688794196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DE7OrFeNWC7NT42z/fRgG9LWd8ypqqUWEnKJtZerNBA=;
        b=uZ/e30b1I3gC7oNBD9ef+9VYhMIXL4LiNnJraXSUHTeFWpER9LTP5EAjtj0ylaZdxd
         uZTBI/sndU0Xr921yVKqdP0aIl33kJqFKnuIaRZ97zn6/UQch8HEPOUt1PmZJYc7Q+pJ
         gfl+PGnIw9j6zc0vUxgzpFSsUFQ1BcsdkseRTExFmWsIgu22DSsu94ZFs2u5oxboMftz
         YTUoqmE5jLXmAhKm6zMbVaE4IYi52QitHthsLJAQcpn0M3/oPvTquX+ZdsoW5rfqPPp4
         RNpMEvJ2A+iB6b63Ge4kMF+v1BvQTqDn4dqR5TPg9hAe3H5ak2uA9SUKSRbs6128gsWN
         vZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686202196; x=1688794196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DE7OrFeNWC7NT42z/fRgG9LWd8ypqqUWEnKJtZerNBA=;
        b=jz9hwKsMBanIBRwZ0LVEdndTsFWL2HEX/OZJZr7Hw+5QL3IG0bfNnW9NXP85Uq0K/i
         0PzYmMg6ei33gns0rap8H/8wxgjD17SljPazLDpZZneIdghzfGvig0R5FezouK1/pZGf
         T6oXYCHy4XG0Ywb9kno2Og0ggwmXAIC4wU9q3vVw05BRPHkKB0AQ9FZn1u4DkCbREWIV
         aHC8pr9bUQR4eQ3GMOFNf3mgJcDJclIQdBt93Ca6DTvWG2IVFU5SOXllchMBy3Pl7G/p
         sqpQtJe7Yi6uW1pD58dacdDS6Zuek1HBh1m0cK6Gx1Uf3mnwiYbUsUKP+OwZwcvb55wA
         bHHA==
X-Gm-Message-State: AC+VfDztseodT1/RgHqZEqCnDz3Y0lSUSUtEMia29HagMm8wTDkkzTdS
        vuK9E1ZiaxAHdz0OXtHfEyMkpw==
X-Google-Smtp-Source: ACHHUZ6qL/mjH4DcEc+/LspZAtJUP9Q8wg5tprU2IcEGsixo18RFI63Tt/3aBPlpI47U3xM+WDcJUA==
X-Received: by 2002:a92:d089:0:b0:325:b002:89b4 with SMTP id h9-20020a92d089000000b00325b00289b4mr7837299ilh.25.1686202196369;
        Wed, 07 Jun 2023 22:29:56 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id e21-20020a62aa15000000b0065014c15a57sm271206pff.35.2023.06.07.22.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 22:29:55 -0700 (PDT)
Date:   Thu, 8 Jun 2023 10:59:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] OPP: Add dev_pm_opp_add_dynamic() to allow more
 flexibility
Message-ID: <20230608052953.l44dwb6n62kx4umk@vireshk-i7>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-12-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607124628.157465-12-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-06-23, 14:46, Ulf Hansson wrote:
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 954c94865cf5..0e6ee2980f88 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1921,8 +1921,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>   * _opp_add_v1() - Allocate a OPP based on v1 bindings.
>   * @opp_table:	OPP table
>   * @dev:	device for which we do this operation
> - * @freq:	Frequency in Hz for this OPP
> - * @u_volt:	Voltage in uVolts for this OPP
> + * @opp:	The OPP to add
>   * @dynamic:	Dynamically added OPPs.
>   *
>   * This function adds an opp definition to the opp table and returns status.
> @@ -1940,10 +1939,10 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>   * -ENOMEM	Memory allocation failure
>   */
>  int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
> -		unsigned long freq, long u_volt, bool dynamic)
> +		struct dev_pm_opp_data *opp, bool dynamic)

The name `opp` is mostly used for instances of `struct dev_pm_opp`. Can we use a
different name here please for the data ?

> +/**
> + * dev_pm_opp_add()  - Add an OPP table from a table definitions
> + * @dev:	device for which we do this operation
> + * @freq:	Frequency in Hz for this OPP
> + * @u_volt:	Voltage in uVolts for this OPP
> + *
> + * This function adds an opp definition to the opp table and returns status.
> + * The opp is made available by default and it can be controlled using
> + * dev_pm_opp_enable/disable functions.
> + *
> + * Return:
> + * 0		On success OR
> + *		Duplicate OPPs (both freq and volt are same) and opp->available
> + * -EEXIST	Freq are same and volt are different OR
> + *		Duplicate OPPs (both freq and volt are same) and !opp->available
> + * -ENOMEM	Memory allocation failure
> + */
> +int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)

Maybe move this to include/linux/pm_opp.h and mark it static inline and get rid
of documentation too.

> +{
> +	struct dev_pm_opp_data opp;
> +
> +	memset(&opp, 0, sizeof(opp));

What about
        struct dev_pm_opp_data data = {0};

I think it is guaranteed that all the fields will be 0 now, not the padding of
course, but we don't care about that here.

> +	opp.freq = freq;
> +	opp.u_volt = u_volt;

Or maybe just

        struct dev_pm_opp_data data = {
                .freq = freq,
                .u_volt = u_volt,
        };

Rest must be 0.

-- 
viresh
