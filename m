Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E315BB4E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 10:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgBMJPl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 04:15:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44429 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbgBMJPk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 04:15:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id g3so2621308pgs.11
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 01:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6QR0i5D8maH05N1Xqm10UqPqza2GaWPuWHxOqQlujp4=;
        b=TsLZQpJtI8RTw9gJ4uw8zrgwAsCbYJEWmx1f5jjKeRlB1ZLy83x5nmAhOhunt6eKEk
         lzKkWQ9DyXgC4OQYqLecPVn9fV/DLPazYRNvb7XiIpOshO0Gd5ROys1KZP1ItmdQsuqR
         qljKgEg37AGeoXzLKs/0QZ+Vhr3Z3ytPUtcovIhlooZdDG/HUa226X18yYFgOOZPz12C
         ogBWqHls468Z93WnAWZEKInOyxCBixscxmIG7ecDQeLbd7vzVfCQomu233pcwASZ43zD
         mJzg/1GmlH7h9gwah5vobpBzpLYLQtv0MnnQ7YQfR5HMO/YUytWFZuqvasdbBtsmNRgo
         wNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6QR0i5D8maH05N1Xqm10UqPqza2GaWPuWHxOqQlujp4=;
        b=B3bOqhF6krVFlddXkn4TptIEiIlLVqqIlpCmvwe7uNH5sB+oa6WPJJ+Oz9yvaTm7h7
         UyBax525hjwICAY5r3CcLd00QObyFBwxHeCIm5ojrqT+TzGV4Wx+3DDUywbtu9AOb+IU
         mktZ1Q6ae+uSAWIRH+476Cklh/tNamJB+kE0EGXnD8YoaSMDE81Z+4ckBsqE2mZxFCZ3
         KtclfIt0Iyx8nrCxG13g3qNEBMX7YwuqsuKNtHD10rLos26UoRc7irg4JeQcr7R/DPwa
         J4n0rgnT1vz2k9nD+y295IQt2hEqNV6q0206a12X21Qjm43MYf21n070ear2jj+YZvRH
         TKTQ==
X-Gm-Message-State: APjAAAX5a+d6EqDYTDIt3tbwPh+a21b0pKN2dNQsdssGmKa4ro6Jy4Ba
        Dm8LnYIRbabPA2EtJvvRXStq8Q==
X-Google-Smtp-Source: APXvYqx5l192f5XlrGi5tCGWrHTbHIJyvKe2MRQouAcBtdNVrgwr0A3OnycrxSu7YBo97Xj3auau0g==
X-Received: by 2002:a62:7a8a:: with SMTP id v132mr13543263pfc.111.1581585340023;
        Thu, 13 Feb 2020 01:15:40 -0800 (PST)
Received: from localhost ([122.167.210.63])
        by smtp.gmail.com with ESMTPSA id 3sm2001563pjg.27.2020.02.13.01.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 01:15:39 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:45:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [EXT] Re: Ask for help about cpufreq issue
Message-ID: <20200213091536.bwxyuwjzga4uogeb@vireshk-i7>
References: <20200207070544.geurecsy4i22xpzl@vireshk-i7>
 <VI1PR04MB4333E6B3340BADBC737E9CFFF3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211055315.qlqrxiqf72u36ijl@vireshk-i7>
 <VI1PR04MB4333D6A41BD1AB77489E3139F3180@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200211063439.aqc4h6np3wjpsg2j@vireshk-i7>
 <VI1PR04MB43334811F21E85BD9DACE259F31B0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200212115054.eouh7e42uqlcweo3@vireshk-i7>
 <VI1PR04MB43332FB8B9FAD91160D91A0CF31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200213084819.jveurrsvtv72ssug@vireshk-i7>
 <VI1PR04MB4333FD2725CA091989CAC979F31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB4333FD2725CA091989CAC979F31A0@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-02-20, 09:12, Andy Tang wrote:
> Hi Viresh,
> 
> > -----Original Message-----
> > From: Viresh Kumar <viresh.kumar@linaro.org>
> > Sent: 2020年2月13日 16:48
> > To: Andy Tang <andy.tang@nxp.com>
> > Cc: rjw@rjwysocki.net; linux-pm@vger.kernel.org
> > Subject: Re: [EXT] Re: Ask for help about cpufreq issue
> > 
> > I agree. Which means that there are some spikes of work getting scheduled
> > on CPUs. The load will increase slowly and will also decrease slowly
> > (step-by-step) with conservative governor.
> > 
> > > So I can't understand why cpu frequency increased?
> > 
> > Tracing or debugging cs_dbs_update() in conservative governor is the only
> > way out I would suggest.
> What's the *TRACING" here referring to? Could you please explain more about it?
> I have no idea what it is.

Sorry about that, I was talking about the in-kernel function tracer
here.

https://www.kernel.org/doc/Documentation/trace/ftrace.txt

-- 
viresh
