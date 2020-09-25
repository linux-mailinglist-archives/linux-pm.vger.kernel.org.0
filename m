Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FD6278A2A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 15:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgIYN7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgIYN7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 09:59:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F7DC0613D3
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 06:59:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so3690841wrw.11
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mlSpbnI9f91cxfpqsFRezlZGD6ngDghBIQQyjrFOHMY=;
        b=u8161EQlqviptebdc4sX9yDB4kT7ymxUhWkQcFpEHwyZT6vrFqFy8yaU3NouV/ZI6u
         kwGEMGNAtiOeIrIUjRzcZgYv0SV9wqorMIDtTbmQ+Ur7A0Uv5KbrTVSZa07Of4UQagqF
         bT337pyYRI1ftEOCTLXLh/Lf1l0cIZFj09KTdTZ+5/3/fSptrdnIjNYweW1q8eOrnXM7
         sSHa4seYHBxhWKmV1i/U35X9dvHuC5k+Wpu50EI/ii3W/yjC0dbAsMINsgSlcGGfPRXx
         IUMktXSjeQqM5ly8OPPSW4RonTJO1/1+JoBsyLhhUmEjo8Y+USZqMojlVxrhqksWuE/m
         OCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mlSpbnI9f91cxfpqsFRezlZGD6ngDghBIQQyjrFOHMY=;
        b=g14fh5TgPPxar3q/65YHS9QIMuoafZlJWBNKjHqMq8OFJLDU830t6Ee4UzryXtoIIs
         GQUTGdsNVguZXgsKS/h3JgQBpi4fWyUYVP6tPPWfTzDUJgWPfRUrUVFWKFqsdVsAjjHR
         3aua8bfb53y6MD6zGvA3pcq2oT3I5pntYHzzgIH5GxrPNaT9CQvTMQoKclsCU6Lp+Mby
         5PJLNyOj9GevN90uuihGRORTidc1SpspLPWUAfJzmpOyG3IXC+wcIc6IpCvCnA69EMuy
         LYzswpYVAGrk8x3AcWB6tumKzfC/iJdn0DtVLknEr9mOAW3r0CJylGot6+4YG0SYj4RQ
         B3ow==
X-Gm-Message-State: AOAM531jFzNCCLmN2Sv8UxUdVNlYP9AvRtdpqTufoB4d8pl0q5D4JuIA
        ABJBj7wq/tw958IwHeniRmj6HQ==
X-Google-Smtp-Source: ABdhPJxvBeHm57r2mwHF+roTeEhAmVxM0FLvzB7cxk76/KSuX+nlkd4qDCNU59NYYoehXW+VVIiCvg==
X-Received: by 2002:adf:e74d:: with SMTP id c13mr4514766wrn.45.1601042344244;
        Fri, 25 Sep 2020 06:59:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id k4sm2918748wrx.51.2020.09.25.06.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 06:59:03 -0700 (PDT)
Date:   Fri, 25 Sep 2020 14:59:00 +0100
From:   Quentin Perret <qperret@google.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: rebuild sched domains on invariance status
 changes
Message-ID: <20200925135900.GA11648@google.com>
References: <20200924123937.20938-1-ionela.voinescu@arm.com>
 <20200924123937.20938-4-ionela.voinescu@arm.com>
 <20200924133925.GC3920949@google.com>
 <20200924161002.GC17927@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924161002.GC17927@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Ionela,

On Thursday 24 Sep 2020 at 17:10:02 (+0100), Ionela Voinescu wrote:
> I'm not sure what is a good way of fixing this.. I could add more info
> to the warning to suggest it might be temporary ("Disabling EAS:
> frequency-invariant load tracking currently not supported"). For further
> debugging there are the additional prints guarded by sched_debug().
> 
> I'll look over the code some more to see if other ideas pop out. Any
> suggestions are appreciated.

Right, I'm not seeing anything perfect here, but I think I'd be
personally happy with this message being entirely guarded by
sched_debug(), like we do for asym CPU capacities for instance.

It's not easy to see if EAS has started at all w/o sched debug anyway,
so I expect folks who need it to enable the debug stuff during
bring-up. With a descriptive enough warn message, that should be just
fine. But that's my 2p, so I'm happy to hear if others disagree.

Thanks,
Quentin
