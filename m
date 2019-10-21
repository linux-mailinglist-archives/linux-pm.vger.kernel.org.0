Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D83DE5EE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfJUIIR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 04:08:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36378 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfJUIIR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 04:08:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so12179749wrt.3;
        Mon, 21 Oct 2019 01:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LqSjagznmreorQh4WjtYpX4/TXXxQLyl2wI57WLhs1A=;
        b=IEObjFEXPGDUd6z6XzvVnqEHSgIsFRosOJro49cIUoX025/yU3BHzQyoRhB8McUc9g
         37//D6S9DWMqzE8ubub6JVVlvDb2EYpTMAognN+RYhZj80wSnK2XW9rQPSNZxeVf12vj
         VvNGfioGWLyc71UCltavgH9wSgQhoKm3zHNAD3/qPlUIxprjqMdpENnHedvx3QYNlHJD
         okFSUpCIald8gd1We+TxS61p2CywAiqnyC4f9VJNoR/lG7KTOzEzOKN8gMI6wMdPPd0H
         0rsi6CRQuNxdVSU486VLG5TJvXgjhW3hOE7ZGDlKCqFvY+DdYvb87APeYreYukWHBn6h
         Y5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LqSjagznmreorQh4WjtYpX4/TXXxQLyl2wI57WLhs1A=;
        b=VszkjsNlOK5pn5XgUTI2BhzNrKYP+btWeYFz147Om2SNM2pRK/vvlBrL+jaz5bV/aj
         7U/0ySHq/ysWcdBJE5y6LgYb4iDTbgMOt0E17DVFDylxc21f89YOR6lGzqUZW+zr71bu
         SMfRkds8udcbk5AMxbXIUB/1meQ3tkMJUOcoonS3WVBk8UVAS2jgKKg+ZDKMTQRhgX72
         rSmwk+hv7eyLGIYmuzC2wT304xmjVmbm28QbABZD5deO5WppCvfQWfuAOUq1BqdqEUZR
         8f1pDZVuS/LNLGZkgUZ5BKAV5qNtMljFlfB3qA9ZzcZo/hGYQtu8KPdI4/pptJmZqnUp
         0+UQ==
X-Gm-Message-State: APjAAAUu8N6sK/s8DkQt4x9XBiWcdjv/xWoVkNB8DK5PvStDTNCzZPVI
        Hy6mzLPGAV1D43Ezq0b/Ykc=
X-Google-Smtp-Source: APXvYqzTRUrh18jX3Gno07y4/ixRibHCySgpY4CHIq82WdkkdE6OsHf3FKF6NG3ZbwYGYrzrHZND6A==
X-Received: by 2002:adf:ee81:: with SMTP id b1mr17098306wro.58.1571645295114;
        Mon, 21 Oct 2019 01:08:15 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u2sm11702169wml.44.2019.10.21.01.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 01:08:14 -0700 (PDT)
Date:   Mon, 21 Oct 2019 10:08:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/6] cpufreq: Initialize cpufreq-dt driver earlier
Message-ID: <20191021080811.GA54219@gmail.com>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
 <66d8ae593ce7936a5f492d0c6855c1ac225b64ee.1571387352.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d8ae593ce7936a5f492d0c6855c1ac225b64ee.1571387352.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


* Amit Kucheria <amit.kucheria@linaro.org> wrote:

> This allows HW drivers that depend on cpufreq-dt to initialise earlier.

My obsessive-compulsive in-brain spellchecker noticed that the title says 
'initialize' (US spelling), while the comment uses 'initialise' (UK 
spelling). Just in case this is not some post-Brexit expression of 
cross-Atlantic friendliness you might want to fix it. :)

Thanks,

	Ingo
