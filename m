Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDCA2645B1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 14:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgIJMGs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 08:06:48 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:34406 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgIJMFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 08:05:55 -0400
Received: by mail-ej1-f66.google.com with SMTP id gr14so8362351ejb.1;
        Thu, 10 Sep 2020 05:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7tM/BCTp6djkJQeLJysbRkWMDhxj2LN3m5UHBQH6ccU=;
        b=C9pNV/pK4XdsSBZ5A+vmV2f6XMBoQr4VA7peVX2uxlevWPNxk21vROab8biimrwxb3
         9OMHvruPjq+yvn/tjgpSlggs/I00NQQkxbIaH8bl3HRmxml28THB1TSHG8YRh+Y9uc7z
         T43XFPv0Xdge+PIYtENXTg2QVkNzxXgm5yrI3X3QqvbfB8BFbedgdoQjFiSPNx9gJ80+
         pSBXkklJEEoO8jPN0zTBdAg54MqITabgkzeM8DXP7upr5qSy1n6zqAWaGvz/1r9zIckB
         mtr4Pf5Tge5BsuS82s2MI5jxn1HqfN2lIL+M4qKY4qEvJc/uVp/GJBks+YvlDXwZczu5
         eqlw==
X-Gm-Message-State: AOAM533AP4ZYtVPKds56uWyJKwuIyqVfIVFx6KQtA6grPxqkllriGJ43
        SXcBFEvby392/wjooB9F0t8=
X-Google-Smtp-Source: ABdhPJyZwVEFfKPhtn6QkU34ffKYQ7jiuFIUovhlfd0F4j57UiTnX4ZBNq4ZmO+8ldaYZwU/1C+zRQ==
X-Received: by 2002:a17:907:43f6:: with SMTP id mu6mr8802421ejb.244.1599739553701;
        Thu, 10 Sep 2020 05:05:53 -0700 (PDT)
Received: from pi3 ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id d6sm7239479edm.31.2020.09.10.05.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:05:52 -0700 (PDT)
Date:   Thu, 10 Sep 2020 14:05:50 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v3 1/3] PM / devfreq: Add devfreq_get_devfreq_by_node
 function
Message-ID: <20200910120550.GA2206@pi3>
References: <20200908102447.15097-1-cw00.choi@samsung.com>
 <CGME20200908101230epcas1p25f1ae5d3230f802a8326bfaa7e49c159@epcas1p2.samsung.com>
 <20200908102447.15097-2-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908102447.15097-2-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 08, 2020 at 07:24:45PM +0900, Chanwoo Choi wrote:
> From: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Split off part of devfreq_get_devfreq_by_phandle into a separate
> function. This allows callers to fetch devfreq instances by enumerating
> devicetree instead of explicit phandles.
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> [cw00.choi: Export devfreq_get_devfreq_by_node function and
>  add function to devfreq.h when CONFIG_PM_DEVFREQ is enabled.]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 46 +++++++++++++++++++++++++++++----------
>  include/linux/devfreq.h   |  6 +++++
>  2 files changed, 41 insertions(+), 11 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
