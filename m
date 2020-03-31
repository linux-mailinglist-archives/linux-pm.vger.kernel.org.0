Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25407199CD0
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgCaR1D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 13:27:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34306 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaR1C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 13:27:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id o1so7869232edv.1;
        Tue, 31 Mar 2020 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mcrAQUUjnBmTfyv+ejaR6lSeHh26TbNTkCdqRT85gWA=;
        b=YlatPw3kMTZwYOzqxtb8S39edjOKJUTha51WoQFYTrWT2PcTiobKlbWzEfHJlvYy+a
         9GOelMXYppY/JnKF1cN1iDf6J+FZUMhR768t1nn6gjZo1v9sgd9h8nCMJIxt8PJV9It+
         kTTMuWUcPGLQJpryr5ULgdzywzXas3lCBjOO6J6TttPwZsXZ5y1Lw7zjMUig/LDq0Dz8
         egwlf/F1mW7mHmi+fTmxvv00+9CvhH//IYkfzVkROwkUCt0JAhFm0O+n9Tnv6iusuFB8
         N0toXzSmnJDRdhuRwpN0M+1oLnsYVgOj00xNdA//GzFqvVj6cbr+vphNKuazKqqfWLSB
         Rg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mcrAQUUjnBmTfyv+ejaR6lSeHh26TbNTkCdqRT85gWA=;
        b=qFE2eRjlLESUwOiHpK2yQm1cmqht2FqzhkrQgvhttlu7KfB0aYfRkLYuE73THPUea+
         n6LE52Du/AxK1qGgzZmk8ySUV+kmefmEGv9AakgkwWBeijokfIj+RiP3Axf/AJIzl3S8
         xl/kuO198Wh+eWcKryKOXfe+4bxEVJInNCoAGxK4fbDaCMckwzKpmD2rgELn6Yf26cuh
         hePYj0MZ0xlTiqW+jheUFfJHzTMRLqeMmWfU9oqKBAWlCTbav/0+hS2a5p2xh8AtV9iu
         4r1yj6V6o3kW60ifWHDNj6kcIAwRWP+d+9peFKxxUzhG2R0haAazmxKVQNsZvCKJUdIE
         xgKw==
X-Gm-Message-State: ANhLgQ3qoEG3Qhoe//mDHlsq6R0/tqMq5JoV6qyez+YpgqpKDgA1D5cg
        uI4NG0OG2l0gtvCd8CjeG4chQuu6
X-Google-Smtp-Source: APiQypL7Rfa6dCTvHvhnrKLsJSWybE0ElcF/fHPTVnCGjVuFvFtf2WL13/3pMwTMBF64EQQv0IWoOQ==
X-Received: by 2002:a05:651c:22e:: with SMTP id z14mr10406742ljn.64.1585675282154;
        Tue, 31 Mar 2020 10:21:22 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id l7sm3452845lfg.79.2020.03.31.10.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 10:21:21 -0700 (PDT)
Subject: Re: [PATCH 5/9] power: supply: smb347-charger: Implement device-tree
 support
To:     Jonghwa Lee <jonghwa3.lee@samsung.com>,
        David Heidelberg <david@ixit.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        mika.westerberg@linux.intel.com, ramakrishna.pallala@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200329161552.215075-1-david@ixit.cz>
 <CGME20200329163055epcas1p2cb50a5892440ecff127f87cb4306571e@epcas1p2.samsung.com>
 <20200329162128.218584-6-david@ixit.cz>
 <2dc4e25c-4b3a-1675-1f9e-0437a3526835@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <44ab265e-4a67-bc26-d931-ca7d155171a2@gmail.com>
Date:   Tue, 31 Mar 2020 20:20:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2dc4e25c-4b3a-1675-1f9e-0437a3526835@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Jonghwa,

31.03.2020 03:25, Jonghwa Lee пишет:
> On 20. 3. 30. 오전 1:21, David Heidelberg wrote:
>> This patch makes smb347 charger driver to support dt binding. All legacy
>> platform data now can be parsed from dt.
>> Because of that smb347 is i2c client driver, IRQ number can be passed
>> automatically through client's irq variable if it is defined in dt.
>> No more to use requesting gpio to irq manually in dt-way.
> Thanks for keeping original commit description and revealing where it 
> comes from.
> 
> Anyway, in the above description, the last three lines doesn't match to 
> the commit since
> 
> the original patch is now split. Please remove them or you can rewrite 
> description as your own.

That's a good suggestion, thank you very much.
