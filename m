Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290E96A9BB
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbfGPNfz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 09:35:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46470 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPNfz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 09:35:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so19990126ljg.13;
        Tue, 16 Jul 2019 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JczOqdcOozRgJZn27WRtXECSpKpZWnFeQlOK21NqJTI=;
        b=QZuO3BM9QL/bCfAs6NU0VAMucHxBgR846CrL/8fvzvPFJghkhO/b+F4hfC9b2MQP/T
         q/RbyLnXV1oT9Pig6TN97yK4XiMKWQ5CGjc/av1crPmTHVTgBUa40Okg9biU1mvODdD0
         HSOOb/OtD0UPtu+ovU7PgA6GHz2ewEpSrNk8rDRUca5Rjk9rv8pweR9p5Kde4H5vQZlz
         nolXdQ6K/r/KFyAPxEj/TX5D3bDgQq0y1mksTC3/7iUr9Bxx/Yi88U5X7hPkdc+yvp9u
         MWbagDGPuxMZOYBYCQPyLPENalhRxDD4yaxDWriolyR9RJIrmZounSCi1YnRj2soVBpp
         xpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JczOqdcOozRgJZn27WRtXECSpKpZWnFeQlOK21NqJTI=;
        b=gsWOw9caFH0wd5BCzQQoFY/yu5MQvW//9ctU0I6RyMTkgeuQAXMIE6RJXfh8Rj3Svg
         EtbZHu/xFlRU8XNDduuT7chx6ztjszw667tt7pSMRkcjDDguByPyR7Dbuwxk+FJ4LlSb
         pbTDAKfsTDdz/xsjuZxS3qiPOvfVm3d24pZhKLi9sNqAj7zm8ZJzkNz01EllnmX++wwE
         TnMjYyDwA2CCPQwJU8Ka5tbZsTAgJix2TB2lNS5TtyfjBfAJratPUyVF3suEjyj7R43T
         Filn3S1ylGzPWX+fQpeEjnLBY1vIAPIWzOYt4U9KtAc4yFUapBLVikuzIcTb08sqlInX
         wINQ==
X-Gm-Message-State: APjAAAWl9O7SKqq/D5xq4DF80rwrvLhPr650hhogPjQbDQHZu4PPF7m7
        uUIVAHbgRpVYRk4G/qet7nxWLwEE
X-Google-Smtp-Source: APXvYqx/xOnw9CBAPawQq8tfPCiKknL+ChvYP0A6lzl+WyHt7N847pLg2hkxymRPmNwV3xygfZMsDg==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr2424477ljl.155.1563284152855;
        Tue, 16 Jul 2019 06:35:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id u18sm3761581ljj.32.2019.07.16.06.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 06:35:52 -0700 (PDT)
Subject: Re: [PATCH v4 12/24] PM / devfreq: tegra30: Inline all one-line
 functions
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190707223303.6755-1-digetx@gmail.com>
 <CGME20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51@epcas4p3.samsung.com>
 <20190707223303.6755-13-digetx@gmail.com>
 <b5634fbe-8bc1-0f04-e13b-6345dfbb5615@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b7da3fa2-00d1-5bd6-408c-202c85be917d@gmail.com>
Date:   Tue, 16 Jul 2019 16:35:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b5634fbe-8bc1-0f04-e13b-6345dfbb5615@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.07.2019 15:26, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> I'm not sure that it is necessary.
> As I knew, usally, the 'inline' is used on header file
> to define the empty functions.
> 
> Do we have to change it with 'inline' keyword?

The 'inline' attribute tells compiler that instead of jumping into the
function, it should take the function's code and replace the function's
invocation with that code. This is done in order to help compiler
optimize code properly, please see [1]. There is absolutely no need to
create a function call into a function that consists of a single
instruction.

[1] https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Inline.html
