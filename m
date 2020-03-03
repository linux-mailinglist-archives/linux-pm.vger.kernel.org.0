Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D69177191
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 09:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCCIw3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 03:52:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40936 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgCCIw2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 03:52:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id 143so2577518ljj.7
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2020 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qP4l3miEhOsGvhCQGfIOAAIiSzN77+8PwgJ0ybST1SE=;
        b=oE18UWg7uB5RWxPJuwXndW24hkOzqPIoL99H1Qv9tUnv8DHc3rMf1f0zZcReU+suxK
         MR3AxZ4g8LYDpIwSSwwuNXt2h/5wYtIXq/9ywWs48ntVpfmob3K2z9XKR1NyTe1DcdLJ
         rWIBVGOFRVEFBss2E+R8lG/26kUA5GJeIvCB//3pCq1aUo5U4cTt2ro7DlsZfdmSYnyp
         GwWVvc3Q+29uTT6yUq/mZIPEa9uNGTtxNw53PeUQ/X8+EwfZ18BFtQXOXqXl7p56vxsd
         3NfHITA92j/M9QzGVcq03JDG80DEYjMdRSOBePH0vVPAT06WR+Rv3flSq7igtB5TlvQD
         BIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qP4l3miEhOsGvhCQGfIOAAIiSzN77+8PwgJ0ybST1SE=;
        b=T/8EnWJhmZ0KOnRlrgBVEAto6Y+tSJwJdNjEY/2OmMGbdI8XhNxS2tBGWFRVjo0x3L
         hU/yFuTNUvLXdfA4UzqfwFMPa1DOFZ5izohyCGIj9L864jpae1Z9Fydl+v0r3eqwGMLl
         /rvRHMMxfKBHG0E+kj6B2wDQCUb76/iihXsWg066L4QZTt/SUY0dqro0ZHXGaIMjtyx1
         a/Va3m6u5bp2qUaKmWjtpBK6bxuOYJFLZuBwKWhqFEdZrUQD9VMPDVa/nMz14yBOPDjK
         unSCpdDiwBWETMK3Vn3jhMlOYcJ4MaKXi7zlMCZ/uPGgkEfQnxpG5cVa5gSBu0vNcvqm
         nArQ==
X-Gm-Message-State: ANhLgQ3xZSfqKTC1+A17xWzwc5CSRolsVOgYsVG6VKBIJ7FjPh/C9nG7
        3pPz1fAeTUQAK/dwm74+0JgstCe4qEiDihIp3tApeg==
X-Google-Smtp-Source: ADFU+vs8vnVGsuXNBfltlkRNIaMr26/HznbXiZTa8hZpumUN/ioJsPKL3uAefOfYGMsXkzIw0k0q1oJs8IuresWlrLc=
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr1754799ljk.13.1583225545328;
 Tue, 03 Mar 2020 00:52:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582871139.git.amit.kucheria@linaro.org>
 <8309e39737c480b0835454cbc6db345c5a27ecd4.1582871139.git.amit.kucheria@linaro.org>
 <a3903db0-302d-a0f3-0515-b248e24e19cd@linaro.org>
In-Reply-To: <a3903db0-302d-a0f3-0515-b248e24e19cd@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 3 Mar 2020 14:22:14 +0530
Message-ID: <CAP245DWhzOHBrQNhqMjVC2+8i-P8bkuM3w8bCSqGfjWemR5WvQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: tsens: Add entry for sc7180
 tsens to binding
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 3, 2020 at 1:35 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 28/02/2020 07:32, Amit Kucheria wrote:
>
> [ ... ]
>
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > index eef13b9446a8..13e294328932 100644
> > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > @@ -39,6 +39,7 @@ properties:
> >                - qcom,msm8996-tsens
> >                - qcom,msm8998-tsens
> >                - qcom,sdm845-tsens
> > +              - qcom,sc7180-tsens
>
> This change is already done by
>
> https://patchwork.kernel.org/patch/11319259/
>
> I've applied it.

Good catch! I'd forgotten I'd even reviewed it when I saw all these
warnings with dtbs_check :-)
