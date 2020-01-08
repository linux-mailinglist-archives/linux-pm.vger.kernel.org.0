Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478631344D6
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 15:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgAHOUm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 09:20:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38487 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgAHOUm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 09:20:42 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so2571461lfm.5;
        Wed, 08 Jan 2020 06:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nkXR1HxldhNTY9+QT7OcgJP5yqKzplwBd69vhUXJ01g=;
        b=MqvJL3bEngnvthTMnTbrB7XsmBVKbfvn4iUGjJHiRgb7d+k+2DX9AUYABY9HnHdKCa
         /e8SjRIE16zAFq0BBlZcIgl3tDyHgW02Iy2smmI2c7Zt35feErZMsWV9ycI2B2kBLEq3
         47Rvk966hW/ZjtYXQpyqCyJ0HmpeKzbN8TxL5BVBwMbcP3x2ruVJxqNwrmxLlO2yY84M
         SY6K7gtECuh7AS+nux6UQ7WvV21F4ubP5BhUfCZXYo3kq706iDWX6iZBEi3Q2Bn2If/m
         LnrD6Kt8xLfWzeLBgZYbdeGRzIsh/j4r/+ulykrTbNWM+AOr7Ge7Ke0v65mMTbwWRIz0
         XINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nkXR1HxldhNTY9+QT7OcgJP5yqKzplwBd69vhUXJ01g=;
        b=BYy43kT+GuCybIUHbR6imN/6d2UlMC1V1YMZPyXGCt/8uGxNl5z824xkRyKpjI75Id
         neK2WtSY/lfV+qiYf01v2I/oP9IvoUYnu1Uz/Smvbknea8+hTcpvbUUUTt4Lz1tNEkje
         NvvU2OR3WX9ndNKyTLbdBlFwWLHJfU00w7F8+/RzbB8caY5GsvB2WUEttEhunRObE2wD
         xZIbwQ0yBms10Q1BQZtruLPka2tfSVFI2UgvCUqTPdXXUyahDTIxzXR8X4mIEE+48cFH
         KBbpGHZyqtU1bucFRVXCOpux82UK9obiE1MAxAWg3SRGT1I7lmAfza66NxrdPj+xeu1A
         Cv0Q==
X-Gm-Message-State: APjAAAX0t3dRbNXfQ0Ye3Ec/Z66N1S17yWVBD16eiye/ktR0qN+rdb1K
        FtDu0++RLK6beVuCb/yh6d0=
X-Google-Smtp-Source: APXvYqy6g5K8sS7Ks5DB90yKTqnlQPXw3BtYkkXEhglE5emF1ljvo0HfBo7Bde8gxHquVyROp553Nw==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr3151111lfa.70.1578493240249;
        Wed, 08 Jan 2020 06:20:40 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d1sm1566119ljl.18.2020.01.08.06.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 06:20:39 -0800 (PST)
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20200107090519.3231-1-cw00.choi@samsung.com>
 <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
 <20200107090519.3231-3-cw00.choi@samsung.com> <20200107214834.GB738324@yoga>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c1e6f324-b0c2-41ff-a015-7ba0b29ad42c@gmail.com>
Date:   Wed, 8 Jan 2020 17:20:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200107214834.GB738324@yoga>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

08.01.2020 00:48, Bjorn Andersson пишет:
> On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:
> 
>> Add new devfreq_transitions debugfs file to track the frequency transitions
>> of all devfreq devices for the simple profiling as following:
>> - /sys/kernel/debug/devfreq/devfreq_transitions
>>
>> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
>> in Kconfig in order to save the transition history.
>>
>> [Detailed description of each field of 'devfreq_transitions' debugfs file]
>> - time_ms	: Change time of frequency transition. (unit: millisecond)
>> - dev_name	: Device name of h/w.
>> - dev		: Device name made by devfreq core.
>> - parent_dev	: If devfreq device uses the passive governor,
>> 		  show parent devfreq device name.
>> - load_%	: If devfreq device uses the simple_ondemand governor,
>> 		  load is used by governor whene deciding the new frequency.
>> 		  (unit: percentage)
>> - old_freq_hz	: Frequency before changing. (unit: hz)
>> - new_freq_hz	: Frequency after changed. (unit: hz)
>>
>> [For example on Exynos5422-based Odroid-XU3 board]
>> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
>> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
>> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
>> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
>> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
>> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
>> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
>> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
>> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
>> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
>> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
>> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
>> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
>> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
>> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
>> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
>> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
>> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
>> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
>> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
>> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
>> [snip]
>>
> 
> Wouldn't it make more sense to expose this through the tracing
> framework - like many other subsystems does?

I think devfreq core already has some tracing support and indeed it
should be better to extend it rather than duplicate.

