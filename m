Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBEC23D0E4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 21:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgHETx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 15:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHEQtS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 12:49:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71514C034622
        for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2020 06:04:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 74so14406187pfx.13
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2020 06:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FnY/wOfG17U2evXDryqB1R65hFqH8w+FrGcWYVmAVPo=;
        b=NdPdO2Qp3EtI8fJ/6wWI5wjq47zVlVrky1fF0BJcsc0oi+v+TxcjSeukF1xTd60AlU
         ze58kZphJ5ivGUQndd0DNaxqElFoFtB+aVL/m6+0lxRzFovh+IUBc5GGdqTSWj5ZD6nX
         zM9xqQxaBSj8UWPJQTuyQIS85hSGP9baInt9emfy6AsYHx+SIsVrlQ9nM/pSibHo383S
         V/bmYrQIa+r1SIz3NZJtqrka1eHUP/tlV0AdJqsO4QzQUAmpFx6p+zfFcSSrerEespBX
         IFkPVKqotTiRy1UUrS27cjNsmopQ0iK9pb+ctyPPqdW+1xivubkl9396TMFGOWR1fX4o
         UjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FnY/wOfG17U2evXDryqB1R65hFqH8w+FrGcWYVmAVPo=;
        b=fx7IQPE9hKzUTX7Ewtk5owZ67a3QeDKh8tmKavVfnPG3fpQlDrvXbd8uDCBSeOV7Ag
         IWAIHlFytRrLW2SAHFNLkAEGAo+FYtTQRdmA/8VaKjUyURfWTH1klf/1qb9s9lzFsCP3
         iGpOCxKhkV28yW3l0xZQERHdCyRG3RTuq8QNTUg2gon/Jz1lUfiu6g0O7ZPIfMJp7YLH
         WraGA6RDlA0g/sKpAxo64zSeOIS6I2fyrxwQOn2LId56xbWJOIhYlYhQbRoK/7hlputY
         Kyno3+dEjKQzC+GDTLkJJ/aG5/k+uYzS4AGf1tiOEeEiQIFH1YxaR/z5eRV6WQVvkGPQ
         PG4g==
X-Gm-Message-State: AOAM532ywp1VOBcC5vzBVRyNig0uyTbh3E4kAW8cEKCDqcazT2YZaGNg
        yb0AA+Xka9DjUFCtDJLc5PzUMw==
X-Google-Smtp-Source: ABdhPJx7S819oCITEbdX1G81mfh3R1LyaJcjIYWSwKa5durMR8TWUF5eY60q1dM6Mwb+JYswZbrvaA==
X-Received: by 2002:a62:7f0e:: with SMTP id a14mr3369514pfd.320.1596632684631;
        Wed, 05 Aug 2020 06:04:44 -0700 (PDT)
Received: from localhost ([223.190.59.99])
        by smtp.gmail.com with ESMTPSA id n12sm4200840pfj.99.2020.08.05.06.04.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 06:04:43 -0700 (PDT)
Date:   Wed, 5 Aug 2020 18:34:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        cristian.marussi@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200805130436.3d2g7z2rsdoesuuk@vireshk-mac-ubuntu>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <a3354ae8-f40f-83f2-d6eb-7f588af75e97@gmail.com>
 <119ce268-18dc-7a4c-b0b2-3a66ff9ff4b0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119ce268-18dc-7a4c-b0b2-3a66ff9ff4b0@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-08-20, 12:04, Lukasz Luba wrote:
> I know that Viresh is going to develop patches and improve these
> cpufreq stats framework. Maybe he also had this 'aggregation' in mind.
> I will leave it him.

I am only going to look at cpufreq's view of stats independently from
the firmware.

-- 
viresh
