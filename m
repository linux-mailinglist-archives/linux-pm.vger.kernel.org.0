Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A59295667
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 04:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895070AbgJVCab (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 22:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895069AbgJVCab (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 22:30:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD6C0613CE;
        Wed, 21 Oct 2020 19:30:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c21so248385ljn.13;
        Wed, 21 Oct 2020 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wqeyzf+V+o/Ow4zgVVzt9Pq0I1vaaEnCh3hUhhGOC6A=;
        b=hEbliSV8YscFKKUIR/YBixKZ2dDTbFRCqTQxDcMAs03Sneh6l4BmD5+wv2dnm6zUXk
         vE0y4qV19fvgPA5uwXuqhsbNJu+2B0NqUeeVEGJicjm9x+Z6pNX7EfgZwfDZ0x4GvYLe
         CilocdR5lKvafJK7QrzyLsFDzT9w9LPOBCqDFGQtYiOxiKcEdKFPegR2VwQ2Cnq0BO1T
         t0eAZ6iA9l9fUZXNd7gHaOhYULO8PmtFt7fjmBK2Lbc5fxVu+ToEvdXsa4VbHkcERxDQ
         ZlYFXSJOUfPfnvCsUdjjerNe1V5gBX/fU4v+kXm8U8D5q6l6cJSwXR11+KZzXkb5F7k9
         63GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wqeyzf+V+o/Ow4zgVVzt9Pq0I1vaaEnCh3hUhhGOC6A=;
        b=srK6YvcUsB3XCIx3JIHLki0H8t35V+a1Ssf1I+F6EJCFeDZWgOWdI0N63zmtmbRWxt
         3xXG7j/IP6srRUBRXRvxIU6Sg1klmyTuXSqUwwRtWEy9LhW6Eh+XbEvXF5iOVSjIvP/+
         MSS0aS3OsCn/+CTGgpFUs4CSaUcKoqj2tNzVZsLkKaW+Hz3FtwqPMZp+XpDzXkTJ46Z+
         1qYIbhJzqgxYSfYkcfIVHlVvOLLQnFryy0g153KBjCBKYhZmIShT9Lp2fxT/+oFm3Xn9
         r37nG+BpCCUn9aWIzkuPRT7f0U8KHqe8T/+6YsS7jc4JNKOzmBuSWp39zvYrJyy994r1
         xeTw==
X-Gm-Message-State: AOAM532FsrHWjm42fPKFcOmn4y+yP3qxVBvpXzj8bo6ZsB30sGYGDOsZ
        WP1ImQ4nnhG22mUAv4rcYCk=
X-Google-Smtp-Source: ABdhPJw8iUhaKBcWPsl/vuT5FtNu/qDRDqkn/fj9Lz6sO7cDDYl7W5Bj9gxlANppEhTr9F6L5Fm2vQ==
X-Received: by 2002:a2e:9583:: with SMTP id w3mr166291ljh.25.1603333828981;
        Wed, 21 Oct 2020 19:30:28 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id x6sm18949lfn.185.2020.10.21.19.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 19:30:28 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     lukasz.luba@arm.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        abel.vesa@nxp.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20201020030407.21047-1-cw00.choi@samsung.com>
 <CGME20201020025045epcas1p4b26b6f23e2896c2d661b2cfa93505e21@epcas1p4.samsung.com>
 <20201020030407.21047-3-cw00.choi@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b94b5c9d-6bfc-0535-baaf-d0809f74de42@gmail.com>
Date:   Thu, 22 Oct 2020 05:30:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020030407.21047-3-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

20.10.2020 06:04, Chanwoo Choi пишет:
>  /**
>   * struct devfreq_governor - Devfreq policy governor
>   * @node:		list node - contains registered devfreq governors
>   * @name:		Governor's name
> + * @attr:		Governor's sysfs attribute flag
>   * @flags:		Governor's feature flags
>   * @get_target_freq:	Returns desired operating frequency for the device.
>   *			Basically, get_target_freq will run
> @@ -57,6 +68,7 @@ struct devfreq_governor {
>  	struct list_head node;
>  
>  	const char name[DEVFREQ_NAME_LEN];
> +	const u64 attr;
>  	const u64 flags;

What about to use plural for the "attrs" as well?
