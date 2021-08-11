Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800913E8E43
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhHKKPU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 06:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhHKKPP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 06:15:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F3CC06179C
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 03:14:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so4556713pje.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rg+nfqNpN4KVS6P5Kg2kgnadiI4aRZsAUMlE7w6kB2k=;
        b=ac4casP3kUB13OsUJQcv38FKO7pVIq50bZ6uPGU1NEdpQ0ASqnp8urXzheGfF4JgZJ
         F0GBVqBxpnRY7eoErIyp2IabG5QIpaejNKNbwc0aQqxzw6oZgMJeXCdM+On3gP7GcwAm
         Ze6ZM7NUk6+K3utV/jdB+12kqYzQTqBoRF8pt/wvWMKT0t0AejJqeovqCSNaOQMJbO1L
         dD5NFrhUjhU22SWOPidIBz2QfpP5F/XNnFPgeAwhtmB5nt6HWk+7H9MN4LVZKKuaHvyE
         KiuTQa4lU4FT+xPngVH2NJUbPObjZ/HoPrBwxQiQRHH+/uoJ61KSOscQQ3Qen6LcUrLD
         YtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rg+nfqNpN4KVS6P5Kg2kgnadiI4aRZsAUMlE7w6kB2k=;
        b=DoVX51A/C8R1pidM7o2qHZMB93UL+MA63r80CY/7Ro3SMP/b6jT0Bdy+jL1c7O7CS7
         iheUVItodheMNPFZvuEghLM4/iGn3YWgs8LNt+4219eEM808esgQwLcnvgn2uq1mlAud
         +3JJXEwQButMx8j+f33JF67q7TmjXeo0FnBOUraMVq6NqUTE/4ga3kLBlac0vOKGApsi
         g/cIQWL/1vIL+Opkk78jYThz+Tpd4xcYnk/GxIDJFLxasUEPtPq8qJV4qx3bXf/toQfc
         NaCy9CPjPZZzJwBHUu0KSyMqbFAFPvQwewLFlgK+ztOiHhbx2sg9KmgprBlme88d2yd/
         WPVg==
X-Gm-Message-State: AOAM530OsT2ZnZC6lvK/FwmU4qYXBiWMlU8zAwDbG6Q6E38cEox06toC
        T9Xf6I7qzyY8Bs7OlgNWED3YXA==
X-Google-Smtp-Source: ABdhPJzXjMW9vKhvdq5O6Gt8ct98tc27N2TMRTz0kLhqKVJ5iHf/FGC7+T3yYcwqi1noPFO5FkhCyA==
X-Received: by 2002:aa7:9f5b:0:b029:3be:2a1f:ca58 with SMTP id h27-20020aa79f5b0000b02903be2a1fca58mr27592438pfr.46.1628676892055;
        Wed, 11 Aug 2021 03:14:52 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id j25sm27085750pfe.198.2021.08.11.03.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 03:14:51 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:44:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/8] cpufreq: Auto-register with energy model
Message-ID: <20210811101449.c2533ediwboeplqj@vireshk-i7>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <YRJym+Vn4bbwQzzs@google.com>
 <20210811051859.ihjzhvrnuct2knvy@vireshk-i7>
 <20210811053406.jqwextgtnxhgsjd2@vireshk-i7>
 <YROc95YKA1Y/TfYI@google.com>
 <20210811095311.e6wnma2ubkqdtuic@vireshk-i7>
 <YROin5WudmmEPard@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YROin5WudmmEPard@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-08-21, 11:12, Quentin Perret wrote:
> I think using the ready() callback can work just fine as long as we
> document clearly it is important to register the EM from there and not
> anywhere else. The dedicated em_register() callback makes that a bit
> clearer and should avoid a bit of boilerplate in the driver, but it's
> not a big deal really, so I'm happy either way ;)

Yeah, I think just the same. It is better to have register_em as a
separate call. I was just wondering if it is the right choice :)

Anyway, I think ready() will get removed pretty soon, so register_em()
will work well. I will redo this series and send it.

-- 
viresh
