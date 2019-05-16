Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D63209D6
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 16:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfEPOgH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 10:36:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38168 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfEPOgH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 10:36:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id b76so1956867pfb.5
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2019 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z6qc+xOm2mSY89YuD64kBnRl0lHCdqO6siMkABQG/tQ=;
        b=kvfajCTwE168YKYYVnpejF49F7QgA/sI8IkR1mGExszOMXoDHkiw2gfW1k7K7emDqT
         gW225qmmYOHVcXMEzXNwTqG8V/sehXeCqsDCKbbh/lSCH+xvw+vdKsL3nnta61rB7Gsl
         TZGJTzkzgNAEHI4E92y8BEKQUt1ft30R6GgYUERKeMnpW9QwXHSY5AzpNSxxlhOjJCOx
         CBTFJ6rIEx07fpX8L3FdoIezgAkfklL0PYjcLTpHBcaT2AkglhyJkfwktl+gU+MfOph8
         RlUohURVcdOPlrTxF7wUVZV+dmbPDV7egtLFQgr2nwW3yb7Egi8wNMi9mdln0hdG5mJ2
         nnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z6qc+xOm2mSY89YuD64kBnRl0lHCdqO6siMkABQG/tQ=;
        b=c9nZWKlxVK8oo1YCP4vfYPZhnL3ffymROgdmlsUsHEW8xse14WZiHTVlT3ZfmrsBKf
         ZVaDffURL8/UQscNaOLUIwA+AQdRjAyCHOoUc0YXsnippi2Yskw6S2DHn1ssPO7Ypi5q
         Mejd04bGynL/1sEI4UDAc9W27j944jNeBvjBScVQbIeXSeLpOYmQqnuwrj9Ep2Y2VE6V
         f2U37JK4C9yJkXOaUrxw35vzVMRjeYeMn/pKPZ2IHAj3ip1p4xev3I1uXC4WLsTT0R3Q
         F/TqgxElqI8VdnakQjKHxOrCl4iOtR2e1rHSmm7hbjTov5pwsYmo9PwQldBcmdyWz4AS
         oIuw==
X-Gm-Message-State: APjAAAVZ0PV9jRko3Agq/gRigxC83cvZP/fuydxZ/fg0g0G9WZ5Gs9v/
        PYL+WNNGUHTdxWcW4ek6a8R4BJ0HP8yS8zb7hhk=
X-Google-Smtp-Source: APXvYqzUd0FpORBfMUBCtYZD0eBrsi/cm9uTYfatp9Rvw0K4bfMa/R3P/Ge8HZtbKCnlO+nXa6XPepUPHKgD/uQj6gk=
X-Received: by 2002:a62:86c4:: with SMTP id x187mr53672089pfd.34.1558017366120;
 Thu, 16 May 2019 07:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com> <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 16 May 2019 23:35:55 +0900
Message-ID: <CAC5umygg7BPhyoKsBDPAoafXHmJnqE1gEarafJDRCrdUnw-3aA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B45=E6=9C=8816=E6=97=A5(=E6=9C=A8) 0:17 Akinobu Mita <akinobu.mi=
ta@gmail.com>:
>
> The NVMe controller reports up to nine temperature values in the SMART /
> Health log page (the composite temperature and temperature sensor 1 throu=
gh
> temperature sensor 8).
> The temperature threshold feature (Feature Identifier 04h) configures the
> asynchronous event request command to complete when the temperature is
> crossed its correspoinding temperature threshold.
>
> This adds infrastructure to provide these temperatures and thresholds via
> thermal zone devices.
>
> The nvme_thermal_zones_register() creates up to nine thermal zone devices
> for valid temperature sensors including composite temperature.
>
> /sys/class/thermal/thermal_zone[0-*]:
>     |---temp: Temperature
>     |---trip_point_0_temp: Over temperature threshold
>     |---trip_point_0_hyst: Under temperature threshold

I misunderstood the under temperature threshold.  It is not hysteresis
for the upper temperature threshold.  It is used to notify cold temperature
that the device may not correctly work.

So we should provide another trip point for under temperature threshold,
but there is no suitable thermal trip type for cold temperature.

I'm going to remove trip_point_0_hyst and not utilize the under temperature
threshold.
