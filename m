Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915CB141B2A
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2020 03:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgASCZQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 18 Jan 2020 21:25:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44235 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgASCZQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Jan 2020 21:25:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id 62so7295606pfu.11
        for <linux-pm@vger.kernel.org>; Sat, 18 Jan 2020 18:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dTrZCBkewhR6vLVB77oZ0SSXBeG8KYL0GW7GFSN+FnE=;
        b=iwVk3BA21WLg5/7JVvxKRP3tCyVtKvzjKIoNMvuGX5cDpYc48Povn0zMkaoY4Go0Rc
         MAREiZJfgBOmDRv609TJ0sjPSPgGGnjFU8gaO+itqtY98JJA7lGh4tQFej7cH+g4MALM
         DVl164Bd1qTyr0+mfZoF4XoXADe7ctw1r2+dpK4Ed1rtSE+imA4WqJtnPkwuViFuqPAO
         aoJyAEWl47gcDZbfd6OUs3Mn2eQBUItA5mKmKvD2MrrCf+wXzssIxvyNQpuoVLeEQIz2
         gp93Tb/hJJGN3dnWUUkwzA/G/W9UE0BWF54hggRHr1/gCozwM1OKrFYjcOFjGYBK512Q
         9AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTrZCBkewhR6vLVB77oZ0SSXBeG8KYL0GW7GFSN+FnE=;
        b=C+yFWdkxmX4QA64WIK9n5l05be+7JdCJWI8NRgehOT3JrCvBkg+8SEiOgeRcSEU3NR
         Q9j8mxmVWG1SyGctUxtzncyvDWu928tNgQG4t7ouDFddoCbnq7CA/yYkEujflReKci3N
         atnyQxh4WNLk617dQm3zJ2hmfGoSm4wNmsUiQBNJBedbn8fTLtad7Y9WKTncJ5ZvbF7z
         nwZOMoZuEWVbquZ6Hf+IvhH3RqyaZ4XWFC77tMnOqbXIe7rFvGW8r0DYY1/3zOkQYC35
         98E0B7weQYH5/+LPKbpK4mm8Hc4LNJOql6a472tyToU/0leLleI00LoSpmGqg5RxPsmt
         PP0g==
X-Gm-Message-State: APjAAAVfdpyoTWiguWKWexVUf1ERu4hKqll8Ueru4Lb0yIPa1egU/2JD
        YvyMpfTaxS3oBI+dpq0DX5k=
X-Google-Smtp-Source: APXvYqy4jV3Jx6p9CNZk9DaObz5rsgtr6HZxKEhG54e1AQVylDXjSigIJEe6E9TCNTooRShc49cXBA==
X-Received: by 2002:a63:f643:: with SMTP id u3mr50862475pgj.291.1579400715911;
        Sat, 18 Jan 2020 18:25:15 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id b65sm33984060pgc.18.2020.01.18.18.25.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 18 Jan 2020 18:25:15 -0800 (PST)
Date:   Sun, 19 Jan 2020 10:25:13 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rjw@rjwysocki.net, f.fainelli@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] cpufreq: brcmstb-avs-cpufreq: avoid potential stuck
 and UAF risk
Message-ID: <20200119022513.GA21407@cqw-OptiPlex-7050>
References: <1578228650-17157-1-git-send-email-qiwuchen55@gmail.com>
 <20200106055637.zq4icl5klg4wpvkx@vireshk-i7>
 <20200106070910.GA17897@cqw-OptiPlex-7050>
 <20200106073109.ndm7enzyznquqps5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106073109.ndm7enzyznquqps5@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 06, 2020 at 01:01:09PM +0530, Viresh Kumar wrote:
> On 06-01-20, 15:09, chenqiwu wrote:
> > There could be a case as the description of this patch besides
> > brcm_avs_driver unloads. Since cpufreq_policy_free() will free
> > the mm of cpufreq_policy at the last moment.
> 
> Ahh, right. Please fix the other "policy" thing I reported and resend
> the patch then.
> 
> -- 
> viresh
Hi,
Any progress about this patch?

Qiwu
