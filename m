Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06863B0CCD
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 20:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhFVS0F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 14:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhFVS0C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 14:26:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ABCC061756
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 11:23:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p9so3453173pgb.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yXA4rHiWjIH9o9XmIG32r03SHImL59Pk8RIZgBFL7d0=;
        b=Ym2SAYocAlxz13BRcPfGv8BL5ruxEwMIEahKmrLIa951qfCVLKr9ib9qEyEluwR76s
         arIDjvRk31dZudsnPP/G0ZxPBVpkMpoJrAqqO0lds4WJufGy4ktUWggJUY+VHBaryxhi
         n+ChYlaDh99MnXKFn+3MinQfk0F5WEpJbIWzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yXA4rHiWjIH9o9XmIG32r03SHImL59Pk8RIZgBFL7d0=;
        b=j4mS+G78ZL+2wsulRh4fqtLUX9HVAimQIkUjJtF+dS6EbA7kSgzKIBzLOS6lCb+UXl
         YGsfr2BhRk6U3ScugfgFMDKMmok9FZS5Sl+50G/h+EsukVpirn6kCEAhZR0Dih+BJajh
         oqBzaK8roep8xYq9nSprmpNLNuI7DifUz+EsGp5rVhWFOVjSXtiGkGR1c/1qKikckxXx
         I6xNp4QTAk6GyP3KuZDw/KvGEeGupWTXIUmnXaTpPuoqApLH3chgLuevmbnjUlVf2tlS
         LWMmbNCvpd9eDbKModicPe8BY0uT8+tjpfbW2zhkTi/RX4vxaZcimzSBlYAd8vUpKbl3
         DUoA==
X-Gm-Message-State: AOAM533P0ETO7/YGf/sfAkgxDo0b4kj6Iu9VfcMsSAULNqr5sswLTQqx
        fMrzskwKJn/Dag7wc5tOMpxF6A==
X-Google-Smtp-Source: ABdhPJyAKRVykKU/KgvZGJQDqYy26+5sRFeqHMwGvD8r2zLxNa5qXN+gVPDw1p3/7DsMBYg0ZSOh3w==
X-Received: by 2002:a05:6a00:1acf:b029:305:d2e4:1687 with SMTP id f15-20020a056a001acfb0290305d2e41687mr2653921pfv.50.1624386226378;
        Tue, 22 Jun 2021 11:23:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:dc21:8b6f:f8cd:9070])
        by smtp.gmail.com with UTF8SMTPSA id o1sm40173pfk.152.2021.06.22.11.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:23:46 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:23:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        chanwoo@kernel.org, cwchoi00@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] PM / devfreq: Export devfreq_get_freq_ragne symbol
 within devfreq
Message-ID: <YNIqsJLqWNSg2oxM@google.com>
References: <20210617060546.26933-1-cw00.choi@samsung.com>
 <CGME20210617054647epcas1p265359058d489661e09d8d48d4937ca7b@epcas1p2.samsung.com>
 <20210617060546.26933-3-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617060546.26933-3-cw00.choi@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 17, 2021 at 03:05:44PM +0900, Chanwoo Choi wrote:

> Subject: PM / devfreq: Export devfreq_get_freq_ragne symbol within devfreq

nit: s/ragne/range/

>
> In order to get frequency range within devfreq governors,
> export devfreq_get_freq_ragne symbol within devfreq.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
