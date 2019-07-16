Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3096A710
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 13:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbfGPLLU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 07:11:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41058 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387472AbfGPLLU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 07:11:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so8515262lfa.8
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=De8/nFrlZkmJ1Y3LPB15A9cMZ47Zx0HgH86pautMcVU=;
        b=MhfVgsHKsWQWV+8Cx6DkHX920ij+HAPhqcs/LrfxSWnmUhcZwwObqzXGuH2sYRl9AN
         iwPdTxgDU9BNifyfjbzo6FeK/XCISN8ezsTqNs3u+GIJ3lhKG+pQTJmQuOD83xC4g0Ic
         lLW+8JbnEAHxIKLzKd2ifrwLiko0942eLh4/D5+V5u4nf2DHsjtiGII+6s8AA9vCq1YZ
         5xhMqY8nftd9xW7FikIn+LRybyEglGiHdlkPwuKOmaS9kE2uxv312YGl9Y8dzzmC9TRf
         YJQ9y8PNnM0Nh8pMom8u5ubKRutmYrih0UEOweKK6LfRjVtpvK4OqKR8HkFLMPoKr9Al
         8pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=De8/nFrlZkmJ1Y3LPB15A9cMZ47Zx0HgH86pautMcVU=;
        b=nlefjtnCNdiurJnC1iz5pQxSqh4P+jWTCpXMYWV5aZAFwOPOC/4TUNg3wrYI4oY1S1
         vGHIJpkLh+Oi/f6g4FE150A7eaa7B+1HrR4j+PkYlb6av8k7T7cpu2z59dncruWJwKVg
         4r8mUv3BvV1pSv/CPES+4jvAyTd8aRmlO5/Ry57doPt/OOHBN36Q3id43gqW7lB6R6EB
         yaVUbkrD5OSMONzPq/XXf9hLzre+2QcR45gl3bH7IdblRf0cwsMbwkKU6+Gxpl7smnAp
         ElUuY225PmcDz6yAxyZcV+YpKexlVK/gwcEA5GXIQP3hlQHiyQdL166pYR678L7r2LKZ
         L87A==
X-Gm-Message-State: APjAAAW6CLRjmdJAZkZoVgiCAQrwbAz1RW/LgnseJXPVOu7OOuQbcOvf
        vwh++rgmfk0m3o4r39+5BfYVeA==
X-Google-Smtp-Source: APXvYqwF1gNN2bVBA6LW6EiKcvNJYhEY68/e2UyoWg9xYJmBg2oHpiJsfK0RzoLVmYtiAgpJogVh+g==
X-Received: by 2002:ac2:528e:: with SMTP id q14mr13449179lfm.17.1563275478425;
        Tue, 16 Jul 2019 04:11:18 -0700 (PDT)
Received: from centauri (ua-83-226-229-61.bbcust.telenor.se. [83.226.229.61])
        by smtp.gmail.com with ESMTPSA id t25sm2793658lfg.7.2019.07.16.04.11.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 04:11:17 -0700 (PDT)
Date:   Tue, 16 Jul 2019 13:11:15 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] cpufreq: qcom: Refactor the driver to make it
 easier to extend
Message-ID: <20190716111115.GA13918@centauri>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-5-niklas.cassel@linaro.org>
 <20190710063026.7yyoxjsqp2ck3z6n@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710063026.7yyoxjsqp2ck3z6n@vireshk-i7>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 10, 2019 at 12:00:26PM +0530, Viresh Kumar wrote:
> On 05-07-19, 11:57, Niklas Cassel wrote:
> > +	drv->opp_tables = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tables),
> > +				  GFP_KERNEL);
> > +	if (!drv->opp_tables) {
> > +		ret = -ENOMEM;
> > +		goto free_drv;
> > +	}
> >  
> >  	for_each_possible_cpu(cpu) {
> >  		cpu_dev = get_cpu_device(cpu);
> > @@ -166,19 +195,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
> >  			goto free_opp;
> >  		}
> >  
> > -		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
> > -							      &versions, 1);
> > -		if (IS_ERR(opp_tables[cpu])) {
> > -			ret = PTR_ERR(opp_tables[cpu]);
> > -			dev_err(cpu_dev, "Failed to set supported hardware\n");
> > -			goto free_opp;
> > +		if (drv->data->get_version) {
> 
> Why depend on get_version here ? The OPP table is already allocated
> unconditionally.

Since the reading of the speedbin efuse is now optional,
it is now inside "if (drv->data->get_version)".

So if I don't also protect "dev_pm_opp_set_supported_hw()"
with "if (drv->data->get_version)" I get:

[    3.135092] cpu cpu0: _opp_is_supported: failed to read opp-supported-hw property at index 0: -22
[    3.139364] cpu cpu0: _opp_is_supported: failed to read opp-supported-hw property at index 0: -22
[    3.148330] cpu cpu0: _opp_is_supported: failed to read opp-supported-hw property at index 0: -22

Probably since drv->versions is initialized to 0,
and if there is no opp-supported-hw in device tree,
OPP framework prints failures.

So it feels safest to only call dev_pm_opp_set_supported_hw()
if we know that we are supposed to parse the speedbin efuse.


Kind regards,
Niklas

> 
> > +			drv->opp_tables[cpu] =
> > +				dev_pm_opp_set_supported_hw(cpu_dev,
> > +							    &drv->versions, 1);
> > +			if (IS_ERR(drv->opp_tables[cpu])) {
> > +				ret = PTR_ERR(drv->opp_tables[cpu]);
> > +				dev_err(cpu_dev,
> > +					"Failed to set supported hardware\n");
> > +				goto free_opp;
> > +			}
> >  		}
> >  	}
> 
> -- 
> viresh
