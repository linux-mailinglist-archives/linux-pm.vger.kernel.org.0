Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB70277088
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 14:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgIXMBX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 08:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbgIXMBV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Sep 2020 08:01:21 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836822344C;
        Thu, 24 Sep 2020 12:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600948880;
        bh=HU8qADua3DwTMUM/LSsTZxoTz6rCKqo/o3hbYAopC/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WxQWSWqRgzYY8HO+TreB3OuLJ9iakIp3SGNpSEYe/XQgXId1zWXwopHY2n/kEDZ+s
         i+Wx5AWrR+ZB2EvOkDO/qcgSL7VNQm2Gdp3eN2aR4amKyjnWpd+Au3XAzuYwC6prtQ
         gduF7L8fm9vxyjmfjYoj+lvhx4iFNcxPcWdkDj2E=
Received: by mail-ed1-f42.google.com with SMTP id i1so3120324edv.2;
        Thu, 24 Sep 2020 05:01:20 -0700 (PDT)
X-Gm-Message-State: AOAM5327wSpgScGo1OLzBKY7vocH9QdGnC6kwG3rgAwuFckU/LFODFVV
        nwwd8TirpiUIMw/5w+nC6LhhKTEtvbZCZtHkon8=
X-Google-Smtp-Source: ABdhPJwYWf7S71P6B5TCnILlClq4OhXhKx8rUJ1AR0ObjVZQAvaeYChg1+r/Lt9rkGb65LLiDd6+v4rSNkFn3wrInKY=
X-Received: by 2002:aa7:da16:: with SMTP id r22mr667038eds.132.1600948879064;
 Thu, 24 Sep 2020 05:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200917193702.31347-1-dmurphy@ti.com>
In-Reply-To: <20200917193702.31347-1-dmurphy@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 24 Sep 2020 14:01:06 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc_K-T95MY84qGX6ERi4OmVVGXSkH3XCKqF84qvak_Eqg@mail.gmail.com>
Message-ID: <CAJKOXPc_K-T95MY84qGX6ERi4OmVVGXSkH3XCKqF84qvak_Eqg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Andrew F Davis from list
To:     Dan Murphy <dmurphy@ti.com>
Cc:     sre@kernel.org, sumit.semwal@linaro.org, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 17 Sep 2020 at 22:02, Dan Murphy <dmurphy@ti.com> wrote:
>
> Andrews TI email is no longer valid and he indicated that it is
> OK to remove him from the MAINTAINERS file for the DMA HEAPS FRAMEWORK.
>
> For the BQ27xxx list I replaced Andrews email with mine.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
