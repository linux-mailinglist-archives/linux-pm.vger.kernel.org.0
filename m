Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AC3286157
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgJGOiC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 10:38:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34999 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgJGOiC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 10:38:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id s66so2448384otb.2;
        Wed, 07 Oct 2020 07:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxPKPSo1YXSeVnez8BVX+TVgSqgZiZ16tUQylumORqs=;
        b=MaYY4sZRX9ApAoKIi3fwcxGPi2WZQ93OdXVy43Rn+QWpTZHvLTZm3XMUpuYAuuFc0a
         X5Q8T17JVa+nAJfVb+1LVOzUARG9hbDSTiC7vZNGl1ecQiHa/0LdMNyoTHSIM3kQHsEb
         PMlcalcnL58E9aHI6d25SBhpBm4mDvdGCVRTM9w0dsYeMbuHXBs+WJy88DlsshuExdeR
         MfrBTD9klvbrDB5Y1ompzSbneicjlQ/DxwvTgNWKpMM7o2mcgBxu8d54HSBh0CIY79lR
         6HG9kY5LAxyJkjSHX4dnid6Ltlb/YAWDvHwJ9IAf/lSjPLMaxvHqvNqicU6UxSeJcvzA
         Ai3Q==
X-Gm-Message-State: AOAM5332UkTJ51qx00XE64dxf4q70vD191K3aqoAsALd3f2zYGdmASVY
        PCGx8u06uSTVXDeNXToumJnRcj4QXhOPoqUtwQ0hO9As
X-Google-Smtp-Source: ABdhPJwCPu87dP4yijxMekKnSvEbU+HyXS4acEJ2qXEkwWF7ppwMZQAsoVAhEVU+dqOQ+gDWIKVwGAMTV97S5KIiNZg=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr2182292otk.260.1602081481527;
 Wed, 07 Oct 2020 07:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201007001934.18606-1-stanimir.varbanov@linaro.org>
In-Reply-To: <20201007001934.18606-1-stanimir.varbanov@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Oct 2020 16:37:50 +0200
Message-ID: <CAJZ5v0hxdxV6pB5q94qCEmeDXOMJQzL3b8ZokgTn00i0MbykvQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Use pmruntime sync variant to put suppliers
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 7, 2020 at 2:20 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Calling pm_runtime_put_sync over a device with suppliers with device
> link flags PM_RUNTIME | RPM_ACTIVE it is observed that the supplier
> is not put (turned off) at the end, but instead put asynchronously.

Yes, that's by design.

> In some case This could lead to issues for the callers which expects
> that the pmruntime sync variants should also put the suppliers
> synchronously.

Why would anyone expect that to happen?

> Also the opposite rpm_get_suppliers is already using pmruntime _sync
> variant of the API.

Yes, it does, because that is necessary.

> Correct this by changing pmruntime_put to pmruntime_put_sync in
> rpm_put_suppliers.

It is not a correction, but a change in behavior without good enough
rationale, as it stands.

Thanks!
