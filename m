Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E953D1A49
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 01:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhGUWbj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 18:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhGUWbj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jul 2021 18:31:39 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C9CC061757
        for <linux-pm@vger.kernel.org>; Wed, 21 Jul 2021 16:12:14 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so3619661otp.8
        for <linux-pm@vger.kernel.org>; Wed, 21 Jul 2021 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=MPq/5xe+ZFrc5ThTaYuC8k1u7ZZx3W3gcPTLJ7TqUVc=;
        b=Y05kIYu1Rc6yqQaGglurstZd9kUhswNFuOz4n0FMlXcPadby9Ug9bveEoYND5fgwJi
         PiUJiRw+PELZ31ItnqcfWq2mSgCTAE7a7FPwBmt728U+NqePRiXzW1SEaOEjdAZCQEFY
         VsB0ZeEUx6JQebpfCMhM+XBSHtwZxAdTgLr3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=MPq/5xe+ZFrc5ThTaYuC8k1u7ZZx3W3gcPTLJ7TqUVc=;
        b=cWSgjUwA7jhPh25LkDFrt135XBrDFn5qVMa9i5MuaAhCRbDC+Jckix3z88bAU//0V5
         KRsoTsRk9M22wQhYz+uGdLdHBZ7HENw7/qM7kDrUpewET8GeivABxINay2nRj/mgOyyw
         jHzV6Eb6B8FKUTA6ezFGXvRkfsXW1l07JVw8I264B30R4dB5tU3vLj9Bh0En9m780gAi
         bYxP7xE8cFj2qH7wbje2c60ORvVBwPXXyhmA5GzhC6fI8FZ8r7bqQx5UNhE5XZ+VCoyB
         m8gzIgabMz+HvW5VTq1b0oAJ7DiHTg3NQ0VbQNjx3SijkRVTN2DOoUrIZrx1VtH9if8O
         hSgw==
X-Gm-Message-State: AOAM531TPRNtGXg2I8T0bTIf2770mCwbK8GwN/YQ0aq4Ew2DblEP+8vk
        v3ULCI0zSUKdUavIcT8oQFGcyx9rpCImrfNB/wFdRw==
X-Google-Smtp-Source: ABdhPJzglFe0sSuxI2Kvcg8hWnhsIoLyZGok/Wp8G7gjYlEThZGGtf81RU4aHu7fYlFhlWtPY3Aipz35Jj9FSk0lAJ4=
X-Received: by 2002:a9d:8c7:: with SMTP id 65mr27882594otf.25.1626909133892;
 Wed, 21 Jul 2021 16:12:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 23:12:13 +0000
MIME-Version: 1.0
In-Reply-To: <1620800053-26405-5-git-send-email-skakit@codeaurora.org>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org> <1620800053-26405-5-git-send-email-skakit@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 23:12:13 +0000
Message-ID: <CAE-0n52BMdoRHe-oy2_8fji8KfBF8wQD9BR-MuRajSp7Keo79w@mail.gmail.com>
Subject: Re: [PATCH V4 4/5] dt-bindings: input: pm8941-pwrkey: Convert pm8941
 power key binding to yaml
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        satya priya <skakit@codeaurora.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting satya priya (2021-05-11 23:14:12)
> Convert qcom pm8941 power key binding from .txt to .yaml format.
>
> The example has been removed in favour of full example being
> available in the qcom,pon.yaml binding.
>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
