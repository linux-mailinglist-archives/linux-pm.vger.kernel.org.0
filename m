Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CAE10953E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 22:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfKYVqW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 16:46:22 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:46456 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYVqV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 16:46:21 -0500
Received: by mail-oi1-f179.google.com with SMTP id n14so14579617oie.13
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2019 13:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8BhdzscDp8JTiOdAbD0ome7zkFZ3IJeBDxD1oxIabo=;
        b=mDofO5TyQ5xPJDeSC15czZY39hvVu/7bQCQ9jzTFElVJBr8t0yTk0pn7PPyJFGeo/3
         BoYVO8xf+thO1XeAY8JUqqzQR1gckQW6C7wfBdU07ObEUT2YxhxahQXdpGRTpdemiJvJ
         RcaOncKtr2UecDSXjEBmq7bTM7AOttkNlexu49rjj5+sD9QZDVXsSsoHQQmNpnIK2koE
         3k3SBpIbgUhZbrCIggsnr5QXqiLzjyAcKU1bDSIRvEC9satqH/Bfmef0kCLSz0xvfEJT
         qo5TOtMnnXV9A5mU8VxL/SL0JEzJIiXRP31c0mIdX1Ey3H/aQus7Z9cycZ9zRmAXZN0Z
         Jeyg==
X-Gm-Message-State: APjAAAVTi6jKULLotS5fyrJYyfjTgcQ2oIPaMksTM9t0jLe7ub5G7Wvw
        FhBiGMPTavOsXlg+QUkDvITWiDwduR9F8z85P/c=
X-Google-Smtp-Source: APXvYqzeG1d3mTm91XVT2ubfQ85oILzgT5aqDGFQyhcgOOhSLA37fh5hMHAxpTATdwNcLdK/rUv9h2Cf6cHnswN7tUU=
X-Received: by 2002:aca:1101:: with SMTP id 1mr846785oir.103.1574718380779;
 Mon, 25 Nov 2019 13:46:20 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com>
 <CAJZ5v0gKvDb8=Y04DB3wQe0rK8Zfw5yNuAybV980ozxfmem=BQ@mail.gmail.com>
 <alpine.DEB.2.21.1911230213510.2531@hp-x360n> <CAJZ5v0i2oC-w1RJ2X35fYyHdysorjLRYs-OBn+y_r6ksEZzVtg@mail.gmail.com>
 <alpine.DEB.2.21.1911241929220.16116@hp-x360n> <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com>
 <alpine.DEB.2.21.1911250812070.3858@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911250812070.3858@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Nov 2019 22:46:09 +0100
Message-ID: <CAJZ5v0hFjW-MG5Jxqx7maC0OH9XzrAPEVqzidQhTORTW5i1M1g@mail.gmail.com>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep:
 Simplify suspend-to-idle control flow)
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 25, 2019 at 5:21 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Mon, 25 Nov 2019, Rafael J. Wysocki wrote:
>
> > OK, but with sleep_no_lps0, does it also hang during resume or not?
>
> It never goes to sleep, is what I'm saying. Screen goes dark, but the machine
> seems to never go into sleep states.

So what exactly does happen when you try to suspend with
sleep_no_lps0?  Does it return to user space right away by itself, or
do you need to do anything to make it do so?
