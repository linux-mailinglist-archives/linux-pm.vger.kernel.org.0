Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2204E4CF13D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 06:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiCGFk3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 00:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiCGFk2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 00:40:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181F0DF44
        for <linux-pm@vger.kernel.org>; Sun,  6 Mar 2022 21:39:34 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso15620048pjj.2
        for <linux-pm@vger.kernel.org>; Sun, 06 Mar 2022 21:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FRHEY3GRFXoG1UU1e98wLEZW7/ZnhLl219P9N6Q7Xfk=;
        b=Iub3o8HZFGzZncj+cUUaGyruUSLVT6eZ4Fa3w6CU8/WDywXHGWPXYEKKxrxAGmClId
         soE+Md0SYuQPvqvIKbIyzzlAamFqsKdG2k7nFO8/8Q6GKJcobhdfA+UwobywjQmyFspW
         QU07Tyf3zEIkL4dkAGfZ909lxs5YX5vMb6ixopBxxnCNdFRAljg82kx3Uk17AnQjpOaO
         oI/h724Rf/wJ3RB/JT9B95ib3pjf69k0OLtVRrFxGlxz08nulXyR1FLZQ1DavnZorjws
         ypOn2O4yPslr3ohfx70+qzqwR9KNnf3uw27T+QQstpYxDqRHjJDxteMNCpSKxyDyxdyW
         7DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FRHEY3GRFXoG1UU1e98wLEZW7/ZnhLl219P9N6Q7Xfk=;
        b=mcf14ynqUqOy3B1LcG3BVnEL9C8z//aj4zyeRD/OtGhyEmYdEi5t3BdPvBUaUTRLmI
         tyHn8DuH14N2kQPstiH9Vs+gZ1FS1Z94Grho0eoAIq9WsG9B2TNRdPPFkBCGwGohv5hb
         l6di0nweZ28KjMBeNZvmckR35cpL0ouP5apKPuYyyvChyQQT/+NiVZ0sESgmqvuBpYpM
         /YTzAkXuFjglqVSVYEjWhP6kE2fFhllMoe/Xw6Ge3VJ2dWJV0k9+qo4ypucYNq6eQTyx
         A1O9CrlZk2Zwz1NJLRgVznZ9ozES46FuJbjmZLdbzZ9llDt3RcyzasgGfLy1Aiki7b7J
         Y6zw==
X-Gm-Message-State: AOAM532gOWCYdcAYSSr/JPOyDM2/kPW13EEVGNmEF9chcyJYDs+vIy+o
        /qi0ZQy7KVopHNW6Zuyi+KLTNuRTWlJyiA==
X-Google-Smtp-Source: ABdhPJzR7lIdi/ac3KEACeJp8z9/Yj+8U8L11ftme1Ar5mD29g3LHJPmxN5LkyMNl2bOYK9ZSbFH+Q==
X-Received: by 2002:a17:902:7610:b0:151:6152:549c with SMTP id k16-20020a170902761000b001516152549cmr10650246pll.91.1646631573579;
        Sun, 06 Mar 2022 21:39:33 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004e5c2c0b9dcsm14392582pfe.30.2022.03.06.21.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 21:39:32 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:09:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: unify the show() and store() styles of attr
Message-ID: <20220307053931.kkhnxrujljynp5cz@vireshk-i7>
References: <20220306021250.64315-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306021250.64315-1-zhanglianjie@uniontech.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-03-22, 10:12, zhanglianjie wrote:
> Unify the show() and store() styles of attr,

What is the problem with current naming that you are facing ? What's
there to unify? Are there two types of names used here ?

If that is so, please explain them first as I am not able to
understand why you are making this change.

-- 
viresh
