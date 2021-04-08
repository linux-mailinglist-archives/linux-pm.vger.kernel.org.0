Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CFF35904D
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 01:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhDHX2a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 19:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhDHX2a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 19:28:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA8C061761
        for <linux-pm@vger.kernel.org>; Thu,  8 Apr 2021 16:28:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u20so4243983lja.13
        for <linux-pm@vger.kernel.org>; Thu, 08 Apr 2021 16:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MEREbouSsOuRPbKttfWRgrK1cYOjat2yvXqYJTFkgo=;
        b=wlYGXg66P5BevvpLfZbVgbO8mhMZfhA5qOzQGWSDWLCoGiufYWo4awl+rbNlts+TNP
         UlRHP0HfKUiBznMBZL+AZfN5FjsokssNlJJdJ6zOo0tD2IJyleWF2P0qUyfTdf/cSIzD
         q6hS/j92xF5NuEkk4kXRN5exLKFUHNA9t60Ihoj5UDjiNQVo4FYHAOZj/qQBo8UP8aX6
         8OcD6FUmdFVhOdYRRD6xjp1zUDqHPlfJFyFdbvRPwuYM8eVMCUzTsxVlJn3XZf6NL4N9
         qQfDnpm6iCl6qgiW1auw+Sqx0qVvc6DCJ47bnbIJTyLpz/BOrqirE+YMGkWtH7l4U03c
         Bhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MEREbouSsOuRPbKttfWRgrK1cYOjat2yvXqYJTFkgo=;
        b=WWbY6/ULdPsX6xpiZ52udG+oT/zC8xVcq8cQwDRC2nXodIT/5TfY5m7xerqVdj6ZM+
         W1R+tvtHPtRptxbtads7RD71PAJiGxM0iZfK8jhD5FgCsTDteK7VDwiLEzwFg+/EaQG0
         n0I18Kc8H6LC+ouRb82z0YIj+7QQdMkgx8K1eDwEBsoa/IU02fCXQqUGQQwZGE8AzwUi
         mZgiWPVK7ejnDID8Nn/YX/eHfu4fjtxUr5gkctCXttze5TjsRFl3K21t/ss6a1pZxvok
         6x5ItwkfSYc0xamYvnTOFTT48Yy6qSa/4KBWURfWfILBOauKTfgaIjgXVJ+v3TydNB2x
         vhkg==
X-Gm-Message-State: AOAM531kPIqYJ1f1vjBENHDoFCiiUv0BRR6TWqjVhsgbli9c5sJppkdX
        PySh9Ss6c8M0kqEAt9c93hlW6Vanaq+koroDz0XhJg==
X-Google-Smtp-Source: ABdhPJxVh1OLdW/A8ehvTkKkxWgoqpp8Ph+dQF5mtyTwZSHg6ygyxPAMf5CCPO/Xm0i6hAZcrMrSSQgD50PDX+hu90E=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr7626121ljj.438.1617924496736;
 Thu, 08 Apr 2021 16:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210317134904.80737-1-sebastian.reichel@collabora.com> <20210317134904.80737-36-sebastian.reichel@collabora.com>
In-Reply-To: <20210317134904.80737-36-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Apr 2021 01:28:05 +0200
Message-ID: <CACRpkdZerDHY0EsZxqadbbWaCCjw7nkOE8VOGPhoL-Rjwp4Bhg@mail.gmail.com>
Subject: Re: [PATCHv2 35/38] dt-bindings: power: supply: ab8500: Convert to DT
 schema format
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 17, 2021 at 2:51 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Convert the binding to DT schema format.
>
> Note: The battery node does not have a compatible value and needs
> to be described from the binding file for the PMIC. That has not
> yet been converted, so I kept the information in plaintext for now.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks for doing this Sebastian:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Long term I want to get rid of the "charging algorithm" device node,
as can be easily seen that is not a real hardware device but just
some mockery to get a platform device up and probed. It is actually
a library. But for now we need to keep it around.

Yours,
Linus Walleij
