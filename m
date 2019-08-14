Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423818E062
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 00:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfHNWMr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 18:12:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35970 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729805AbfHNWMq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 18:12:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so199096pfi.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pn4+TVeFCCrcFG61M/ievKm/DZAmwLymLPS9PLFRAC0=;
        b=EXLXiKcwPDfZkDU3XkB5qIFQTQ25u5KzxI/NkZKQr00Ib8AkKTPEA+PjN59Qxb86VH
         0TwkGx7bpIp1HSMsDsleheBWi4srrti35kr4xdaaliQyM7PeVM41oYPfQkulEeDt6UfC
         pyno9YE+Tr81So6uEXPqtEDHIU/I8nu/GT4OqIxvh/15nIqtReIlOcbSGPyPiMU9vqwL
         RPrjVJcDJ2nxBzrfDuNilPNgD0YkPJliWFfzs7WIuWpNW2uVvFrfgl118craXTgwpKB9
         ikgRK4uvBlN7WngDbX6fGxNtjOU2SeFjd1dd/NXZzqqtn4DKX3+4o63yHvHNkt1mgBn2
         vG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pn4+TVeFCCrcFG61M/ievKm/DZAmwLymLPS9PLFRAC0=;
        b=QFvoOdN+j71Kq1wlB7L76gEFYA1pjreED8MrMknp9+T0p0GxxeyQkkn6wmk8mOHryg
         sKR7mOT1hu3IrZnxJffomLzT9HTjO/LjiHH7g1fojrARqKu4uanOjSz8Xa6mCV3Cm0I2
         Lj5Z/6+wc94wnRJICsYvi1fuo5LGuqsD35hFEz77u5guns5Zuprm/WxtG9jerpNH9hFC
         AZPadfTQbCkqt/7U31i4N+54aePnhtjoKv54oDHHxCHda2ZOwOaBRMOqoPQ5kbNqETzC
         w1NsInl+77xM23ZSEfsQIPlPo75Mf3cqy0+Sqs/91YEgnPe1Pkez3QO2fBFhXcZku4il
         gHog==
X-Gm-Message-State: APjAAAVEs/6O4WayP8hbnkSqoGTUpKb5D59LSzCD5Vxuqby+EMKdgtDI
        BopfvJhnmDDBaGvdsYxqAQgVYBSC5oCTDPXB7cfT2g==
X-Google-Smtp-Source: APXvYqw9g0Ol6/us+Q/GSJVfgGX9NA6KnY0Keszi05hjY2TDTg9/n6bBjGRTuD0ehbKefyqYBvdltfVoI7u4VRb0bnE=
X-Received: by 2002:a62:cec4:: with SMTP id y187mr2208756pfg.84.1565820765370;
 Wed, 14 Aug 2019 15:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190613184923.245935-1-nhuck@google.com> <27428324-129e-ee37-304a-0da2ed3810a0@linaro.org>
 <CAJkfWY4X-YwuansL1R5w0rQNmE_hVJZKrMBJmOLp9G2DJPkNow@mail.gmail.com>
In-Reply-To: <CAJkfWY4X-YwuansL1R5w0rQNmE_hVJZKrMBJmOLp9G2DJPkNow@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Aug 2019 15:12:34 -0700
Message-ID: <CAKwvOdkEp=q+2B_iqqyHJLwwUaFH2jnO+Ey8t-hn=x4shTbdoA@mail.gmail.com>
Subject: Re: [PATCH] thermal: armada: Fix -Wshift-negative-value
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 13, 2019 at 10:28 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Following up to see if this patch is going to be accepted.

Miquel is listed as the maintainer of this file in MAINTAINERS.
Miquel, can you please pick this up?  Otherwise Zhang, Eduardo, and
Daniel are listed as maintainers for drivers/thermal/.
-- 
Thanks,
~Nick Desaulniers
