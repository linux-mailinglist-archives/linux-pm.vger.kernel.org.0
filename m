Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B337F2F1280
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 13:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbhAKMpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 07:45:06 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38442 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbhAKMpG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2021 07:45:06 -0500
Received: by mail-ot1-f49.google.com with SMTP id j20so16733913otq.5;
        Mon, 11 Jan 2021 04:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OE8Ck6Fz6PnIIJhS2pFaP159N05z71BcH03XOcV38i0=;
        b=rVPuShmh/DWoBdcGQ45LebkT1CKh5afaNe6Dr28TRf2k0X7t4csDh+Jf6fP37H5ZPj
         VE6aqhe4rogyhBT03DcFo/rLeOW7B7WHT6pcTi0FCBTCAvd/FJk98MzAHJMuGas9vSLu
         4b8QB20CaT7LX93ozXMVTODmKoDqbdwHPH/umRxBjGst2CyQdtwaIrl5WRbRCb5Uoh+g
         IwiAhs5M+Tyuo3am7MxjSxrSD5s5rOnOjMrWAkaT4s17q4f2V3/cRbwikQur50WnHRSf
         yyRTzYTe31je7lnIOboHHkb7EmX72zqWNjnO5IwIkP62fDO42iftnLqLfmfwA4u11DN4
         smSg==
X-Gm-Message-State: AOAM531SAxb5khf9F3F5427sL3IsX2X+bNCaEvnFvZDI8OZ4WRMdECZH
        7MTOPc8a40x6bknWJ+B3xVbdQq62pAvmfykBhG4=
X-Google-Smtp-Source: ABdhPJwWSyyTbjv3EPW+3ZKqkIBuX/hY9RKQ+COKETsyjcM7OEG7VAF9tn9SEDQ+djQD8i9vpabOzIfgD4tBQpUIK7g=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr11109977otk.206.1610369065577;
 Mon, 11 Jan 2021 04:44:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610338353.git.yu.c.chen@intel.com> <f03c683e06109a00ef3e3ecdd068759dfb4ac0b7.1610338353.git.yu.c.chen@intel.com>
In-Reply-To: <f03c683e06109a00ef3e3ecdd068759dfb4ac0b7.1610338353.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Jan 2021 13:44:09 +0100
Message-ID: <CAJZ5v0i5F3kFOxzAax1RS9etrLtzLBuPRoqvbQM=NwuonFZDVw@mail.gmail.com>
Subject: Re: [PATCH 1/2][v2] cpufreq: intel_pstate: Add parameter to get
 guarantee frequency
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wendy Wang <wendy.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 11, 2021 at 8:40 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Add input parameter to receive guarantee pstate from intel_pstate_get_hwp_max()
> for later use.

I'm not a fan of this change, because the new argument will only be
needed in one place where intel_pstate_get_hwp_max() and it requires
adding redundant local vars and pointless updates elsewhere.

Besides, in intel_pstate_get_cpu_pstates() you can do something like
this after calling intel_pstate_get_hwp_max():

cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(READ_ONCE(cpu->hwp_cap_cached));
cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
