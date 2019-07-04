Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD65F1C2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 05:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfGDDTA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 23:19:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37227 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfGDDTA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 23:19:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so2234221pfa.4
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2019 20:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kknuiE25JazcoWI+ohjzHmUKAkhig4V+ZiiIxT9Gyb4=;
        b=d27RkAq9gKLJqrY+FycTST6nQXQQSRTiG8AB7gDmrCz6MV8pBTjJrlEeFVwZU9HJqk
         VJXfzcCghYPG+VRhuGsMS/sG3qOEeLXnZ/5JFCSXJmojrRwyqUMQfBKzNPfzuyZw2FcP
         b3GlyHnPYzJ5XtuEuoL3eXjfZ9XZlrp9R7qlsPOOwXaaBEZsjL0QULe1Y24HMZnt5EUe
         MwK4ezYEm3xazpgP/+CB67NcacklSUP8ag5GsyEIs86R7tIllqysNCq7iwknpKYRYucY
         o5xd6cJfhNAVNqY9EbVTEzPYs1lJ3lzxCZ4Gcvv+yudL0VQrNobBljxJcS8kCLkBd3D7
         hc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kknuiE25JazcoWI+ohjzHmUKAkhig4V+ZiiIxT9Gyb4=;
        b=m/bO8snDviBNWTVVticBKlSGvdJ5Ygk9BvQGr2Lg5Z7oLGlU54dxLBw5bTIbMOJPWd
         elV61ZA6+H1+xOpf4U54c3u83pc5qTvfBKg5a9UyDfRu10BAWbFTORmckcQhY/CJ15pA
         IyexaBgsa3bovoxMaAJWspUeCEZIgg4cDp25CzaWdm/0YC+W7F8k2mwr1JFTjQOdoQVx
         ZA7UO0hIXzwtLu24P3j64hKYnhgBxGVUN/+lmZtiPaxAYQxPpBt3dlG9vtBCFGWs6VHu
         GVMGe6Nak0qYX24Nbsr6+bQxM9a5wpdvqe39JePVLjbE3RoTaJedurw88GcSrw8s0c0J
         VzNg==
X-Gm-Message-State: APjAAAU67MhtpPvvuLyMvbWHeMbre5j5t+CUc4Q9LVPE/mb+4XFOtlMs
        C4+34r395fdxxz3Ect91j8Frag==
X-Google-Smtp-Source: APXvYqzaPtJIZTxux2+hj4YNN+mXNrtHYW7qJYP/0i9PfTolR0OAk0Ic6hyutbOKjiN8aZcJQNt1/Q==
X-Received: by 2002:a65:64d3:: with SMTP id t19mr31597381pgv.112.1562210339316;
        Wed, 03 Jul 2019 20:18:59 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id r6sm3137424pji.0.2019.07.03.20.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 20:18:58 -0700 (PDT)
Date:   Thu, 4 Jul 2019 08:48:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [pm:linux-next 91/102] include/linux/pm_qos.h:197:9: error:
 expected '(' before 'type'
Message-ID: <20190704031856.bpmvzbcor2idqj66@vireshk-i7>
References: <201907040956.ywZASIcA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907040956.ywZASIcA%lkp@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-07-19, 09:04, kbuild test robot wrote:
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> head:   267eacd79cadd5e2d6307320497d66119907c411
> commit: 57fa6137402b98327d1247c5aaf3d4f0595a73fe [91/102] PM / QOS: Pass request type to dev_pm_qos_read_value()
> config: riscv-allnoconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 57fa6137402b98327d1247c5aaf3d4f0595a73fe
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from kernel//power/qos.c:33:0:
>    include/linux/pm_qos.h: In function 'dev_pm_qos_read_value':
> >> include/linux/pm_qos.h:197:9: error: expected '(' before 'type'
>      switch type {
>             ^~~~
>    include/linux/pm_qos.h:197:9: warning: statement with no effect [-Wunused-value]
> >> include/linux/pm_qos.h:204:1: warning: no return statement in function returning non-void [-Wreturn-type]
>     }
>     ^
>    include/linux/pm_qos.h: At top level:
>    include/linux/pm_qos.h:219:4: error: expected identifier or '(' before '{' token
>        { return 0; }
>        ^
>    include/linux/pm_qos.h:216:19: warning: 'dev_pm_qos_add_notifier' declared 'static' but never defined [-Wunused-function]
>     static inline int dev_pm_qos_add_notifier(struct device *dev,

Very embarrassing. Fixed these two now. Thanks.

-- 
viresh
