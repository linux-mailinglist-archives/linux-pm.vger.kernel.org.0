Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2CD67310D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jan 2023 06:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjASFQb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Jan 2023 00:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASFQa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2023 00:16:30 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1516AC9
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 21:16:28 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 20so1299818plo.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 21:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVamRwg47e7JomZYS51/vFhQgPnkTMn8aAsEafDtbAQ=;
        b=MFge/j3m75+cZ8vY8wmYW63HFOJqHiWd3Pdhn/69Mx/Dri4LxllCHnx+BKs5f8czes
         yYAj9oWFFHXmC+hmuDEmQLC8dcBBI2POx1fRwR/5A0AP2+Jbjrh9+Ut22z7C0mYWun8i
         YnZQgVWGQ9MiFjaWN4yObw59YzcuyliXqdRGYl1nXaPl05kVQmdooeJTq1iGM4jngryB
         m8RKB6f1F1ISPS7+hUKUvXY5cjLlibn76LiQe6TEy+tf4VDtLteFdCK8xH2g3VNewvm+
         4leX7Hx6RHJWi0kzVVvtbgchj1OSh2QZGtNli7S3SF77WzH1y7I6DX3X6UgaKv7bOysa
         Tpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVamRwg47e7JomZYS51/vFhQgPnkTMn8aAsEafDtbAQ=;
        b=C0PwvANlfCxCQM0hd3TgyLNt5twl9g1L8H/cTivL67GKkppBFCKMwLESESXE7kRdwQ
         CkrmJSUcnlqdfYUrHYvQbGOWFlbY7P27lKPdUlSJIwVyzVUMQyH8CD9bxo1BXXHcIzd+
         4mXOcQQE4pr1xiZZo0u1D6i42Iwg3rX2sj3/JqUxDeXXC1eQGHw28eMckPbjEABSi13c
         khxqyLRgF8rKSZ2S7slm0eHOLNbYfxOk4lKXQbjpLJlvN1cWWTxJ7RDpN/E0KY2YBjxE
         hAkbw8K6efegCR1dZjFDLagE65zjVmpri0So5sSQH1BmdHP3EDPjXGgOpVeR+OZYvf1g
         t7SQ==
X-Gm-Message-State: AFqh2koS/omwu87bcaaGxwktcDrRb96ErtlxkaU/ee1litgk8zx+SqUG
        qTOOnv3MFgzjfu6tOm670+ieAg==
X-Google-Smtp-Source: AMrXdXts8rSAKygqpdeOjQR88r50roQumtOlj18cpeCK2uCLtB5aIdQseFMbUVRQgkXTKg1E1qm+mw==
X-Received: by 2002:a17:902:c24c:b0:194:7696:b0f9 with SMTP id 12-20020a170902c24c00b001947696b0f9mr22640309plg.66.1674105387586;
        Wed, 18 Jan 2023 21:16:27 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001894198d0ebsm9529061plf.24.2023.01.18.21.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:16:26 -0800 (PST)
Date:   Thu, 19 Jan 2023 10:46:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/3] thermal: core: call put_device() only after
 device_register() fails
Message-ID: <20230119051625.bd4dtnriw6jys6nt@vireshk-i7>
References: <cover.1674030722.git.viresh.kumar@linaro.org>
 <d6e5d4fcca5f66d290e907d10c45cb2e7bbb09e5.1674030722.git.viresh.kumar@linaro.org>
 <CAJZ5v0j5Rfw7pj05WsNka0BCNOszxsvPuMfNH8Kh88J+QZFHfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j5Rfw7pj05WsNka0BCNOszxsvPuMfNH8Kh88J+QZFHfA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-01-23, 20:58, Rafael J. Wysocki wrote:
> On Wed, Jan 18, 2023 at 9:38 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > put_device() shouldn't be called before a prior call to
> > device_register(). __thermal_cooling_device_register() doesn't follow
> > that properly and needs fixing. Also
> > thermal_cooling_device_destroy_sysfs() is getting called unnecessarily
> > on few error paths.
> >
> > Fix all this by placing the calls at the right place.
> >
> > Based on initial work done by Caleb Connolly.
> >
> > Fixes: 4748f9687caa ("thermal: core: fix some possible name leaks in error paths")
> > Fixes: c408b3d1d9bb ("thermal: Validate new state in cur_state_store()")
> > Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> OK, so I think that this patch is needed for 6.2 and the other two may
> be queued up for later (they do depend on this one, though, of
> course).  Is my understanding correct?

Right.

-- 
viresh
