Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23021552B5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 08:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgBGHFs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 02:05:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38879 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGHFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2020 02:05:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6so618609plj.5
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2020 23:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xANPQVyH+owLkLOlKxIOpXRWiIMFgm2m9Ut3ysm7ehk=;
        b=uZxEEwIIpa5aDj9Q6FGk79uJ1NOO2vIve4jKCpAfa12/E/oUkykLtZFqUpQEdCtJGZ
         U8SM8VQfYmEJAiTsLqA/3Fnpz1giUdRFrJBaLjvLEmnABN9lZlv555CuiTfXCG4C2VAm
         lAT2qjRJGsS6ZM4gTOX7m7AcIZyvnDvNKYAe2FC1r3YeYnQQfhrwMb8YzykrM+Hb2MO2
         gWp5bBaSSxWC/iqNtWgM9Yd7sJ9JNRsHCoiJ8gitEYM6U/0LZBU7AjYwA0l9I43rXzLF
         zd1lBx5nV3gKrznbyGdxOuKfYv9khuCM4c38NtEJ/9XJPhDykib5CZ4zLqOlfoFVL0Df
         SYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xANPQVyH+owLkLOlKxIOpXRWiIMFgm2m9Ut3ysm7ehk=;
        b=KgBhcqyK+ucLKQHKOlRaiH4iMK+G7hOXBzLcKOI//uNH8pQ9goi8tGfnLeTCWmbq66
         /VnB5JqjG9BfHSvQ8zhuCBmPormyHXuWIq9l/Z0eqRIJNSwDGsAxknJ0BHuSN7MhRUzm
         xZXzGSGOJqxL3HM3rso55LSMIvnVVGoiHdFpgzzHmkUcD1J3dbc9jsBaRhI9PZA1OriV
         iQgBTJzMtZJjWE5MOFvTlfvZxzAdoRqv8Qn9hOwWhUYKRZ4lu1ZsVxvnWvrzm6dzvJVQ
         PZCEKiGTIF2KKSpYEk8OQyt+/47t6M/EqD7HMEfpsBSn+GXefS5CnG/xc6DegOf1ftMe
         9Z/Q==
X-Gm-Message-State: APjAAAW5ZWCkYxAYY4IpxM9NueJyR1PdbmQvUgMqo3x2EM5la4NACshT
        CkozkDAZP0ze9Q95ZlYLG5N0uMON0Rw=
X-Google-Smtp-Source: APXvYqzqzhppETxeEIbwoHzZFDlvke3geQuYXghLR2GpBmaLXqJWKibJUR0GlEafJOlxhXGg6vSZXw==
X-Received: by 2002:a17:902:6b84:: with SMTP id p4mr8027390plk.15.1581059146928;
        Thu, 06 Feb 2020 23:05:46 -0800 (PST)
Received: from localhost ([122.172.141.204])
        by smtp.gmail.com with ESMTPSA id d14sm1696957pfq.117.2020.02.06.23.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 23:05:45 -0800 (PST)
Date:   Fri, 7 Feb 2020 12:35:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [EXT] Re: Ask for help about cpufreq issue
Message-ID: <20200207070544.geurecsy4i22xpzl@vireshk-i7>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20200207052321.povhuxrlm25ueoak@vireshk-i7>
 <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB43334D5868037FCAE4D7631BF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-02-20, 06:03, Andy Tang wrote:
> Hi Viresh,
> 
> I have tried performance governor, cpu frequency is at the lowest frequency.
> I also tried ondemand governor with high cpu load, cpu frequency doesn't increase too.
> 
> root@localhost:~# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> performance
> root@localhost:~# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> 1600000 1000000 800000 500000
> root@localhost:~#
> root@localhost:~# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> 500000
> 
> root@localhost:~# cat /sys/devices/system/cpu/cpufreq/policy0/stats/*
> cat: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: Permission denied
> 1600000 214
> 1000000 91
> 800000 82
> 500000 480088
> 240
>    From  :    To
>          :   1600000   1000000    800000    500000
>   1600000:         0        15        10        10
>   1000000:        21         0        22        18
>    800000:         6        23         0        44
>    500000:         7        23        41         0

See, frequencies are getting changed according to this table (at least
from cpufreq's point of view), which means that cpufreq transitions
are passing just fine.

I just had a look at the driver and may have some idea on what's going
on. The cpufreq driver doesn't program the frequencies, but instead it
just switches the parent clk for changing the frequency. And when you
try to read the frequency, all we do is read the frequency from the
clk pointer using clk_get_rate().

So, here are the things which can go wrong, in order of how I would
like to debug them.

- The frequency of all parent clocks is set to 500 MHz by someone and
  so clk_get_rate() always report that despite changes to the stats
  table.

- clk_set_parent() isn't setting the parent correctly.

Try putting some print messages to the driver to see if target_index()
routine is able to set the parent clk properly or not.

-- 
viresh
