Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB66B3955AD
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 09:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhEaHB5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 03:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhEaHB4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 03:01:56 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F25DC061574
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 00:00:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id q25so8334905pfn.1
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0cI9a13eI39oGfs3qq6toKoSIsN69Wi6fPtAR/rCyPM=;
        b=RHawpBbR7PJW+BWTTlJeTKrlM9LMQC/TYMF+r6mIbTgAedSxJroBKAJDuFH7ElrhKq
         CKWIoqvvq3F0xeshwn4jKs6BffzkSoBzVtw28ywhzg9OmHq2bV0/rviGNHzFy4TkO48h
         N0pQRaa+/pu1MXfWo2hewt1KPn5M/JduyStKzFyYF2sQK22DfBci8IoTzy7PG7qpeznU
         4CxuxApeJwKXl96L4kTmqsei2xFSQk2npSY2RHjGm0yeDWN9mFR6G07o/3X6KbeZto/S
         6XC92KRDVBC8UcJvEbOM+jNkmz+DWPBpRPydy4qjcoIJKhbJJNvjY/kkbeVbQuUchq2Y
         XTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0cI9a13eI39oGfs3qq6toKoSIsN69Wi6fPtAR/rCyPM=;
        b=cDSekC2o2yEZQZgMIVKLH0PHHHllu0g8Fs86FXVm0B25Kn0sIEV/BXU2dHyYJ7uICV
         w38weBBNiQQldxLXTnoBiy6uUswy7p4oV6Q/geTYwCo86r8dCFR6ZES8FtQ4QdRvhjNB
         pu8cO2uGzd8isdTSeblAItZpccgIAO7hpcFlbCeLROBwLiqBFMneNZelFskTPCQ1Hvsl
         8uC3Nt1w4kNpc0gX309dU8UH74PiaGV5QqCjVB3TMZyQlrdLjyYV+Ul/vvkr4/D7UPO5
         jbAqELfQUQDPt+y49VsG8TlulK0jtHlz0pD38wERqSkdaWJ/WVgEl5Fh8ybgAztp37x/
         pwDQ==
X-Gm-Message-State: AOAM5302pyOQicD1AjwApYHeuw9gQUja/amMabk4+e3ppAoIjy8p5sjx
        9645M7tQqGZYLTnERsrATVOzBg==
X-Google-Smtp-Source: ABdhPJyfmJRCIgp0cqMRS5e55B86SoB4C+bnKxQ3GXfxAIIOvEuFlTOIVLO3HUXGItddE7qsHdBKkw==
X-Received: by 2002:a62:55c4:0:b029:2e8:f854:d31c with SMTP id j187-20020a6255c40000b02902e8f854d31cmr15428034pfb.59.1622444411513;
        Mon, 31 May 2021 00:00:11 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id z15sm1146240pgu.71.2021.05.31.00.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 00:00:10 -0700 (PDT)
Date:   Mon, 31 May 2021 12:30:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: Dynamic power management
Message-ID: <20210531070008.crnzij44jk3pfs7q@vireshk-i7>
References: <BMXPR01MB2870D9D1E222FFF4BE1FC3C1EE229@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <BMXPR01MB28706C00AA1203BFC31E56B7EE3F9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <20210531064726.t3oosgjqafb4raez@vireshk-i7>
 <BMXPR01MB2870C33B5B7A146A35A654B0EE3F9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BMXPR01MB2870C33B5B7A146A35A654B0EE3F9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Are bhai, you need to register on the below link. I just gave it to you.. 

http://vger.kernel.org/vger-lists.html

Go here, search for linux-pm, click on subscribe, enter your details


On 31-05-21, 06:57, Pankaj  Vinodrao Joshi wrote:
> Hi Viresh,
> 
> i have tried to send mail to linux-pm but every time there is issue with mail delivery the mail is getting delivered to you but not to the list. Even  i tried to send through gmail too but facing same issue.
> Your message to linux-pm@vger.kernel.org couldn't be delivered.
> vger.kernel.org suspects your message is spam and rejected it.
> Pankaj.VJ       Office 365      vger.kernel.org
> Sender          Action Required
> Messages suspected as spam
> 
> 
> Thanks
> ________________________________
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Monday, May 31, 2021 12:17 PM
> To: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
> Subject: Re: Dynamic power management
> 
> You have send an email to linux-pm list, have you subscribed it at all ? I don't
> think your mail reached to anyone there.
> 
> http://vger.kernel.org/vger-lists.html
> 
> On 31-05-21, 05:22, Pankaj  Vinodrao Joshi wrote:
> > Hi Viresh ,
> >
> > I am working with the new architecture which is new in the market and is not fully mature with respect to the dynamic PM. I believe following are the frameworks available with dynamic power management but currently i am using cpufreq framework only
> >
> > CPUfreq, Devfreq
> > OPP
> > Genpd
> > Runtime PM
> > Clocks
> > Regulators
> >
> > Can you please guide me if i want support for all above framework what and all support i should have ? What is SoC side and kernel side dependency implement above frameworks?? Kindly help.
> >
> >
> > Thanks
> 
> --
> viresh
> [EXT]

-- 
viresh
