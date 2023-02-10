Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4EC691ABB
	for <lists+linux-pm@lfdr.de>; Fri, 10 Feb 2023 10:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjBJJFP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Feb 2023 04:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjBJJEz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2023 04:04:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C072637701
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 01:04:25 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id co8so586088wrb.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2023 01:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K7VIxGHRdprRV/LqkHIT4VXtM2nS0UlK2A3+S/yfPzU=;
        b=ruHL2ggkOLZrj/A1ju7AHyTWEpcP61OVgpgRcz6Ynbv3U4ENy0MTGWzkmzDKT0FKa+
         kxwheHnLfTF19VQElv5b7C1kTerLXF/Sm9dn8flXSppWr4feiaBjnIUZKoFuS3sq+aeG
         rTLF9/sYd300Yo+5rZHVLSIgWopIqp+Bib9SXMRFD+AxVmDzLKc5jP5o0blmC9/xXJ68
         H1y9bzuV045QH/lUvvffzQrH4bcqNX6nNfbco4wRboCCzBMKaV4X2OvFG+FlXVfgQ5O1
         hSuRClDFUoh8MethGF6L1kH1HmskaeVE64M+bpEuqtFF3Dn2UZYAtw+RNdd+ONTY+db4
         UZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7VIxGHRdprRV/LqkHIT4VXtM2nS0UlK2A3+S/yfPzU=;
        b=19AHb/dSsSystQezeP7pT/vK03q7U7wOyAbqQUhIF6GAXJ58fz19jNgG+4YKiaTHc/
         cj5EypEtGUT12mQBCEBPG44cKfTgr9ae1uj/o2KJ1rAaac9aTAF2ivNVkkDBYwJaSp1i
         Py5fshHk9BkOEKM5o6LKMfIyPc1hIuVRg2mdozmiypBY1XFZ5joyvpZrUgWaOLjQVJQ5
         D+5Ozb9z+rI/2V6sQ3WmhuJaxmNCSFnXVUCF4NTaoh9lAZH/7YJcmEFIP4FmSLmkryNt
         s6fi4up3YS5wBPKUS4qcEibCdN4dqEq8/tBd3nCDJpbChTazuwnIMi5b1yhbeOE6NGVM
         xMqQ==
X-Gm-Message-State: AO0yUKWRoie3aF6zb4wGaOxJ8FQmnP4xrAcGDlIcZwp3W3rlexyvWHSa
        EA1uN88ETK2iEItgkqaXRrCncw==
X-Google-Smtp-Source: AK7set83noZf3enDbMTsBZDwxEicf2PTn9Yq7G9YrGZxZuCfxXPH0i2MIcZmQZROagL9Bdp3MbW7bg==
X-Received: by 2002:adf:f708:0:b0:2c5:3cd6:4fdf with SMTP id r8-20020adff708000000b002c53cd64fdfmr4285892wrp.39.1676019864173;
        Fri, 10 Feb 2023 01:04:24 -0800 (PST)
Received: from linaro.org (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.gmail.com with ESMTPSA id c13-20020adfef4d000000b002c3db0eec5fsm3075177wrp.62.2023.02.10.01.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 01:04:23 -0800 (PST)
Date:   Fri, 10 Feb 2023 10:04:20 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 00/11] ARM: removal of STiH415/STiH416 remainings bits
Message-ID: <20230210090420.GB175687@linaro.org>
References: <20230209091659.1409-1-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230209091659.1409-1-avolmat@me.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 09, 2023 at 10:16:48AM +0100, Alain Volmat wrote:
> Most of code in order to support STiH415 and STiH416 have already
> been removed from the kernel in 2016, however few bits are still
> remainings.
> This serie removes the last pieces of support for STiH415, STiH416
> and STiD127.

How would like to have the patches applied ?

Ack from the different maintainers or each maintainer apply the relevant patches ?

Thanks
  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
