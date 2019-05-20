Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65BD22BF1
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 08:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfETGQq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 02:16:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41222 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfETGQo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 02:16:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so6667787pfq.8
        for <linux-pm@vger.kernel.org>; Sun, 19 May 2019 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j7flk/DSkrz8ciFVm2tXEa7iDLO7WbVCRqJJwVgxAH4=;
        b=ghEoMNT9/yN0OmaGTfwUmbLSFIhFEow2cCdiGzL+DIevX9u5WnA1+uEtKVb506eSKf
         slsW1mWN3VSCUjDKRcTuetSp8AOloaTHvdapUMD5ieSRzUTk42igKPpNVSVKJk58bFlh
         HWrmuM+iM1sjEOkFjZfT7Vc96toVUKOfQHQoHd34RF81b3sNAYEdwYmtq6ujQh17I0bj
         NOgv6Yl2kP5k2gchI+zmoK4Qvnpq29JPhBh/DHpjwXGg7GOj2PRuhhYcNE6n7tQxuKMT
         j8wd+3yEohmlHwbY0gW3s9C5BmLBl1U3T+tiqRg7Upp0sH05WEj3hsvUpFYDRZcvRRVL
         vqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j7flk/DSkrz8ciFVm2tXEa7iDLO7WbVCRqJJwVgxAH4=;
        b=KJFjR+YQQEnX+UuZSsKbcNZ7G+EvNvxtJY4rXvT/pvo2qYbuB0/C9eHx8LBunOdrjm
         kzzb1Hjsj5V4ZFYeVFylqaVcp8tfx5EOTnhQxlsJSJCT4/PFau9rerTkFYq43ZCatz5u
         6U40EOFoO762TxRzlQjx6nT4bmNYKjKXw3UmNFk6c27BL1tejUzh/ZCCgCLpd4baKTHd
         Atk67sDWGVQUxjJ/rFuTkH8Ir+fcDQw7k2KInG7Lf9l7f4D9K8xf+E9QHKm5bI474HFp
         O8v1fl6ESYf62NX7QE7Ybwl5WMacG7jaM/0HgH32erCH3/NoHGWehOh7iF8exfd5mMQr
         oe0Q==
X-Gm-Message-State: APjAAAU2dpXzcWHeIBj6HWNikQPVD/uFsfiCZcO9SZJ1oN77bYJ4QlTi
        JbinLIw95vrwGReTYyiXjiKSgg==
X-Google-Smtp-Source: APXvYqx+7OUdo03ZrYJprsOAW5JDs8v4y0TSBWWq+UIVaruRPwXQbhQrKnveriuVbNfkdlVtwkUAbA==
X-Received: by 2002:a63:5742:: with SMTP id h2mr72727810pgm.194.1558333003587;
        Sun, 19 May 2019 23:16:43 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id c16sm15836970pfd.99.2019.05.19.23.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 23:16:42 -0700 (PDT)
Date:   Mon, 20 May 2019 11:46:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, Qais.Yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/5] cpufreq: Use QoS layer to manage freq-constraints
Message-ID: <20190520061640.vfn5cmv6a76lhfw4@vireshk-i7>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <2575955.AqKVkXLaMl@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2575955.AqKVkXLaMl@aspire.rjw.lan>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-02-19, 12:30, Rafael J. Wysocki wrote:
> On Thursday, February 21, 2019 12:29:26 PM CET Viresh Kumar wrote:
> > Hello,
> > 
> > This patchset attempts to manage CPU frequency constraints using the PM
> > QoS framework. It only does the basic stuff right now and moves the
> > userspace constraints to use the QoS infrastructure.
> > 
> > Todo:
> > - Migrate all users to the QoS framework and get rid of cpufreq specific
> >   notifiers.
> > - Make PM QoS learn about the relation of CPUs in a policy, so a single
> >   list of constraints is managed for all of them instead of per-cpu
> >   constraints.
> > 
> > V1->V2:
> > - The previous version introduced a completely new framework, this one
> >   moves to PM QoS instead.
> > - Lots of changes because of this.
> 
> Well, thanks for working on this, but I'm rather unlikely to look at it in
> detail before 5.1-rc1 is released.

Hi Rafael,

This series was posted almost 3 months back. Any comments on this would be very
helpful.

-- 
viresh
