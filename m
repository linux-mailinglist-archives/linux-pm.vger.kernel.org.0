Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9587CA59C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 12:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjJPKiT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 06:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjJPKiS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 06:38:18 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4183
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 03:38:16 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57b64731334so2618300eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697452696; x=1698057496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAgUR3xRL7gFj/DHyTLw31gfxB/iFGUHd6OvglMhuyo=;
        b=cerybdnnTWUHBq+WT6zaGRt2p81hMN1oG4MnzF8eCgDFxGxW3iS3tu5RasPB596euG
         eTTnECuQmeX1+bsVLQN1i435q2GulNqa9k0BgvJmwt2ksrg4W5mO6lK8oPwC1UpdG4Gg
         5CRwjJHyA/FjLdQepwLa/kjDrX/WoD8RS6eHjLuSltopLqEso2EPuibPOFh7Kl/1Z3pc
         Xtb/h5pfEqFsX1GQ/9LfQ9U3GDpry5Y5CgCm/SY3cn+c1YCVDbHIMFTIofeYh5F3c/LQ
         INp8QxVFg1vlmTW33jsRIsLC7Z81nnxps3LJ9y5cq2fCCFBLjYXPFYqxH2NpGYXE8grX
         DNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452696; x=1698057496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAgUR3xRL7gFj/DHyTLw31gfxB/iFGUHd6OvglMhuyo=;
        b=BZxzlPwDjRxSlT7zVnT8yG9ooQ4yUaDcbLMpFDCuaLt57/jUoNHDrFxnZYwCKdfKNL
         G/9baIiavmuLnX5ToNrZ3hpod35JFB6k2WjKaxd65l3/ZCGmL5MvgYiAZF5h8PhWku8x
         9Pg9TS+FBL6jJHZlzZU+p6VQ7f2yQaXyCOqR2E1nx8WwAHc7zlbPvjQP1s/PZKOn2DQB
         3qYw5za63StlO6Eu1C9wfkFAkVlHVTV8KwaEE4gORW4fvlDdEYUJYCCh5pQMlBE/kwq6
         fYk/3NxbVWNVVQkKEeb5EJP1KQBju81YX2KpX4c9s7/a675g7dCiYQLvPxPjACBYWxMe
         wu0w==
X-Gm-Message-State: AOJu0YwFl1hC3ebzOT3oZXPfJafW7QEGJyA9ZyYvpKNoxmc2DUNF4Dw2
        itQChv0tG0YxM6NEY/s9bjr79w==
X-Google-Smtp-Source: AGHT+IExsrhW9bSKl2TqFLDIEryzLqEfN3vuGhRQyK6BYqYnDMGH+JqMehUgeO2CLApwK5kpIcJsPg==
X-Received: by 2002:a05:6358:9485:b0:135:46d9:12f7 with SMTP id i5-20020a056358948500b0013546d912f7mr33192103rwb.26.1697452695978;
        Mon, 16 Oct 2023 03:38:15 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id w21-20020a637b15000000b005ab281d0777sm5493770pgc.20.2023.10.16.03.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:38:15 -0700 (PDT)
Date:   Mon, 16 Oct 2023 16:08:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] OPP: Reorder code in _opp_set_required_opps_genpd()
Message-ID: <20231016103813.mz26xhfzfca7c7kf@vireshk-i7>
References: <cover.1697186772.git.viresh.kumar@linaro.org>
 <a5bd698a7a899fb63b4c5caec7068bf5a395165c.1697186772.git.viresh.kumar@linaro.org>
 <CAPDyKFpHy-32h+yu4X-psGqpaqFNpY0CgveHgd_3Zu57KPg3Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpHy-32h+yu4X-psGqpaqFNpY0CgveHgd_3Zu57KPg3Dw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-23, 12:11, Ulf Hansson wrote:
> Why always return 0 and not the error code anymore?

Oops, fixed with:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3516e79cf743..42ca52fbe210 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1076,7 +1076,7 @@ static int _opp_set_required_opps_genpd(struct device *dev,
 {
        struct device **genpd_virt_devs =
                opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
-       int index, target, delta, ret;
+       int index, target, delta, ret = 0;

        /* Scaling up? Set required OPPs in normal order, else reverse */
        if (!scaling_down) {
@@ -1105,7 +1105,7 @@ static int _opp_set_required_opps_genpd(struct device *dev,

        mutex_unlock(&opp_table->genpd_virt_dev_lock);

-       return 0;
+       return ret;
 }

 /* This is only called for PM domain for now */


-- 
viresh
