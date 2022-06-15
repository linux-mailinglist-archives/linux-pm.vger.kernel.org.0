Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833154D4AA
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jun 2022 00:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350235AbiFOWjP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jun 2022 18:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350216AbiFOWjO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2022 18:39:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFA35622D
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 15:39:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v17-20020a17090a899100b001ead067eaf9so150587pjn.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pQRp5BbVCSaGqSGvHgou5E1UOEOB+Lu4226kkcHBKjQ=;
        b=SmO8RUCdAKrU8HxVNrjzigPN5g3nj1qi7AgFeu+aH5ylRMy+iVMsJbyYEj0gifQdr7
         ivlTb3vkoiOa3FQSUBGPicwQozc2l2w8X7bfJPldjl44UiSxCA7lOJm9cYrkURoXcPRj
         xT9G37IpdFV559hJaYFxj4oWkmItOR4YetU6JNbFJMDIGITjj1oGVkk2C4Icj21Db7LY
         OUu1xoayMARu1qTH4Uq+r3kRuD9bNOHKlRd52frz5TUPJsSmLSz5DluyJHf2buHQDMzy
         xcioe9gghR3xnWNJN7r3JxVXiAgzGlL+QWyIMNMu7yARtkB7gt2ZKk6/eD0M2MNOk79C
         mM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pQRp5BbVCSaGqSGvHgou5E1UOEOB+Lu4226kkcHBKjQ=;
        b=0+bO6DbfawV6fvUoWXeCd05cjUCtpdAT3O7RzpkBdSg6dvEA3OeIVGqE9XMYNHCSKJ
         5JnQNZ4zfpkYXmE/jqeJE9BfPzQL5/4BFiFdpnO3yNW+qOz5D4sPvNMmjkUikYQUPGld
         vs8F3wmayr4Mi9E5DDUkYueHXv+gnnrjqBIkIp1vhCFLyzMFi5L0gyYOI1rHjNbMrjMq
         OrJAeaaA2MFkfQgmQ83P1Juyk5wc2ypGq3FrVmt1KVeogkHt4i/hyiJCMuZX11uWBsHC
         fklOt9WgcCO+pn8yyEERkXEJ8ISeoSFhhsx8BxC/Cbm8MiG7LZBu3/Tq/0Msyefdligt
         AETA==
X-Gm-Message-State: AJIora+KxNhJBJ1baRtojoMbuEyJBKB0JmOlJn9X+Bdb7KvSpqxD/xN1
        io2kHg5SwNsfo5Q/g+a4YRS3qQ==
X-Google-Smtp-Source: AGRyM1sUtBxy5UXGXtiSfpqIU7Oj2qBS1pFqD+1ojgUDG8KQX5Eejr5QcaW/by/2AEa9YdVboyKTEA==
X-Received: by 2002:a17:902:c7d1:b0:163:bb03:d5f0 with SMTP id r17-20020a170902c7d100b00163bb03d5f0mr1717420pla.167.1655332753533;
        Wed, 15 Jun 2022 15:39:13 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id bj24-20020a056a00319800b0050dc76281ddsm128207pfb.183.2022.06.15.15.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:39:13 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:39:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 13/16] mfd: core: Use acpi_dev_for_each_child()
Message-ID: <Yqpfj5sa3x/gmZmM@google.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <2653857.mvXUDI8C0e@kreacher>
 <2726954.BEx9A2HvPv@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2726954.BEx9A2HvPv@kreacher>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 13 Jun 2022, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of walking the list of children of an ACPI device directly,
> use acpi_dev_for_each_child() to carry out an action for all of
> the given ACPI device's children.
> 
> This will help to eliminate the children list head from struct
> acpi_device as it is redundant and it is used in questionable ways
> in some places (in particular, locking is needed for walking the
> list pointed to it safely, but it is often missing).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v1 -> v2:
>    * Add R-by from Andy.
> 
> ---
>  drivers/mfd/mfd-core.c |   31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
