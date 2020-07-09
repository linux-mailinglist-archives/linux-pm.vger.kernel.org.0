Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE41219C91
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgGIJsv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIJsv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 05:48:51 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59896C061A0B;
        Thu,  9 Jul 2020 02:48:50 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g139so782857lfd.10;
        Thu, 09 Jul 2020 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o1KOOfGxx5OBPyQu2rzVGMw+QBwUPbLf1gugF3794NM=;
        b=c4oOymho1TrBeDcmCQNBQhLoBKzheX/2MWq0P86Rz/AjM+iKgkb+A6/JzGQVvyhFk1
         BU+5Zb/YNb+ZWK3A7K36ZkVit9N3l0hyEqyr8iifVN2o5OkTzH9GvJXxZHbEpYlpkuIs
         amtA0nAJXM2cORLNwDpHJ5n8xvzkDpYhAFIJX739B5eeLL6qSdMpB8buqJRgL700fEW7
         ZvjGimHGi3bw874GMttAxxgsIag41ko5oygMQxUlY1pmMCI+Gl4rrd5W3rR0VwAfglLz
         /UUATRDg8CuTidMDyKz1cq9y4AEjxbGeNKLC3sqP5C1Av2IXpdz4AWOUORhbqZydZAwD
         ttAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o1KOOfGxx5OBPyQu2rzVGMw+QBwUPbLf1gugF3794NM=;
        b=eAqKQyYPlMXllEHKi4NbYjpG9awcV6X1xYX1IO4byZ/GD9Rl2cwbGWsJHt0QNZwaLt
         6Aj5m0trk5yBXjwhYjkgToBVJvs9fjqDh3HFgTMcu9xpgR4YEfybSCsCo9zxxJxda88Z
         Nh9izzqi2ydM0f1EW+g63AdF9Hc3LQdIsOiwnqhAzytfinIbXQJHkdgbHKPqtC86BL/x
         +0EF2YIc9qSUkl/G9FaIoL/VGg04DYy08ajyD+9jbZsRjvkFjYhAiS+f3j3R8N3R0U6o
         3O0KPpvrJsbigf4FS4UhtoLdeGvJC66AIrbSXXdGT5PmEQLpY7QxisaqgvvoPK+E50JM
         QgRw==
X-Gm-Message-State: AOAM530/0Wyg4BxXK2rGKousuxAFKtaMRrHSbk1HqmYhhVohIC1uk7Vg
        KFdmsddTu1v8sTyiyKbtaRBVFpts
X-Google-Smtp-Source: ABdhPJw4/tIoFu5b89x1nLqmW945MGGZnNiar1WkGb0h0pkf8tgj9mGKrzH5BOFMXYKFWPEgyeSFaw==
X-Received: by 2002:ac2:5443:: with SMTP id d3mr38897569lfn.121.1594288128386;
        Thu, 09 Jul 2020 02:48:48 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id 16sm613344ljw.127.2020.07.09.02.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 02:48:47 -0700 (PDT)
Subject: Re: [PATCH v2] cpuidle: tegra: Correctly handle result of
 arm_cpuidle_simple_enter()
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20200702001354.27056-1-digetx@gmail.com>
 <4ffff3d8-2d41-3fb2-ed16-c9662d18d261@nvidia.com>
 <3bc2064e-e94d-984c-edab-50b4dc2fd2dd@gmail.com>
 <be99caca-b50a-0e12-29dc-2da0d924af43@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <55744bfb-af5e-ed2e-654c-d6de9b26b696@gmail.com>
Date:   Thu, 9 Jul 2020 12:48:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <be99caca-b50a-0e12-29dc-2da0d924af43@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.07.2020 12:06, Jon Hunter пишет:
> 
> On 08/07/2020 15:32, Dmitry Osipenko wrote:
>> 08.07.2020 15:34, Jon Hunter пишет:
>>>
>>> On 02/07/2020 01:13, Dmitry Osipenko wrote:
>>>> The enter() callback of CPUIDLE drivers returns index of the entered idle
>>>> state on success or a negative value on failure. The negative value could
>>>> any negative value, i.e. it doesn't necessarily needs to be a error code.
>>>> That's because CPUIDLE core only cares about the fact of failure and not
>>>> about the reason of the enter() failure.
>>>>
>>>> Like every other enter() callback, the arm_cpuidle_simple_enter() returns
>>>> the entered idle-index on success. Unlike some of other drivers, it never
>>>> fails. It happened that TEGRA_C1=index=err=0 in the code of cpuidle-tegra
>>>> driver, and thus, there is no problem for the cpuidle-tegra driver created
>>>> by the typo in the code which assumes that the arm_cpuidle_simple_enter()
>>>> returns a error code.
>>>>
>>>> The arm_cpuidle_simple_enter() also may return a -ENODEV error if CPU_IDLE
>>>> is disabled in a kernel's config, but all CPUIDLE drivers are disabled if
>>>> CPU_IDLE is disabled, including the cpuidle-tegra driver. So we can't ever
>>>> see the error code from arm_cpuidle_simple_enter() today.
>>>>
>>>> Of course the code may get some changes in the future and then the typo
>>>> may transform into a real bug, so let's correct the typo in the code by
>>>> making tegra_cpuidle_enter() to directly return the index returned by the
>>>> arm_cpuidle_simple_enter().
>>>
>>> Are you suggesting that arm_cpuidle_simple_enter() could be updated to
>>> actually return an error? Sorry it is not clear to me what you are implying.
>>
>> Hello, Jon!
>>
>> Yes, I'm saying that *potentially* arm_cpuidle_simple_enter() could be
>> updated to actually return error.
> 
> 
> OK, then I am confused, because after your change, we would now ignore
> any error that could be returned in the future. Yes the current code
> does not set the variable 'index' correctly, but before we set the value
> of 'index' shouldn't we check that the value being returned is not a
> negative error code first?

Could you please clarify what do you mean by "ignore any error"? Do you
mean the error message?

After this patch, the tegra_cpuidle_enter() will directly return the
index returned by the arm_cpuidle_simple_enter(). I guess this may be
unclear if you're only looking at the patch and not at the whole code.

Please see how tegra_cpuidle_enter() looks after applying this patch:

static int tegra_cpuidle_enter(struct cpuidle_device *dev,
			       struct cpuidle_driver *drv,
			       int index)
{
	unsigned int cpu = cpu_logical_map(dev->cpu);
	int err = 0;

	index = tegra_cpuidle_adjust_state_index(index, cpu);
	if (dev->states_usage[index].disable)
		return -1;

	if (index == TEGRA_C1)
		index = arm_cpuidle_simple_enter(dev, drv, index);
	else
		err = tegra_cpuidle_state_enter(dev, index, cpu);

	if (err && (err != -EINTR || index != TEGRA_CC6))
		pr_err_once("failed to enter state %d err: %d\n", index, err);

	return err ? -1 : index;
}
