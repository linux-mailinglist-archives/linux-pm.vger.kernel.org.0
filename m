Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A986A01D7
	for <lists+linux-pm@lfdr.de>; Thu, 23 Feb 2023 05:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjBWEVu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Feb 2023 23:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjBWEVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Feb 2023 23:21:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935614A1E7
        for <linux-pm@vger.kernel.org>; Wed, 22 Feb 2023 20:20:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso635433pjb.4
        for <linux-pm@vger.kernel.org>; Wed, 22 Feb 2023 20:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TRBD8yg6dUK4AaUQGib4Hoz1984+FusiOehCYwp9Ng=;
        b=XXo8r11nXT3/BolF08nuhJHewPK9vyYnGBxn4jie9xvAkDxd5RexAmQF+QxQuMN8Pa
         iCtu57dPM1Ty4Q2Db9ma3XbmiQk23oelclRFrTyP+wIyPEb5GuP0lm6RxpNoLNOOGmBf
         ixg1VUhiTgW6KLVp7Fe2nA5ZQQhy0LNl2exV/YTEMlzZF+KAwc1HUrGSvQ+hwd6zQtY1
         QUDUs4AJ0dyT49SGtiG28x1IQS5AnYSI7aLASBFlnmReGr2vT5ltwrI+yyK4PEVdVI2f
         G3Ni9tMJGVS8X293wS0xeIp/HTkXpjKgogEny/+pW1N3Mn4WaYXWWMUFRLAKPUnG8zCM
         cbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TRBD8yg6dUK4AaUQGib4Hoz1984+FusiOehCYwp9Ng=;
        b=iYGPpWyA9vpnVvDV9xId+pis5bgDLJl/jB/Y1YBwVxSI8muBQrvyn3W/iY0/hBc8hE
         mt+3udNVCfQHpemCKkO9HP6v/FnjwkUa1DkOMVKpavSxUGnFcwksWSlNXZ9ZVIM7+1o0
         UELEOP+z4QIJtRZ/bBXJiCtFjWb67snkEMNKO8iCy7QZ6GImd6rMdZLB/vtEV2NxCssr
         taYsj+tMOFG9fpGi6Ql9lWTRdYKJR8yjSpA/9/pxSyBDV9AKFkK5r1R+e20tr6ROqiCB
         cmyHLx5Te61lmylNCWyZB8v2gSRw9v0TaN3EZ0vEaiQArXfISpjiHKg/9cjxaRjjxhnF
         aeag==
X-Gm-Message-State: AO0yUKXDqr3pG8wCWf+EHnfaRvVUl48TSgVvtE72DMdYX4LkpDmfoWMg
        51dIzuiYmj+R6immo84MDBwR0A==
X-Google-Smtp-Source: AK7set9ddwdMLZ8EDu3bjVLbQnBMLzYcrfQ6KIQBY1gwakmqQVKanL2MY3ULG0yIYt/Vafx8eda6aA==
X-Received: by 2002:a17:90b:3eca:b0:234:1d4c:6ef4 with SMTP id rm10-20020a17090b3eca00b002341d4c6ef4mr11237625pjb.8.1677126019638;
        Wed, 22 Feb 2023 20:20:19 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id gg11-20020a17090b0a0b00b00230745a7744sm5558692pjb.52.2023.02.22.20.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 20:20:19 -0800 (PST)
Date:   Thu, 23 Feb 2023 09:50:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 14/27] kbuild, cpufreq: tegra124: remove MODULE_LICENSE
 in non-modules
Message-ID: <20230223042017.bz234d3km5i2pgyg@vireshk-i7>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-15-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222121453.91915-15-nick.alcock@oracle.com>
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
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks.

-- 
viresh
