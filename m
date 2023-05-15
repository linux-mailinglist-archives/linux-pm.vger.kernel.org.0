Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F1C702828
	for <lists+linux-pm@lfdr.de>; Mon, 15 May 2023 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbjEOJUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 May 2023 05:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbjEOJTy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 May 2023 05:19:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D1D2D4A
        for <linux-pm@vger.kernel.org>; Mon, 15 May 2023 02:14:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ab032d9266so115487445ad.0
        for <linux-pm@vger.kernel.org>; Mon, 15 May 2023 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684142097; x=1686734097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7x6IG+D+CDvFt9+uoAYNRqVX+sWv9VeK/5Co9Jqg4hs=;
        b=NYHbllLHaJUP9gdiJ0/0Kx75t7WoXSqRvP24ERePPI49rlzZ5i7rXucMs0gvsLQsIt
         bz084R7n3M+XdHeJeJBxXK55W5MOuXUQWRONNWWNdRUXvmjAJ7N2MvyITU7CfKZn6tfC
         Vpk7N6XhRpEipdDpN62UlQLzqMm+skLiz2uj+Iry6/RuyMdpJY/9hFGmcdocICL5xt6j
         iFxK1p8x34UVIIsTYG8ohgRLqwHQ+7X7b4NRBOFWudqU+C+hnQ5BF8Z7VLqTLzFYOB1B
         CR7wZDNfQ8ajdisTphrfVLeW/EXe3sdFC4h5uSJO/hU95ks66byF82wcwBntioTOulDZ
         hOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684142097; x=1686734097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7x6IG+D+CDvFt9+uoAYNRqVX+sWv9VeK/5Co9Jqg4hs=;
        b=JROjYXMUcfrTg70oMEoFduJamE8vv2bAYG7SShIDUAPgxWXZGRR9RRstzqsZCLP8LG
         urYB6sj+dZgZ4wzpelXwR584HNq/FwsVNKG+ZjvJ75AEpqgIESsrKHUODHE1Yl0wW6Ku
         M9iFruGyuc5O9BukY6SpK+AkM+eQ8WxyvN4Yubs0V7XMSfDYK8nRMqJd1G1YnNqQIsNz
         jj+fJlZCAKqINJndqkH7MaT9KO9DrL6KGnEEBlpB/lNK0dxvNEC60d2K9OP62Clso4hM
         NrXArJw5LjatR70AcksBXZcs0/DJcza6++ee28Ij+PJQjIiYRHJveeO5e8wMcJWV4D4l
         i9tA==
X-Gm-Message-State: AC+VfDxcdW0ZGHry0SBIJoMUIPIIbo2l7uHh+83NrMIjsi8NV8JvnKze
        Xblji5PREmrmgvewSxUPfr/IBbVIgJ+vXh1YpAw=
X-Google-Smtp-Source: ACHHUZ6z3Nj8QLbqszPysPviwSiiBx2yj+vfkuCC12+6lxs1T+quDhheujAB29Q7rRxmfi7mJhWlsQ==
X-Received: by 2002:a17:903:110e:b0:1ae:100a:4fed with SMTP id n14-20020a170903110e00b001ae100a4fedmr6418284plh.26.1684142097124;
        Mon, 15 May 2023 02:14:57 -0700 (PDT)
Received: from localhost ([122.172.82.60])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902768500b001a682a195basm12999647pll.28.2023.05.15.02.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:14:56 -0700 (PDT)
Date:   Mon, 15 May 2023 14:44:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sparc: Don't allocate cpufreq_driver dynamically
Message-ID: <20230515091454.hhpkkyqvqtxcsoaa@vireshk-i7>
References: <96f7ea2c952075030ab8d24ee2d3983e1b144f36.1683795616.git.viresh.kumar@linaro.org>
 <CAJZ5v0iU1aLRd447x=4_ng7JoGCiptw3ps5gzFcG_kVwGa2wPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iU1aLRd447x=4_ng7JoGCiptw3ps5gzFcG_kVwGa2wPg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-05-23, 12:21, Rafael J. Wysocki wrote:
> On Thu, May 11, 2023 at 11:01 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > There is no point allocating the cpufreq driver dynamically and add so
> > much complexity in the driver.
> >
> > Do what is done for other cpufreq drivers and statically allocate the
> > cpufreq driver.
> >
> > Reported-by: Markus Elfring <Markus.Elfring@web.de>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Applied. Thanks.

-- 
viresh
