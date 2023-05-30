Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54871599F
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 11:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjE3JNg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 05:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjE3JNe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 05:13:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B49EA
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 02:13:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso3121778b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685438013; x=1688030013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YyyX52BF67Diz7Uf4mK/fLgyb9Q3DsmlKfmTtraC+Kc=;
        b=qhpLK30bDaXs2103YXxXpPhPc9s/QNqCZj9KumXFLCR9TTKSCLJQE+c6iGbdMsJrK1
         Q1fp47dMZcqYjxeTbuXkNHnJRYHHXaQWSX4SUNNL1SoC0rpTYATl9Akj6eG/rrGIf6ef
         GftP40ZjmYSLYaEQeZpUpw0hAIC/fWA+Xga094ToFIptD4zI7muZzLtioAI7/MPItX/d
         b0btwY1DqYJAU4RMB3OK73yoiSIMCaPAKMRMhHNHWm5WUYnXpSQiw/9JGXeVoGJMp7eC
         1w6VPReUF9a+IdFMumse+29Apj3Op1kFYnmJFGVdeEXpZLRK2inLG3XM7CwPU6z2wFvC
         aTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685438013; x=1688030013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyyX52BF67Diz7Uf4mK/fLgyb9Q3DsmlKfmTtraC+Kc=;
        b=NkFKcUGQKVvJ0uYtEv8MHwnmmScfxFOcf8CVojz4J/L+7uw7wTL00WbdUx4ICmsZzG
         I/+LJOZDfmDwagzK3gkParDhZRWtGhAfHcBwXpc9Y+Jhu05FkLV72A0MsLmULxhcwPyI
         XIiSACyxcHbtvEveBzuKhHERAsOPDa2s+6L+PJB/xU3DSHpkXX+0uZjh4pt+WfTyEval
         CWIWvmpfpbGtzh5MfR8vHTDr3L1ezBCWti7QHlcLQdKfdRc2UIQXaFJjvxu0fCZK6FQr
         iG9jS91GXKLhGf1Olb7cY9SCduXMm1bu37C8oddAfpa9RmV6gHuHsTWh3eA4ZXJ9HPRf
         jeew==
X-Gm-Message-State: AC+VfDy46ZqdDDFt5B/aidWAdowefo1dcPrGzMe404Ge4WbHJQ6biuVe
        vdTp1sD37jTuDTowBDhIzjWkFQ==
X-Google-Smtp-Source: ACHHUZ75GlZV0riMuA+mh9FpJNHYTb//2BMZQzskvLcCzyby+XqrOWQk0a7PECu6ai46safOQB5OAQ==
X-Received: by 2002:a05:6a20:9e4a:b0:10c:d33a:5c50 with SMTP id mt10-20020a056a209e4a00b0010cd33a5c50mr1807478pzb.36.1685438012962;
        Tue, 30 May 2023 02:13:32 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78c11000000b0063afb08afeesm1224572pfd.67.2023.05.30.02.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 02:13:32 -0700 (PDT)
Date:   Tue, 30 May 2023 14:43:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] opp: Fix use-after-free in lazy_opp_tables after probe
 deferral
Message-ID: <20230530091330.e3nawo6ey2an4ir2@vireshk-i7>
References: <20230524-opp-lazy-uaf-v1-1-f5f95cb4b6de@kernkonzept.com>
 <20230529053148.xuhuv6skg2xqworr@vireshk-i7>
 <ZHW0YY4xoUmR_UPg@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHW0YY4xoUmR_UPg@kernkonzept.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-05-23, 10:31, Stephan Gerhold wrote:
> Thanks, this seems to fix the crash as well. Are you going to handle it
> or should I send a v2 with this diff?

Please send a V2 :)

> During _allocate_opp_table() it's accessed without the opp_table_lock,
> because of
> 
> 	/* Drop the lock to reduce the size of critical section */
> 	mutex_unlock(&opp_table_lock);
> 
> 	if (opp_table) {
> 		/* ... */
> 		mutex_lock(&opp_table_lock);
> 	} else {
> 		opp_table = _allocate_opp_table(dev, index);
> 
> 		mutex_lock(&opp_table_lock);
> 		/* ... */
> 	}
> 
> This doesn't seem to cause any problems in my case though so it's
> unrelated to the crash I observed.

Hmm, right. Maybe we need a lock for that list, want to take that up ?

-- 
viresh
