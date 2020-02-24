Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30A16A330
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 10:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgBXJyp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 24 Feb 2020 04:54:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32870 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBXJyp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 04:54:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id w6so8182695otk.0;
        Mon, 24 Feb 2020 01:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gc6ixcj3vcw3nu96Ty+gdGEq2138xYv/wwhs4XUu2JA=;
        b=tmAb1VYcMDhWJ0yTxSndDi4CVoc1mbrUMwol37RDmTWtqSN2ivlBNBSjkskjnt7l3L
         Bv5hvvDgkmw10ftcd83CADKWctU/mHCnp7Gfdwf69k7MyeNQc5/Lj97PtMSwHXmgFyGv
         A/6Bp42/Q0od1NYRYl2GwIStuAsyngKtEq2cN2eKrd/GiqiWlbkz9pAdM1pgQIvTdzPD
         g5pPplwVn2b3HovZMm1GO+Lq8J8Vp+Q+u6MKILNOzSAvnhgxNBpTh+PFppS9FZ9bZUf0
         NYEqB4d5dPzU73M5e9yTiZARBF/ZX/rtV39erW1XSpNm5PSc81txEEU6Sf9rfXES4Lkq
         gBmQ==
X-Gm-Message-State: APjAAAVJ2SuHxQGvv+6F5Vf/8R1O4rTZlD+l+uzjCfHojmZBXevO7/th
        4Fewyxn/lhq6/ROK8LEW18+TJcLXwAUXRx50VV7aIgaj
X-Google-Smtp-Source: APXvYqwA/mVepV1pQKvgqqZxKBhmxkxDpD3Midirk8+nN9iSD2FCRjNLiUIZZcvJ8NGUXV4sWFOoHCwmaSvVBvDl5ag=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr37281264otr.167.1582538084570;
 Mon, 24 Feb 2020 01:54:44 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0iSEV9S=zTa9++vUCO6GTfBE2sxNY+b4mMMt4Y6RCRvjA@mail.gmail.com>
 <62491094-D13B-4EED-8190-4AA4EB77036B@lca.pw>
In-Reply-To: <62491094-D13B-4EED-8190-4AA4EB77036B@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Feb 2020 10:54:33 +0100
Message-ID: <CAJZ5v0jXZOd0yfnwcP1NrfrXnALx=5E1nmK8DHk8bJ0SLUYzAQ@mail.gmail.com>
Subject: Re: [PATCH -next] power/qos: fix a data race in pm_qos_*_value
To:     Qian Cai <cai@lca.pw>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, elver@google.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 24, 2020 at 2:01 AM Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Feb 23, 2020, at 7:12 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > It may be a bug under certain conditions, but you don't mention what
> > conditions they are.  Reporting it as a general bug is not accurate at
> > the very least.
>
> Could we rule out load tearing, store tearing and reload of global_req in cpuidle_governor_latency() for all compilers and architectures which could introduce logic bugs?
>
>         int global_req = cpu_latency_qos_limit();
>
>         if (device_req > global_req)
>                 device_req = global_req;
>
> If under register pressure, the compiler might get ride of the tmp variable, i.e.,
>
> If (device_req > cpu_latency_qos_limit())
> —-> race with the writer.
>          device_req = cpu_latency_qos_limit();

Yes, there is a race here with or without the WRITE_ONCE()/READ_ONCE()
annotations (note that these annotations don't prevent CPUs from
reordering things, so device_req may be set before global_req
regardless).

However, worst-case it may cause an old value to be used and that can
happen anyway if the entire cpuidle_governor_latency_req() runs
between the curr_value update and pm_qos_set_value() in
pm_qos_update_target(), for example.

IOW, there is no guarantee that the new value will be used immediately
after updating a QoS request anyway.

I agree with adding the annotations (I was considering posting a patch
doing that myself), but just as a matter of making the intention
clear.
