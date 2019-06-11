Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4812D4191C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 01:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389600AbfFKXpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 19:45:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46952 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404767AbfFKXpr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 19:45:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so6116138pgr.13
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2019 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EE5fao1AUitHL11bqb8RzdJd171k3eMtm5FzLnxkzMU=;
        b=D7fip/1V+5bW+B8dWrY7plbTkotwRxUvYjzMcfs/yAIf4igp83VQrrPfKXjepLI22P
         E9k+82PdFR2nwcil8hYAmTIjZ6P6SEqn8wfklTSbnLRAhXcaJ2n20+R8erkT8PY7i6sI
         2+qdr/vOBxAQ2qk5YyJ+KWgnMgaojGDTXLC4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EE5fao1AUitHL11bqb8RzdJd171k3eMtm5FzLnxkzMU=;
        b=l0bh62bcAUB1CTqCEKdb164MABVCLl81xSwN+LcPzAMPHvtc1vhVNHufH+tuYwwOz+
         0RNLSOeK+Ng66qM5QnS0QJy4WSXWd8tLk46QBvn2hJk+XHpZDk5PlmunYBJSkLtINch9
         P8TeZr2In8c3DXvSRbXj7odOpFyx6RJlNAWxtXD5kIhivm2HOBLa1acQ/tZ9I53NfNoB
         hfmGReQ5D4m6XdJGr8IRHRJMy2d/+KuCg/27TIbgSpYZWzeliF+Q0Uw4HsRB8+qTXBiI
         PqPsWdWKzUOL7YavRQeFIV3TcaUjYPcVmhAPnEk81P+ROz6Hfr6IGR/k+U7fhGpXOxMy
         Cd9Q==
X-Gm-Message-State: APjAAAUi+VyBaNxpyQreSSgtcglKIWbc0I7gg5Sc3eDYRwKrJaXjBkKr
        PsKu0jxB8B1z7eXKjzeh9ShNEg==
X-Google-Smtp-Source: APXvYqxcqR3WSelpvX3tCqTRattGgRgcJ2IJb5b+N+ksFZzMMp3sg9U/czcW6OvmAOE7+XoNWsiLwQ==
X-Received: by 2002:a63:5c1a:: with SMTP id q26mr23389230pgb.260.1560296746374;
        Tue, 11 Jun 2019 16:45:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 16sm14711166pfo.65.2019.06.11.16.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 16:45:45 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:45:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/5] PM / QOS: Pass request type to
 dev_pm_qos_{add|remove}_notifier()
Message-ID: <20190611234543.GI137143@google.com>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <c263629a53dba33f9e7190b82172a88cc79654d1.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c263629a53dba33f9e7190b82172a88cc79654d1.1560163748.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 10, 2019 at 04:21:32PM +0530, Viresh Kumar wrote:
> In order to use the same set of routines to register notifiers for
> different request types, update the existing
> dev_pm_qos_{add|remove}_notifier() routines with an additional
> parameter: request-type.
> 
> For now, it only supports resume-latency request type.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/power/pm_qos_interface.txt | 10 ++++++----
>  drivers/base/power/domain.c              |  8 +++++---
>  drivers/base/power/qos.c                 | 14 ++++++++++++--
>  include/linux/pm_qos.h                   | 12 ++++++++----
>  4 files changed, 31 insertions(+), 13 deletions(-)

My QoS background is nil, but this looks reasonable to me:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
