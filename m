Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A161CF56B
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgELNQn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 09:16:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41347 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgELNQn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 09:16:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id g9so4179262edr.8;
        Tue, 12 May 2020 06:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NIwzJl9fpDrjOBLjiihFDvWgheTrbFtBuLTM/ySrEf0=;
        b=alS0GcsqsyHoHlsUWgUm604kxY64R5E+Ya+wJmZ3urawzsYcnZcvw8yfrljz7u6sSA
         hMzm0yqwt4JK+7nsr/+wq/qYkFSc3pYrT5TOl+b0fIAezBBE5VVBPTrt/ZgW3wdMI7K5
         K1X47vp90gPTogD2grdH8CO8tvS6xfVozmPI8H2QABblGt3l6R5+3x7BJpXadBPakG78
         e28agp39E9ViJPd7NwNYvtoKhP/w47GUNjevoyaG114uiIq5LJ3UugHJGiSblsE+1V7p
         wyyYNxp58lP7WxOdb1pyk0LQ3HHl3DCHwrbD2Xb29PahAL+UDd3NiUsKQQBcyCbpP06K
         lTcg==
X-Gm-Message-State: AGi0PuaxPAOVvtsokBYmvYnJlnwvWGSYDKcuQlsrLGj8LbCmz/NDobDg
        Q0weBxo7vUzeFHZmSW5RSd0=
X-Google-Smtp-Source: APiQypKTjaJ85/GzsRb13MsiaK4dm1XvENOhWOccmQ5NP1MCWiE2Pzk3YZiLUFGIowz6AxyTfcUsRg==
X-Received: by 2002:a50:cd57:: with SMTP id d23mr13372694edj.181.1589289401350;
        Tue, 12 May 2020 06:16:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id n9sm1620876ejs.0.2020.05.12.06.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 06:16:40 -0700 (PDT)
Date:   Tue, 12 May 2020 15:16:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, Kukjin Kim <kgene@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v3] memory/samsung: reduce protected code area in IRQ
Message-ID: <20200512131638.GA18782@kozik-lap>
References: <20200512123149.40162-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200512123149.40162-1-bernard@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 12, 2020 at 05:31:49AM -0700, Bernard Zhao wrote:
> This change will speed-up a bit this IRQ processing and there
> is no need to protect return value or printing.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
> Changes since v1:
> *change release lock before the if statement.
> *revert dmc->df->lock mutex lock to protect function
> exynos5_dmc_perf_events_check
> 
> Changes since v2:
> *Improve subject and commit message
> 
> Link for V1:
> *https://lore.kernel.org/patchwork/patch/1238888/
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 6 ++----

Thanks, applied.

Best regards,
Krzysztof

