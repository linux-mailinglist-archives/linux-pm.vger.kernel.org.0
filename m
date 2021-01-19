Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7308D2FBD5C
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 18:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389447AbhASRRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 12:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387698AbhASRQ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 12:16:56 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3DAC061575;
        Tue, 19 Jan 2021 09:16:14 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id n8so13979221ljg.3;
        Tue, 19 Jan 2021 09:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RmWj/UzVbuMskxSAnc8X5V0ahshV8pjHXZBtgZv7UAE=;
        b=bTp4WrzFwiHSxydDyCkWOq3fZQMLdKbNnGWbMnBxOIoiUskFYclofhT94qxN1hElV2
         FKA7dmkxGYxhKBqcG8z7M/9189KkdaHpqaK0TaTj//90PS6rrjh3IY496mcn2g9kRck8
         gMMqWY+pGvwFYd1qG4HLG1wnONLVBZ2dMLmForU6yatH51t3xG4o6Vt/Vw3Tw022Mqyx
         Coo4/bhEyG6MVakPH9WBWSsJU0jss8wBjpU5B3dx4pMsx9qY0MwochDS4GAHtzTr6VtH
         /xwheU83vnvppvFutcgrAmXiu8x0TwKa7SUGOgIWrNY+1JLQxLFqlOtPChXg298ZtizS
         XctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RmWj/UzVbuMskxSAnc8X5V0ahshV8pjHXZBtgZv7UAE=;
        b=eWzVeL5iKXA6ClAwl3tCimgXJk7tOd+PcwRD0d584mMb/Ixs2zbDeaebmezoOIi/d4
         MBrY4GhV8WHnHHlrdMOs6ZPKcsd+Jao0bXQgDU0j49uy92+MLClMscXiD7Qp9PX/SKUo
         tDUTDNMftBmsuP0iI3GDP0AXHwc3mtn5LCBow1i2jrdxFOglUNcBY95Y7nv59hpZIr/m
         8gsI5IZosEXvDoSogQirUGHteGqtetiKKRg12yvkZHnABe/c+89JYtyF5Fo6G6y95PQ+
         QC6xEV1dwSF/cH8CnAOm71qeXAjFG+RGcLAfqhdRi4EnVcmOFmE7la09lTfAsoVPP53W
         N9ow==
X-Gm-Message-State: AOAM5319iPnMAMJKTwf7yeecc4KSKIaV3OmcqN3V42O0WL+OE6mX5Clu
        QS0/tplihvmbRowCd1gZMY5VuXaNJVQ=
X-Google-Smtp-Source: ABdhPJx3WXTc2/X7V7/uNNPBIewl8UfFtdgwYDFzuY9LSVUMy+Xbez9ktrXFvrarfFlqEVnbrFI5nA==
X-Received: by 2002:a2e:85c1:: with SMTP id h1mr2467237ljj.127.1611076572760;
        Tue, 19 Jan 2021 09:16:12 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id a31sm1973017ljq.109.2021.01.19.09.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 09:16:12 -0800 (PST)
Subject: Re: [PATCH] opp: Prepare for ->set_opp() helper to work without
 regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c657b5b0-b841-1b26-8008-2fb4b490d63d@gmail.com>
Date:   Tue, 19 Jan 2021 20:16:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <302c014726dbd9fcde852985528c139d2214a1f2.1611038066.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

19.01.2021 09:35, Viresh Kumar пишет:
> +	mutex_lock(&opp_table->lock);
> +	opp_table->set_opp_data = data;
> +	if (opp_table->sod_supplies) {
> +		data->old_opp.supplies = opp_table->sod_supplies;
> +		data->new_opp.supplies = opp_table->sod_supplies +
> +					 opp_table->regulator_count;
> +	}
> +	mutex_unlock(&opp_table->lock);

Why do we need all these locks in this patch?

The OPP API isn't thread-safe, these locks won't make the API
thread-safe. At least both sod_supplies and set_opp() pointers should be
set and unset under the lock.

If you're about to make OPP thread-safe, then I suggest to do it
separately from this change. Otherwise this patch looks good to me.
