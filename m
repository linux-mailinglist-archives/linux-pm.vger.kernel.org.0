Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960686A714
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 13:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfGPLLf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 07:11:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40804 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733200AbfGPLLf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 07:11:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so19480288lji.7
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3UppoPnrfp6kARoJ/BDdFjbxhg47y2G5VBuTvBYTHHQ=;
        b=ZZMThBuqDwl13ushWHRzxVb31hKXGtnUr381OARDy7qrG6qqWJpTATmxvAQnytdAd3
         WWDhBdDpm+aWAaKR6GNoMepO73uWzpX3Qrndbq8J4ty6ViUsvfMqyfs6/itFL/SsfjvD
         CzxIFvBlOjGBd7b3bQw1kh10DwoT/SRvujKG3kD7MpfQ58VUFlH7XAtPL2MVgV+UUGdM
         PdJxH8MVJRUyObEnV+822Z8xRF663Ftj2lbHKB47Za8KRrcZFef/noS7YpIO/Wdn4R3n
         v/aLNt5jQ5gRow8yjC6AmEIagWic/ijm95+H7igKOYeyZsuZTnBx5UE36T44aBN4y5d1
         VXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3UppoPnrfp6kARoJ/BDdFjbxhg47y2G5VBuTvBYTHHQ=;
        b=KgMYbqYrY5julVN9Fr0Ymjh+yyaLT3kQB8RQ7t+92aC5p41AejLMfnEBkKdH7PnfYG
         rmEcRQWUppEPp8SL8mgbmotQe8nQhRlT1VFhWoOyy5xBQsVSEQ8kS290U02TFeaNES5p
         Hocb3er/8zIggcrcfNWCAVjliszckPNc+dLC9dE/nNuFTQs1MBSRWxV0spSWbH6Reya5
         8DFotSRpPwF4ALWaCuEnoNsIRGFZcTkR8UGLzwFizwsLXNg7ztsLkdLTW0zgxFKzdpd2
         muO4fTYp4vyFpZNdBxc/3heZ/AdAZ70/Z+kwGgE0DnumPpV67oCO1vQCrtAlXX7qL47J
         gJnA==
X-Gm-Message-State: APjAAAVEPMw3wf8D5ijsekBM9ClPJjpecA0zrr7YK/rN38/9jprIuser
        fHeId6AjYpz/OZXvL2scrFVWmQ==
X-Google-Smtp-Source: APXvYqzeSAcuRom68dwCg4OqurM1KOFbKuik+yk8ytvJMNyBTrsS8bz4TOshqSAR5pUyabqrXE0MZg==
X-Received: by 2002:a2e:b4c9:: with SMTP id r9mr17164546ljm.196.1563275493271;
        Tue, 16 Jul 2019 04:11:33 -0700 (PDT)
Received: from centauri (ua-83-226-229-61.bbcust.telenor.se. [83.226.229.61])
        by smtp.gmail.com with ESMTPSA id m25sm2768631lfc.83.2019.07.16.04.11.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 04:11:32 -0700 (PDT)
Date:   Tue, 16 Jul 2019 13:11:30 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Sricharan R <sricharan@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 02/13] cpufreq: qcom: Re-organise kryo cpufreq to use it
 for other nvmem based qcom socs
Message-ID: <20190716111130.GB13918@centauri>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-3-niklas.cassel@linaro.org>
 <20190710061839.quncnis6pjyjntip@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710061839.quncnis6pjyjntip@vireshk-i7>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 10, 2019 at 11:48:39AM +0530, Viresh Kumar wrote:
> On 05-07-19, 11:57, Niklas Cassel wrote:
> > -static struct platform_driver qcom_cpufreq_kryo_driver = {
> > -	.probe = qcom_cpufreq_kryo_probe,
> > -	.remove = qcom_cpufreq_kryo_remove,
> > +static struct platform_driver qcom_cpufreq_driver = {
> > +	.probe = qcom_cpufreq_probe,
> > +	.remove = qcom_cpufreq_remove,
> >  	.driver = {
> > -		.name = "qcom-cpufreq-kryo",
> > +		.name = "qcom-cpufreq",
> 
> Should we still name it "qcom-cpufreq-nvmem" here ? Only the string
> here.

Sure, I can fix this in next version.

Kind regards,
Niklas

> 
> >  	},
> >  };
> 
> -- 
> viresh
