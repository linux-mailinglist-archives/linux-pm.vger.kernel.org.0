Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5374D612DC
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfGFT4Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jul 2019 15:56:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36583 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfGFT4P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 6 Jul 2019 15:56:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so5692558pfl.3;
        Sat, 06 Jul 2019 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rdIXRuC7NtBV4U1/w6LEafkVG7RzW7TEmbreVlueNKA=;
        b=Cqvb9HBEcixv91n56a2YxAnRpUeggG7y5cXiyagiVu7Vs9OM71q1RhrTZ4Jk4DBqLC
         oR10n5MBlJbouu5999P3lWVOZG/WzqqmFtlqhJ7q4gvoGDUP2d09sJGsREXFpNUzssRV
         jIaRwKRoHGEdOUOcXFoLkvwkvmRy4eTw40Ivuo5x5mkJyg7uKxURLwRakU12vMEuTMrP
         GiD2zv8+3zC0UC8LohxaoYBVDp3BodkhtoZKSbbUDQcEq7z71AS5bKcHVqBw7YEJTUFQ
         BbwwBi7SwN7pp5U24GtPzRVlitkOhHqf0fTYKNq6xKa7wtnyzZzRsHB8Xd+3zbZlZVi5
         osPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rdIXRuC7NtBV4U1/w6LEafkVG7RzW7TEmbreVlueNKA=;
        b=KQfnerXf8qdHY84t4fqx2PGdmIZZawfCKmZZnP4gZAuRBTFZmE+EAjgk0xiIh19kzl
         Duo7nRVaG/q4/FtYU5Gi9Z3oyfw8zHKyaaO8GP5jJL6obQrxsQ4t15WG5BoMRV3Aolok
         we3HhMwZYqmYeLGPEal+Eu5IQEoOUgJFLPgLbTJcwUmJ2xFIxIXwHxBv+Oc29NB6fGhW
         Qrr2Qx0uyK3NESPBrhlR5GVcvQQn+DJu3omg/f2r0Hif8S5Asy3MepbFLxOY5nFunWQR
         xIA+SeeL3EkdmY5lABX0wNpQw2NAET4lqYPzkpQUA9rA2Pfrw32hMwLsf7GBg2JxJsJM
         EaoA==
X-Gm-Message-State: APjAAAUzQYuV+lyXkDwoGAawbJUEELfcrBJgMNJIt1I1QNESSrcuHa1V
        IvlTM8kG04H2ay3qXbE4kBk=
X-Google-Smtp-Source: APXvYqxL2fcdJMRm7Zr4rY9qTpSt3wgEXavqeaaNwMzlyQE7DqTdBwn62soMZFefr4wMjd/ZDjwUmw==
X-Received: by 2002:a17:90a:cb97:: with SMTP id a23mr13025330pju.67.1562442974920;
        Sat, 06 Jul 2019 12:56:14 -0700 (PDT)
Received: from Shreeya-Patel ([49.34.71.227])
        by smtp.googlemail.com with ESMTPSA id y11sm18657887pfb.119.2019.07.06.12.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Jul 2019 12:56:14 -0700 (PDT)
Message-ID: <dcbc0088f31f26f80ab05e51787099df9b70262f.camel@gmail.com>
Subject: Re: [PATCH] Documentation: cpu-freq: Convert core.txt file to ReST
 format
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     skhan@linuxfoundation.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Sun, 07 Jul 2019 01:26:07 +0530
In-Reply-To: <CAJZ5v0hovK+BY0kozGvkyCgR5CFHpZUu71BZRjUUdCYV8fM5Hg@mail.gmail.com>
References: <20190705210428.8039-1-shreeya.patel23498@gmail.com>
         <CAJZ5v0hovK+BY0kozGvkyCgR5CFHpZUu71BZRjUUdCYV8fM5Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2019-07-06 at 09:58 +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 5, 2019 at 11:04 PM Shreeya Patel
> <shreeya.patel23498@gmail.com> wrote:
> > 
> > Convert core file to ReST format, in order to allow it to
> > be parsed by Sphinx. Make a minor change of correcting the wrong
> > function name cpufreq_put_cpu to cpufreq_cpu_put.
> > Also create an index.rst file in cpu-freq and add it's entry
> > in the main Documentation/index.rst file.
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> 
> I've said "no" no three previous attempts and this one is not
> different.
> 
Sorry, I was not knowing about it.

> I don't want to have anything .rst in Documentation/cpu-freq/.
> 
> There is a *new* admin-guide doc for cpufreq already and what is
> missing is a *new* driver-api one.
> 
Yes I saw that but it didn't include all the details given in
Documentation/cpu-freq hence I thought of sending this initial patch.

Thanks

> Thanks!

