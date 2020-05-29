Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689771E78CB
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 10:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2IxR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2IxR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 04:53:17 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C8C03E969
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 01:53:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h95so41699pje.4
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2020 01:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGET3CBBUC4YXX4TlJHckN8MF+SPjFN/azDCcWhI2Ko=;
        b=SWa5XpdrM29Wbs5Mw6zgwp8mCh30ePzU1vT2IcYhIFRC78Jxm0fiVOhXtmWwrs2Ahy
         ggVgDefMrIq2K9hf6N3fboVOA2+Zicl6rIQE9Ai5YIo/fg1vkbsR9hPNCZEXlOBE8Pkx
         nw8kw4BvM0voEtwz8AxPq2dWQfXSBgGcPbTzKXejm6QNJlJEbBcw641R4bZNTaAW2mCc
         u5ynMGTk33E0lmpzbfhm8x7AViclTVF6D+FdG4k0xE+JZ86ELSdKGa5b+DqAesyCsZHl
         K7E7ah4wBkL57nPf9Esn7kVNukYKUkTYgpkARyEong8SqIt+f+17TJ+4FpNzSARzeyle
         SJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGET3CBBUC4YXX4TlJHckN8MF+SPjFN/azDCcWhI2Ko=;
        b=jjRI0nS+k8tjw2cVYUAuA5+Iwyj5OJ0pZAlRCcNXXDNHUfE3hm6nb4KzhAb5H7MaYw
         pyiobLcuKTWN4s/bqsGJA7vFq2uF88mj26rplNsS8Wt8d8zFvMGSNgkQazVVR0rsFaSW
         Or7YN5nvakKg/1mFjw7UzXRJVLI/cd4EzHJaMEKrXxeya0kHWkDb7B7qnj1Wa1dqYTyW
         GbABssEWao+hnpa4MYglEJmhRw2CwL2G8PoYBNKj1QsstGnmgC6jCrArPWFVfLmy02Pd
         NY/k+QPlLWs7Lo0barakuACP2+iNVYHHO4ze9i8n94IGngtflCghjR2ElhsQy0x5YgAV
         0K6g==
X-Gm-Message-State: AOAM533uwbapFBZ+GFq2RQiQ0Au8PU+gL/kAkPBupbaGbtX60whS3qqJ
        QuwQQ82Q08T0enAUBjYkd+V3QQ==
X-Google-Smtp-Source: ABdhPJwuI4rIRBIq1dxGugKKd5/iQJqr5G4+M20A2XqCtASxoz6s0Gu6vHf0nTGa3J3GqNy2SPLyAQ==
X-Received: by 2002:a17:902:9a46:: with SMTP id x6mr7598778plv.141.1590742396371;
        Fri, 29 May 2020 01:53:16 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id x20sm6597552pfc.211.2020.05.29.01.53.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:53:15 -0700 (PDT)
Date:   Fri, 29 May 2020 14:23:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] opp: Remove bandwidth votes when target_freq is zero
Message-ID: <20200529085313.6hvow6mzrm4wcrxf@vireshk-i7>
References: <20200529084153.GA1298732@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529084153.GA1298732@mwanda>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-05-20, 11:41, Dan Carpenter wrote:
> Hello Viresh Kumar,
> 
> The patch c57afacc9270: "opp: Remove bandwidth votes when target_freq
> is zero" from May 27, 2020, leads to the following static checker
> warning:
> 
> 	drivers/opp/core.c:875 dev_pm_opp_set_rate()
> 	error: uninitialized symbol 'opp'.
> 
> drivers/opp/core.c
>    844   */
>    845  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>    846  {
>    847          struct opp_table *opp_table;
>    848          unsigned long freq, old_freq, temp_freq;
>    849          struct dev_pm_opp *old_opp, *opp;
>                                              ^^^
> 
>    850          struct clk *clk;
>    851          int ret;
>    852  
>    853          opp_table = _find_opp_table(dev);
>    854          if (IS_ERR(opp_table)) {
>    855                  dev_err(dev, "%s: device opp doesn't exist\n", __func__);
>    856                  return PTR_ERR(opp_table);
>    857          }
>    858  
>    859          if (unlikely(!target_freq)) {
>    860                  /*
>    861                   * Some drivers need to support cases where some platforms may
>    862                   * have OPP table for the device, while others don't and
>    863                   * opp_set_rate() just needs to behave like clk_set_rate().
>    864                   */
>    865                  if (!_get_opp_count(opp_table))
>    866                          return 0;
>    867  
>    868                  if (!opp_table->required_opp_tables && !opp_table->regulators &&
>    869                      !opp_table->paths) {
>    870                          dev_err(dev, "target frequency can't be 0\n");
>    871                          ret = -EINVAL;
>    872                          goto put_opp_table;
>    873                  }
>    874  
>    875                  ret = _set_opp_bw(opp_table, opp, dev, true);
>                                                      ^^^
> Not initialized.
> 
>    876                  if (ret)
>    877                          return ret;
>    878  
>    879                  if (opp_table->regulator_enabled) {
>    880                          regulator_disable(opp_table->regulators[0]);
>    881                          opp_table->regulator_enabled = false;
>    882                  }

Thanks. I have already fixed and pushed the fix yesterday.

-- 
viresh
