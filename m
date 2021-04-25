Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4028036A942
	for <lists+linux-pm@lfdr.de>; Sun, 25 Apr 2021 22:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhDYUsD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Apr 2021 16:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhDYUsD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Apr 2021 16:48:03 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CB8C061761
        for <linux-pm@vger.kernel.org>; Sun, 25 Apr 2021 13:47:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z14so1467505ioc.12
        for <linux-pm@vger.kernel.org>; Sun, 25 Apr 2021 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mf3PfXpISSLDZMwm9YZTjHVTAuZA/fvHBTlgaYQIzcI=;
        b=X5AVotbEK6atQhNjrhtrKs3bygci5Hs9SdVKnTVbPJDpTIwFNEExX/mnZzzaIdYN56
         We87O01mb+dinYzuDIkE/XV7X1vEDC4s4HdXwijqqdwtS7HAUrVy61RfAHMqoCuGCyo0
         iXVBDvNwY6dcWBtMwEGuEjADsc3EnDeqpmfm5IkABz+d0gjFduOp8i+EaHSzTxCvrlwt
         ooTjGMtdNMvWmGYsWaV6hnPZ/DCQkJBFckbUYsB9c5m9gRat1RJ1MjNwU2LYK+qcjiuv
         jfeJiTcUhCgFaBjwR7/Yy/+1OUwpC3KXdnCJfaYrniNABJ5m94F47gR+DlhbLbzH8XNu
         xCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mf3PfXpISSLDZMwm9YZTjHVTAuZA/fvHBTlgaYQIzcI=;
        b=KTfSmHvp1Czj1dLh4LK3IWJ1XlLR1BYR2bA2Y1G32RqP2eMLiQEpINfZ0jit1j79AV
         5UcAR/4mnS7QqUHSIxU3Z91wTY2KMyshVYg1EgFHaUU7PDHbNFcIyyPbZjaHG/gS2mg4
         R8wOdLaoEtkIUIkDioR69yYg5rKjY9s8A2LmyFUje7SUvKz65Atte+1VrY0zPdamp35q
         tnJelQHuf8Ze9plFhD/oansKAKbLV7elXLAvGIghgu6h4SKUB9ZVPXSQDY05d+SG+B6q
         MNf+rwfg00fRZuQaLYihhwhtl1sG6TKHeLcDPPRhb72pmhcjkuH62H1lYINBYOTeFttb
         vQ4Q==
X-Gm-Message-State: AOAM530EKLPesHJL8/F2fj6l7XwahR9BiMXd2du5dVcUKNTY00R9g/xx
        QOHTRudg+Ik4ThE2Y4hIQv/dI4rC/WGGn5SGpjjm0g==
X-Google-Smtp-Source: ABdhPJygw52SbW2dXW+oPoyP50PRJ3SqpU5dALd4uwGiFSlA85XNU5GjOTBuXNctFj4gYs+N1Ax+fsUeXxWS12NU3Ec=
X-Received: by 2002:a05:6638:2044:: with SMTP id t4mr13460135jaj.12.1619383640861;
 Sun, 25 Apr 2021 13:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210412074309.38484-1-psampat@linux.ibm.com> <20210412074309.38484-2-psampat@linux.ibm.com>
In-Reply-To: <20210412074309.38484-2-psampat@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sun, 25 Apr 2021 13:47:10 -0700
Message-ID: <CAAYoRsVcVnrBSNu=umdVWtRw3PyuD=c4uaCCcoGQpSWgq3AH=g@mail.gmail.com>
Subject: Re: [RFC v4 1/2] cpuidle: Extract IPI based and timer based wakeup
 latency from idle states
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pratik,

On Mon, Apr 12, 2021 at 12:43 AM Pratik Rajesh Sampat
<psampat@linux.ibm.com> wrote:
>
> Introduce a mechanism to fire directed IPIs from a specified source CPU
> to a specified target CPU and measure the difference in time incurred on
> wakeup.
>
> Also, introduce a mechanism to queue a HR timer on a specified CPU and
> subsequently measure the time taken to wakeup the CPU.
>
> Finally define a simple debugfs interface to control the knobs to fire
> the IPI and Timer events on specified CPU and view their incurred idle
> wakeup latencies.
>
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>

Reviewed-by: Doug Smythies <dsmythies@telus.net>
