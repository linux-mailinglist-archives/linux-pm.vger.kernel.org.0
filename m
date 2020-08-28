Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6033725558F
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 09:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgH1Hre (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 03:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgH1Hrb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 03:47:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAA0C061264;
        Fri, 28 Aug 2020 00:47:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h19so232254ljg.13;
        Fri, 28 Aug 2020 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+nxdFB2SD1U2sfuKxuZ2pIP6ISrQGy1F0qzmd7+b6wg=;
        b=JT+2BSIrxkhf1IdPHgoLDn8lPHq133AytQ58puYNVftQgkfmYXdWyr4h3W0PEioNyQ
         qji1nD02VddgP/JjROsxWPKE9rVJDXvtxk8qfbhppL/M6NZ2OE6asfcL+IYsfDzD4Sx1
         He4AOmO1d8GT4i/GPt+mYuO3aVFfgke3hD/PegfXArnWN2FS/6aqej6PQ/vlkonhgUGD
         ZUX8+bDukp+JkUvP79G8IxbydRBM9nUSZUsH4glkfOpip9cyEPTGhIDr0U3NN8ZRvfmg
         XNOlMj8gXkJWhIvVjQ1qghyuhGxt7JiE6ICtwgQJOhQ1NIni6x3NcWJnrJCkzmnpNdj3
         llYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+nxdFB2SD1U2sfuKxuZ2pIP6ISrQGy1F0qzmd7+b6wg=;
        b=pS7Q15Z3chws4MD4UWcf2dSmmJ5R5Qw3uQVZtKLJrQfCpd5YR1T0hBSj+XAiuyrxKt
         JCG4qLArENf+VmmHT/qNQlDl73XQb3vcau9UyG4MFQ9+K6lXNyjFjxKQD4eoDtrJ1rMf
         1R9f5u8tUE3Ry/leLDOCHicEltNV9CzZe/cM8R/ehAKjo5k+ZUU7RQyOw+5dcC51H0Jq
         mtSIl45zI2LKofSjGIyZfZV6Yq5XNOuNvkT6bfFpzZPiGVSMqhnmDpKjyah7M/SJc3ZO
         hrfUAxSUOMz/j+THQp1ShYA/+I1tP2EQGKPcwkdq+99MGNLrBg3oyh26Ag5y3dpEybI8
         tDyQ==
X-Gm-Message-State: AOAM5306ujLSRFYJVVPJH1CNcpTEaffkbgtzagTGlfuyWQqHa/ok0GPp
        xjOxJpmerK9dj/IMxalAN0kYHXG6Kvw=
X-Google-Smtp-Source: ABdhPJy8Srr4VmzEiVkBuWffTSQD0zbomVX6iHd2wGQttsdmF3mW+/l/mCkAnKcJhgmgvj4Scs655w==
X-Received: by 2002:a05:651c:1291:: with SMTP id 17mr317790ljc.366.1598600849729;
        Fri, 28 Aug 2020 00:47:29 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id u10sm37756lju.113.2020.08.28.00.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 00:47:29 -0700 (PDT)
Subject: Re: [PATCHv1 2/2] power: supply: smb347-charger: Use generic property
 framework
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20200826144159.353837-1-sebastian.reichel@collabora.com>
 <20200826144159.353837-3-sebastian.reichel@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7a06b330-0cd5-4487-7b05-81d7ad7702d5@gmail.com>
Date:   Fri, 28 Aug 2020 10:47:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826144159.353837-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

26.08.2020 17:41, Sebastian Reichel пишет:
> Simplify the driver and remove the DT specific code by
> using the generic device property framework.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/power/supply/smb347-charger.c | 40 +++++++++++++--------------
>  1 file changed, 19 insertions(+), 21 deletions(-)

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>


