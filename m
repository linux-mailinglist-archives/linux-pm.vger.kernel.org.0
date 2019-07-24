Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECB573E9F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390212AbfGXU0N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 16:26:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38962 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389130AbfGXThv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 15:37:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so21715283pgi.6
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=QFJC3GS7SLbhEX9yLYIlfgrpJlGsNCGKHcxux2RXL8U=;
        b=dY9QfISi0mzz6dT2+u7lTmTaFJqWVPPE2AvBBL37m53aXiWDaGr7kR9QlJVDHbRTEh
         ATjhVFJsyDmAuE96/iaGX2t7d72ebA+veCDxFMlM0aPo2qXoEmzBXOLigAUahjSr2IjC
         llI517jBkBnLLKkP+GfvnjFsKRltJ6WuuHp84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=QFJC3GS7SLbhEX9yLYIlfgrpJlGsNCGKHcxux2RXL8U=;
        b=IzJHSJ94VdhhYfn2NtO2aF6VQCtAYPYO6Md1f5ILsHJgMDEhFEAbKKVx32ksSS8lDt
         8QxrRMAh6Ik/G/i47GCFx3TO6UbHKKeH/hx0oBa6wsUYPbbYGiUncWdeyoyJmMby8HDV
         7i4Gh6qzj+bpkZufDevkrbbrgbTeBNBMagcmTMuvQUgiosZedcw6jlljdP4P0Ah0APoo
         iwRkHTQY1V+o+iCixZUvastqbO89lDl7WCnB49BICqFV9wda8WmmS0wKbE4BMWHSq1Gg
         RZpaGdblmOSbKaUYAFGcxKQABIDng01Xf6DJ3bREkGrwW31tofc7TD3hzrD6hVOpoiOG
         HTwQ==
X-Gm-Message-State: APjAAAW5l8YsygTW/Ph9dLuJtPQ0T1/xJnD/xg4q/xZiHBaB3xURv4Xx
        DUt2OvOOoIkKk4qalDp17dLjIsxQfSQ=
X-Google-Smtp-Source: APXvYqzCSyV3fyjPi8PknWSIPwreP9uODkfgEhhIEkHvblpFYOLy8zWQGA8n4P6AHkBN9fjX0sXPzQ==
X-Received: by 2002:a65:52c5:: with SMTP id z5mr68804383pgp.118.1563997070692;
        Wed, 24 Jul 2019 12:37:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 185sm47926192pfd.125.2019.07.24.12.37.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 12:37:50 -0700 (PDT)
Message-ID: <5d38b38e.1c69fb81.e8e5d.035b@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190724145251.GB18620@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org> <20190722215340.3071-2-ilina@codeaurora.org> <5d3769df.1c69fb81.55d03.aa33@mx.google.com> <20190724145251.GB18620@codeaurora.org>
Subject: Re: [PATCH V2 2/4] drivers: qcom: rpmh-rsc: avoid locking in the interrupt handler
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 24 Jul 2019 12:37:49 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Lina Iyer (2019-07-24 07:52:51)
> On Tue, Jul 23 2019 at 14:11 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2019-07-22 14:53:38)
> >> Avoid locking in the interrupt context to improve latency. Since we
> >> don't lock in the interrupt context, it is possible that we now could
> >> race with the DRV_CONTROL register that writes the enable register and
> >> cleared by the interrupt handler. For fire-n-forget requests, the
> >> interrupt may be raised as soon as the TCS is triggered and the IRQ
> >> handler may clear the enable bit before the DRV_CONTROL is read back.
> >>
> >> Use the non-sync variant when enabling the TCS register to avoid readi=
ng
> >> back a value that may been cleared because the interrupt handler ran
> >> immediately after triggering the TCS.
> >>
> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> ---
> >
> >I have to read this patch carefully. The commit text isn't convincing me
> >that it is actually safe to make this change. It mostly talks about the
> >performance improvements and how we need to fix __tcs_trigger(), which
> >is good, but I was hoping to be convinced that not grabbing the lock
> >here is safe.
> >
> >How do we ensure that drv->tcs_in_use is cleared before we call
> >tcs_write() and try to look for a free bit? Isn't it possible that we'll
> >get into a situation where the bitmap is all used up but the hardware
> >has just received an interrupt and is going to clear out a bit and then
> >an rpmh write fails with -EBUSY?
> >
> If we have a situation where there are no available free bits, we retry
> and that is part of the function. Since we have only 2 TCSes avaialble
> to write to the hardware and there could be multiple requests coming in,
> it is a very common situation. We try and acquire the drv->lock and if
> there are free TCS available and if available mark them busy and send
> our requests. If there are none available, we keep retrying.
>=20

Ok. I wonder if we need some sort of barriers here too, like an
smp_mb__after_atomic()? That way we can make sure that the write to
clear the bit is seen by another CPU that could be spinning forever
waiting for that bit to be cleared? Before this change the spinlock
would be guaranteed to make these barriers for us, but now that doesn't
seem to be the case. I really hope that this whole thing can be changed
to be a mutex though, in which case we can use the bit_wait() API, etc.
to put tasks to sleep while RPMh is processing things.
=20
