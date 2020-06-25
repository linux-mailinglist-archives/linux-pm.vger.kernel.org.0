Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286E120998E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 07:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389615AbgFYFrc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 01:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389497AbgFYFrb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 01:47:31 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A821C061573
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 22:47:31 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id t23so1128707vkt.5
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 22:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Pyf0GGvFVlXsdDyV6XIIzdPqN+R0eNNqJvFwUcTnuQ=;
        b=NLPjaUmVWEdwr3ufy0pJAdyTKWHhcA1I+POUG5D6lz7Y0eAuoVUFJuP4weZ7N3WzeN
         /yMrWQVRvJ0+rlA33aFwLrpB6T9yHLqO4XbTVCGg3WUEOEsLpT6L/uw0j/K8gSfEDnn8
         ECvwrH3hOzi4tUJGMu2axZLXlpxBvo44/cGf+qh1p7SWDj3GdGe8NvlWunaErT+TpKeA
         BaasQKGPxAW3VzxEtaKA9unVB7PFKUmlBqRM7M4qvPwLC3AKzrXan6a1OunMe3nZC96w
         rUL+XgxmyOnm3aHp48j4SZlESnDm+LttG+OSry6PTWJAjvIn2R8/6PPYvGFMCseYF0yk
         WLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Pyf0GGvFVlXsdDyV6XIIzdPqN+R0eNNqJvFwUcTnuQ=;
        b=hE22bAUW8f6i1GBtfq6vySShOpphw5K+iBbsIPyhNI+ZQtEzaHp1QRmn7XRbhz2mGy
         Bx0bgIIyCKnC1rrmnvi3w9n9U2AQkPzp5FOTfVCkf0UXdGQAnghG4c70/zzemW7lRakh
         K9i3KV5k6gzVkqIA0SQQq/ZsE0EAnZQA1lvmpjhjMo7/OsyVHlxNlEyi4MWvv+Zy4xDn
         q/9/rr7nmxzcn94COS8PSMpGzAiwBmZOKOmblVMe0MA5I75ZOCpfL6VtrweKelJuu+0E
         aVUYCsIG5nQZqCacBi95gb4SMHOFdjSXw7S6kgMvj91PYQj5+yDnJyxZ/OUL8NZAmtzr
         3eig==
X-Gm-Message-State: AOAM532C/HOmW5k2a8cPD7+BNg970tU1nt+CKL/Z/u6QWXcX3DM2AC2F
        9p+bBg6abYQw9sKfwr5ShhR3V8qNbxZZ33KirFbifw==
X-Google-Smtp-Source: ABdhPJz29/gwxTOnUa+6XWgaPKMFCENul0uiekbDYgqPdKvRSaVgk4wq5FPQsyia16fNAO7d1Z4wSbTgFy8RGO5Xeqc=
X-Received: by 2002:a1f:d783:: with SMTP id o125mr26144467vkg.46.1593064050335;
 Wed, 24 Jun 2020 22:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200623180832.254163-1-konradybcio@gmail.com>
 <20200623180832.254163-4-konradybcio@gmail.com> <CAHLCerOAM5j+gZWP9MUuGZ+TQfBg4Z=GoEdUfxBTwtEs5TqUuw@mail.gmail.com>
 <CAMS8qEUT+Kdq-gqZn25X7W2V8HacuXFbeoTDz=N7C7MNpSfOHA@mail.gmail.com>
In-Reply-To: <CAMS8qEUT+Kdq-gqZn25X7W2V8HacuXFbeoTDz=N7C7MNpSfOHA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 25 Jun 2020 11:17:19 +0530
Message-ID: <CAHLCerPOwO1JHUtb33fFkBH9wAT6Ty4E4GxbHNvbEkwr2SOvuw@mail.gmail.com>
Subject: Re: [PATCH 3/8] arm64: dts: qcom: sdm630: Add tsens node
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 24, 2020 at 8:32 PM Konrad Dybcio <konradybcio@gmail.com> wrote:
>
> Interesting, the downstream DTS only mentions the 0x010AD one..
> Are you sure you're not looking at 636/660?
>

I looked a bit closer. So there are two instances of the controller
but the platform doesn't have as many sensors. So using just one
controller is fine. I suspect the other controller might be disabled
in firmware.

Regards,
Amit
