Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC64C0EE2
	for <lists+linux-pm@lfdr.de>; Wed, 23 Feb 2022 10:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbiBWJKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Feb 2022 04:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiBWJKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Feb 2022 04:10:42 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A088580228
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 01:10:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 75so19341797pgb.4
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 01:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wwEeIbVKRAFJc1IUROvg7itOrJyqhQC3kCceTm88ch8=;
        b=xoEiNPwmXke/nkZ+DHLML+rqVhZKfA5g2eNwCprpOPWpsB2mBdhm3r7fZWJm77ipkp
         vrMwX13qNO4zEY1fMqN/y0g0HIfiRkJlRB+JF7WVnmRR07Y7S8dnSjlfx4W3T2FjGywb
         lSvSAfrbHA3lDrBiL487sp/sc12pqGXt2qrhzgwQsl9UUaI0hLjJGLEGp75Xi4Y8Z5Za
         kbShy8E4rW66PdUgdyQCUgnTxUo0QFQNSdlIwWLybJYpYwm9OLT69Mo6vZAvNMDID8Yb
         sCwinct0dhRRhj+KkmJmQymMr3zrpInDNOgrkE7K8oakKrzmIMvORby4TNYYrmqM28u7
         YhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wwEeIbVKRAFJc1IUROvg7itOrJyqhQC3kCceTm88ch8=;
        b=xzae23z6zZwFdPO5J8JsJZUz2jZfHY3u/QHD8GHkeyNHV8GuIe/VIQcz5vbnjbZmCT
         9ds7IG9JlsmN7xteO8MsF9ec9UtSkEt0rBtYYdxHBuAtE3KmqLQyQxGfAoKnKhJI2DEp
         Y1YRv6EAugJt8iAnFyttyjZL83Zit6cVFh4LSphU8uzZ4CFKBvN5z7rYzazsyT89mFjX
         cdNcGWIrIW4exc8OpLIn9Npa9f3gDJQ8vimhg54Et05FWs74vazWT51lhN+eYmSjl+Iq
         PPlmbKZi0CK4IkKHI5GyLRT+KlDC2noYFhgQMzLGc+oxtR7SnhY/4fp+xjKcnInFhmZp
         zHFw==
X-Gm-Message-State: AOAM531CfSUZs7L2fNGlYt5DaVRP3tpZiPq22+1EuB++kzQerg3o5jMa
        EFDZz5I610zjZEqIOXuUGxJWDg==
X-Google-Smtp-Source: ABdhPJxY3zmpRDrdJPFVLfKKYjvYzCca+xNI3tbn213m0TTlPNQfpWhFGnb77TgCu1ptREKSDnDGVw==
X-Received: by 2002:a63:9845:0:b0:375:5cc8:7d34 with SMTP id l5-20020a639845000000b003755cc87d34mr1002442pgo.124.1645607414211;
        Wed, 23 Feb 2022 01:10:14 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id h4sm6269241pfo.81.2022.02.23.01.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:10:13 -0800 (PST)
Date:   Wed, 23 Feb 2022 14:40:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [[PATCH v2 2/2] OPP: Add 'opp-microwatt' parsing for advanced EM
 registration
Message-ID: <20220223091012.w3flzpye6z55jnwd@vireshk-i7>
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <20220222140746.12293-3-lukasz.luba@arm.com>
 <20220223055357.t3wulpla64vt3xus@vireshk-i7>
 <b6682d6f-a6ae-8a82-68c3-13840c02d178@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6682d6f-a6ae-8a82-68c3-13840c02d178@arm.com>
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

On 23-02-22, 08:59, Lukasz Luba wrote:
> OK, so you want to have this available for the whole system. I can do
> that. I would go for one value of power 

One value per supply, right ?

> and try to fit into the
> opp_parse_supplies() code.

Correct.

> As far as I can see in the
> dev_pm_opp_get_voltage() the simple solution: supplier[0] and u_volt
> is used. I would go for similar solution for u_watt.
> There is even a single u_amp and no _max, _min variants, so should be
> good..

Yes, I don't think we need min/max/target kind of naming here. Just a single
value per supply is enough.

-- 
viresh
