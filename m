Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B005281FC
	for <lists+linux-pm@lfdr.de>; Mon, 16 May 2022 12:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242620AbiEPKZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 May 2022 06:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242592AbiEPKZi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2022 06:25:38 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25E211A19
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 03:25:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h85so15350956iof.12
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wi7FZ4sQpiYFKSAT45PbkZoAgmyf6uUSxphI+SAE7xg=;
        b=gExCtsIsHo4jDqSh1oIaaQMB/SVgN1TgdoLWTbuBqlwADdC4X8/BXUu0W5pAsIbnuB
         Gd/lIj0KUexSKmCA6VgMA5qw0Kp80B8oD++5zkRiD1X5kn70tlwr8pOM8HKCaPgJpZod
         hVCcl6MZZajGoz5v/sH7W7trFYcCi0WK4tPqbHNTRsxxQyivr4dYEzu+tgvXPYXOzrk8
         hZcIPvbUEEEl7+dIEQMujSm2xzHvye0fTzRpcGSJBYt4JbZVMeEOT5yMn6Rm3sr9rwVD
         GSPgTZ9358/8ti/Vq3+MyAbtWI6VESWFHyxGEE3yK5dHhlPRlQ9D6yGDrvYSAVI7XABI
         R7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wi7FZ4sQpiYFKSAT45PbkZoAgmyf6uUSxphI+SAE7xg=;
        b=nd3HdKi2/d5X1CvusLsWJB9S6jlGkTMZa65pOk2NzPsZLuJWkIYO96hsTPmz8vrvXE
         IuGPB2C4ZeMX5DQBfIx6520hPoANoB69m8fyj7V6MjotzdGGdtoOPXmklemXZ8KNsemq
         CXEP+sEdf4OUDOYnsITTT/JjoPTYVH7KkAodlDTx13M5GaGN6FqgQyGpM5N5M9Eshiz3
         x5vbblMakGT5GV5SPe0uxXb5VO61IfJjOTXCKJVR05JXyypdVEyum2j7zQMxsb5QDPKI
         EY5Sql2J3Wzumh+tqsYZp6Ibz1YvQjobVktgAxgUK48yRcBjFanxB6RkN6m30sNUjfkf
         W9Ew==
X-Gm-Message-State: AOAM53367WFnLavKiK2Jughjpz0fsM6BVj6NA3gs6NLeuIuL3mWgzNBU
        htqf4O6jvKWFOxKrlJh99IkajAGNpgQZ/4dO8+dpWQ==
X-Google-Smtp-Source: ABdhPJxw5zlT4NJpzsyi5yIx3XxcoNdxQbi+F3voNa3E3vqfR8SegU6lhQZA3QYcoF2h5lNr7l0dDXMuGhUcC7d/92g=
X-Received: by 2002:a05:6638:450a:b0:32e:1bd1:735f with SMTP id
 bs10-20020a056638450a00b0032e1bd1735fmr4119326jab.145.1652696726666; Mon, 16
 May 2022 03:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220516030251.42323-1-schspa@gmail.com> <20220516030251.42323-2-schspa@gmail.com>
In-Reply-To: <20220516030251.42323-2-schspa@gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 16 May 2022 11:25:15 +0100
Message-ID: <CAKohpokHFd=EAOXvpecde=QRGEq8Ek+P6UsLjfVDrW0nOspuFg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpufreq: make interface functions and lock holding
 state clear
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 May 2022 at 04:12, Schspa Shi <schspa@gmail.com> wrote:
>
> cpufreq_offline() calls offline() and exit() under the policy rwsem
> But they are called outside the rwsem in cpufreq_online().
>
> This patch move the offline(), exit(), online(), init() to be inside
> of policy rwsem to achieve a clear lock relationship.
>
> All the init() online() implement only initialize policy object without
> holding this lock and won't call cpufreq APIs need to hold this lock.
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
