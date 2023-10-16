Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88317CA4E3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjJPKML (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 06:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKMJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 06:12:09 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5435CD9
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 03:12:08 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7af52ee31so52104017b3.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697451127; x=1698055927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N7GzyXA8HbBxQ30YWmSeGxysysf0/shmwrDGNGvGWY4=;
        b=D//L3i7hgzuSsHviGZrdzwOuIkl4UUaDWygJv+xKMkZ3E0UhZOTO/7n/qbDZyBqpqf
         nqtVEw3cT7TMURVmFAN+4U5G1AExdxgZN6nnPAyqEPdFbkUv3AyAIefyvA2KYibfUbzl
         vLi4jR+mG18pXnFGjefuVi1V4uR3yOya0AzEePYp09Zf1S6sbn6cpS3H0evx/cpapoLS
         6vqNYQ5Ump7zl/Q+eSsqd0Qzpcdcf9sVOpua5apu9RZ5pwyqsAhzPVAM0zykYnrcbBIU
         RDt7QSLoYEsDVvGqqyZNwnmmwuPekYKO7nkwxKZ58/FS3QksXpFQFlh0AQCbxCh12zKy
         BkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451127; x=1698055927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7GzyXA8HbBxQ30YWmSeGxysysf0/shmwrDGNGvGWY4=;
        b=NEc/JkUWiIsqVyUD3OaPmCmXFkI0W0cR4i51m7HrqXxeAuRrp4vhHkvvAg1QFSKe7f
         I/Wy33J2Q3Jj15IWKbtDpWOeAU61tkn/ZSJYgtE1ZLjZuilDnToMzqh0YO81IJ2gO0jc
         6rXznr+9EykGoXQiPEtmCsCJMw6H/fgazt3uM9khoKib+iyJCOSDl8svlX7oNhK/xHH4
         VBrsseJjM2pfBdopgVu8MqSbHrcx7xMgM8Nn0SITIdKj6KgyG/rCzvasqs6a2UH8Caxx
         b+Z4C7cgh2iRAMDuTpoXg8BCEZ4Lr90ZLJ0b6c4mbo1eib0y0Rk5/qT9ye0YatyUIUwe
         6uYQ==
X-Gm-Message-State: AOJu0Ywq/9RrPQVVA5Xhi3qDAXyAUnZKrKmz9/XxDIJYyGKw2ijN5lxr
        bFV7i3Gwe6YrKIj4V0s92fUIMh8bzddGuI4fDMZO6A==
X-Google-Smtp-Source: AGHT+IG6aOvCRIBz1xOwrSba3ffH+swQQpSqTGXJKAtFT9KpCOR7F2mke46E2OrPhb2UuEgeZLEhbkfVIIM2OkFSirU=
X-Received: by 2002:a25:4006:0:b0:d9a:51d7:2d1c with SMTP id
 n6-20020a254006000000b00d9a51d72d1cmr15303113yba.45.1697451127552; Mon, 16
 Oct 2023 03:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697186772.git.viresh.kumar@linaro.org> <58b984a1144b0db1dd6bdbcbbfbac69326f02dd1.1697186772.git.viresh.kumar@linaro.org>
In-Reply-To: <58b984a1144b0db1dd6bdbcbbfbac69326f02dd1.1697186772.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Oct 2023 12:11:31 +0200
Message-ID: <CAPDyKFoQnjdfQaSLqfjqTOqcrhXZLrY5ObhUyUDPUOga2cV4Yg@mail.gmail.com>
Subject: Re: [PATCH 1/5] OPP: Fix formatting of if/else block
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 13 Oct 2023 at 10:48, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Add {} to both if else blocks or none.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/opp/of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index ae5c405bbf9a..85e2af3d6a49 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -208,9 +208,9 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>                 mutex_lock(&opp_table_lock);
>                 list_add(&opp_table->lazy, &lazy_opp_tables);
>                 mutex_unlock(&opp_table_lock);
> -       }
> -       else
> +       } else {
>                 _update_set_required_opps(opp_table);
> +       }
>
>         goto put_np;
>
> --
> 2.31.1.272.g89b43f80a514
>
