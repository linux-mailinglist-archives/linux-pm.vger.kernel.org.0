Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6771BC078
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 16:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgD1OCq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgD1OCp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 10:02:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A95EC03C1AB
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 07:02:45 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t11so16954885lfe.4
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2020 07:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jE1ry3/WH39fvkitlEImOc9VA+8Es26FANSqOuJc04E=;
        b=gKRvwPTf1AvgqGtJF+/FWCwKJY0q95FhYY5JScuWdpMP00paUsHcpU/fjv1hAk55r6
         Jl5fmzws4VNaXL2yAhSpQQszWnHHFbzhEUPa/Y4v48vDg0kbPDMSKabG27po61hR/aXq
         vu6pds4YpVzMlDJxQVebXZkDTCaZpbWf/FSkrRATp2ING17+GqmKftnjbOCGa8/oTchm
         XSw1ceWIBF9nM8my4ojkw96invyr0LWcGXIJV4S9THUjC2bTs7yFx8uZzA9KpVVnIDld
         3Lf1AD4KpBIDY25xy9EX9h/ggg/yxqsKIN/lmmMJIxt08GiaJ7d4xi1WQowSIOMibw9A
         ZgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jE1ry3/WH39fvkitlEImOc9VA+8Es26FANSqOuJc04E=;
        b=oHLgpJCJDCjR4xxeQ//RhtMhJjqJtIcuSQgl4Y32JEWqjVMeIMnItWq4AjixBbpNIZ
         Ieks9tr6TRlpTIwB3eiUTDNLgGjjQ044r0NjDAB+5ch+hmX/ozGoQ4aqi8Wi63BUDCpx
         TW/7QRxydTvfCVzTrGqpnRbPY4/MAeb4XSnPJk1hRT2M+Ge/Yde0JwXuk2r/mO3ZN3AY
         eYrAagZidYAEf0g/kSkKnb0D2im/N4NooIoZ/IGU3kiugTvA/NKAsLE92r12I1KND2Gf
         /OmSMAEkQUlzKgRG2fabwEB7rgqQgsTM1N8epgbZ8DjieghBwjvEnfga8bNxzYw2KoBh
         QF8w==
X-Gm-Message-State: AGi0PuY2n/L7p98wF9QYbIBHeVZRsEfc2ODTCQMp4gln0pnPnPcay8MI
        ayO46cuQ3Wdqv/3zmVwEyy++qow+1+O+rMw0wOqKBw==
X-Google-Smtp-Source: APiQypJbBQG+lZGnEgJPVGO7k2y8d3LYISivUTbhjYNTeX3f5ZWBtN9OGNiQwGYtCNT0qnO4WCiwZG8ZYp8xJeFGyA4=
X-Received: by 2002:a19:700b:: with SMTP id h11mr19393584lfc.89.1588082563613;
 Tue, 28 Apr 2020 07:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200426094250.23995-1-yanaijie@huawei.com>
In-Reply-To: <20200426094250.23995-1-yanaijie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 16:02:31 +0200
Message-ID: <CACRpkdYwu3LnN9KGfbjhnJu75hmKBKgnSWnDCWmdnGWGGGYPTw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500_fg: remove comparison to bool
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 26, 2020 at 11:43 AM Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following coccicheck warning:
>
> drivers/power/supply/ab8500_fg.c:2402:5-24: WARNING: Comparison to bool
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
