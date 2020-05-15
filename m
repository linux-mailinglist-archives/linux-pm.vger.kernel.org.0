Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9791D5915
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 20:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgEOS3r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgEOS3q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 14:29:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E31EC061A0C
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 11:29:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w64so3652117wmg.4
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GJ9JhcL5w+UKUif3imo4eTLikeA01EEdC4v2F/TAyYo=;
        b=u4wTi9baIUhOAwGePlS93LW9WleOHD7hiHU85TQGl6kB3A89YHNvOVKf9nEa2ZXwDJ
         ewBNDg7Ru3BbIHGC9RE1x6g/scMTKPw1m+OMX1T7wPehuTbdnnCm44X5eYyDJtBt2+iG
         OqJ6p8zfawDjNrz3roVA4TlmfPBQwR5ntqqCYbZpX7wgksam+Un9Iw3nrxpU/STzjnCL
         WjN3tcva3TaGFtTrzgBximFbVol9XvBsJeT/KK3ti6lFni/Sk4egi+jmWLOhWMmHZJc3
         r6FyyyAfOThsGFnz5mw/JgFj81cQEoeSL8SS8HWjlSRYjQT1C0mFnkuPW7H5rrnTJYsC
         6fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GJ9JhcL5w+UKUif3imo4eTLikeA01EEdC4v2F/TAyYo=;
        b=BaCuFN7i1aSsZWfW91xbGT0b+u0yvN4T9nNNO69i7rqh/R9IeIrwupqvfLAdLP12eZ
         ADdh07+EHWWMNmh/CqruIuH8Rp+RcFEVHysl/XwaK24q6mi+iF2+kYb5E/C2NIMj+nzy
         dK5DAGXXTyn9oeoEfFEb8N+gbN3a9CwvJcdPFsa2St5Jd6bK5YKlWpzKGPAG8UHzXYsA
         8SIzB9f+sZ1D1CHjQna/BwwJ9FclruOFnI4dIbkHRO6dtTZ+M3nB7rPJYESIFAxdS0Rm
         2ehcpzIUfrYaNI2wOB6A0dglTy/pRwpDg4jc8dZQu4q/ROdWWTbmN1p5abNcG+FdNPcY
         iZXQ==
X-Gm-Message-State: AOAM533ZiB76RCYviOmaSBswNSbH/iagwtffbWrdlF+Yzo4OvOXELYKE
        KnkzNNIOLTflwNEWXBL0UHUhdhG8jUo=
X-Google-Smtp-Source: ABdhPJz/hCF+DYv5rBjLp/yIksSf1A9sF91/4odzyWZ6Alby3Um3A6BcMB0Lix+gtLUkPWaVIQz2Gw==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr5347731wmc.104.1589567385074;
        Fri, 15 May 2020 11:29:45 -0700 (PDT)
Received: from linaro.org ([2a01:e34:ed2f:f020:5450:281:8a7d:dd9a])
        by smtp.gmail.com with ESMTPSA id n9sm4959897wmj.5.2020.05.15.11.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:29:44 -0700 (PDT)
Date:   Fri, 15 May 2020 20:29:42 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        "shenyang (M)" <shenyang39@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>, linuxarm@huawei.com
Subject: Re: [PATCH V3 2/2] thermal: Add HiSilicon Kunpeng thermal driver
Message-ID: <20200515182942.GB760381@linaro.org>
References: <1587455093-33876-3-git-send-email-shenyang39@huawei.com>
 <53ca3883-9155-c023-7916-10ec8cccf977@linaro.org>
 <0be585d3-1180-7b42-8b51-392a34793f70@huawei.com>
 <b1739246-3639-a6c1-6c0d-275eb2ab0d16@linaro.org>
 <5EB65D33.80105@hisilicon.com>
 <96c7578e-25cf-d258-6505-8c1c631dbe82@linaro.org>
 <5EB8A9DC.9030004@hisilicon.com>
 <85f9f90f-2b67-4cfd-cc28-b14e037755b7@linaro.org>
 <CAHLCerMfbJ3cAD32DHmYjEHPTa85a=ocYiPi3C9Ew5ctj-rVvQ@mail.gmail.com>
 <5EBD42BA.7070008@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5EBD42BA.7070008@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 14, 2020 at 09:08:10PM +0800, Zhou Wang wrote:
> On 2020/5/13 20:45, Amit Kucheria wrote:
> > On Mon, May 11, 2020 at 1:44 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:

[ ... ]

> > They're simply using the thermal framework to show some temperatures
> > in sysfs. It seems they have no use for any of the other features of
> > the thermal framework, all that is handled in ACPI firmware.
> 
> This driver is ACPI based.
> 
> > 
> > I do wonder if such drivers would be better off registering a hwmon
> > driver instead.
> 
> If this driver is registering as a hwmon driver, it will block possible
> usages of other thermal features in the future.
> 
> So as a new driver, we would like to register to thermal subsystem :)

When I did the first comments, I missed the point of the ACPI aspect but the
main concern remains, especially in regard with the "features in the future".

Please, do not aggregate the sensors in the driver. Make them separate to give
the real view of the system.

The aggregation aspect is still under discussion (virtual sensor or virtual
thermal zone).


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
