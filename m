Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ABF4A6424
	for <lists+linux-pm@lfdr.de>; Tue,  1 Feb 2022 19:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiBASnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Feb 2022 13:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiBASnR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Feb 2022 13:43:17 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE0DC06173B
        for <linux-pm@vger.kernel.org>; Tue,  1 Feb 2022 10:43:17 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h14so16133944plf.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Feb 2022 10:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=6fPJFl5vrGTy5wN+6iyLxqMIH5fB+nup+utSNi7xCFI=;
        b=JFoC8kCvrk6PVaxIzJ3yNULiqngFgKPktXk6Uy8wQFysm1RKVZ1yng4MaoFknXvCl5
         w50qhHlMbRZ8qg5eKV6q+aY5S+AexzLC726J3dITlnzwKwKhUY767Yiyu26rk+dQR4El
         iZvrQ5OXzLrsR3koSAnpyPb59rfDdrSWlYmb60GBs2NxZFkpnfsPJzTJ8DtB93E6/SBN
         QkNs0I0nrAyVRUHmTRYTQzBWuI3eXJm22L+kdU283/sdSJsaqA8Df8BqbkfppInv6RoC
         uAXJAXYBK/e8ighPrDnAm3bCLsXg0Bcl5Wd5q2oUbLpOXMUV0ZRNnJukZqWzHkdHX9cL
         4FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6fPJFl5vrGTy5wN+6iyLxqMIH5fB+nup+utSNi7xCFI=;
        b=LyUbiFSzCtMmGkFipdFitQb/XxclYKy9LSeUgoOHTOLsr63wVASgRpCJhh/IrN7PyH
         cY6LVBAomPWI60o78AtXCTFPAKnO17cbz9Z2IqvHELV048sQYO0zvGhIeVgMwG9AGyI0
         m038wmNOnO+hRqlokSLOU63x4kmYWpC8YavfHJu8nNnzHkgsqFTqnwAtJZGiuZXN6G0a
         sOUeDK46TeICbmDBghuySGVI//8XuaOlOt3DafwOnaSjjOnyEoZIwaXf3EKjzm6H5sbJ
         eDLwMirKhMqa2TOvEoP+rbbNJgrT+oSSqS470tDCYSHGOWIgmDh/XNLPMyb8r/Jxk0tU
         94/Q==
X-Gm-Message-State: AOAM532JMCBZ97RmI3bYYy6c8SPJLeDQZrmlwS3QJkgitc0khwOyd929
        vZpZr6qLlz5JyJ3t/TB6D8g2PrpiuZ1Scw==
X-Google-Smtp-Source: ABdhPJyaOJVKaHFfRhEGAmObqlO5/p6vKN4OSc6RYhmsGbTY9lg7Dx448+JitmRXoD1gp5a8X4QMsw==
X-Received: by 2002:a17:902:710c:: with SMTP id a12mr26847513pll.108.1643740997274;
        Tue, 01 Feb 2022 10:43:17 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id s19sm9183477pfu.34.2022.02.01.10.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:43:16 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Matthias Kaehlcke <mka@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH v4 RESEND 0/2] Add a generic virtual thermal sensor
In-Reply-To: <CAJZ5v0iX=SSaPzZNBX8gNMDPCUewiQA_bHxka2pxvtFHxmPxww@mail.gmail.com>
References: <20220111103346.2660639-1-abailon@baylibre.com>
 <7hilu9xe7n.fsf@baylibre.com>
 <CAJZ5v0gZFBEKDt6S0H91F5xCjC3qtT6B+cTnv6u1nijMHkc8jA@mail.gmail.com>
 <7h35lcygin.fsf@baylibre.com>
 <CAJZ5v0iX=SSaPzZNBX8gNMDPCUewiQA_bHxka2pxvtFHxmPxww@mail.gmail.com>
Date:   Tue, 01 Feb 2022 10:43:16 -0800
Message-ID: <7hbkzqmnqz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Mon, Jan 24, 2022 at 10:23 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>>
>> > On Mon, Jan 24, 2022 at 5:58 PM Kevin Hilman <khilman@baylibre.com> wrote:
>> >>
>> >> Daniel, Amit,
>> >>
>> >> Alexandre Bailon <abailon@baylibre.com> writes:
>> >>
>> >> > This series add a virtual thermal sensor.
>> >> > It could be used to get a temperature using some thermal sensors.
>> >> > Currently, the supported operations are max, min and avg.
>> >> > The virtual sensor could be easily extended to support others operations.
>> >> >
>> >> > Changes in v2:
>> >> > - Fix some warnings / errors reported by kernel test robot
>> >> > - rename some struct and functions with a more accurate name
>> >> > - update the dt bindings: rename type attribute to aggregation-function
>> >> > - factorize a little bit the aggregation functions
>> >> > Changes in v3:
>> >> > - Aggregate thermal zone instead of thermal sensors
>> >> > - Use try_get_module / put_module to prevent thermal providers to be removed
>> >> > - Update the bindings, to be more accurate
>> >> > Changes in v4:
>> >> > - Fix two warnings reported by kernel test robot
>> >>
>> >> Any more feedback on this series?
>> >
>> > Hopefully, I'll get to it this week and I'll let you know.
>>
>> Thanks Rafael,
>
> Done, please see
> https://lore.kernel.org/linux-pm/CAJZ5v0jejFG76OfewYg3kmKv4xwLdRBpC+zRpJ9Jom+tqo7qyg@mail.gmail.com/

Thank you.
