Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E673234797
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFDNFi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 09:05:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42704 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfFDNFi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 09:05:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so8479141lje.9;
        Tue, 04 Jun 2019 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AtISXc3jFgJoLSHh5PWT1AZKuf7dNq1h2+HU+Zatn7w=;
        b=VQl8HXs1JvXKlRqQOH9bH729BCGyptIFjlxS+jppf2VLBZo+mL1enMs5UmCOFlyv3Z
         4yJDQT2HFDx/yrQXMuVS1l1J5S4mEJC5pDv7GkyKaa6etpNNGQhY9iewWE/PYdFaVt6U
         dZIJh3EFXEXFs/i0A4+avgzW97bzdABWVg8VF6YR6CvLRhkbmMJ097ZSHVVEjjYmLH0D
         rFivNev2y3Gv8KOP82JmOSdewgrhE4DoIalHbgPtzusxZkkUk4imEHOmVmCQaCDAKdFC
         XpnpCKce7q6C8Z7azvoDK9Tuc6t/QvDp7xZLNen/7xVV5quPsigoJLQqEy5Evls0JDDU
         M39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AtISXc3jFgJoLSHh5PWT1AZKuf7dNq1h2+HU+Zatn7w=;
        b=i/TtvCVwkinWco/tpHszJR2kc5akoNTQlbfdF98nSES1jPL4GPMMImi6TRfRCV+gXo
         C3Y0OYoFoZeX2Aj6TCoiGFO6+8kgdH0/XzfI+c25cHCXuJ8n6uJYIsVVgTabXBUphk7+
         0vLIdm1U1STb2I/k85lVetmezDE6oDYL2vNtu6dk/nnNePgTZDt2USxTQi/OhmcO/dqw
         bEIDc9jW6tbVHrukdhBvF32khoZydcT8zp/kIgKWtOCupxjt0072Lh/wbtxHPsP+YQtI
         q1SZvjqiFEz8ENkAgEu/3g7xKRtNb6ppo3p3HLOtv3yUsOgRZB4ibBPzN9LjoWgD+2hK
         BPBQ==
X-Gm-Message-State: APjAAAXUdvhQ+dYdxvdljpM3uxoj1w59rL3AXY89HoMmGSLUe/GxkqpV
        Axb4+BV0GgdrD+KHjW1qBG2waBK7
X-Google-Smtp-Source: APXvYqzN2rPb0j0exDHrTMAjnJbEwSNFphqt3mgRuA0QVXlgI5G9vdQFmdEim7ot3iAS1BFrMVcT3g==
X-Received: by 2002:a2e:3a01:: with SMTP id h1mr4872724lja.132.1559653535252;
        Tue, 04 Jun 2019 06:05:35 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id l22sm3205565ljb.39.2019.06.04.06.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:05:33 -0700 (PDT)
Subject: Re: [PATCH v4 05/16] PM / devfreq: tegra: Don't set EMC clock rate to
 maximum on probe
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-6-digetx@gmail.com> <20190604110042.GE16519@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <71f7b41c-b33f-92fa-e0a5-85fefeb57274@gmail.com>
Date:   Tue, 4 Jun 2019 16:05:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604110042.GE16519@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.06.2019 14:00, Thierry Reding пишет:
> On Thu, May 02, 2019 at 02:38:04AM +0300, Dmitry Osipenko wrote:
>> There is no real benefit from doing so, hence let's drop that rate setting
>> for consistency.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 2 --
>>  1 file changed, 2 deletions(-)
> 
> Do you have any numbers to tell how long it would take for the EMC rate
> to get incremented? My understanding is that ACTMON basically reacts to
> system load, so I could imagine that not setting to the maximum
> frequency after this is loaded might make the system slow in the short
> term. Only after ACTMON has collected enough data to determine that it
> needs to clock the EMC higher would system speed resume normal.
> 
> I guess technically this patch doesn't change anything if the system
> already boots at the highest EMC frequency anyway, which I think it does
> on many (although not all) devices.
> 
> Anyway, you said you've tested this and are satisfied with the
> performance, so it can't be that bad:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>

It takes 12ms for ACTMON to react and then about (couple) hundred
microseconds to change memory freq. This is a very short period of time
that human being can't notice.

AFAIK, in practice there are no devices in the wild that boot up with
DRAM clocked at lowest rate. Most devices have a video output and thus
require significant memory bandwidth at a boot time already. Secondly,
higher memory bandwidth is only really needed for a cases like
multimedia, in most generic cases CPU is hitting cache and not utilizing
DRAM a lot.
