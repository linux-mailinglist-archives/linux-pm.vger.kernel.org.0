Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C1D76DFE9
	for <lists+linux-pm@lfdr.de>; Thu,  3 Aug 2023 07:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjHCF4M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Aug 2023 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHCF4L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2023 01:56:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0BC2D49
        for <linux-pm@vger.kernel.org>; Wed,  2 Aug 2023 22:56:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-563df158ecaso372460a12.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Aug 2023 22:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691042170; x=1691646970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7WsYV/x7lyB/wTNGCIcHVMNipm/cU1Q7w5THwIRrSU=;
        b=zAgoVRmjKopQptfjt67R46qrgqXC6e7F8RrNLBq0gotYSQZOeWgnOMgIva55l3NKHe
         271ABzS+rcGJOZQdiqE85sxQfOFOoRat3iYCzFrPjqU1z47X6J+NV0980nOYhWUh+R/O
         jGs+KODx1PnSoxZjaQ022rqvHyqLvBGrs+ADB02lZCe7MizoIkD14Zoaj5x3ofhG5uNC
         R0IX+JtSNH7XAyq6Uc7xOHafeRMb6/s9jQr8UmKTBVR7AzN8Mms7u4xn3/TBrLglW8/A
         oa/lwW0/JfNKx318653BCbr2BptGYdVt9mK9Xh31imoa0JeyRvCsQGN7Zwl6a8I4AqPi
         EsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691042170; x=1691646970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7WsYV/x7lyB/wTNGCIcHVMNipm/cU1Q7w5THwIRrSU=;
        b=hxbLQeHDkxI21uSGs31rNeRdHPFpuyVnFmsEBDK4L7W84WOkse2op87dldO8Yzr59H
         X7pWQL5WibdT7rMxTWJRSlqzHi8vpjJe3yVlu04ihb3P90S40CkHiPh70fITnN3M+RSA
         FmP4gQKC1kbGpem/ODEr1mlq+2by16j5ThJyhf3ygfD/eC4px07geqik9Yz+SPACObg4
         RKqNV//5VA3Tn3TkD5LO/VLl0OsjpMoMro1xyDyzFMawVfcijOTOaOLATy+y5eUshoWf
         AIv7JwAS+f0c3FwKqVEEib/K7t+NNsQPgqW/vaTh65PvWQCSWqeQJhUDdmsa87i36age
         Zl+w==
X-Gm-Message-State: ABy/qLaKibiESHX+wgmmvuyY3k0bB5AdVtH/9yGBS4L5Fo6SqlD2LEHP
        CPYb1qnymXv8m69hZc9RnofCBQ==
X-Google-Smtp-Source: APBJJlEs/F725rHcqtyueFIg9TFFt0P4AKB76xQ2koQUxZ42Kq2Mdg6ZzKKjgx8nvTjdp3EwutDy6Q==
X-Received: by 2002:a17:902:ea95:b0:1b0:6038:2982 with SMTP id x21-20020a170902ea9500b001b060382982mr17234494plb.41.1691042169672;
        Wed, 02 Aug 2023 22:56:09 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b001b03b7f8adfsm13451200plh.246.2023.08.02.22.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 22:56:09 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:26:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug
Message-ID: <20230803055607.ueliy6eofvhoy4gw@vireshk-i7>
References: <ZMh45KH2iPIpNktr@work>
 <66e19ae3-253d-5377-5cc2-566ec3cfed49@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66e19ae3-253d-5377-5cc2-566ec3cfed49@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-08-23, 10:05, Florian Fainelli wrote:
> On 7/31/23 20:15, Gustavo A. R. Silva wrote:
> > Allocate extra space for terminating element at:
> > 
> > drivers/cpufreq/brcmstb-avs-cpufreq.c:
> > 449         table[i].frequency = CPUFREQ_TABLE_END;
> > 
> > and add code comment to make this clear.
> > 
> > This fixes the following -Warray-bounds warning seen after building
> > ARM with multi_v7_defconfig (GCC 13):
> > In function 'brcm_avs_get_freq_table',
> >      inlined from 'brcm_avs_cpufreq_init' at drivers/cpufreq/brcmstb-avs-cpufreq.c:623:15:
> > drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds=]
> >    449 |         table[i].frequency = CPUFREQ_TABLE_END;
> > In file included from include/linux/node.h:18,
> >                   from include/linux/cpu.h:17,
> >                   from include/linux/cpufreq.h:12,
> >                   from drivers/cpufreq/brcmstb-avs-cpufreq.c:44:
> > In function 'devm_kmalloc_array',
> >      inlined from 'devm_kcalloc' at include/linux/device.h:328:9,
> >      inlined from 'brcm_avs_get_freq_table' at drivers/cpufreq/brcmstb-avs-cpufreq.c:437:10,
> >      inlined from 'brcm_avs_cpufreq_init' at drivers/cpufreq/brcmstb-avs-cpufreq.c:623:15:
> > include/linux/device.h:323:16: note: at offset 60 into object of size 60 allocated by 'devm_kmalloc'
> >    323 |         return devm_kmalloc(dev, bytes, flags);
> >        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -Warray-bounds.
> > 
> > Link: https://github.com/KSPP/linux/issues/324
> > Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied. Thanks.

-- 
viresh
