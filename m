Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27170F8762
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 05:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKLE0P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 23:26:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44570 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLE0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 23:26:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id f19so10942034pgk.11
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 20:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7BKfMfSXnTh3cSSm4voN8yjp51GKJooV7R4HH1qU3AE=;
        b=pGd6nNYcLhdp6v9KouXWOxBsIlmOlL8anLquDkgG+6jRebdBjlC2BqN9Ybc3E7OMa9
         r4ABb9D2Rzy4hMHBOgPbUcaA1d9O/k639KZretorBJRvdbxsmg0t6YdjptAPtw6/pjqj
         fe41Y+0mGquomnD3XIuxNplnk+NxcArjfN9z/tNjgmQVkxhNHoToK0S0wSExk3xKjfr2
         FTmc1lbVot2NmiEepuw2EOuEc4A5u1x0P6yQCkCgEo3P9jumpRVgLOGumi6y+0iOYTw/
         nZlg4j82fC7lBa8+WDmDqnAs6MjQr16hHK5eNGf8DnAom10LOYze2c+fXugnMUExEkIV
         PkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7BKfMfSXnTh3cSSm4voN8yjp51GKJooV7R4HH1qU3AE=;
        b=qZBHApl9JqKXSS7WJxj+jgju3mq/UYbOia4Gq/HkYbdJYu3Y4JQySbbxRbVw0BeK+E
         koDtBzED2uDS5KtLGgB4WQJMxeK5ryElhzefdCRbXyOhyj4Eu2aF31MB/W8VSP+xNkLy
         9Id1mkwPpKn/K0BdkdLrSMRqxoK0mMy4HZKvjgvoNrfB9dwoZhyOO/d+e16EE/aBF9E/
         CMtDevXAHLyxjS8if9iW1rEQSKRFx5+QcdLSLP/h6/hqSY79SHRY1MUXp62681GEdtB6
         biITAip28EZu0oP64YyhkDaKPiPE0YPF+mnsJolXFOizsdxXUHj52nNHYH8euKN1kS6A
         BOyg==
X-Gm-Message-State: APjAAAXCuPdTwR0J1m4/Ot+Zz1CSDmBOjpXeZXZiecKLn+/ERBJiPH8V
        FpVrK/wsWsV81krXEkPR9VsU8w==
X-Google-Smtp-Source: APXvYqyMn0g27kWpD6eV1C9Ag2lK/JyppJPH9+82MVGsgHQFXI8g+rUZwrZCvoJXVVxm5YB8pr5eow==
X-Received: by 2002:a17:90a:1048:: with SMTP id y8mr3699651pjd.22.1573532772696;
        Mon, 11 Nov 2019 20:26:12 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id s1sm6182078pgb.57.2019.11.11.20.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 20:26:11 -0800 (PST)
Date:   Tue, 12 Nov 2019 09:56:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Add usage_stat file to sysfs
Message-ID: <20191112042608.5of2bn7ubpokhqxn@vireshk-i7>
References: <CGME20191111215534epcas5p35b69167fa14a5c026b765c43faa5ec67@epcas5p3.samsung.com>
 <f70ebc907933717ae5fe2af5bc7f53eed0ef3308.1573508311.git.leonard.crestez@nxp.com>
 <41c7e481-7bbd-cf5c-a18c-31b4a3dd907e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c7e481-7bbd-cf5c-a18c-31b4a3dd907e@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-11-19, 09:46, Chanwoo Choi wrote:
> Hi Leonard,
> 
> The role of sysfs is not the debugging. We cannot add new sysfs entry
> in order to get the load tracking for the debugging. 
> 
> For the debugging, use the perf event in linux kernel generally.
> And devfreq core already merged the perf event as following:
> 
> [1] commit 1be0730f1dcd ("trace: events: add devfreq trace event file")
> [2] commit cf451adfa392 ("PM / devfreq: add tracing for scheduling work")
> 
> In result, Not Ack of this patch.

Such information if useful can be added to debugfs though.

-- 
viresh
