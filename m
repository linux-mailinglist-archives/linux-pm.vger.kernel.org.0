Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F3EA958
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 03:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfJaCyv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 22:54:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38060 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfJaCyv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 22:54:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id k10so1628179pgm.5;
        Wed, 30 Oct 2019 19:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R0JsaK4f1xEtQSFbcUbhcY9DkK+W7bL2F/GkfdJxzSc=;
        b=Qz+MgiJRm/rzwAsKbUsraO3YsUz8V+lcF4/JjYTi4WgR41qcgdyhb1oQgSLSU9sSiw
         eUHFzaK7qBrbaMyacOf+pnyHvP9+Cuo9sExjxKt9Hs6Czfdzqm0Om3qAuvc6OfQtAg9h
         +/BDYeqgbjksorYsDyA+SYS/WlWhNza5pmMtVoCXoniqa/nRKRlm5Lvm/nN5/7htRUhQ
         d8oVpPONtGPQl9tcOfLYFElxsTo2LrSWV163eH4/H3FdrVE42U0O3x2knSCoPJgHk6VL
         VybJ0Mphzh8IY2lX8CWQc8j8TsmEoDTu7/Pdhnu3IlrEO3sF499cJVTAzo8NMhbg1zFL
         cDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R0JsaK4f1xEtQSFbcUbhcY9DkK+W7bL2F/GkfdJxzSc=;
        b=DAfMKl0pH/wL9sl3ezPzzPo0x6OuHnLcafKrI5Wk1HkRopKApSo4d4LsUh1a1LwMhC
         Q1WlQ6OSCQ7+SDANFIATVQmVVburEy6VG/IxXO14tLjiBHde9hS0FaI3b9tY6lN7kYwd
         xnwdM9Zb5JoWhu37cFlAtm3bdSUh5kwgi1HgpVy6Wd+jZ1oIdW/YIGhOdgElfketUKML
         sxXB3gf/mxzpBy7WGpfl1eYRu9VzztPs4d+00qoTAL/unHMaPYvpcRM+PuALs3UXmw5g
         Fl5YIgH36uRPBJn3rwMNcB6xFdtmXad75HdZTz8ASqtjg7hqmv85c6K077LC95NARc4J
         mG5A==
X-Gm-Message-State: APjAAAW6J/GU4eQ6clPkhdwonce/ncgXKx0zvuFPbqfLZQsnnuD6Nphd
        lGS3kKdT271HGT73DkvIvUc=
X-Google-Smtp-Source: APXvYqxe7VnkXFg8g+xbspGRNveCtft+qIbKnqnBRnS3ojLwCM8ombIddlnwCvXSy79F0Z/pCclLew==
X-Received: by 2002:a17:90a:aa98:: with SMTP id l24mr3562033pjq.96.1572490490330;
        Wed, 30 Oct 2019 19:54:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ck20sm3573710pjb.5.2019.10.30.19.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 19:54:49 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
To:     Christoph Hellwig <hch@lst.de>,
        Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
References: <20191029223214.18889-1-linux@roeck-us.net>
 <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
 <20191030140511.GA14252@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2931487e-2720-fd42-fda0-e47cf89c90c9@roeck-us.net>
Date:   Wed, 30 Oct 2019 19:54:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030140511.GA14252@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/30/19 7:05 AM, Christoph Hellwig wrote:
> On Wed, Oct 30, 2019 at 08:16:48PM +0900, Akinobu Mita wrote:
>> The nvme_init_identify() can be called multiple time in nvme ctrl's
>> lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
>> should we need to prevent nvme_hwmon_init() from registering hwmon
>> device more than twice?
>>
>> In the nvme thermal zone patchset[1], thernal zone is registered in
>> nvme_init_identify and unregistered in nvme_stop_ctrl().
> 
> So Guenter said above the thermal subsystem could use the information
> from hwmon as well.  Does this mean this patch would solve your needs
> as well?
> 
Depends on the requirements. Unlike hwmon/iio, we don't have clear
guidelines describing when thermal vs. hwmon would be a better choice.
There is some interconnect between thermal and hwmon, but quite often
it is a one-way street (hwmon devices can easily register thermal
zones, for thermal zone devices it is a bit more difficult to register
associated hwmon devices).

For the most part, peripherals (memory, network devices, video
controllers, real time clocks, etc) are today handled by the hardware
monitoring subsystem. The one notable exception is the ath10k wireless
controller, but even that registers both a thermal device and a hardware
monitoring device. Sometimes peripheral devices tell the hardware
monitoring subsystem that it should also register thermal zones (I
would guess that ath10k doesn't do that because the mechanism didn't
exist back in 2014). On the other side, SoCs typically register
thermal zones and rarely register as hardware monitoring device.

Guenter
