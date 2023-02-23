Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BAD6A01DB
	for <lists+linux-pm@lfdr.de>; Thu, 23 Feb 2023 05:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjBWEWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Feb 2023 23:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjBWEVc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Feb 2023 23:21:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103844AFC6
        for <linux-pm@vger.kernel.org>; Wed, 22 Feb 2023 20:20:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so3019344pjn.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Feb 2023 20:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVJ32kp9wwWd2a1LXfR/fFS9Yx1xIGlwmV6aBdpxYbw=;
        b=niMkt0Nf/sESAEVV6rHiAPbk9t5VUNguGk7k3hOVPlunoC176xYjW0lCn4RhhslRFG
         BiYjBqXlB42RzSHtCkgCiYfdoCX/UAwwUx8mH3yyoOzLbmtiAM42elnSY6s07FGSfLqn
         cQO9FC1AfK0KDa1fJUqA55dLrftcjIKQI5LdW62pSiVZPQB9u280zPd8dA1ko0LW7jSQ
         PmkiCQQVkXk8lvEKNgNAawgakzUkBBs9ajHwdZ3gEj5ApM8awmyApYjxay+ATItokJQg
         rxct4O4/oNOW7y5vN4av40peSHorno14uxggdFScI1EY4rw/tpTYDdmueOTnHs1LfdD2
         +CTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVJ32kp9wwWd2a1LXfR/fFS9Yx1xIGlwmV6aBdpxYbw=;
        b=wAaehB+4467RfJ91QXVry5wgSZmctL0A5VKmuruDlVd8yzo2F4PTLUkORxabrp+Nbs
         mfWDlnhzh/5G/5k7lOK3IC0RUWWArWWCaFuhiZ2as8czzaERPAblATTc1ntt3gcB5wwq
         P7RNrrVgMvrvG9AhQ3MtU4xgGbeUkwdWZqCkcdnfi9pgHRY4WAolZQBe+CjIESEyQwmI
         ejPoU1M8Itq1Q5OZdam2jAG3aXcu5GpgxhIVdJ/5IAeg/RmMyl3cLq0aAnvq2hXTNL17
         xpMnfylDx3Mm2u8ImWEmy5OnrodgdhH3O4OwJBTNsxKow6Y0AUp8CFMfC0YRlN4yUz23
         i+8g==
X-Gm-Message-State: AO0yUKWXaLa84wJP6e2j1Rkvsg+QL5dabVns5ablPTmqdVNb1usHVzY8
        PhCfeZJSL6D2/UEaYHpAKWouyw==
X-Google-Smtp-Source: AK7set+XPYbkdsqliVlZEGDZP6uurH9OJ7JmVEeq84t2Ty8tjuwXBlT/DuK3y0vZw4Si2apg4diXGw==
X-Received: by 2002:a17:90b:1e02:b0:233:af77:c075 with SMTP id pg2-20020a17090b1e0200b00233af77c075mr11136794pjb.36.1677126030265;
        Wed, 22 Feb 2023 20:20:30 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id v3-20020a17090a4ec300b002372106a5casm3441787pjl.44.2023.02.22.20.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 20:20:29 -0800 (PST)
Date:   Thu, 23 Feb 2023 09:50:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 15/27] kbuild, cpufreq: remove MODULE_LICENSE in
 non-modules
Message-ID: <20230223042027.n2shjf723hjwib6j@vireshk-i7>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-16-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222121453.91915-16-nick.alcock@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-02-23, 12:14, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/cpufreq/freq_table.c | 1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks.

-- 
viresh
