Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70CE7C4932
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 07:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjJKF0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 01:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKF0z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 01:26:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588FE8E
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 22:26:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c88b46710bso35300565ad.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 22:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697002013; x=1697606813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7LIxd8tmkXQNk22je5bQbirCOvsUYcJoh2rUfnuEyM=;
        b=jNJBraD/XYtkm9Ozb86b48O2UywarRaU0NxCaBrWjFtz5KZ6pnTX997jQPJept84ox
         gQzRjybTUxQse9DnqPQUYuNrvsItZvjBmenJfs85aJ8nP+45X0lv3iNfx6+vuHgkVjil
         UWrFVInJzC3s2xMOqM0OFLITpvAODZC0TH/r4/c8zwFWC2gmkL+0GW0JyR+dt8mM3jxi
         IaVT+Zt5mg6ZxsYkuvjbkgW+JCoVymsK8f2uXwwG1yMp58ENMePIgR/iF+KId2CpZ1Vm
         dPsDFB9MukV9irTsoY+G37zJ7GYfQrm+azN0jIYCKe+TRCSYBmaUpmwXtVQ4ZKv1BtgH
         KboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697002013; x=1697606813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7LIxd8tmkXQNk22je5bQbirCOvsUYcJoh2rUfnuEyM=;
        b=tUjWmOTIJLOXEm3sbrwOfbDRI0lIFlrzSSglPB0RD1NWtcFLUP2WwqgSEFreQG2VK+
         oSi3T/vMghIpV4BdtT76gCoSjnc+RNRC9331wo6zYDxNSBFP3vuvvOfs/mUC9TiVEmBk
         w4BtbXDdKYf4aP52GFGE+iYJzgBcPz9SZVLJIRCxxoyfOn7YAtpQMNEzaAcVdsCfMmoH
         3wYoG3uJxC69j/E/KrCCB1Oju2o4TzxV5cxRMf0dVl7VZzv7hUc1nrY64DB84ifmK2ZW
         mBRaJO2Y79BDIG3U4KRSjmDiJpoUyJLMW0ZpPvsYW7souJm1rR6EdSBTqLvczwo3Bv8m
         fzEw==
X-Gm-Message-State: AOJu0YwfD23cK3rW889ZyZfdmCIxnuXJPEE5u2XglnZqT4P0y91nmI3v
        K7wsOd+Vo5JiMGu4t2THbfw/4A==
X-Google-Smtp-Source: AGHT+IGXl0KjS9+SAfUKmvWeye1q9gQWzqsLucPuTz9SB8LNxhW1XcdCkb0em1aBE5w3kqKPDNgKbA==
X-Received: by 2002:a17:902:db06:b0:1c4:2ca5:8b7c with SMTP id m6-20020a170902db0600b001c42ca58b7cmr19815364plx.61.1697002012779;
        Tue, 10 Oct 2023 22:26:52 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ab8c00b001c444106bcasm12840463plr.46.2023.10.10.22.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 22:26:52 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:56:50 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bryan Brattlof <bb@ti.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        ARM Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] cpufreq: ti-cpufreq: Enable AM62P5 CPUFreq
Message-ID: <20231011052650.vxxfeqeozrwleuim@vireshk-i7>
References: <20231010175524.558577-4-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010175524.558577-4-bb@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-10-23, 12:55, Bryan Brattlof wrote:
> Hello everyone!
> 
> This short series adds the am62p5 compatible to ti-cpufreq and
> cpufreq-dt-platdev for the new am62p family of TI SoCs. It uses the same
> A53s and efuse configuration as the rest of the am62xxx extended family
> so we're just using the same am625 data structure for the am62p5.
> 
> Thanks for reviewing
> ~Bryan
> 
> Bryan Brattlof (2):
>   cpufreq: dt-platdev: add am62p5 to blocklist
>   cpufreq: ti-cpufreq: Add opp support for am62p5 SoCs
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/ti-cpufreq.c         | 1 +
>  2 files changed, 2 insertions(+)

Applied. Thanks.

-- 
viresh
