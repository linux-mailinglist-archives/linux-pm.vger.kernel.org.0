Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D917DE236
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 04:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfJUCkx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 22:40:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38832 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfJUCkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2019 22:40:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so6811474pgt.5
        for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2019 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Bmcm7T/zcyVGhPhSabpZfUntv4i1edeqmeNi4+8NAw=;
        b=OA/AFTiKFstPFoO/Ct4VVDeh4wnOMLVd+warA3PtSFT+985BDdvHSedeHMQ6jsHjfz
         3lAfbTQr58ine6Ey7l/xUZcuIpAi3X5ZPe5qCoS0uO3XGOhvhm1KRJHo2qwLo1QQ0pus
         gt8DOW/ue3q7TzQyJ/xlGWFAWprVEDNYrAUIpx41Nu58/lSYlc8pOHHLhTmz1FwpGX9V
         pt/taCEuuqHBUFrjah4hZ+/2yF3nL8dJE58kivfgcibws0zJbOjdCeYazSrfnD1ez3wG
         qXC8dwi23to7Y636OFL1U1r3ClIueqjqpjTdhX/DE+Dn2IoFdUgSTvFIshCKgTsR8YP2
         Xvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Bmcm7T/zcyVGhPhSabpZfUntv4i1edeqmeNi4+8NAw=;
        b=inY4xPSKblGGCCkXVT3gWL2JNpimog+m1eRcSrjA42M7s60DMT5seYIJnNGkmqHwFi
         WXLTe2BqtyFuJDL6ZPPbTHhRsTyfrWmlp+1uvCR97J/KNdv+bzZwWuvrPOYZTm0TgGtl
         mgu3/ZXaOxn4UOYFrXZ9UFug6o1VMT2WAvbITLchWFuhPiuL5yxesrIuu7M0dRwNtBKT
         SYPoz4rOJE5TH2DYrQzOAJINUOYHG7MOvAN5FHSedMP7MWILJUT6ncn34/7VaMujCPcd
         XT24LTcFUn0pNk2Kt2a6LQIWigL94b76EyVcoRHM+GzJOOwEOpvFSDKQVV3gbSqJKyBd
         cPXg==
X-Gm-Message-State: APjAAAXDXNpGGF/oGpNoz401xOAjnzeBbxzw4LzCDCwCRUO1CExhEJxU
        ED1e/9gKdcPJ4MCI8OwqAtC9Ug==
X-Google-Smtp-Source: APXvYqxLx0H3vlInhitEUORpSnDYrwSm3XKCc7L2YZpm1pbtgErYPIS1rZ/LGLGMGdM8wz92rggLBQ==
X-Received: by 2002:a17:90a:9f44:: with SMTP id q4mr25587101pjv.81.1571625652356;
        Sun, 20 Oct 2019 19:40:52 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id e14sm13870948pgk.70.2019.10.20.19.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:40:51 -0700 (PDT)
Date:   Mon, 21 Oct 2019 08:10:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v3 2/5] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191021024049.uyit2zp24l6jqzf5@vireshk-i7>
References: <20191018103749.11226-1-sudeep.holla@arm.com>
 <20191018103749.11226-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018103749.11226-3-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-19, 11:37, Sudeep Holla wrote:
> +static struct platform_driver ve_spc_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "vexpress-spc-cpufreq",
> +	},
> +	.probe		= ve_spc_cpufreq_probe,
> +	.remove		= ve_spc_cpufreq_remove,
> +};
> +module_platform_driver(ve_spc_cpufreq_platdrv);
>  
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
> -MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
> +MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
> +MODULE_DESCRIPTION("Vexpress SPC ARM big LITTLE cpufreq driver");
>  MODULE_LICENSE("GPL v2");

Strange. The -B option you used while generating the patch makes it
fails to get applied om my side with am -3. git doesn't get the rename
of file properly and shows me this conflict:

  
  static int ve_spc_init_opp_table(const struct cpumask *cpumask)
  {
@@@ -68,4 -697,7 +727,11 @@@ static struct platform_driver ve_spc_cp
  };
  module_platform_driver(ve_spc_cpufreq_platdrv);
  
++<<<<<<< HEAD
 +MODULE_LICENSE("GPL");
++=======
+ MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+ MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+ MODULE_DESCRIPTION("Vexpress SPC ARM big LITTLE cpufreq driver");
+ MODULE_LICENSE("GPL v2");
++>>>>>>> cpufreq: merge arm_big_little and vexpress-spc

Can you resend this patch (only) without the -B option ?

-- 
viresh
