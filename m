Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E007B5B1
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 00:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfG3W0k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 18:26:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39868 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbfG3W0k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 18:26:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so26576816pfn.6
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=wtE8Qs6WxdqfhKDtqY7NOxwIx8qnuciqL0xbnCEtDy8=;
        b=lf0JpW9ckD66UO7/vIhzs7MO0L2BH0pJ2Z5wVAUptbQ4zwlT/dfgE/gLqdt+cmnojs
         eUO2YzcXwrTXe7Qq62KIBCw8xgJP4qmKQ199TOALlhH/RuZTJhJEcw2tjBIj33yD74kd
         jREJt4lJCLk8a3jx4NXibqd00INprbu8qPUhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=wtE8Qs6WxdqfhKDtqY7NOxwIx8qnuciqL0xbnCEtDy8=;
        b=HzQ6NWsMNf0DYBCEK3pCl3T8Piapb6vZhrDLOdv7m+vS7UFSzf7LmxgnWONAsMTc2o
         EPUC9CVbFlv15ZzVfFHOsADG2mvFTyHdt3oz06S90gEUJZjqOF/S0b7BuUToEZBWTUez
         zt8BZQ9vF+psPXkoovHN/Q3AQiNrTIuCBbkQdvcwPqZpP6rwIx5gp0BnmZAhWkdwTBNM
         RTZ0YHAmKmHF2ULYeW9AXsaJs83DhDbYA98bgDbMs8KI5KI7VuwW8BAlFBof5aX9p5z5
         APTBgndx2pKEsr4UqoikR9oL6yT44Nb1DXQ+p14N7qTvFV0kFS8aEIXC/y+UI7lt/6Xc
         bIfA==
X-Gm-Message-State: APjAAAU0b3h/VBqU0DS7GxA0r39Qk3ERTdT5AthVHg6Zz7CfRBHw/OW7
        voLR42HKo9QXrGMY1vyN25Bxlg==
X-Google-Smtp-Source: APXvYqzmCGgbSxYYdExQZf0zV20cq2S0wbI4IzmWdNg3JbAP1ExccOW0hF6cMcASAqTVi42DsD6p4Q==
X-Received: by 2002:a63:8a49:: with SMTP id y70mr16015123pgd.271.1564525599777;
        Tue, 30 Jul 2019 15:26:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm107068280pgg.27.2019.07.30.15.26.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:26:39 -0700 (PDT)
Message-ID: <5d40c41f.1c69fb81.ac63f.947f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2085893.cJkfNvi94x@kreacher>
References: <20190730024309.233728-1-trong@android.com> <CANA+-vBKg_W88Oy_wJs1NNYaZ2ciJKO=Mrs47etYTDNXUKW9Uw@mail.gmail.com> <5d4090ea.1c69fb81.d5cab.4dcd@mx.google.com> <2085893.cJkfNvi94x@kreacher>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Tue, 30 Jul 2019 15:26:38 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rafael J. Wysocki (2019-07-30 15:17:55)
> On Tuesday, July 30, 2019 8:48:09 PM CEST Stephen Boyd wrote:
> > Quoting Tri Vo (2019-07-30 11:39:34)
> > > On Mon, Jul 29, 2019 at 10:46 PM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
> > > >
> > > > On Tue, Jul 30, 2019 at 4:45 AM Tri Vo <trong@android.com> wrote:
> > > > > - Device registering the wakeup source is now the parent of the w=
akeup source.
> > > > >   Updated wakeup_source_register()'s signature and its callers ac=
cordingly.
> > > >
> > > > And I really don't like these changes.  Especially having "wakeup"
> > > > twice in the path.
> > >=20
> > > I can trim it down to /sys/class/wakeup/<ID>/. Does that sound good?
> >=20
> > Using the same prefix for the class and the device name is quite common.
> > For example, see the input, regulator, tty, tpm, remoteproc, hwmon,
> > extcon classes. I'd prefer it was left as /sys/class/wakeup/wakeupN. The
> > class name could be changed to wakeup_source perhaps (i.e.
> > /sys/class/wakeup_source/wakeupN)?
>=20
> Alternatively /sys/class/wakeup/wsN
>=20

Or /sys/class/wakeup/eventN? It's your bikeshed to paint.

