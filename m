Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42036EF5A8
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 07:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbfKEGrm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 01:47:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41718 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387567AbfKEGrm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 01:47:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id p26so14418587pfq.8
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2019 22:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c8eBVSCLgnx4UHNdOIdUmMHjAPLlK/lRDbaNxZy4A4c=;
        b=mEPTpthPqrMH5V6gpUyO2MP9vjXUVOG5F+cfT9fHTAvMDsPPnu++Uy0Y/UG1VJn5YB
         reVqWzhKjLkXKJEVOpPWdARHD0lqj2UqV+m7feK5PILe6moTpRjApPU5kK+I0/R3+RPc
         1Ng5a7znl+03oVa+3EvpFWPqYHxP5S3K1iv22FgcNrumGnBOOsKrmoRwAwoYfl3p/JKO
         Yz970pjFTHptsZLlCJ+GJUF/T33U/rERVx4Z+cntj127yJee4y01vFwqsfBQysMyyTmz
         0GV7j8Bhm+iIW7YG33GDh50N70CaHEuUuf6kqNCOzhYt3AR2Q39VH9eMvy8dt11Gatq3
         IomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c8eBVSCLgnx4UHNdOIdUmMHjAPLlK/lRDbaNxZy4A4c=;
        b=lbH7DrxurVPCTrqEX9wBWOjh8EbL78fB39g0J37sxHUoc4dAMi/LxXK+LyE9pATZG3
         1VvxTHcnuxeG8om3GnSe+/3QTF/hOLvfzW375I5a7jnPHMe8PDG/xfpb1qvH0d9U0t8g
         zV96BAuY0DAmpPkS/neLUgmDU3Uu+XhrynzTX+KP+4SS9by8aPY02oPL1ep4aI+krbfK
         AXW8YMdO4wKtip6/jwQu6pSyzcnjiPJr7L8Gri3CFy9XoZU8zUzkL/gEfpQ8jm8au/81
         51tsZI9SPdEFx60/9d3r790G4rIQrKQ3sr9Ji5b1TSW3+JnW4rbhqqNz8uNzpU4Eqja/
         FWAg==
X-Gm-Message-State: APjAAAVwZd/Ez82jG2nejQp+C63mySRWsbO50mQKwum81ExAVO+JKCWH
        HOD+ZIhKyclOadkw94V92n0WAQ==
X-Google-Smtp-Source: APXvYqysgFxpzP8+b+00PPJbazsimS6pA5b/uc82/LVtNch0fd3yxbSpRVAafZ4s/JVNEawZcmWuKQ==
X-Received: by 2002:a17:90a:1089:: with SMTP id c9mr4506695pja.8.1572936460366;
        Mon, 04 Nov 2019 22:47:40 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id q184sm19465254pfc.111.2019.11.04.22.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 22:47:39 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:17:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/cpufreq/brcmstb-avs-cpufreq.c:449: bad test ?
Message-ID: <20191105064735.t6qiz2kc266em7vi@vireshk-i7>
References: <DB7PR08MB38017C35D2B5E025804338129C660@DB7PR08MB3801.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR08MB38017C35D2B5E025804338129C660@DB7PR08MB3801.eurprd08.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-10-19, 15:18, David Binderman wrote:
> Hello there,
> 
> drivers/cpufreq/brcmstb-avs-cpufreq.c:449:61: warning: logical ‘or’ of collectively exhaustive tests is always true [-Wlogical-op]
> 
> Source code is
> 
>     return (magic == AVS_FIRMWARE_MAGIC) && ((rc != -ENOTSUPP) ||
>         (rc != -EINVAL));
> 
> Maybe better code:
> 
>     return (magic == AVS_FIRMWARE_MAGIC) && (rc != -ENOTSUPP) &&
>         (rc != -EINVAL);

Right. Care to send a proper patch for this ?

-- 
viresh
