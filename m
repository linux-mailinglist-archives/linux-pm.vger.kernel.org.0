Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEE534EAD7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhC3Oqt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 10:46:49 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:44996 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhC3OqY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 10:46:24 -0400
Received: by mail-oo1-f41.google.com with SMTP id p2-20020a4aa8420000b02901bc7a7148c4so3825343oom.11;
        Tue, 30 Mar 2021 07:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Fb2lr7X+C2CJhdbObn3AZ8NAudIfCxV3pT8ToWUbIM=;
        b=dOqQDhk3hpE/XK3T10z0WrQ/uM0DnbTlKHdhxs6CIqpJV5XudaTyz/EJXMHykbtiFY
         guMKvmMWBHWicSjQtHThLM877t8m8Wj8F5QF05mQJ9WPWS/puYorqfoa1YrAAEYB68Qe
         1vTVg65GPonlLK5gyANDHJalh1xYtn1+64UPDnEQHmg4ASS0CzyA86OJF045fwx5rD5o
         8/vF6uzSuHXZj6qOhVXlTjPtn1ppHLbxuXNAPldVbhGCXPKP6tRtBha6dpVgsrvilhDH
         m7Ia8hJ1dsAmPcovsgUqc49v6KGqfXDnuGbHqiTHywMMoK25zAlmBciO8KF/sIkwsbyX
         y4DA==
X-Gm-Message-State: AOAM532Fw8uoo8geCSK95DFj4tuMXZdDvDfr6vFjyPtn92wyAjhEibQY
        ewnUJZreIreOdWUZpO96ZQwtAKcxaY9oJkAO9piuBlmC
X-Google-Smtp-Source: ABdhPJyIIRQPINx68kwqxgQUuWnb9T7lw6ZcQ5LC/bT40MbZnTN3kCtztdr4Qz0jEIeFztaFwfU8NgoVR4TV98eqqQA=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr25999905oou.44.1617115583446;
 Tue, 30 Mar 2021 07:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB08924CD74C6EB773C4D5FAFDBF7E9@MW2PR2101MB0892.namprd21.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Mar 2021 16:46:12 +0200
Message-ID: <CAJZ5v0g+=AnRAmAAn8NpHm8bmZ1WkwDpjb5rr_zPOVABW1PYug@mail.gmail.com>
Subject: Re: Fix hibernation in FIPS mode?
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "crecklin@redhat.com" <crecklin@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 30, 2021 at 12:14 AM Dexuan Cui <decui@microsoft.com> wrote:
>
> Hi,
> MD5 was marked incompliant with FIPS in 2009:
> a3bef3a31a19 ("crypto: testmgr - Skip algs not flagged fips_allowed in fips mode")
> a1915d51e8e7 ("crypto: testmgr - Mark algs allowed in fips mode")
>
> But hibernation_e820_save() is still using MD5, and fails in FIPS mode
> due to the 2018 patch:
> 749fa17093ff ("PM / hibernate: Check the success of generating md5 digest before hibernation")
>
> As a result, hibernation doesn't work when FIPS is on.
>
> Do you think if hibernation_e820_save() should be changed to use a
> FIPS-compliant algorithm like SHA-1?

I would say yes, it should.

> PS, currently it looks like FIPS mode is broken in the mainline:
> https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg49414.html
