Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A738C262
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 10:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhEUI7T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 04:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbhEUI7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 04:59:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0BDC061574
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 01:57:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so6812086pjv.1
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XMIrhbwqdqHX9d4VQOfjc3Qvdk/hAz3k+PVc81KsXYw=;
        b=vZ6nFGFW+rs+B3TG0YcFLNVuEoYaAmowFtVYmgz5wsrArRdUQH01qZ0cflpK+kNs4C
         S+4jWbXKp90rDJTKUlUO2KlWUzNna7jiztym6B1wcWWBhP9m91h4uS1TMMyWYUaALQMo
         KkDkQ9uLWRU2EZxs2zVh3+uNygeW7CYsjnj26S3upmH4kXtVMwbDYrzbK5Axc+0jWZWy
         MzehTIRLphgKccNJvDeruI+cJtD8FycUebLImTvcsImSBl01ldPnlUmsrFrBd9Tw6qIz
         pavVKdOBP07WPvsWb5WsMcQQFGZNaa0XMU7+RWaLv/1kXspo2Zk7fLrjwba2xw865N1w
         f4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XMIrhbwqdqHX9d4VQOfjc3Qvdk/hAz3k+PVc81KsXYw=;
        b=ppbCoZnAQBRm2pWn6k6Wf6viItx5P5CdfQmG7WqVieNfBdhBXUHMaWRA2rn+VDDJf8
         OUzNJFLGwH9RIipQQo4FyExHKkMS4g73gNqCRH71IXX2bwtlM5W8+quUwzQTxwZc8IHO
         GXPDUpCIPvWWRc86Lk3MsbPhlO/gCO+MVImt05cBmCGx2FZhKSuSnen9OUPACfkAtzVa
         DPUADMhhIjYc1RhsyR4xTHNqNp26YhCiLg0Oz0XIS5k+tEvfCBDd1ouP5g8kt0cyqONB
         rdarT1KRt77ndeDV5buYuWz+J4EneFltVkr2/4stXX2nf7yn9ns0gQgBLL+VxHl8/S4J
         Txbw==
X-Gm-Message-State: AOAM532Y5HwgrO/c9hQVgF35kpJrAimhKOVgxYmo4f/tDI7eAUS3fSEZ
        eILFZD79S7N4VvoYK8bSoLafMg==
X-Google-Smtp-Source: ABdhPJy6YctGom52wQz70AZNwXg1+Vl/X0e9tVWoLvgYUPdjczVyIgYcgM1roXX+RP+dnrz0gZ1weg==
X-Received: by 2002:a17:90a:f0d2:: with SMTP id fa18mr10170795pjb.126.1621587475062;
        Fri, 21 May 2021 01:57:55 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id p11sm4034207pjo.19.2021.05.21.01.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 01:57:54 -0700 (PDT)
Date:   Fri, 21 May 2021 14:27:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: suspend to RAM opet
Message-ID: <20210521085752.76lbzijawjg5jomn@vireshk-i7>
References: <BMXPR01MB287032B27D235B5749A9C43CEE299@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BMXPR01MB287032B27D235B5749A9C43CEE299@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-05-21, 08:20, Pankaj  Vinodrao Joshi wrote:
> Hi,
> i understood that when i do $echo mem > /sys/power/state the complete system will go into suspend to RAM state also while going into suspend to RAM state the system will perform few operation like freezing of userspace ,blocking interrupt etc.
> 
> But i want to understand when i do mem to /sys/power/state exactly where this will get written and which driver/file will take care that this mem should reach to each device ??
> 
> Kindly help to understand how the entries from sysfs interface will reach to individual device driver.

kernel/power/main.c: state_store()

-- 
viresh
