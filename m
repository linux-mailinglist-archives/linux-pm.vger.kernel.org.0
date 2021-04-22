Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880C6367936
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 07:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhDVFXV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 01:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhDVFXV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 01:23:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EF0C06174A
        for <linux-pm@vger.kernel.org>; Wed, 21 Apr 2021 22:22:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h15so13197047pfv.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Apr 2021 22:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HgPSl6VSw3n8mZkypE21VxQIUk7XXvdMYqy75Pka0Ok=;
        b=Q2+MUMYKxv6DX/kXTtayHKXsqM5vfBOif7ndvTUxBJn4rEB2KK4eB+fu30+Q3oKFx5
         pwKPTle8yqIvfCDDTi+FwNVp57cRZiGekl7Lu0JDShEkIhG0UwAE0TJbvPHAsC/WPjhE
         blNTt73qgdtKQu27fctvhND+iABMUyA7dQWF4rEWyQqxZhitECy0ZrOCcQfklgXZeVQz
         Y96x0NmiG2OPC71SAnrW0JDXbjQJ5vbjbST5L6JU1aKBCqzOvAlBGlshxIPCemakyvnl
         J1iZ5jHDW4jMp0G2qBQwVyiPhnP8CEMkLsw28AvtI0gvCMaTbwN9OmCDycKeZ/VLOqVC
         h1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HgPSl6VSw3n8mZkypE21VxQIUk7XXvdMYqy75Pka0Ok=;
        b=iTSm6qB444s9WqnsHnTKR6DEd08bLJn3I483FpTyRngf87rAuHi2d+nA4bbEIipurX
         iQ4iy8VhFRqqRRpa3fQ/L/UdbdpYqjW8codKPflmXbgLvE83/CdbNxTo5v/3Zmnm/uUm
         KUELK2xfWEgG7GhWz4DFRWrBCLoCdc3KuFGz1j/1dTzF7fivYbtVG/K3VVw5vpjriWHu
         CQt9fmwAFnpMXYjfV+eLPDqe0NLmNWQ+bk0f3TZfvqpi6pxxpuTZojiROI9CVF7OG8lp
         +/kzDqUnm965QE94o8eallfk9wbzhKWpYI9S0pvo/kKAG40jJYlXCwvS1vQrLkn1sKwP
         fekg==
X-Gm-Message-State: AOAM532CE2HPgveSFkrc21m4JLeCcfIWSobTzW++2K6vxli8NOaLZ0u5
        votJW+MT8zUuxo21LYquYMTq/TzH0L7Vhg==
X-Google-Smtp-Source: ABdhPJwtaWjcolBXs0QEQrQ8bxFtqE2txt0i2kHgMdQPq8Td6YqQh1+8OZH6oN0E0XtStA7gn+0o3g==
X-Received: by 2002:a63:4d5c:: with SMTP id n28mr1817749pgl.436.1619068966279;
        Wed, 21 Apr 2021 22:22:46 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id l3sm3553277pju.44.2021.04.21.22.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 22:22:45 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:52:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: cpu governor and cpufreq
Message-ID: <20210422052243.6a3i6gwgys57pvuc@vireshk-i7>
References: <BMXPR01MB287059E28B26332A636573ECEE479@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BMXPR01MB287059E28B26332A636573ECEE479@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-04-21, 12:03, Pankaj  Vinodrao Joshi wrote:
> Hi,
> 
> i am trying to explore linux power management and was going through
> cpu governor and freq scaling but i have following doubts can
> someone help me to get it clarified
> 
> 1) i understood that there are different governors implemented in
>    linux kernel like ondemand, userspace etc. and each policy can
>    have different governor for each cpu ,

No. A governor controls an entire policy (policy is used to relate
CPUs, normally all CPUs belonging to a policy are controlled by a
single knob (a single bit in a register), and so they all run on the
same frequency all the time). There is a driver flag
(CPUFREQ_HAVE_GOVERNOR_PER_POLICY), which is required to allow a
different governor for each policy, without it same governor will be
used for all online CPUs.

>    but i want to understand
>    how these policies are interlinked with drivers, how they will
>    use governors ?

Policies are created (or provided by the drivers), they mainly
provide a function to change frequency (only one of target(),
target_index() or setpolicy()).

A governor is not related to a driver at all, it just tells how and
when we are going to change the frequency, and cpufreq core uses the
above callback to make that change.

> 2) which governor to use is this written in the driver code ?

Again, governor doesn't have anything to do with the driver.

> How i should verify which policy driver is using ?

All the policies are used at the same time, as each CPU needs to be
controlled by a policy..

>    i was going through
>    gpio-brcmstb.c and i was not able to see anything about cpufreq
>    scaling.

-- 
viresh
