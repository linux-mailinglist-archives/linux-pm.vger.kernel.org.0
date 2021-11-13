Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6556644F229
	for <lists+linux-pm@lfdr.de>; Sat, 13 Nov 2021 09:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhKMI3h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Nov 2021 03:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhKMI3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Nov 2021 03:29:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F7AC061766
        for <linux-pm@vger.kernel.org>; Sat, 13 Nov 2021 00:26:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso8765935wms.3
        for <linux-pm@vger.kernel.org>; Sat, 13 Nov 2021 00:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dKUfatl1miH+nLBpROPo1OzL2IGaJUPRrE+2ZNKXzx4=;
        b=TSqOrtqFLLBtV0yHrvFGzaeIC0y4S6+GtpLfSORdEnEBcUpji9eQtm4GOeP9BjeC7F
         XgBkEPNaMRRAqeT7xfO5sy9hr1sgkedXeihcVaFdyhJVac3+inoAnuVzjsYRNTlIrt/T
         VC7QrXEbGTSXjWZCwNddtOKkep8CoR4Avd/SR3j85ljEGAn/U9LludDaoh7UdfqVUCUy
         3AL636YmjZE+iK0Y5jp66b22J1W1SfLz1MYuEn8/hjA7mZ603qJtVdmdC0+n/DkPy8tQ
         3b5+24X5vdAoR6xjUzFRBNRshaQJDKFcKQPhobao/29ZGEWM2l8hZoD1IFscccu3Olct
         Llfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dKUfatl1miH+nLBpROPo1OzL2IGaJUPRrE+2ZNKXzx4=;
        b=cu/fHRpnb4ECxDzSi+fHUoVZDlNBo8zpg0Ihpg+NiINr7zmrasFug7IonWOZQQSqXm
         EoM1MscXQgKgvQceJzr22C2+Qob/2PsHMEDZ4W2udhnmVNRhWiF15FS2J6HAY63mcWhO
         AQDMNdxdzpDOMzSbfqdGZsOmejYMMlMdMHTILOR3VmcpwyuP3MDEIrdXGDzHnhzjQOW/
         rn8bx2oEuzWFqLbsoVh8sQ9VGQtJ1iYCXNEnWt/dqoblvG9OFgezsPcUuubrfl5/B+l/
         RwLMugzryfgBEu0j61/GECvD66VaPW6YrCevKEwy4L+Pp3ijduyww4GGXoJh6E3W0VBG
         OzIQ==
X-Gm-Message-State: AOAM530fI3vumcRiRC96OWVMyMD88CtAqEqiq983CAKFC5K6ph0+etJo
        ohFiGIeL3l/v/1V3psA0Oglvdg==
X-Google-Smtp-Source: ABdhPJxuhN7KN1zm35KUmYSGM69mJA6bDRrvTvWT+OmHObUfhhPq0uy1kDDH3hyFzuZIXRaw0viu9Q==
X-Received: by 2002:a05:600c:3227:: with SMTP id r39mr44164293wmp.120.1636792003211;
        Sat, 13 Nov 2021 00:26:43 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:90b:17fa:42f:1e9c? ([2a01:e34:ed2f:f020:90b:17fa:42f:1e9c])
        by smtp.googlemail.com with ESMTPSA id n129sm3518478wmn.36.2021.11.13.00.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 00:26:42 -0800 (PST)
Subject: Re: correct source tree to make contributions to Linux thermal
 framework
To:     "Balakrishnan, Anand" <anandbal@lab126.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "amit.kachhap@gmail.com" <amit.kachhap@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Healy, Christopher" <healych@amazon.com>
References: <1636488946043.43408@lab126.com> <YYvuAU+d3TAS6fI7@kroah.com>
 <1636656130551.5237@lab126.com>
 <5007f2fd-285c-73fd-21a9-ab0029578d4a@linaro.org>
 <1636755294516.66191@lab126.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <01d80851-f26b-0314-b1a4-2dbc3a620394@linaro.org>
Date:   Sat, 13 Nov 2021 09:26:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1636755294516.66191@lab126.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


[Cc: Rafael]

Hi Anand,

yeah, actually it is a bit fuzzy because we did a small reorg.

You can either send to the tree pointed in the MAINTAINERS file or
against the tree I pointed below. I would recommend to use the later. In
any case it will be synced with the one in MAINTAINERS when we are close
to the release.

On 12/11/2021 23:14, Balakrishnan, Anand wrote:
> Hey Daniel,
> 
> Thank you for for the information. In the future, If I have to find this information by myself, is there a document for this?
> I was looking at https://www.kernel.org/doc/linux/MAINTAINERS and there are several references to thermal here, but I did not see any mention of the tree you pointed me to.
> 
> Thanks,
> Anand
> ________________________________________
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> Sent: Thursday, November 11, 2021 11:09 AM
> To: Balakrishnan, Anand; linux-pm@vger.kernel.org; amit.kachhap@gmail.com; viresh.kumar@linaro.org; amit.kucheria@verdurent.com
> Cc: Healy, Christopher
> Subject: RE: [EXTERNAL] correct source tree to make contributions to Linux thermal framework
> 
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On 11/11/2021 19:42, Balakrishnan, Anand wrote:
>> Hello folks,
>>
>> At our company, we maintain an internal thermal framework patch. We are exploring the option to up-stream this patch so we don't have to keep porting this from one Kernel version to the other. Looking for advise on the right device tree to get started.
>> Thermal framework code resides here: https://elixir.bootlin.com/linux/latest/source/drivers/thermal. What is the correct source tree we should use from https://git.kernel.org/??
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/
> 
> branch : next
> 
> 
> 
> --
> <http://www.linaro.org/> Linaro.org Å Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 


-- 
<http://www.linaro.org/> Linaro.org Å Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
