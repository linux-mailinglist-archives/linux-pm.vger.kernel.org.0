Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70EA24D11E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgHUJG2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 05:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHUJG1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 05:06:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1D2C061385;
        Fri, 21 Aug 2020 02:06:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so759768pfw.9;
        Fri, 21 Aug 2020 02:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ClwOCvNdMbSwIvrMHBCrtpWj2Sg/nFcA0Erlf/v7f9I=;
        b=pB+qRKM2AHS443Cscmz2VK4Ro/JI40bwhD7Jojrqv8T5gBjlAJHShryWeO428vDXYX
         ba1w9qmlClKif7NBjCAoRMkKUF93bm5sXS8wJu0QtUkrJbhhyqtFDODTNmN5V0lTklSs
         vkL39anLkBg7pl9m6hMWkwMXJPnmACSdheQtEfT5fo0M9o6448sE4ajPJqRh8iIz4dAT
         0bkU/CNmCn78G43XilreYQG+s0mSsgtzijT58BNhCKzJZneW2IDR/Ci5STpAmsl28R9L
         m8PgYNKRE+rWrQAeEtOUzTB0N9vmecHgcD47MIePwL2oORMeciG+NGBpQD9OQoMlSXd5
         lojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClwOCvNdMbSwIvrMHBCrtpWj2Sg/nFcA0Erlf/v7f9I=;
        b=owMckdZwQpIX9bwI1iSY7ifUDL3LAbqXhv1ydeK3wGijcF9uEmFLeOtu9DtbfdHOlO
         l2O/A6oTlfvvfYyvPaao1lckPV8KQrDmu54oqzvtEI5vjzcHfKsanlNAtleNvEgkAujn
         LcTdTg5n5972fwk4WBdZW/Ie5Si03aTCN6Vky5K025DUoj6L87w8Pn8MrC11METMF6XD
         W7Bhcbllp4KiO4L97v5BuR4E9Uh8l5LB6PQj2E3yQORmkI/MIXQ1M+x02/cWv8bmFeer
         EjkwhmU6jmUWZfEkrzf8AUQM5XQiw5sfVk/5SFhWvNWuWUPtsdnytRDk93XHs0X2J3iV
         8g2A==
X-Gm-Message-State: AOAM5332SWu5OBKVPvmnfLTTAErWiTaOhNromtavrI0gxLK+ZdlKxDUh
        f4bx0zyl7+U5WTqcQ1hGero=
X-Google-Smtp-Source: ABdhPJzA8ojiKKI8C6VE102tj7IvFCYcv7NiClYkDnphzjF8/kZShjWd0Ex6CLnTjD6jrVu9Pjy4HA==
X-Received: by 2002:a62:6185:: with SMTP id v127mr1627684pfb.259.1598000787273;
        Fri, 21 Aug 2020 02:06:27 -0700 (PDT)
Received: from localhost ([124.156.176.71])
        by smtp.gmail.com with ESMTPSA id o19sm1388158pjs.8.2020.08.21.02.06.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 02:06:26 -0700 (PDT)
Date:   Fri, 21 Aug 2020 17:06:27 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "zhangwen@yulong.com" <zhangwen@yulong.com>
Subject: Re: [PATCH] thermal: sysfs: Fall back to vmalloc() for cooling
 device's statistics
Message-ID: <20200821170627.00003d5e.zbestahu@gmail.com>
In-Reply-To: <7a0c2e488e024c0694fd730f95ba98fb@AcuMS.aculab.com>
References: <20200821024406.10404-1-zbestahu@gmail.com>
        <7a0c2e488e024c0694fd730f95ba98fb@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 21 Aug 2020 08:39:45 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Yue Hu
> > Sent: 21 August 2020 03:44
> > 
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > We observed warning about kzalloc() when register thermal cooling device
> > in backlight_device_register(). backlight display can be a cooling device
> > since reducing screen brightness will can help reduce temperature.
> > 
> > However, ->get_max_state of backlight will assign max brightness of 1024
> > to states. The memory size can be getting 1MB+ due to states * states.
> > That is so large to trigger kmalloc() warning.  
> 
> I can't help feeling that there is an 'adequate' implementation
> that doesn't require anywhere near 1MB of memory.

However, it should be a potential issue due to what i described above, rt?

Thx.

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

