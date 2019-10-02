Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B670EC8FC8
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 19:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfJBRX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 13:23:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46654 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBRX1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 13:23:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so20547485wrv.13;
        Wed, 02 Oct 2019 10:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nzNAW4QY/zCjsjZa28ydl9OQI+8F/1QiLCLBnRQrEao=;
        b=togZMZgLDitqtf5W3tyUWg20Bo3G0qTe42BCGz8HSS35JN7Cpm642Rw6u49PitUzKk
         hj1kqUOl37k0pM62pQfWNY8qE36Al0XDgZJZIu5s3oRkmBLkOIpUm+J+e+fR7jQC0nmW
         dGTCqqci9fniz8zM7dqCe95WPO6wlYGk223xKUjBxLpxfevwBtYOLorwWYqwQckJzrFP
         GrRZC/W1Q0wF/jt40YM+d9EI9jFtyWjWXcsXpwOo3hHrepmvCGXsyoyDTKjvzqu5VDI7
         ZiLpzqruxwo5k+NcW4ZdssDMc3nKUtpUuY9q25x2nG+CNLKJlKu+8KrhP/0bq7N2fGj5
         +R8g==
X-Gm-Message-State: APjAAAWltOo/wNeFl6D0cFVbLZG9vXpfiAkkRUPr4A1DCHY0ugZjEwUK
        Q/EzcoPvtHvFULe4tMv8Fe8=
X-Google-Smtp-Source: APXvYqwNucqhWJvk5ezJtj648rwbekIqzLM6WPWAfMSVXhINx3Syw+zxmOe53m4oBLNZvolGL2J00w==
X-Received: by 2002:adf:e988:: with SMTP id h8mr3602872wrm.354.1570037003007;
        Wed, 02 Oct 2019 10:23:23 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id 79sm10111624wmb.7.2019.10.02.10.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 10:23:22 -0700 (PDT)
Date:   Wed, 2 Oct 2019 19:23:19 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v3 1/4] dt-bindings: memory-controllers: Add Exynos5422
 DMC interrupts description
Message-ID: <20191002172319.GC21463@kozik-lap>
References: <20191002060455.3834-1-l.luba@partner.samsung.com>
 <CGME20191002060504eucas1p2f023677bb85a7f6a1efebf891e8d81df@eucas1p2.samsung.com>
 <20191002060455.3834-2-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191002060455.3834-2-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 02, 2019 at 08:04:52AM +0200, Lukasz Luba wrote:
> Add description for optional interrupt lines. It provides a new operation
> mode, which uses internal performance counters interrupt when overflow.
> This is more reliable than using default polling mode implemented in
> devfreq.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../bindings/memory-controllers/exynos5422-dmc.txt    | 11 +++++++++++

Thanks, applied.

Best regards,
Krzysztof

