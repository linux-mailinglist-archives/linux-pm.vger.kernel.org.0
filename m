Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E64B522C7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 07:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfFYFWb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 01:22:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34623 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfFYFWb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 01:22:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so8174568plt.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2019 22:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/gWuRyU/Duq5CAjVUkd2QM2Pr9Cpbj+2yc6xJIqbYg0=;
        b=h+gLEkNLHZI8vojygUc5xkXMj5Ju/qGHRsfGvpLiGP2lBjfFLyAqK+RDSp3CkKzuod
         PJgZxbWv47976szedhsoRivQbdE9jnXELNP7kYJS6JxtT9/rcHqRrlYySPF3bNPx1ilt
         oLhi6hYouYvweu0bIplQf8OSvL4sB1SypFdP6USWti5Io4JMzO6s60SUOmssi+HFNTFD
         l1ZHxwt/FT02sadDIpqaXNbhBpAmwTurb85cwUFbrW+wPmQq+crblfvoABz1tfix2O5H
         DssgQqqzklDPKS6YZI+GdLIgF0sfOnFaQvNuD9PzUqOHa8liPtc2rIcRMjIr2kLx5rlF
         aIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/gWuRyU/Duq5CAjVUkd2QM2Pr9Cpbj+2yc6xJIqbYg0=;
        b=I7HdACv0ndZiWnsxViISvRjFNakVl7VByGb3BC5ncgTKj4o1L2q4HARgHp8mZyoKrM
         9IvMLbXhqJoyiWN8WdnyCQIIyNMBvTJ4XoLVaw0LCBu6YMSNkP4gW9e9puf46HdD/t9A
         pjl/wLun2jvIoo4xv770R3068JqU2pvIHx5T3sgmDEJkCszPrup9Z88Z79MfAbS2gCT9
         wgFdDbk+Xne9b0Nc/iI5KmoHPkJ/KanLjgX4paaqSHBhVr9Zfr9zSJySqDxNlAKSOQZO
         TaeqFVszboTBVCPR0UsvVrI1JnSnA6ubkczg19/YaDKkZfpULpiVkHafgGv8auGAm6DW
         OGdw==
X-Gm-Message-State: APjAAAWIfuOdqOinBCqN5yiHhQk+Yg1Zh2hcNXsbZPqX/wRmeQIqG1Y+
        9fKdWBMz2uGAKP6O2w1WcPxOQQ==
X-Google-Smtp-Source: APXvYqx6447KBR7F9f0rnZe2hhCgdBbpaALrx7vLYLsRwlMUTihth3sIcjPTgIzTmQm89dV5ft39jw==
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr125187497plb.46.1561440150610;
        Mon, 24 Jun 2019 22:22:30 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id a22sm13653060pfn.173.2019.06.24.22.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 22:22:28 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:52:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20190625052227.3v74l6xtrkydzx6w@vireshk-i7>
References: <20190622003449.33707-1-saravanak@google.com>
 <20190624094349.rtjb7nuv6g7zmsf2@vireshk-i7>
 <CAGETcx_ggG8oDnAVaSfuHfip1ozjQpFiGs15cz8nLQnzjTiSTg@mail.gmail.com>
 <20190625041054.2ceuvnuuebc6hsr5@vireshk-i7>
 <CAGETcx8MuXkQyD5qZBC948-hOu=kWd4hPk2Qiu-zWOcHBCc=FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8MuXkQyD5qZBC948-hOu=kWd4hPk2Qiu-zWOcHBCc=FA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-06-19, 22:00, Saravana Kannan wrote:
> All of the cases above are some real world scenarios I've come across.
> CPU and L2/L3 on ARM systems are a good example of (2) but the passive
> governor doesn't work with CPUs yet. But I plan to work on that later
> as that's not related to this patch series.

So in case of CPUs, the cache will be the parent device and CPU be the
children ? And CPUs nodes will contain the required-opps property ?

-- 
viresh
