Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734EA22053D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgGOGje (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgGOGjd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:39:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FCCC061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:39:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so1969129plm.10
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K1kqfp/kSgMwqPN12bKZZ//tfp2BxSTq1mD1swS+LDI=;
        b=WTpGJqyvZjouFkCmi9zC/0IzuJwZoNFGlTzKYuYnoDp3GznjB6msDkhLTTTBu81Esi
         VaiNpYKxJmEPniJqqf09uJdBkXcLEIlWpbN9YChqtejiEx5VVXwlAWq9RvVYA9F10bOq
         Z4rxBdm44p8Cq8K/f5i74jWh1LV9csMsmEbFW+oFQ7/MxGBvm9QESsA11YtoP9tSC7bH
         x1n3ZtXcPmgWKB1GOyjfJWyZgff0uRvK/uNOG0z5TdlWF1Pg47pEK57j4UjItuoeS2h8
         JuwpEwZ9zcTL4k5YVHLs72Ty+YvrUQtNDOpdd243y3StSD5cGBZqDxK0RP+egFp0dBq6
         OIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K1kqfp/kSgMwqPN12bKZZ//tfp2BxSTq1mD1swS+LDI=;
        b=uE6Gz837Y+teQpzt1Po3Xy5v0EBNYw+yc4aLsKlhFdMUqwWSHMhYPqtVOryXXKrdoF
         3tcv1c5SD1Me6eDE/4/+OxG01d3ppUt43lYr1HFvVpDMB3hHzc+7sFsh6W17e3m4IzfE
         Yre2ONDqed6yK6RP+QkbaAXmO7wm8XfBcz0fVLjwJ08WSvhBlyz6kbqrBxFs4XTaTOOK
         lDfREPveQ7LKAgPKZ/QhLtt394NstQhRyzeUDF2pXMNGhu7IMoCc8XYExEQt6HZE9N+W
         I9KhwhiY4mqHUP1QgjZxmEPc44A9z2I7w6azG2Kulr4iKlhcxNqMMJRcgD3jonVm8yVT
         RItA==
X-Gm-Message-State: AOAM531o/lvQs5t/uB2ZS0r5hWyyLIlGifBSQHeIQLaA99vNFIrF9fnv
        TogKwT1HIfYPmxo7f7C5BoDAdw==
X-Google-Smtp-Source: ABdhPJxLbshzrCuRoNXOv/ZJi7ksi9A0wHLDGdlFvXgLu4FgBdgA0IgbBWVDw+UxdqJZWSCcNXm/wQ==
X-Received: by 2002:a17:90a:368c:: with SMTP id t12mr8639149pjb.90.1594795171879;
        Tue, 14 Jul 2020 23:39:31 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id d190sm1013466pfd.199.2020.07.14.23.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 23:39:31 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:09:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/13] cpufreq/arch: powerpc: pasemi: Move prototypes to
 shared header
Message-ID: <20200715063929.42p5ljlcuwie7pmz@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-6-lee.jones@linaro.org>
 <20200715030706.prxya7fyylscoy25@vireshk-i7>
 <CAOesGMi1dfqPbFJ8YoUoJ75NdU1=XiNoYx+6+JLu44a4LuuYGA@mail.gmail.com>
 <20200715063607.GQ1398296@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715063607.GQ1398296@dell>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-20, 07:36, Lee Jones wrote:
> I searched for "include.*platforms/" in drivers/, and was scared off
> this method since no one else does this.

Yeah its not right for generic drivers, but this is very much platform
specific so it is fine here.

-- 
viresh
