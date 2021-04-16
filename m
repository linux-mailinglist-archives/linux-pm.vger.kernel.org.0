Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37606362326
	for <lists+linux-pm@lfdr.de>; Fri, 16 Apr 2021 16:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhDPOvS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Apr 2021 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhDPOvS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Apr 2021 10:51:18 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475CC061756
        for <linux-pm@vger.kernel.org>; Fri, 16 Apr 2021 07:50:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id i6so11331364qti.10
        for <linux-pm@vger.kernel.org>; Fri, 16 Apr 2021 07:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=F9UU+jQfSexw8hhu+M3eVO5mGHcQtJmjLJ/mzZBvj3w=;
        b=T0vJs/lJAC0Ybn7Efy634+G7ZKmCufJ9QoDi698/qShOzuzBCeI5+4ldpRnyU+OK5P
         QijOq7Xsc9jJMvEMV8FPzsJoNMBtS6w9PwwGt1SYFccVf8AxKNUYCGQ+7Qaq0E3159ls
         IHKYMHD9pCbLNhsuAwqdBCExzdKTJXJZYo96A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=F9UU+jQfSexw8hhu+M3eVO5mGHcQtJmjLJ/mzZBvj3w=;
        b=cmI9qEDULggXtGJb2CUw7UXI4WX9L3sk2cWYxb4oFY8CMQmqlGBDyPSICf61kPkfKP
         Xq9e6BgKuJNqWY0pACdzq9luN6cwsYNAwE5FB7mm9Dbrgi3MC1k3M+aE0NlzC5sa6iym
         8GoBJ8+SZh15jyOGfWtmzH4GqqFZ7EB1DbUP/EqR+E2wk0wTo5q3jgUvhLrMNnyR5Ner
         vT5YoNBPypsdAh5PmNcwRaESNG33DMBH1y8HaC2IjThhtJ267n93Bewue3O30q3z9v9k
         8k9X2CoUTwVsHNe4A6fRqpAMFFaE5ae/4u7iTHgtjs9x6rV0pWaEudyEVjL3jSg5N46w
         5yCQ==
X-Gm-Message-State: AOAM5322eLeTv0UVQTxx98yT/dUEs8tJxRvJZADpLtzyNIQnGJmLFi8K
        9uGJoMSX79/E4FdT+YxH/wpBTw==
X-Google-Smtp-Source: ABdhPJywamb1TLItL6hxBu1k1N+8qI7IzVo29e3lYbx9KXCvkTtePLSyJAjSMJnORNIIIibEMnqwIQ==
X-Received: by 2002:a05:622a:1208:: with SMTP id y8mr8288221qtx.215.1618584651456;
        Fri, 16 Apr 2021 07:50:51 -0700 (PDT)
Received: from saya.kepstin.ca (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id k126sm4231654qkb.4.2021.04.16.07.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:50:50 -0700 (PDT)
Message-ID: <65e556b53fad029474fd948afecf0e226aa01f87.camel@kepstin.ca>
Subject: Re: [PATCH v4] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Apr 2021 10:50:48 -0400
In-Reply-To: <68be4830-36ec-85ad-56ae-ee3cf9b9589c@amd.com>
References: <20210330213825.77294-1-terry.bowman@amd.com>
         <17d15837848eddd8445b206356531b9b5aae644b.camel@kepstin.ca>
         <68be4830-36ec-85ad-56ae-ee3cf9b9589c@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2021-04-16 at 06:42 -0500, Terry Bowman wrote:
> 
> Hi Calvin,
> 
> Thanks for the feedback. I'll begin making the change and testing.
> I'll 
> respond with V2 patch in this thread.
> 
> Regards,
> Terry

It looks like there might already be a patch in the pipeline for this
issue; see Chen Yu's response to my patch here:
https://lkml.org/lkml/2021/4/14/1322
I'm hoping we get some clarification of the status soon.

While you're respinning your patch, there's one other issue that I
noticed - all the idx/offset-related functions pass the offset value in
a variable of type "int" (32bit signed integer), but the offset of the
AMD MSR_CORE_ENERGY_STAT MSR is 0xC001029A, which exceeds INT_MAX. The
offsets should all use "off_t" to get a 64bit type and avoid wrapping
or sign extension issues.

-- 
Calvin Walton <calvin.walton@kepstin.ca>

