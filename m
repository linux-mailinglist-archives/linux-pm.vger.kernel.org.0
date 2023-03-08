Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61426B0013
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 08:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjCHHmG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 02:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCHHmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 02:42:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27D924485
        for <linux-pm@vger.kernel.org>; Tue,  7 Mar 2023 23:41:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g3so14422890wri.6
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2023 23:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678261318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nk+w85PAyeUxe12nhT6etuDmNPjcokbFmhyBnV2hxU=;
        b=X3fkIvfdM7yWkTQcAi7BCb6DvilgDkUramTed1gUB43/9WtVKw95Mn0jGQ4i8iYmBK
         ZM9GHmur5OxeTF3ZTtCxFP/dm98H1d2V2XrDhr/idWl7HNnYWYhM6+xYZk7uzUnn/tiP
         +y+on4OPIjlZHlvY5wrZ8HXA4LukMJdG2YyJ1LXAsPEDKJ8hxI5s56Qgv6oyuoPkEVir
         xj+3FGDy2XlxnnEybZix++iOXcyQYlSQQQqqGzu2aspl7SJTTSO+otXxyBgrmsuCxbBl
         08rlZhdUrJTeSlbGuIPOAiKtPav5SyVlJMieUWjMl2fURQvWbaatD5Z0uaGlLYe3nW6U
         V4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678261318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nk+w85PAyeUxe12nhT6etuDmNPjcokbFmhyBnV2hxU=;
        b=Yk/APeJDhotGXECVrI3BKhN5mNA7/UjY9kdwQu4frqq6Z106GrlxF+X73V0ZWO5PUx
         opI+EvR22eFWQQUrFHt9RMMDNR0YW0KDw8Cog+XBRcVvGr+eZTmqVu4H03m35oo3oh+v
         zMLfGO+FfV2pMJIQFe05+GxlQQD7eUA7f8GW/LPHL7fL2TFDBguKL16bDt6gXjxslEb8
         8/XP7cj6Ge1KTo2RSi+pnMYCVXL+iPmTpDCumX8YxvMHV+j7qiuNEFl2/81bK2k3AYC9
         dQuecApvbRZAz+LBgj7Hp49/dfQZWSGY7QpFquE90vAfJPPPTyZMM6ApS0BXXzBawz1/
         VW8Q==
X-Gm-Message-State: AO0yUKW2/M0o4K72gAYObq+AHxTWFEJX9M7oyMzT7wgCyI3+UikomvLX
        4EpKt9DYGx20ghH6biT9Quc=
X-Google-Smtp-Source: AK7set9YSl562SpKe6t/zQyZrEG7EfZuPQIgq6v0spOnc0P5pqwi/eP0Zmr48qYrgQyi0a0cR0e1ng==
X-Received: by 2002:adf:f389:0:b0:2c7:31cf:8be1 with SMTP id m9-20020adff389000000b002c731cf8be1mr10755024wro.12.1678261318330;
        Tue, 07 Mar 2023 23:41:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j29-20020a5d6e5d000000b002c59f18674asm14407477wrz.22.2023.03.07.23.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 23:41:57 -0800 (PST)
Date:   Wed, 8 Mar 2023 10:41:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [bug report] thermal/x86_pkg_temp_thermal: Add support for
 handling dynamic tjmax
Message-ID: <770f472c-3220-4498-829d-b6970e1dac7b@kili.mountain>
References: <add7a378-4d50-4ba1-81d3-a0c17db25a0b@kili.mountain>
 <0ac7dd5f384dbb6045897b558afb6e91d20e32ed.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ac7dd5f384dbb6045897b558afb6e91d20e32ed.camel@intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 08, 2023 at 03:15:29AM +0000, Zhang, Rui wrote:
> Hi, Dan,
> 
> thanks for the report.
> 
> > The patch 58374a3970a0: "thermal/x86_pkg_temp_thermal: Add support
> > for handling dynamic tjmax" from Dec 19, 2022, leads to the following
> > Smatch static checker warning:
> > 
> > 	drivers/thermal/intel/x86_pkg_temp_thermal.c:159
> > sys_set_trip_temp()
> > 	warn: no lower bound on 'temp'
> > 
> Actually, this problem always exists. I have sent a patch to fix it.
> 
> May I know why it is found only after the recent change?

No, I just blamed the wrong commit.  There was a recent CVE we were
responding to which forced some Smatch changes.  So that's why the
warning is new.

regards,
dan carpenter

