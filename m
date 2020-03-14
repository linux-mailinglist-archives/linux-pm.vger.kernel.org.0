Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DD1857B0
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 02:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCOBp5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Mar 2020 21:45:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42268 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgCOBp5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Mar 2020 21:45:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id b21so6952550edy.9;
        Sat, 14 Mar 2020 18:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oJNL3gJVarSfgnj/xZ8e1v4N3wwQZ3+G6UH5cn1DZKY=;
        b=epp1F7RQF8dyE+jDoYIGqnJXXh3ngzWRGV7uzTbzk3TBCNgfaQaE8d4dP2ZLmY0DJ+
         CqSokF0zE3/F9p9fRxEWpIMiAXrS/nCmyNHzSCTYQLcrYNzd7x5mfl90UwohECYXsfT/
         T+cOD8uSccH4CUcKAp+o4BDtUl/fPJzpibrNPizUCc5kLAg8jOxbcszNVGkg7yL50sML
         XWHS5I3LiyZZUDt2w7jvlfh5d8vZCDHfsE5tm1KoQYVXFSa5nJ92Prk7Xj1vWsCcdx5q
         nTHX8yaD4nATlMCEq7WHQ5vQOa6lx5mcUGaDqjcV7+3e1HCe0KiC3s/YiNqLKt0rMpED
         SxZw==
X-Gm-Message-State: ANhLgQ0YjwXcGyf10wNoie90C2n2odVuDtz0YW+5EN9MCmd+CtcLW+Xg
        AEAvenBETF7zE1U0DuWyu0acfLLf
X-Google-Smtp-Source: ADFU+vsKOOL2UHib0/pNgwvknqu0ygBfBLObd+RRWf136IE+uExXy8WOyTcRRaS8oCCPzf515dqUtg==
X-Received: by 2002:a17:906:9405:: with SMTP id q5mr16440276ejx.317.1584211552602;
        Sat, 14 Mar 2020 11:45:52 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id v17sm350384edb.27.2020.03.14.11.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 11:45:51 -0700 (PDT)
Date:   Sat, 14 Mar 2020 19:45:49 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] power: charger: max14577: Add proper dt-compatible
 strings
Message-ID: <20200314184549.GA20063@kozik-lap>
References: <20200220145127.21273-1-m.szyprowski@samsung.com>
 <CGME20200220145135eucas1p1ba181cef65c7a4f91a254ee35e022f08@eucas1p1.samsung.com>
 <20200220145127.21273-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220145127.21273-3-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 03:51:27PM +0100, Marek Szyprowski wrote:
> Add device tree compatible strings and create proper modalias structures
> to let this driver load automatically if compiled as module, because
> max14577 MFD driver creates MFD cells with such compatible strings.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/power/supply/max14577_charger.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

The approach is still being discussed (in patch #1) so this should be
applied if patch #1 is also accepted. In such case:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
