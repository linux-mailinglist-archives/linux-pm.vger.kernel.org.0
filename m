Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A50DE625
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfJUIUu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 04:20:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45396 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUIUu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 04:20:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id o205so10276729oib.12;
        Mon, 21 Oct 2019 01:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGEXmo3gWHNdYvsyhcJf295cLVFl9GYDu9vcj/Wl/HA=;
        b=KXgjaPFOqg8Z0L6/LL1AX6c1xSqNm7fFxMIWCQGQKYEUC7GE8+mH5z1tN1vPTSE3xT
         oIjJXZ5zizpAN7Xt3Gi9eTr4zsg5FEU0KiQ8VHJMfPbFIb35fnWrzVfLHKP/6ziEtEwT
         Tg+1ryPXRyoUuQq/Qy8RVREr54wqqESilJ6t51DKjnO3pJ67426emaV48DTZwdAYVXod
         qNvUHoGRBvHF41yuPGRC8brz4iUxbnmg3N8usHXRhRfSw6jqHkP5DtnUsczZS2hyGtMU
         Sb67rqDzIL4gA9MHebkdA/UoicFzO4AI2BjHxY5/L+ixKit4U2s6SBexwyiolQDmMrOG
         puew==
X-Gm-Message-State: APjAAAXX9i3sI7bcLcF9Rv7O5dg8gyEFSHUzM+6b3NpW92K/mUiqBxc0
        uf2sPnKDCM948u9tFyxSF6z0UeTy7qijs/3UMz1BDA==
X-Google-Smtp-Source: APXvYqyB48oXt5Oyi+FmosIyChlhsJQqJvoY7Kvo+kO4MYVtaBkHX8AnMaaDE/llDjngql2hE3EYQipYpIZE7hTR/0o=
X-Received: by 2002:aca:d405:: with SMTP id l5mr17102856oig.115.1571646049356;
 Mon, 21 Oct 2019 01:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191017163503.30791-1-sudeep.holla@arm.com> <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
 <20191018101924.GA25540@bogus> <4881906.zjS51fuFuv@kreacher>
 <20191018110632.GB25540@bogus> <20191021021551.bjhf74zeyuqcl4w3@vireshk-i7>
In-Reply-To: <20191021021551.bjhf74zeyuqcl4w3@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Oct 2019 10:20:38 +0200
Message-ID: <CAJZ5v0jts=uE63vQ9ApP1GMPVzF6Ap4r5b6BP1q3urx5YzBPUA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 21, 2019 at 4:15 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-10-19, 12:06, Sudeep Holla wrote:
> > Callstack is:
> >
> > (cpufreq_notifier_max)
> > (notifier_call_chain)
> > (blocking_notifier_call_chain)
> > (pm_qos_update_target)
> > (freq_qos_apply)
> > (freq_qos_remove_request)
> > (cpufreq_policy_free)
> > (subsys_interface_unregister)
> > (cpufreq_unregister_driver)
>
> @sudeep: I see that the patch is merged now, but as I said earlier the
> reasoning isn't clear yet. Please don't stop working on this and lets
> clean this once and for all.
>
> What patches were you testing this with? My buggy patches or Rafael's
> patches as well ? At least with my patches, this can happen due to the
> other bug where the notifier doesn't get removed (as I said earlier),
> but once that bug isn't there then this shouldn't happen, else we have
> another bug in pipeline somewhere and should find it.

Right.

I have found one already which should be fixed in my current
linux-next branch, so testing that in particular would be appreciated.
